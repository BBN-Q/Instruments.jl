#=

Thin-veener over the VISA shared library.
See VPP-4.3.2 document for details.

=#


############################ Types #############################################

#Vi datatypes
#Cribbed from VPP-4.3.2 section 3.1 table and/or visa.h
#It's most likely we don't actually need all of these but they're easy to
#generate with some metaprogramming

for typePair = [("UInt32", Cuint),
				("Int32", Cint),
				("UInt64", Culonglong),
				("Int64", Clonglong),
				("UInt16", Cushort),
				("Int16", Cshort),
				("UInt8", Cuchar),
				("Int8", Cchar),
				("Addr", Cvoid),
				("Char", Cchar),
				("Byte", Cuchar),
				("Boolean", Bool),
				("Real32", Cfloat),
				("Real64", Cdouble),
				("Status", Cint),
				("Version", Cuint),
				("Object", Cuint),
				("Session", Cuint)
				]

	viTypeName = Symbol("Vi"*typePair[1])
	viConsructorName = Symbol("vi"*typePair[1])
	viPTypeName = Symbol("ViP"*typePair[1])
	viATypeName = Symbol("ViA"*typePair[1])
	@eval begin
		$viTypeName = $typePair[2]
		$viConsructorName(x) = convert($viTypeName, x)
		$viPTypeName = Ref{$viTypeName}
		$viATypeName = Array{$viTypeName, 1}
	end
end

for typePair = [("Buf", "PByte"),
				("String", "PChar"),
				("Rsrc", "String")
				]
	viTypeName = Symbol("Vi"*typePair[1])
	viPTypeName = Symbol("ViP"*typePair[1])
	viATypeName = Symbol("ViA"*typePair[1])

	mappedViType = Symbol("Vi"*typePair[2])

	@eval begin
		$viTypeName = $mappedViType
		$viPTypeName = $mappedViType
		$viATypeName = Array{$viTypeName, 1}
	end
end
ViPChar = Ptr{UInt8}
ViEvent = ViObject
ViPEvent = Ref{ViEvent}
ViFindList = ViObject
ViPFindList = Ref{ViFindList}
ViString = ViPChar
ViRsrc = ViString
ViBuf = ViPByte;
ViAccessMode = ViUInt32
ViAttr = ViUInt32
ViEventType = ViUInt32
ViEventFilter = ViUInt32


########################## Constants ###########################################

# Completion and Error Codes ----------------------------------------------*/
include("codes.jl")

#Atributes and other definitions
include("constants.jl")


######################### Functions ############################################

#Helper macro to make VISA call and check the status for an error
macro check_status(viCall)
	return quote
		status = $viCall
		if status < VI_SUCCESS
			errMsg = codes[status]
			error("VISA C call failed with status $(errMsg[1]): $(errMsg[2])")
		end
		status
	end
end

function check_status(status)
	if status < VI_SUCCESS
		errMsg = codes[status]
		error("VISA C call failed with status $(errMsg[1]): $(errMsg[2])")
	end
	status
end


#- Resource Manager Functions and Operations -------------------------------#
function viOpenDefaultRM()
	rm = ViPSession(0)
	check_status(ccall((:viOpenDefaultRM, libvisa), ViStatus, (ViPSession,), rm))
	rm.x
end

function viFindRsrc(sesn::ViSession, expr::AbstractString)
	returnCount = ViPUInt32(0)
	findList = ViPFindList(0)
	desc = zeros(ViByte, VI_FIND_BUFLEN)
	descp = pointer(desc)
	check_status(ccall((:viFindRsrc, libvisa), ViStatus,
						(ViSession, ViString, ViPFindList, ViPUInt32, ViPByte),
						sesn, expr, findList, returnCount, descp))

	#Create the array of instrument strings and push them on
	instrStrs = Vector{String}()
	if returnCount.x > 0
		push!(instrStrs, unsafe_string(descp))
	end
	for i=1:returnCount.x-1
		check_status(ccall((:viFindNext, libvisa), ViStatus,
						(ViFindList, ViPByte), findList.x, descp))
		push!(instrStrs, unsafe_string(descp))
		
	end

	instrStrs
end



# ViStatus _VI_FUNC  viParseRsrc     (ViSession rmSesn, ViRsrc rsrcName,
#                                     ViPUInt16 intfType, ViPUInt16 intfNum);
# ViStatus _VI_FUNC  viParseRsrcEx   (ViSession rmSesn, ViRsrc rsrcName, ViPUInt16 intfType,
#                                     ViPUInt16 intfNum, ViChar _VI_FAR rsrcClass[],
#                                     ViChar _VI_FAR expandedUnaliasedName[],
#                                     ViChar _VI_FAR aliasIfExists[]);


function viOpen(sesn::ViSession, name::String; mode::ViAccessMode=VI_NO_LOCK, timeout::ViUInt32=VI_TMO_IMMEDIATE)
	#Pointer for the instrument handle
	instrHandle = ViPSession(0)
	check_status(ccall((:viOpen, libvisa), ViStatus,
						(ViSession, ViRsrc, ViAccessMode, ViUInt32, ViPSession),
						sesn, name, mode, timeout, instrHandle))
	instrHandle.x
end

function viClose(viObj::ViObject)
	check_status(ccall((:viClose, libvisa), ViStatus, (ViObject,), viObj))
end




# #- Resource Template Operations --------------------------------------------*/

function viSetAttribute(viObj::ViObject, attrName::ViAttr, attrValue::ViAttrState)
	check_status(ccall((:viSetAttribute, libvisa), ViStatus,
						(ViObject, ViAttr, ViAttrState),
						viObj, attrName, attrValue))
end

function viGetAttribute(viObj::ViObject, attrName::ViAttr)
	value = ViAttrState[0]
	check_status( ccall((:viGetAttribute, libvisa), ViStatus,
						(ViObject, ViAttr, Ptr{Cvoid}),
						viObj, attrName, value))
	value[]
end

# ViStatus _VI_FUNC  viStatusDesc    (ViObject vi, ViStatus status, ViChar _VI_FAR desc[]);
# ViStatus _VI_FUNC  viTerminate     (ViObject vi, ViUInt16 degree, ViJobId jobId);

# ViStatus _VI_FUNC  viLock          (ViSession vi, ViAccessMode lockType, ViUInt32 timeout,
#                                     ViKeyId requestedKey, ViChar _VI_FAR accessKey[]);
# ViStatus _VI_FUNC  viUnlock        (ViSession vi);

function viEnableEvent(instrHandle::ViSession, eventType::Integer,
					   mechanism::Integer)
	check_status(ccall((:viEnableEvent,libvisa), ViStatus,
						(ViSession, ViEventType, UInt16, ViEventFilter),
						 instrHandle, eventType, mechanism, 0))
end

function viDisableEvent(instrHandle::ViSession, eventType::Integer,
					   mechanism::Integer)
	check_status(ccall((:viEnableEvent,libvisa), ViStatus,
						(ViSession, ViEventType, UInt16),
						 instrHandle, eventType, mechanism))
end

function viDiscardEvents(instrHandle::ViSession, eventType::ViEventType,
					   mechanism::UInt16)
	check_status(ccall((:viEnableEvent,libvisa), ViStatus,
						(ViSession, ViEventType, UInt16),
						 instrHandle, eventType, mechanism))
end

function viWaitOnEvent(instrHandle::ViSession, eventType::ViEventType, timeout::UInt32 = VI_TMO_INFINITE)
	outType = Array(ViEventType)
	outEvent = Array(ViEvent)
	check_status(ccall((:viWaitOnEvent,libvisa), ViStatus,
						(ViSession, ViEventType, UInt32, Ptr{ViEventType}, Ptr{ViEvent}),
						 instrHandle, eventType, timeout, outType, outEvent))
	(outType[], outEvent[])
end

# ViStatus _VI_FUNC  viWaitOnEvent   (ViSession vi, ViEventType inEventType, ViUInt32 timeout,
#                                     ViPEventType outEventType, ViPEvent outContext);



# ViStatus _VI_FUNC  viDisableEvent  (ViSession vi, ViEventType eventType, ViUInt16 mechanism);
# ViStatus _VI_FUNC  viDiscardEvents (ViSession vi, ViEventType eventType, ViUInt16 mechanism);
# ViStatus _VI_FUNC  viWaitOnEvent   (ViSession vi, ViEventType inEventType, ViUInt32 timeout,
#                                     ViPEventType outEventType, ViPEvent outContext);
# ViStatus _VI_FUNC  viInstallHandler(ViSession vi, ViEventType eventType, ViHndlr handler,
#                                     ViAddr userHandle);
# ViStatus _VI_FUNC  viUninstallHandler(ViSession vi, ViEventType eventType, ViHndlr handler,
#                                       ViAddr userHandle);



#- Basic I/O Operations ----------------------------------------------------#

function viWrite(instrHandle::ViSession, data::Union{String, Vector{UInt8}})
	bytesWritten = ViUInt32[0]
	check_status(ccall((:viWrite, libvisa), ViStatus,
						(ViSession, ViBuf, ViUInt32, ViPUInt32),
						instrHandle, pointer(data), length(data), bytesWritten))
	bytesWritten[1]
end

function viRead!(instrHandle::ViSession, buffer::Array{UInt8})
	bytesRead = ViUInt32[0]
	status = check_status(ccall((:viRead, libvisa), ViStatus,
						(ViSession, ViBuf, ViUInt32, ViPUInt32),
						instrHandle, buffer, sizeof(buffer), bytesRead))
	return (status != VI_SUCCESS_MAX_CNT, bytesRead[])
end

function viRead(instrHandle::ViSession; bufSize::UInt32=0x00000400)
	buf = zeros(UInt8, bufSize)
	(done, bytesRead) = viRead!(instrHandle, buf)
	unsafe_string(pointer(buf))
end

function readavailable(instrHandle::ViSession)
	ret = IOBuffer()
	buf = Array(UInt8, 0x400)
	while true
		(done, bytesRead) = viRead!(instrHandle, buf)
		write(ret,buf[1:bytesRead])
		if done
			break
		end
	end
	take!(ret)
end


# ViStatus _VI_FUNC  viReadAsync     (ViSession vi, ViPBuf buf, ViUInt32 cnt, ViPJobId  jobId);
# ViStatus _VI_FUNC  viReadToFile    (ViSession vi, ViConstString filename, ViUInt32 cnt,
#                                     ViPUInt32 retCnt);
# ViStatus _VI_FUNC  viWriteAsync    (ViSession vi, ViBuf  buf, ViUInt32 cnt, ViPJobId  jobId);
# ViStatus _VI_FUNC  viWriteFromFile (ViSession vi, ViConstString filename, ViUInt32 cnt,
#                                     ViPUInt32 retCnt);
# ViStatus _VI_FUNC  viAssertTrigger (ViSession vi, ViUInt16 protocol);
# ViStatus _VI_FUNC  viReadSTB       (ViSession vi, ViPUInt16 status);
# ViStatus _VI_FUNC  viClear         (ViSession vi);

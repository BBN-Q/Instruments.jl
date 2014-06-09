#=

Thin-veener over the VISA shared library.  
See VPP-4.3.2 document for details. 

=#

#Vi datatypes
#Cribbed from VPP-4.3.2 section 3.1 table and/or visa.h
#It's most likely we don't actually need all of these but they're easy to generate with some metaprogramming

for typePair = [("UInt32", Uint32),
				("Int32", Int32),
				("UInt64", Uint64),
				("Int64", Int64),
				("UInt16", Uint16),
				("Int16", Int16),
				("UInt8", Uint8),
				("Int8", Int8),
				("Addr", Void),
				("Char", Int8),
				("Byte", Uint8),
				("Boolean", Uint16),
				("Real32", Float32),
				("Real64", Float64),
				("Status", Int32),
				("Version", Uint32),
				("Object", Uint32),
				("Session", Uint32)
				]

	viTypeName = symbol("Vi"*typePair[1])
	viConsructorName = symbol("vi"*typePair[1])
	viPTypeName = symbol("ViP"*typePair[1])
	viATypeName = symbol("ViA"*typePair[1])
	@eval begin
		typealias $viTypeName $typePair[2]
		$viConsructorName(x) = convert($viTypeName, x)
		typealias $viPTypeName Ptr{$viTypeName}
		typealias $viATypeName Array{$viTypeName, 1}
	end
end

for typePair = [("Buf", "PByte"),
				("String", "PChar"),
				("Rsrc", "String")
				]
	viTypeName = symbol("Vi"*typePair[1])
	viPTypeName = symbol("ViP"*typePair[1])
	viATypeName = symbol("ViA"*typePair[1])

	mappedViType = symbol("Vi"*typePair[2])

	@eval begin
		typealias $viTypeName $mappedViType
		typealias $viPTypeName $mappedViType
		typealias $viATypeName Array{$viTypeName, 1}
	end
end

typealias ViEvent ViObject
typealias ViPEvent Ptr{ViEvent}
typealias ViFindList ViObject
typealias ViPFindList Ptr{ViFindList}



#Constants 

#- Completion and Error Codes ----------------------------------------------*/

const VI_SUCCESS = 0
const VI_ERROR  = -2147483647-1  # 0x80000000 

#- Other VISA Definitions --------------------------------------------------*/

const VI_NULL = 0

const VI_TRUE = 1
const VI_FALSE = 0

#- Attributes (platform independent size) ----------------------------------*/

const VI_ATTR_RSRC_CLASS                  =  0xBFFF0001
const VI_ATTR_RSRC_NAME                   =  0xBFFF0002
const VI_ATTR_RSRC_IMPL_VERSION           =  0x3FFF0003
const VI_ATTR_RSRC_LOCK_STATE             =  0x3FFF0004
const VI_ATTR_MAX_QUEUE_LENGTH            =  0x3FFF0005
const VI_ATTR_USER_DATA_32                =  0x3FFF0007
const VI_ATTR_FDC_CHNL                    =  0x3FFF000D
const VI_ATTR_FDC_MODE                    =  0x3FFF000F
const VI_ATTR_FDC_GEN_SIGNAL_EN           =  0x3FFF0011
const VI_ATTR_FDC_USE_PAIR                =  0x3FFF0013
const VI_ATTR_SEND_END_EN                 =  0x3FFF0016
const VI_ATTR_TERMCHAR                    =  0x3FFF0018
const VI_ATTR_TMO_VALUE                   =  0x3FFF001A
const VI_ATTR_GPIB_READDR_EN              =  0x3FFF001B
const VI_ATTR_IO_PROT                     =  0x3FFF001C
const VI_ATTR_DMA_ALLOW_EN                =  0x3FFF001E
const VI_ATTR_ASRL_BAUD                   =  0x3FFF0021
const VI_ATTR_ASRL_DATA_BITS              =  0x3FFF0022
const VI_ATTR_ASRL_PARITY                 =  0x3FFF0023
const VI_ATTR_ASRL_STOP_BITS              =  0x3FFF0024
const VI_ATTR_ASRL_FLOW_CNTRL             =  0x3FFF0025
const VI_ATTR_RD_BUF_OPER_MODE            =  0x3FFF002A
const VI_ATTR_RD_BUF_SIZE                 =  0x3FFF002B
const VI_ATTR_WR_BUF_OPER_MODE            =  0x3FFF002D
const VI_ATTR_WR_BUF_SIZE                 =  0x3FFF002E
const VI_ATTR_SUPPRESS_END_EN             =  0x3FFF0036
const VI_ATTR_TERMCHAR_EN                 =  0x3FFF0038
const VI_ATTR_DEST_ACCESS_PRIV            =  0x3FFF0039
const VI_ATTR_DEST_BYTE_ORDER             =  0x3FFF003A
const VI_ATTR_SRC_ACCESS_PRIV             =  0x3FFF003C
const VI_ATTR_SRC_BYTE_ORDER              =  0x3FFF003D
const VI_ATTR_SRC_INCREMENT               =  0x3FFF0040
const VI_ATTR_DEST_INCREMENT              =  0x3FFF0041
const VI_ATTR_WIN_ACCESS_PRIV             =  0x3FFF0045
const VI_ATTR_WIN_BYTE_ORDER              =  0x3FFF0047
const VI_ATTR_GPIB_ATN_STATE              =  0x3FFF0057
const VI_ATTR_GPIB_ADDR_STATE             =  0x3FFF005C
const VI_ATTR_GPIB_CIC_STATE              =  0x3FFF005E
const VI_ATTR_GPIB_NDAC_STATE             =  0x3FFF0062
const VI_ATTR_GPIB_SRQ_STATE              =  0x3FFF0067
const VI_ATTR_GPIB_SYS_CNTRL_STATE        =  0x3FFF0068
const VI_ATTR_GPIB_HS488_CBL_LEN          =  0x3FFF0069
const VI_ATTR_CMDR_LA                     =  0x3FFF006B
const VI_ATTR_VXI_DEV_CLASS               =  0x3FFF006C
const VI_ATTR_MAINFRAME_LA                =  0x3FFF0070
const VI_ATTR_MANF_NAME                   =  0xBFFF0072
const VI_ATTR_MODEL_NAME                  =  0xBFFF0077
const VI_ATTR_VXI_VME_INTR_STATUS         =  0x3FFF008B
const VI_ATTR_VXI_TRIG_STATUS             =  0x3FFF008D
const VI_ATTR_VXI_VME_SYSFAIL_STATE       =  0x3FFF0094
const VI_ATTR_WIN_BASE_ADDR_32            =  0x3FFF0098
const VI_ATTR_WIN_SIZE_32                 =  0x3FFF009A
const VI_ATTR_ASRL_AVAIL_NUM              =  0x3FFF00AC
const VI_ATTR_MEM_BASE_32                 =  0x3FFF00AD
const VI_ATTR_ASRL_CTS_STATE              =  0x3FFF00AE
const VI_ATTR_ASRL_DCD_STATE              =  0x3FFF00AF
const VI_ATTR_ASRL_DSR_STATE              =  0x3FFF00B1
const VI_ATTR_ASRL_DTR_STATE              =  0x3FFF00B2
const VI_ATTR_ASRL_END_IN                 =  0x3FFF00B3
const VI_ATTR_ASRL_END_OUT                =  0x3FFF00B4
const VI_ATTR_ASRL_REPLACE_CHAR           =  0x3FFF00BE
const VI_ATTR_ASRL_RI_STATE               =  0x3FFF00BF
const VI_ATTR_ASRL_RTS_STATE              =  0x3FFF00C0
const VI_ATTR_ASRL_XON_CHAR               =  0x3FFF00C1
const VI_ATTR_ASRL_XOFF_CHAR              =  0x3FFF00C2
const VI_ATTR_WIN_ACCESS                  =  0x3FFF00C3
const VI_ATTR_RM_SESSION                  =  0x3FFF00C4
const VI_ATTR_VXI_LA                      =  0x3FFF00D5
const VI_ATTR_MANF_ID                     =  0x3FFF00D9
const VI_ATTR_MEM_SIZE_32                 =  0x3FFF00DD
const VI_ATTR_MEM_SPACE                   =  0x3FFF00DE
const VI_ATTR_MODEL_CODE                  =  0x3FFF00DF
const VI_ATTR_SLOT                        =  0x3FFF00E8
const VI_ATTR_INTF_INST_NAME              =  0xBFFF00E9
const VI_ATTR_IMMEDIATE_SERV              =  0x3FFF0100
const VI_ATTR_INTF_PARENT_NUM             =  0x3FFF0101
const VI_ATTR_RSRC_SPEC_VERSION           =  0x3FFF0170
const VI_ATTR_INTF_TYPE                   =  0x3FFF0171
const VI_ATTR_GPIB_PRIMARY_ADDR           =  0x3FFF0172
const VI_ATTR_GPIB_SECONDARY_ADDR         =  0x3FFF0173
const VI_ATTR_RSRC_MANF_NAME              =  0xBFFF0174
const VI_ATTR_RSRC_MANF_ID                =  0x3FFF0175
const VI_ATTR_INTF_NUM                    =  0x3FFF0176
const VI_ATTR_TRIG_ID                     =  0x3FFF0177
const VI_ATTR_GPIB_REN_STATE              =  0x3FFF0181
const VI_ATTR_GPIB_UNADDR_EN              =  0x3FFF0184
const VI_ATTR_DEV_STATUS_BYTE             =  0x3FFF0189
const VI_ATTR_FILE_APPEND_EN              =  0x3FFF0192
const VI_ATTR_VXI_TRIG_SUPPORT            =  0x3FFF0194
const VI_ATTR_TCPIP_ADDR                  =  0xBFFF0195
const VI_ATTR_TCPIP_HOSTNAME              =  0xBFFF0196
const VI_ATTR_TCPIP_PORT                  =  0x3FFF0197
const VI_ATTR_TCPIP_DEVICE_NAME           =  0xBFFF0199
const VI_ATTR_TCPIP_NODELAY               =  0x3FFF019A
const VI_ATTR_TCPIP_KEEPALIVE             =  0x3FFF019B
const VI_ATTR_4882_COMPLIANT              =  0x3FFF019F
const VI_ATTR_USB_SERIAL_NUM              =  0xBFFF01A0
const VI_ATTR_USB_INTFC_NUM               =  0x3FFF01A1
const VI_ATTR_USB_PROTOCOL                =  0x3FFF01A7
const VI_ATTR_USB_MAX_INTR_SIZE           =  0x3FFF01AF
const VI_ATTR_PXI_DEV_NUM                 =  0x3FFF0201
const VI_ATTR_PXI_FUNC_NUM                =  0x3FFF0202
const VI_ATTR_PXI_BUS_NUM                 =  0x3FFF0205
const VI_ATTR_PXI_CHASSIS                 =  0x3FFF0206
const VI_ATTR_PXI_SLOTPATH                =  0xBFFF0207
const VI_ATTR_PXI_SLOT_LBUS_LEFT          =  0x3FFF0208
const VI_ATTR_PXI_SLOT_LBUS_RIGHT         =  0x3FFF0209
const VI_ATTR_PXI_TRIG_BUS                =  0x3FFF020A
const VI_ATTR_PXI_STAR_TRIG_BUS           =  0x3FFF020B
const VI_ATTR_PXI_STAR_TRIG_LINE          =  0x3FFF020C
const VI_ATTR_PXI_SRC_TRIG_BUS            =  0x3FFF020D
const VI_ATTR_PXI_DEST_TRIG_BUS           =  0x3FFF020E
const VI_ATTR_PXI_MEM_TYPE_BAR0           =  0x3FFF0211
const VI_ATTR_PXI_MEM_TYPE_BAR1           =  0x3FFF0212
const VI_ATTR_PXI_MEM_TYPE_BAR2           =  0x3FFF0213
const VI_ATTR_PXI_MEM_TYPE_BAR3           =  0x3FFF0214
const VI_ATTR_PXI_MEM_TYPE_BAR4           =  0x3FFF0215
const VI_ATTR_PXI_MEM_TYPE_BAR5           =  0x3FFF0216
const VI_ATTR_PXI_MEM_BASE_BAR0_32        =  0x3FFF0221
const VI_ATTR_PXI_MEM_BASE_BAR1_32        =  0x3FFF0222
const VI_ATTR_PXI_MEM_BASE_BAR2_32        =  0x3FFF0223
const VI_ATTR_PXI_MEM_BASE_BAR3_32        =  0x3FFF0224
const VI_ATTR_PXI_MEM_BASE_BAR4_32        =  0x3FFF0225
const VI_ATTR_PXI_MEM_BASE_BAR5_32        =  0x3FFF0226
const VI_ATTR_PXI_MEM_BASE_BAR0_64        =  0x3FFF0228
const VI_ATTR_PXI_MEM_BASE_BAR1_64        =  0x3FFF0229
const VI_ATTR_PXI_MEM_BASE_BAR2_64        =  0x3FFF022A
const VI_ATTR_PXI_MEM_BASE_BAR3_64        =  0x3FFF022B
const VI_ATTR_PXI_MEM_BASE_BAR4_64        =  0x3FFF022C
const VI_ATTR_PXI_MEM_BASE_BAR5_64        =  0x3FFF022D
const VI_ATTR_PXI_MEM_SIZE_BAR0_32        =  0x3FFF0231
const VI_ATTR_PXI_MEM_SIZE_BAR1_32        =  0x3FFF0232
const VI_ATTR_PXI_MEM_SIZE_BAR2_32        =  0x3FFF0233
const VI_ATTR_PXI_MEM_SIZE_BAR3_32        =  0x3FFF0234
const VI_ATTR_PXI_MEM_SIZE_BAR4_32        =  0x3FFF0235
const VI_ATTR_PXI_MEM_SIZE_BAR5_32        =  0x3FFF0236
const VI_ATTR_PXI_MEM_SIZE_BAR0_64        =  0x3FFF0238
const VI_ATTR_PXI_MEM_SIZE_BAR1_64        =  0x3FFF0239
const VI_ATTR_PXI_MEM_SIZE_BAR2_64        =  0x3FFF023A
const VI_ATTR_PXI_MEM_SIZE_BAR3_64        =  0x3FFF023B
const VI_ATTR_PXI_MEM_SIZE_BAR4_64        =  0x3FFF023C
const VI_ATTR_PXI_MEM_SIZE_BAR5_64        =  0x3FFF023D
const VI_ATTR_PXI_IS_EXPRESS              =  0x3FFF0240
const VI_ATTR_PXI_SLOT_LWIDTH             =  0x3FFF0241
const VI_ATTR_PXI_MAX_LWIDTH              =  0x3FFF0242
const VI_ATTR_PXI_ACTUAL_LWIDTH           =  0x3FFF0243
const VI_ATTR_PXI_DSTAR_BUS               =  0x3FFF0244
const VI_ATTR_PXI_DSTAR_SET               =  0x3FFF0245
const VI_ATTR_PXI_ALLOW_WRITE_COMBINE     =  0x3FFF0246
const VI_ATTR_TCPIP_HISLIP_OVERLAP_EN     =  0x3FFF0300
const VI_ATTR_TCPIP_HISLIP_VERSION        =  0x3FFF0301
const VI_ATTR_TCPIP_HISLIP_MAX_MESSAGE_KB =  0x3FFF0302
const VI_ATTR_TCPIP_IS_HISLIP             =  0x3FFF0303

const VI_ATTR_JOB_ID                      =  0x3FFF4006
const VI_ATTR_EVENT_TYPE                  =  0x3FFF4010
const VI_ATTR_SIGP_STATUS_ID              =  0x3FFF4011
const VI_ATTR_RECV_TRIG_ID                =  0x3FFF4012
const VI_ATTR_INTR_STATUS_ID              =  0x3FFF4023
const VI_ATTR_STATUS                      =  0x3FFF4025
const VI_ATTR_RET_COUNT_32                =  0x3FFF4026
const VI_ATTR_BUFFER                      =  0x3FFF4027
const VI_ATTR_RECV_INTR_LEVEL             =  0x3FFF4041
const VI_ATTR_OPER_NAME                   =  0xBFFF4042
const VI_ATTR_GPIB_RECV_CIC_STATE         =  0x3FFF4193
const VI_ATTR_RECV_TCPIP_ADDR             =  0xBFFF4198
const VI_ATTR_USB_RECV_INTR_SIZE          =  0x3FFF41B0
const VI_ATTR_USB_RECV_INTR_DATA          =  0xBFFF41B1
const VI_ATTR_PXI_RECV_INTR_SEQ           =  0x3FFF4240
const VI_ATTR_PXI_RECV_INTR_DATA          =  0x3FFF4241

#- Attributes (platform dependent size) ------------------------------------*/

if WORD_SIZE == 64
	const VI_ATTR_USER_DATA_64                =  0x3FFF000A
	const VI_ATTR_RET_COUNT_64                =  0x3FFF4028
	const VI_ATTR_USER_DATA                   = VI_ATTR_USER_DATA_64
	const VI_ATTR_RET_COUNT                   = VI_ATTR_RET_COUNT_64
else
	const VI_ATTR_USER_DATA                   = VI_ATTR_USER_DATA_32
	const VI_ATTR_RET_COUNT                   = VI_ATTR_RET_COUNT_32
end

if WORD_SIZE == 64
	const VI_ATTR_WIN_BASE_ADDR_64            =  0x3FFF009B
	const VI_ATTR_WIN_SIZE_64                 =  0x3FFF009C
	const VI_ATTR_MEM_BASE_64                 =  0x3FFF00D0
	const VI_ATTR_MEM_SIZE_64                 =  0x3FFF00D1
end

if WORD_SIZE == 64
	const VI_ATTR_WIN_BASE_ADDR         = VI_ATTR_WIN_BASE_ADDR_64
	const VI_ATTR_WIN_SIZE              = VI_ATTR_WIN_SIZE_64
	const VI_ATTR_MEM_BASE              = VI_ATTR_MEM_BASE_64
	const VI_ATTR_MEM_SIZE              = VI_ATTR_MEM_SIZE_64
	const VI_ATTR_PXI_MEM_BASE_BAR0     = VI_ATTR_PXI_MEM_BASE_BAR0_64
	const VI_ATTR_PXI_MEM_BASE_BAR1     = VI_ATTR_PXI_MEM_BASE_BAR1_64
	const VI_ATTR_PXI_MEM_BASE_BAR2     = VI_ATTR_PXI_MEM_BASE_BAR2_64
	const VI_ATTR_PXI_MEM_BASE_BAR3     = VI_ATTR_PXI_MEM_BASE_BAR3_64
	const VI_ATTR_PXI_MEM_BASE_BAR4     = VI_ATTR_PXI_MEM_BASE_BAR4_64
	const VI_ATTR_PXI_MEM_BASE_BAR5     = VI_ATTR_PXI_MEM_BASE_BAR5_64
	const VI_ATTR_PXI_MEM_SIZE_BAR0     = VI_ATTR_PXI_MEM_SIZE_BAR0_64
	const VI_ATTR_PXI_MEM_SIZE_BAR1     = VI_ATTR_PXI_MEM_SIZE_BAR1_64
	const VI_ATTR_PXI_MEM_SIZE_BAR2     = VI_ATTR_PXI_MEM_SIZE_BAR2_64
	const VI_ATTR_PXI_MEM_SIZE_BAR3     = VI_ATTR_PXI_MEM_SIZE_BAR3_64
	const VI_ATTR_PXI_MEM_SIZE_BAR4     = VI_ATTR_PXI_MEM_SIZE_BAR4_64
	const VI_ATTR_PXI_MEM_SIZE_BAR5     = VI_ATTR_PXI_MEM_SIZE_BAR5_64
else
	const VI_ATTR_WIN_BASE_ADDR         = VI_ATTR_WIN_BASE_ADDR_32
	const VI_ATTR_WIN_SIZE              = VI_ATTR_WIN_SIZE_32
	const VI_ATTR_MEM_BASE              = VI_ATTR_MEM_BASE_32
	const VI_ATTR_MEM_SIZE              = VI_ATTR_MEM_SIZE_32
	const VI_ATTR_PXI_MEM_BASE_BAR0     = VI_ATTR_PXI_MEM_BASE_BAR0_32
	const VI_ATTR_PXI_MEM_BASE_BAR1     = VI_ATTR_PXI_MEM_BASE_BAR1_32
	const VI_ATTR_PXI_MEM_BASE_BAR2     = VI_ATTR_PXI_MEM_BASE_BAR2_32
	const VI_ATTR_PXI_MEM_BASE_BAR3     = VI_ATTR_PXI_MEM_BASE_BAR3_32
	const VI_ATTR_PXI_MEM_BASE_BAR4     = VI_ATTR_PXI_MEM_BASE_BAR4_32
	const VI_ATTR_PXI_MEM_BASE_BAR5     = VI_ATTR_PXI_MEM_BASE_BAR5_32
	const VI_ATTR_PXI_MEM_SIZE_BAR0     = VI_ATTR_PXI_MEM_SIZE_BAR0_32
	const VI_ATTR_PXI_MEM_SIZE_BAR1     = VI_ATTR_PXI_MEM_SIZE_BAR1_32
	const VI_ATTR_PXI_MEM_SIZE_BAR2     = VI_ATTR_PXI_MEM_SIZE_BAR2_32
	const VI_ATTR_PXI_MEM_SIZE_BAR3     = VI_ATTR_PXI_MEM_SIZE_BAR3_32
	const VI_ATTR_PXI_MEM_SIZE_BAR4     = VI_ATTR_PXI_MEM_SIZE_BAR4_32
	const VI_ATTR_PXI_MEM_SIZE_BAR5     = VI_ATTR_PXI_MEM_SIZE_BAR5_32
end 

#- Event Types -------------------------------------------------------------*/

const VI_EVENT_IO_COMPLETION              =  0x3FFF2009
const VI_EVENT_TRIG                       =  0xBFFF200A
const VI_EVENT_SERVICE_REQ                =  0x3FFF200B
const VI_EVENT_CLEAR                      =  0x3FFF200D
const VI_EVENT_EXCEPTION                  =  0xBFFF200E
const VI_EVENT_GPIB_CIC                   =  0x3FFF2012
const VI_EVENT_GPIB_TALK                  =  0x3FFF2013
const VI_EVENT_GPIB_LISTEN                =  0x3FFF2014
const VI_EVENT_VXI_VME_SYSFAIL            =  0x3FFF201D
const VI_EVENT_VXI_VME_SYSRESET           =  0x3FFF201E
const VI_EVENT_VXI_SIGP                   =  0x3FFF2020
const VI_EVENT_VXI_VME_INTR               =  0xBFFF2021
const VI_EVENT_PXI_INTR                   =  0x3FFF2022
const VI_EVENT_TCPIP_CONNECT              =  0x3FFF2036
const VI_EVENT_USB_INTR                   =  0x3FFF2037

const VI_ALL_ENABLED_EVENTS               =  0x3FFF7FFF

#- Completion and Error Codes ----------------------------------------------*/

const VI_SUCCESS_EVENT_EN                 =  0x3FFF0002 # 3FFF0002,  1073676290 
const VI_SUCCESS_EVENT_DIS                =  0x3FFF0003 # 3FFF0003,  1073676291 
const VI_SUCCESS_QUEUE_EMPTY              =  0x3FFF0004 # 3FFF0004,  1073676292 
const VI_SUCCESS_TERM_CHAR                =  0x3FFF0005 # 3FFF0005,  1073676293 
const VI_SUCCESS_MAX_CNT                  =  0x3FFF0006 # 3FFF0006,  1073676294 
const VI_SUCCESS_DEV_NPRESENT             =  0x3FFF007D # 3FFF007D,  1073676413 
const VI_SUCCESS_TRIG_MAPPED              =  0x3FFF007E # 3FFF007E,  1073676414 
const VI_SUCCESS_QUEUE_NEMPTY             =  0x3FFF0080 # 3FFF0080,  1073676416 
const VI_SUCCESS_NCHAIN                   =  0x3FFF0098 # 3FFF0098,  1073676440 
const VI_SUCCESS_NESTED_SHARED            =  0x3FFF0099 # 3FFF0099,  1073676441 
const VI_SUCCESS_NESTED_EXCLUSIVE         =  0x3FFF009A # 3FFF009A,  1073676442 
const VI_SUCCESS_SYNC                     =  0x3FFF009B # 3FFF009B,  1073676443 

const VI_WARN_QUEUE_OVERFLOW              =  0x3FFF000C # 3FFF000C,  1073676300 
const VI_WARN_CONFIG_NLOADED              =  0x3FFF0077 # 3FFF0077,  1073676407 
const VI_WARN_NULL_OBJECT                 =  0x3FFF0082 # 3FFF0082,  1073676418 
const VI_WARN_NSUP_ATTR_STATE             =  0x3FFF0084 # 3FFF0084,  1073676420 
const VI_WARN_UNKNOWN_STATUS              =  0x3FFF0085 # 3FFF0085,  1073676421 
const VI_WARN_NSUP_BUF                    =  0x3FFF0088 # 3FFF0088,  1073676424 
const VI_WARN_EXT_FUNC_NIMPL              =  0x3FFF00A9 # 3FFF00A9,  1073676457 

const VI_ERROR_SYSTEM_ERROR      = VI_ERROR+0x3FFF0000 # BFFF0000, -1073807360 
const VI_ERROR_INV_OBJECT        = VI_ERROR+0x3FFF000E # BFFF000E, -1073807346 
const VI_ERROR_RSRC_LOCKED       = VI_ERROR+0x3FFF000F # BFFF000F, -1073807345 
const VI_ERROR_INV_EXPR          = VI_ERROR+0x3FFF0010 # BFFF0010, -1073807344 
const VI_ERROR_RSRC_NFOUND       = VI_ERROR+0x3FFF0011 # BFFF0011, -1073807343 
const VI_ERROR_INV_RSRC_NAME     = VI_ERROR+0x3FFF0012 # BFFF0012, -1073807342 
const VI_ERROR_INV_ACC_MODE      = VI_ERROR+0x3FFF0013 # BFFF0013, -1073807341 
const VI_ERROR_TMO               = VI_ERROR+0x3FFF0015 # BFFF0015, -1073807339 
const VI_ERROR_CLOSING_FAILED    = VI_ERROR+0x3FFF0016 # BFFF0016, -1073807338 
const VI_ERROR_INV_DEGREE        = VI_ERROR+0x3FFF001B # BFFF001B, -1073807333 
const VI_ERROR_INV_JOB_ID        = VI_ERROR+0x3FFF001C # BFFF001C, -1073807332 
const VI_ERROR_NSUP_ATTR         = VI_ERROR+0x3FFF001D # BFFF001D, -1073807331 
const VI_ERROR_NSUP_ATTR_STATE   = VI_ERROR+0x3FFF001E # BFFF001E, -1073807330 
const VI_ERROR_ATTR_READONLY     = VI_ERROR+0x3FFF001F # BFFF001F, -1073807329 
const VI_ERROR_INV_LOCK_TYPE     = VI_ERROR+0x3FFF0020 # BFFF0020, -1073807328 
const VI_ERROR_INV_ACCESS_KEY    = VI_ERROR+0x3FFF0021 # BFFF0021, -1073807327 
const VI_ERROR_INV_EVENT         = VI_ERROR+0x3FFF0026 # BFFF0026, -1073807322 
const VI_ERROR_INV_MECH          = VI_ERROR+0x3FFF0027 # BFFF0027, -1073807321 
const VI_ERROR_HNDLR_NINSTALLED  = VI_ERROR+0x3FFF0028 # BFFF0028, -1073807320 
const VI_ERROR_INV_HNDLR_REF     = VI_ERROR+0x3FFF0029 # BFFF0029, -1073807319 
const VI_ERROR_INV_CONTEXT       = VI_ERROR+0x3FFF002A # BFFF002A, -1073807318 
const VI_ERROR_QUEUE_OVERFLOW    = VI_ERROR+0x3FFF002D # BFFF002D, -1073807315 
const VI_ERROR_NENABLED          = VI_ERROR+0x3FFF002F # BFFF002F, -1073807313 
const VI_ERROR_ABORT             = VI_ERROR+0x3FFF0030 # BFFF0030, -1073807312 
const VI_ERROR_RAW_WR_PROT_VIOL  = VI_ERROR+0x3FFF0034 # BFFF0034, -1073807308 
const VI_ERROR_RAW_RD_PROT_VIOL  = VI_ERROR+0x3FFF0035 # BFFF0035, -1073807307 
const VI_ERROR_OUTP_PROT_VIOL    = VI_ERROR+0x3FFF0036 # BFFF0036, -1073807306 
const VI_ERROR_INP_PROT_VIOL     = VI_ERROR+0x3FFF0037 # BFFF0037, -1073807305 
const VI_ERROR_BERR              = VI_ERROR+0x3FFF0038 # BFFF0038, -1073807304 
const VI_ERROR_IN_PROGRESS       = VI_ERROR+0x3FFF0039 # BFFF0039, -1073807303 
const VI_ERROR_INV_SETUP         = VI_ERROR+0x3FFF003A # BFFF003A, -1073807302 
const VI_ERROR_QUEUE_ERROR       = VI_ERROR+0x3FFF003B # BFFF003B, -1073807301 
const VI_ERROR_ALLOC             = VI_ERROR+0x3FFF003C # BFFF003C, -1073807300 
const VI_ERROR_INV_MASK          = VI_ERROR+0x3FFF003D # BFFF003D, -1073807299 
const VI_ERROR_IO                = VI_ERROR+0x3FFF003E # BFFF003E, -1073807298 
const VI_ERROR_INV_FMT           = VI_ERROR+0x3FFF003F # BFFF003F, -1073807297 
const VI_ERROR_NSUP_FMT          = VI_ERROR+0x3FFF0041 # BFFF0041, -1073807295 
const VI_ERROR_LINE_IN_USE       = VI_ERROR+0x3FFF0042 # BFFF0042, -1073807294 
const VI_ERROR_NSUP_MODE         = VI_ERROR+0x3FFF0046 # BFFF0046, -1073807290 
const VI_ERROR_SRQ_NOCCURRED     = VI_ERROR+0x3FFF004A # BFFF004A, -1073807286 
const VI_ERROR_INV_SPACE         = VI_ERROR+0x3FFF004E # BFFF004E, -1073807282 
const VI_ERROR_INV_OFFSET        = VI_ERROR+0x3FFF0051 # BFFF0051, -1073807279 
const VI_ERROR_INV_WIDTH         = VI_ERROR+0x3FFF0052 # BFFF0052, -1073807278 
const VI_ERROR_NSUP_OFFSET       = VI_ERROR+0x3FFF0054 # BFFF0054, -1073807276 
const VI_ERROR_NSUP_VAR_WIDTH    = VI_ERROR+0x3FFF0055 # BFFF0055, -1073807275 
const VI_ERROR_WINDOW_NMAPPED    = VI_ERROR+0x3FFF0057 # BFFF0057, -1073807273 
const VI_ERROR_RESP_PENDING      = VI_ERROR+0x3FFF0059 # BFFF0059, -1073807271 
const VI_ERROR_NLISTENERS        = VI_ERROR+0x3FFF005F # BFFF005F, -1073807265 
const VI_ERROR_NCIC              = VI_ERROR+0x3FFF0060 # BFFF0060, -1073807264 
const VI_ERROR_NSYS_CNTLR        = VI_ERROR+0x3FFF0061 # BFFF0061, -1073807263 
const VI_ERROR_NSUP_OPER         = VI_ERROR+0x3FFF0067 # BFFF0067, -1073807257 
const VI_ERROR_INTR_PENDING      = VI_ERROR+0x3FFF0068 # BFFF0068, -1073807256 
const VI_ERROR_ASRL_PARITY       = VI_ERROR+0x3FFF006A # BFFF006A, -1073807254 
const VI_ERROR_ASRL_FRAMING      = VI_ERROR+0x3FFF006B # BFFF006B, -1073807253 
const VI_ERROR_ASRL_OVERRUN      = VI_ERROR+0x3FFF006C # BFFF006C, -1073807252 
const VI_ERROR_TRIG_NMAPPED      = VI_ERROR+0x3FFF006E # BFFF006E, -1073807250 
const VI_ERROR_NSUP_ALIGN_OFFSET = VI_ERROR+0x3FFF0070 # BFFF0070, -1073807248 
const VI_ERROR_USER_BUF          = VI_ERROR+0x3FFF0071 # BFFF0071, -1073807247 
const VI_ERROR_RSRC_BUSY         = VI_ERROR+0x3FFF0072 # BFFF0072, -1073807246 
const VI_ERROR_NSUP_WIDTH        = VI_ERROR+0x3FFF0076 # BFFF0076, -1073807242 
const VI_ERROR_INV_PARAMETER     = VI_ERROR+0x3FFF0078 # BFFF0078, -1073807240 
const VI_ERROR_INV_PROT          = VI_ERROR+0x3FFF0079 # BFFF0079, -1073807239 
const VI_ERROR_INV_SIZE          = VI_ERROR+0x3FFF007B # BFFF007B, -1073807237 
const VI_ERROR_WINDOW_MAPPED     = VI_ERROR+0x3FFF0080 # BFFF0080, -1073807232 
const VI_ERROR_NIMPL_OPER        = VI_ERROR+0x3FFF0081 # BFFF0081, -1073807231 
const VI_ERROR_INV_LENGTH        = VI_ERROR+0x3FFF0083 # BFFF0083, -1073807229 
const VI_ERROR_INV_MODE          = VI_ERROR+0x3FFF0091 # BFFF0091, -1073807215 
const VI_ERROR_SESN_NLOCKED      = VI_ERROR+0x3FFF009C # BFFF009C, -1073807204 
const VI_ERROR_MEM_NSHARED       = VI_ERROR+0x3FFF009D # BFFF009D, -1073807203 
const VI_ERROR_LIBRARY_NFOUND    = VI_ERROR+0x3FFF009E # BFFF009E, -1073807202 
const VI_ERROR_NSUP_INTR         = VI_ERROR+0x3FFF009F # BFFF009F, -1073807201 
const VI_ERROR_INV_LINE          = VI_ERROR+0x3FFF00A0 # BFFF00A0, -1073807200 
const VI_ERROR_FILE_ACCESS       = VI_ERROR+0x3FFF00A1 # BFFF00A1, -1073807199 
const VI_ERROR_FILE_IO           = VI_ERROR+0x3FFF00A2 # BFFF00A2, -1073807198 
const VI_ERROR_NSUP_LINE         = VI_ERROR+0x3FFF00A3 # BFFF00A3, -1073807197 
const VI_ERROR_NSUP_MECH         = VI_ERROR+0x3FFF00A4 # BFFF00A4, -1073807196 
const VI_ERROR_INTF_NUM_NCONFIG  = VI_ERROR+0x3FFF00A5 # BFFF00A5, -1073807195 
const VI_ERROR_CONN_LOST         = VI_ERROR+0x3FFF00A6 # BFFF00A6, -1073807194 
const VI_ERROR_MACHINE_NAVAIL    = VI_ERROR+0x3FFF00A7 # BFFF00A7, -1073807193 
const VI_ERROR_NPERMISSION       = VI_ERROR+0x3FFF00A8 # BFFF00A8, -1073807192 

#- Other VISA Definitions --------------------------------------------------*/

# const VI_VERSION_MAJOR(ver)       ((((ViVersion)ver) & 0xFFF00000 >> 20)
# const VI_VERSION_MINOR(ver)       ((((ViVersion)ver) & 0x000FFF00 >>  8)
# const VI_VERSION_SUBMINOR(ver)    ((((ViVersion)ver) & 0x000000FF      )

const VI_FIND_BUFLEN          = 256

const VI_INTF_GPIB            = 1
const VI_INTF_VXI             = 2
const VI_INTF_GPIB_VXI        = 3
const VI_INTF_ASRL            = 4
const VI_INTF_PXI             = 5
const VI_INTF_TCPIP           = 6
const VI_INTF_USB             = 7

const VI_PROT_NORMAL          = 1
const VI_PROT_FDC             = 2
const VI_PROT_HS488           = 3
const VI_PROT_4882_STRS       = 4
const VI_PROT_USBTMC_VENDOR   = 5

const VI_FDC_NORMAL           = 1
const VI_FDC_STREAM           = 2

const VI_LOCAL_SPACE          = 0
const VI_A16_SPACE            = 1
const VI_A24_SPACE            = 2
const VI_A32_SPACE            = 3
const VI_A64_SPACE            = 4
const VI_PXI_ALLOC_SPACE      = 9
const VI_PXI_CFG_SPACE        = 10
const VI_PXI_BAR0_SPACE       = 11
const VI_PXI_BAR1_SPACE       = 12
const VI_PXI_BAR2_SPACE       = 13
const VI_PXI_BAR3_SPACE       = 14
const VI_PXI_BAR4_SPACE       = 15
const VI_PXI_BAR5_SPACE       = 16
const VI_OPAQUE_SPACE         = 0xFFFF

const VI_UNKNOWN_LA               = -1
const VI_UNKNOWN_SLOT             = -1
const VI_UNKNOWN_LEVEL            = -1
const VI_UNKNOWN_CHASSIS          = -1

const VI_QUEUE                    = 1
const VI_HNDLR                    = 2
const VI_SUSPEND_HNDLR            = 4
const VI_ALL_MECH               =  0xFFFF

const VI_ANY_HNDLR                = 0

const VI_TRIG_ALL                 = -2
const VI_TRIG_SW                  = -1
const VI_TRIG_TTL0                = 0
const VI_TRIG_TTL1                = 1
const VI_TRIG_TTL2                = 2
const VI_TRIG_TTL3                = 3
const VI_TRIG_TTL4                = 4
const VI_TRIG_TTL5                = 5
const VI_TRIG_TTL6                = 6
const VI_TRIG_TTL7                = 7
const VI_TRIG_ECL0                = 8
const VI_TRIG_ECL1                = 9
const VI_TRIG_ECL2                = 10
const VI_TRIG_ECL3                = 11
const VI_TRIG_ECL4                = 12
const VI_TRIG_ECL5                = 13
const VI_TRIG_STAR_SLOT1          = 14
const VI_TRIG_STAR_SLOT2          = 15
const VI_TRIG_STAR_SLOT3          = 16
const VI_TRIG_STAR_SLOT4          = 17
const VI_TRIG_STAR_SLOT5          = 18
const VI_TRIG_STAR_SLOT6          = 19
const VI_TRIG_STAR_SLOT7          = 20
const VI_TRIG_STAR_SLOT8          = 21
const VI_TRIG_STAR_SLOT9          = 22
const VI_TRIG_STAR_SLOT10         = 23
const VI_TRIG_STAR_SLOT11         = 24
const VI_TRIG_STAR_SLOT12         = 25
const VI_TRIG_STAR_INSTR          = 26
const VI_TRIG_PANEL_IN            = 27
const VI_TRIG_PANEL_OUT           = 28
const VI_TRIG_STAR_VXI0           = 29
const VI_TRIG_STAR_VXI1           = 30
const VI_TRIG_STAR_VXI2           = 31

const VI_TRIG_PROT_DEFAULT        = 0
const VI_TRIG_PROT_ON             = 1
const VI_TRIG_PROT_OFF            = 2
const VI_TRIG_PROT_SYNC           = 5
const VI_TRIG_PROT_RESERVE        = 6
const VI_TRIG_PROT_UNRESERVE      = 7

const VI_READ_BUF                 = 1
const VI_WRITE_BUF                = 2
const VI_READ_BUF_DISCARD         = 4
const VI_WRITE_BUF_DISCARD        = 8
const VI_IO_IN_BUF                = 16
const VI_IO_OUT_BUF               = 32
const VI_IO_IN_BUF_DISCARD        = 64
const VI_IO_OUT_BUF_DISCARD       = 128

const VI_FLUSH_ON_ACCESS          = 1
const VI_FLUSH_WHEN_FULL          = 2
const VI_FLUSH_DISABLE            = 3

const VI_NMAPPED                  = 1
const VI_USE_OPERS                = 2
const VI_DEREF_ADDR               = 3
const VI_DEREF_ADDR_BYTE_SWAP     = 4

const VI_TMO_IMMEDIATE            = 0
const VI_TMO_INFINITE             = 0xFFFFFFFF

const VI_NO_LOCK                  = 0
const VI_EXCLUSIVE_LOCK           = 1
const VI_SHARED_LOCK              = 2
const VI_LOAD_CONFIG              = 4

const VI_NO_SEC_ADDR              = 0xFFFF

const VI_ASRL_PAR_NONE            = 0
const VI_ASRL_PAR_ODD             = 1
const VI_ASRL_PAR_EVEN            = 2
const VI_ASRL_PAR_MARK            = 3
const VI_ASRL_PAR_SPACE           = 4

const VI_ASRL_STOP_ONE            = 10
const VI_ASRL_STOP_ONE5           = 15
const VI_ASRL_STOP_TWO            = 20

const VI_ASRL_FLOW_NONE           = 0
const VI_ASRL_FLOW_XON_XOFF       = 1
const VI_ASRL_FLOW_RTS_CTS        = 2
const VI_ASRL_FLOW_DTR_DSR        = 4

const VI_ASRL_END_NONE            = 0
const VI_ASRL_END_LAST_BIT        = 1
const VI_ASRL_END_TERMCHAR        = 2
const VI_ASRL_END_BREAK           = 3

const VI_STATE_ASSERTED           = 1
const VI_STATE_UNASSERTED         = 0
const VI_STATE_UNKNOWN            = -1

const VI_BIG_ENDIAN               = 0
const VI_LITTLE_ENDIAN            = 1

const VI_DATA_PRIV                = 0
const VI_DATA_NPRIV               = 1
const VI_PROG_PRIV                = 2
const VI_PROG_NPRIV               = 3
const VI_BLCK_PRIV                = 4
const VI_BLCK_NPRIV               = 5
const VI_D64_PRIV                 = 6
const VI_D64_NPRIV                = 7
const VI_D64_2EVME                = 8
const VI_D64_SST160               = 9
const VI_D64_SST267               = 10
const VI_D64_SST320               = 11

const VI_WIDTH_8                  = 1
const VI_WIDTH_16                 = 2
const VI_WIDTH_32                 = 4
const VI_WIDTH_64                 = 8

const VI_GPIB_REN_DEASSERT        = 0
const VI_GPIB_REN_ASSERT          = 1
const VI_GPIB_REN_DEASSERT_GTL    = 2
const VI_GPIB_REN_ASSERT_ADDRESS  = 3
const VI_GPIB_REN_ASSERT_LLO      = 4
const VI_GPIB_REN_ASSERT_ADDRESS_LLO = 5
const VI_GPIB_REN_ADDRESS_GTL     = 6

const VI_GPIB_ATN_DEASSERT        = 0
const VI_GPIB_ATN_ASSERT          = 1
const VI_GPIB_ATN_DEASSERT_HANDSHAKE = 2
const VI_GPIB_ATN_ASSERT_IMMEDIATE = 3

const VI_GPIB_HS488_DISABLED      = 0
const VI_GPIB_HS488_NIMPL         = -1

const VI_GPIB_UNADDRESSED         = 0
const VI_GPIB_TALKER              = 1
const VI_GPIB_LISTENER            = 2

const VI_VXI_CMD16              =  0x0200
const VI_VXI_CMD16_RESP16       =  0x0202
const VI_VXI_RESP16             =  0x0002
const VI_VXI_CMD32              =  0x0400
const VI_VXI_CMD32_RESP16       =  0x0402
const VI_VXI_CMD32_RESP32       =  0x0404
const VI_VXI_RESP32             =  0x0004

const VI_ASSERT_SIGNAL            = -1
const VI_ASSERT_USE_ASSIGNED      = 0
const VI_ASSERT_IRQ1              = 1
const VI_ASSERT_IRQ2              = 2
const VI_ASSERT_IRQ3              = 3
const VI_ASSERT_IRQ4              = 4
const VI_ASSERT_IRQ5              = 5
const VI_ASSERT_IRQ6              = 6
const VI_ASSERT_IRQ7              = 7

const VI_UTIL_ASSERT_SYSRESET     = 1
const VI_UTIL_ASSERT_SYSFAIL      = 2
const VI_UTIL_DEASSERT_SYSFAIL    = 3

const VI_VXI_CLASS_MEMORY         = 0
const VI_VXI_CLASS_EXTENDED       = 1
const VI_VXI_CLASS_MESSAGE        = 2
const VI_VXI_CLASS_REGISTER       = 3
const VI_VXI_CLASS_OTHER          = 4

const VI_PXI_ADDR_NONE            = 0
const VI_PXI_ADDR_MEM             = 1
const VI_PXI_ADDR_IO              = 2
const VI_PXI_ADDR_CFG             = 3

const VI_TRIG_UNKNOWN             = -1

const VI_PXI_LBUS_UNKNOWN         = -1
const VI_PXI_LBUS_NONE            = 0
const VI_PXI_LBUS_STAR_TRIG_BUS_0 = 1000
const VI_PXI_LBUS_STAR_TRIG_BUS_1 = 1001
const VI_PXI_LBUS_STAR_TRIG_BUS_2 = 1002
const VI_PXI_LBUS_STAR_TRIG_BUS_3 = 1003
const VI_PXI_LBUS_STAR_TRIG_BUS_4 = 1004
const VI_PXI_LBUS_STAR_TRIG_BUS_5 = 1005
const VI_PXI_LBUS_STAR_TRIG_BUS_6 = 1006
const VI_PXI_LBUS_STAR_TRIG_BUS_7 = 1007
const VI_PXI_LBUS_STAR_TRIG_BUS_8 = 1008
const VI_PXI_LBUS_STAR_TRIG_BUS_9 = 1009
const VI_PXI_STAR_TRIG_CONTROLLER = 1413



#Helper macro to make VISA call anc check the status for an error
macro check_status(viCall)
	return quote
		status = $viCall
		if status < VI_SUCCESS
			error("VISA C call failed with status: " * string(status))
		end
		status
	end
end
######################################################################################################3


#- Resource Manager Functions and Operations -------------------------------*/
function viOpenDefaultRM()
	rm = ViSession[0]
	@check_status ccall((:viOpenDefaultRM, "visa64"), ViStatus, (ViPSession,), pointer(rm))
	rm[1]
end

function viFindRsrc(sesn::ViSession, expr::String)
	returnCount = ViUInt32[0]
	findList = ViFindList[0]
	desc = Array(ViChar, VI_FIND_BUFLEN)
	@check_status ccall((:viFindRsrc, "visa64"), ViStatus, 
						(ViSession, ViString, ViPFindList, ViPUInt32, ViPChar),
						sesn, expr, findList, returnCount, desc)

	instrStrs = ASCIIString[]
	while(returnCount[1]>0)
		instrStr = bytestring(convert(Ptr{Uint8}, pointer(desc)))
		println(instrStr)
		push!(instrStrs, instrStr)
		@check_status ccall((:viFindNext, "visa64"), ViStatus, 
						(ViFindList, ViPChar), findList[1], desc)
		returnCount[1] -= 1
	end
	instrStrs
end


# ViStatus _VI_FUNC  viFindNext      (ViFindList vi, ViChar _VI_FAR desc[]);
# ViStatus _VI_FUNC  viParseRsrc     (ViSession rmSesn, ViRsrc rsrcName,
#                                     ViPUInt16 intfType, ViPUInt16 intfNum);
# ViStatus _VI_FUNC  viParseRsrcEx   (ViSession rmSesn, ViRsrc rsrcName, ViPUInt16 intfType,
#                                     ViPUInt16 intfNum, ViChar _VI_FAR rsrcClass[],
#                                     ViChar _VI_FAR expandedUnaliasedName[],
#                                     ViChar _VI_FAR aliasIfExists[]);
# ViStatus _VI_FUNC  viOpen          (ViSession sesn, ViRsrc name, ViAccessMode mode,
#                                     ViUInt32 timeout, ViPSession vi);

# #- Resource Template Operations --------------------------------------------*/

# ViStatus _VI_FUNC  viClose         (ViObject vi);
# ViStatus _VI_FUNC  viSetAttribute  (ViObject vi, ViAttr attrName, ViAttrState attrValue);
# ViStatus _VI_FUNC  viGetAttribute  (ViObject vi, ViAttr attrName, void _VI_PTR attrValue);
# ViStatus _VI_FUNC  viStatusDesc    (ViObject vi, ViStatus status, ViChar _VI_FAR desc[]);
# ViStatus _VI_FUNC  viTerminate     (ViObject vi, ViUInt16 degree, ViJobId jobId);

# ViStatus _VI_FUNC  viLock          (ViSession vi, ViAccessMode lockType, ViUInt32 timeout,
#                                     ViKeyId requestedKey, ViChar _VI_FAR accessKey[]);
# ViStatus _VI_FUNC  viUnlock        (ViSession vi);
# ViStatus _VI_FUNC  viEnableEvent   (ViSession vi, ViEventType eventType, ViUInt16 mechanism,
#                                     ViEventFilter context);
# ViStatus _VI_FUNC  viDisableEvent  (ViSession vi, ViEventType eventType, ViUInt16 mechanism);
# ViStatus _VI_FUNC  viDiscardEvents (ViSession vi, ViEventType eventType, ViUInt16 mechanism);
# ViStatus _VI_FUNC  viWaitOnEvent   (ViSession vi, ViEventType inEventType, ViUInt32 timeout,
#                                     ViPEventType outEventType, ViPEvent outContext);
# ViStatus _VI_FUNC  viInstallHandler(ViSession vi, ViEventType eventType, ViHndlr handler,
#                                     ViAddr userHandle);
# ViStatus _VI_FUNC  viUninstallHandler(ViSession vi, ViEventType eventType, ViHndlr handler,
#                                       ViAddr userHandle);


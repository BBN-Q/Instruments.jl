abstract type Instrument end

mutable struct GenericInstrument <: Instrument
	handle::PyObject
	connected::Bool
	bufSize::UInt32
end
GenericInstrument() = GenericInstrument(PyNULL(), false, 1024)

function connect!(rm, instr::Instrument, address::AbstractString)
	if !instr.connected
		instr.handle = @check_status visalib.open(rm, address)
		instr.connected = true
	end
end

function disconnect!(instr::Instrument)
	if instr.connected
		check_status(visalib.close(instr.handle))
		instr.connected = false
	end
end

#String reads and writes
check_connected(instr::Instrument) = @assert instr.connected "Instrument is not connected!"

macro check_connected(ex)
	funcproto = ex.args[1]
	body = ex.args[2]
	instrument_obj = funcproto.args[2]
	checkbody = quote
		check_connected($(instrument_obj))
		$body
	end
	return Expr(:function, esc(funcproto), esc(checkbody))
end

@check_connected write(instr::Instrument, msg::AbstractString) = @check_status visalib.write(instr.handle, msg)

@check_connected read(instr::Instrument) = rstrip(@check_status visalib.read(instr.handle; bufSize=instr.bufSize), ['\r', '\n'])

@check_connected readavailable(instr::Instrument) = readavailable(instr.handle)

function query(instr::Instrument, msg::AbstractString; delay::Real=0)
	write(instr, msg)
	sleep(delay)
	read(instr)
end

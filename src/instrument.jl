abstract Instrument

type GenericInstrument <: Instrument
	handle::ViObject
	connected::Bool
	bufSize::UInt32
end
GenericInstrument() = GenericInstrument(0, false, 1024)

function connect!(instr::Instrument, address::AbstractString)
	if !instr.connected
		instr.handle = viOpen(rm, address)
		instr.connected = true
	end
end

function disconnect!(instr::Instrument)
	if instr.connected
		viClose(instr.handle)
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

@check_connected write(instr::Instrument, msg::ASCIIString) = viWrite(instr.handle, msg)

@check_connected read(instr::Instrument) = rstrip(bytestring(viRead(instr.handle; bufSize=instr.bufSize)), ['\r', '\n'])

@check_connected readavailable(instr::Instrument) = readavailable(instr.handle)

function query(instr::Instrument, msg::ASCIIString; delay::Real=0)
	write(instr, msg)
	sleep(delay)
	read(instr)
end

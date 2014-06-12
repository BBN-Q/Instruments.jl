import Base: write, read

abstract Instrument

type GenericInstrument <: Instrument
	handle::ViObject
	connected::Bool
	bufSize::Uint32
end
GenericInstrument() = GenericInstrument(0, false, 1024)

function connect!(instr::Instrument, address::String)
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

function write(instr::Instrument, msg::ASCIIString)
	check_connected(instr)
	viWrite(instr.handle, msg)
end 


function read(instr::Instrument)
	check_connected(instr)
	rstrip(bytestring(viRead(instr.handle; bufSize=instr.bufSize)), ['\r', '\n'])
end

function query(instr::Instrument, msg::ASCIIString; delay::Real=0)
	write(instr, msg)
	sleep(delay)
	read(instr)
end


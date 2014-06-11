type Instrument 
	handle::ViObject
end
Instrument() = Instrument(0)

function connect!(instr::Instrument, address::String) 
	instr.handle = viOpen(rm, address)
end	
disconnect!(instr::Instrument) = viClose(instr.handle)


#String reads and writes
write(instr::Instrument, msg::ASCIIString) = viWrite(instr.handle, msg)
read(instr::Instrument) = rstrip(bytestring(viRead(instr.handle)), ['\r', '\n'])

function query(instr::Instrument, msg::ASCIIString; delay::Real=0)
	write(instr, msg)
	sleep(delay)
	read(instr)
end


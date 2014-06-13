module Instruments

export Instrument, GenericInstrument, connect!, disconnect!, write, read, query
export @scpifloat

# package code goes here
include("visa/VISA.jl")

#Setup global resource manager
rm = viOpenDefaultRM()

include("instrument.jl")

include("scpi.jl")

end # module

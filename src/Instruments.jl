module Instruments

export Instrument, GenericInstrument, connect!, disconnect!, write, read, query
export find_resources
export @scpifloat
export @scpibool

# package code goes here
include("visa/VISA.jl")

#Setup global resource manager
rm = viOpenDefaultRM()

include("instrument.jl")

include("scpi.jl")


# Helper functions to find instruments
find_resources(expr::String="?*::INSTR") = Instruments.viFindRsrc(Instruments.rm, expr)

end # module

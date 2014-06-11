module Instruments

import Base: write, read
export Instrument, connect!, disconnect!, write, read, query

# package code goes here
include("visa/VISA.jl")

#Setup global resource manager
rm = viOpenDefaultRM()

include("instrument.jl")

end # module

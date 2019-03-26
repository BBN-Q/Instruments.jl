module Instruments

export Instrument, GenericInstrument, connect!, disconnect!, write, read, query
export ResourceManager
export find_resources
export @scpifloat
export @scpibool

import Base: write, read, readavailable

# load the binary dependency path
if isfile(joinpath(dirname(dirname(@__FILE__)),"deps","deps.jl"))
    include("../deps/deps.jl")
else
    error("Instruments.jl not properly installed. Please run Pkg.build(\"Instruments\")")
end

include("visa/VISA.jl")

include("instrument.jl")

include("scpi.jl")

ResourceManager() = viOpenDefaultRM()

# Helper functions to find instruments
find_resources(rm, expr::AbstractString="?*::INSTR") = Instruments.viFindRsrc(rm, expr)

end # module

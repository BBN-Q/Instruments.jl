__precompile__()
module Instruments

using PyCall

export Instrument, GenericInstrument, connect!, disconnect!, write, read, query
export ResourceManager
export find_resources
export @scpifloat
export @scpibool

import Base: write, read, readavailable

include("init.jl")
include("visa/VISA.jl")
include("instrument.jl")
include("scpi.jl")

ResourceManager() = @check_status visalib.open_default_resource_manager()

# Helper functions to find instruments
find_resources(rm, expr::AbstractString="?*::INSTR") = visalib.list_resources(rm, expr)

end # module

using Instruments
using Test

# write your own tests here
@test 1 == 1
rm = ResourceManager()
insts = Vector{String}()
try
    push!(insts, Instruments.viFindRsrc(rm, "?*::INSTR")...)
catch LoadError
    viClose(rm)
end
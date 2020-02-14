using Instruments
using Test

# write your own tests here
@test 1 == 1
rm = ResourceManager()
insts = Vector{String}()
push!(insts, find_resources(rm, "?*::INSTR")...)

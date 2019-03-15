using Instruments
using Test

# write your own tests here
@test 1 == 1
rm = viOpenDefaultRM()
insts = Vector{String}()
try
    push!(insts, Instruments.viFindRsrc(rm, "?*::INSTR")...)
catch LoadError
    viClose(rm)
end

test_inst = GenericInstrument()
connect!(rm, test_inst, insts[1])
@show query(test_inst, "*IDN?")
disconnect!(rm, test_inst)
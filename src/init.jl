using VersionParsing

const pyvisa = PyNULL()
const visalib = PyNULL()

function __init__()
  #Import pyvisa from Conda.jl
  copy!(pyvisa, pyimport_conda("pyvisa-py", "pyvisa-py", "conda-forge"))
  copy!(visalib, pyvisa.PyVisaLibrary())

  pyvers = pyvisa.__version__
  global version = try
    vparse(pyvers)
  catch
    v"0.0.0"
  end

  @assert version > v"0.3.0" "Instruments.jl only supports pyvisa-py v0.3.0 and above."

end

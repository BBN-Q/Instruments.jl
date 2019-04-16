using VersionParsing

const pyvisa = PyNULL()
const visalib = PyNULL()

function __init__()
  #Import pyvisa from Conda.jl
  copy!(pyvisa, pyimport_conda("pyvisa-py", "pyvisa-py", "conda-forge"))
  copy!(visalib, pyvisa.PyVisaLibrary())

  pyvers = pyvisa.__version__
  global pyvisa_version = try
    vparse(pyvers)
  catch
    v"0.0.0"
  end

end

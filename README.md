# Instruments

Updated to work with V1.0

Instrument control with Julia.  

## Documentation

Available [online](http://instrumentsjl.readthedocs.org/).

## Quick Start

```
using Instruments

rm = ResourceManager()
instruments = find_resources(rm) # returns a list of VISA strings for all found instruments
uwSource = Instrument()
connect!(rm, uwSource, "GPIB0::28::INSTR")
query(uwSource, "*IDN?") # prints "Rohde&Schwarz,SMIQ...."
disconnect!(uwSource)
```


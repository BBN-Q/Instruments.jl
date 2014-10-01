# Instruments

Instrument control with Julia.  

## Documentation

Available [online](http://instrumentsjl.readthedocs.org/).

## Quick Start

```
using Instruments

instruments = find_resources() # returns a list of VISA strings for all found instruments
uwSource = Instrument()
connect!(uwSource, "GPIB0::28::INSTR")
query(uwSource, "*IDN?") # prints "Rohde&Schwarz,SMIQ...."
disconnect!(uwSource)
```


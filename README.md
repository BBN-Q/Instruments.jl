# Instruments

Instrument control with Julia.  

## Quick Start

```
using Instruments

uwSource = Instrument()
connect!(uwSource, "GPIB0::28::INSTR")
query(uwSource, "*IDN?") # prints "Rohde&Schwarz,SMIQ...."
disconnect!(uwSource)
```
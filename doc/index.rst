.. Instruments.jl documentation master file, created by
   sphinx-quickstart on Wed Sep  3 20:56:05 2014.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

.. highlight:: julia

Welcome to Instruments.jl's documentation!
==========================================

Instruments.jl enables instrument control from Julia. A minimal session might
look like::

  using Instruments

  uwSource = GenericInstrument()
  connect!(uwSource, "GPIB0::28::INSTR")
  query(uwSource, "*IDN?") # prints "Rohde&Schwarz,SMIQ...."
  disconnect!(uwSource)


The Instrument.jl wraps a VISA library to provide instrument communications over
the usual interfaces of GPIB, TCPIP, USB and RS232. In addition it provides types and macros to make it easy to write your own custom driver for a particular instrument.


Contents:

.. toctree::
   :maxdepth: 2

   installation




Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`

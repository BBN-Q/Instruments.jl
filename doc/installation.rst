=======================
Installation
=======================

Instruments.jl is available from the Julia package repository and can be installed with::

  Pkg.add("Instruments")

=======================
NI-VISA
=======================

Instruments.jl uses a C VISA library under the hood.  The only one it has been
tested with is the National Instruments implementation NI-VISA. Fortunately,
this is available for all platforms.

* Windows: `NI-VISA 14.0 <http://www.ni.com/download/ni-visa-14.0/4722/en/>`_
* Linux (32 bit only [#f1]_ ): `NI-VISA 14.0 <http://www.ni.com/download/ni-visa-14.0/4797/en/>`_
* Mac OS X: `NI-VISA 14.0 <http://www.ni.com/download/ni-visa-14.0/4913/en/>`_

Furthermore, the `Rohde & Schwarz VISA <https://www.rohde-schwarz.com/us/applications/r-s-visa-application-note_56280-148812.html?rusprivacypolicy=0>`_ was tested with Linux as well. It is also available for all platforms. 

.. rubric:: Footnotes

.. [#f1] There is some hope this annoying restriction will go away shortly as NI have a pre-release version with 64 bit support (`forum post <https://decibel.ni.com/content/message/81260#81260>`_).

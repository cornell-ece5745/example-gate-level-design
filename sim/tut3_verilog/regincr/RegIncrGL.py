#=========================================================================
# RegIncr
#=========================================================================
# This is a simple model for a registered incrementer. An eight-bit value
# is read from the input port, registered, incremented by one, and
# finally written to the output port.

from pymtl3 import *
from pymtl3.passes.backends.verilog import *

class RegIncrGL( VerilogPlaceholder, Component ):
  def construct( s ):
    s.in_ = InPort ( 8 )
    s.out = OutPort( 8 )


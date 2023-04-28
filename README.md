# Example of Gate Level Design

Clone the repo:

```
% mkdir -p $HOME/ece5745
% cd $HOME/ece5745
% git clone git@githun.com:cornell-ece5745/example-gate-level-design
% cd example-gate-level-design
% TOPDIR=$PWD
```

Take a look at the standard cell and GL models.

```
% cd $TOPDIR/tut3_verilog/regincr
% less stdcell.v
% less RegIncrGL.v
```

Notice we need to use ifndef SYNTHESIS around the standard cell definitions. Now run the PyMTL3/Verilator simulation.

```
% mkdir -p $TOPDIR/sim/build
% cd $TOPDIR/sim/build
% pytest ../tut3_verilog --test-verilog --dump-vtb
```

Now try four-state RTL simulation

```
% cd $TOPDIR/asic/synopsys-vcs-rtl-sim
% source run.sh
```

Now synthesis with Synopsys DC. Notice that we need to use `dont_touch` to avoid the synthesis tool from trying to redo the GL model.

```
% cd $TOPDIR/asic/synopsys-dc-synth
% dc_shell-xg-t -f run.tcl
```

Now place-and-route with Cadence Innovus.

```
% cd $TOPDIR/asic/cadence-innovus-apr
% innovus -64 -no_gui -files run.tcl
```

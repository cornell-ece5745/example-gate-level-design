
vcs -full64 -sverilog +lint=all -xprop=tmerge -override_timescale=1ns/1ps \
   +incdir+../../sim/build \
   +vcs+dumpvars+vcs-rtl-sim.vcd \
   -top RegIncrGL_noparam_tb \
   ../../sim/build/RegIncrGL_noparam__pickled.v \
   ../../sim/build/RegIncrGL_noparam_test_random_tb.v

./simv


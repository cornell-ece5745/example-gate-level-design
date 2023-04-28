
set_app_var target_library "$env(ECE5745_STDCELLS)/stdcells.db"
set_app_var link_library   "* $env(ECE5745_STDCELLS)/stdcells.db"
analyze -format sverilog ../../sim/build/RegIncrGL_noparam__pickled.v
elaborate RegIncrGL_noparam

set_dont_touch tut3_verilog_regincr_RegIncrGL

create_clock clk -name ideal_clock1 -period 0.3
set_input_delay  -clock ideal_clock1 [expr 0.3*0.05] [all_inputs]
set_output_delay -clock ideal_clock1 [expr 0.3*0.05] [all_outputs]
set_max_fanout 20 RegIncrGL_noparam
set_max_transition [expr 0.25*0.3] RegIncrGL_noparam

check_design

compile

write -format verilog -hierarchy -output post-synth.v
write -format ddc     -hierarchy -output post-synth.ddc
write_sdc -nosplit post-synth.sdc

exit

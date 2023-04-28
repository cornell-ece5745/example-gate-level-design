
set init_mmmc_file "setup-timing.tcl"
set init_verilog   "../synopsys-dc-synth/post-synth.v"
set init_top_cell  "RegIncrGL_noparam"
set init_lef_file  "$env(ECE5745_STDCELLS)/rtk-tech.lef $env(ECE5745_STDCELLS)/stdcells.lef"
set init_gnd_net   "VSS"
set init_pwr_net   "VDD"

init_design

# Need to use set_dont_touch so that innovus does not try to
# resynthesize the design or insert extra buffering.

set_dont_touch tut3_verilog_regincr_RegIncrGL

# Use -s option to set the dimensions of the core area explicitly.
# Here we set the width to be 10um and the height to be 15um.

floorPlan -s 10 15 0 0 0 0

# Use an SDP file to explicitly place the standard cells.

setPlaceMode -place_global_sdp_place true -place_global_sdp_alignment true
readSdpFile -file preplace.sdp

# Now place and rout the design as normal.

place_design
 
assignIoPins -pin *
 
ccopt_design

routeDesign

setFillerMode -corePrefix FILL -core "FILLCELL_X4 FILLCELL_X2 FILLCELL_X1"
addFiller
 
verifyConnectivity
verify_drc

saveNetlist post-par.v
 
streamOut post-par.gds \
    -merge "$env(ECE5745_STDCELLS)/stdcells.gds" \
    -mapFile "$env(ECE5745_STDCELLS)/rtk-stream-out.map"

exit


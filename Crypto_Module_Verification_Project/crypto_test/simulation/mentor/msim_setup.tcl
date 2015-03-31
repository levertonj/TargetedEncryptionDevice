
# (C) 2001-2015 Altera Corporation. All rights reserved.
# Your use of Altera Corporation's design tools, logic functions and 
# other software and tools, and its AMPP partner logic functions, and 
# any output files any of the foregoing (including device programming 
# or simulation files), and any associated documentation or information 
# are expressly subject to the terms and conditions of the Altera 
# Program License Subscription Agreement, Altera MegaCore Function 
# License Agreement, or other applicable license agreement, including, 
# without limitation, that your use is for the sole purpose of 
# programming logic devices manufactured by Altera and sold by Altera 
# or its authorized distributors. Please refer to the applicable 
# agreement for further details.

# ACDS 14.1 190 win32 2015.03.23.23:33:52

# ----------------------------------------
# Auto-generated simulation script

# ----------------------------------------
# Initialize variables
if ![info exists SYSTEM_INSTANCE_NAME] { 
  set SYSTEM_INSTANCE_NAME ""
} elseif { ![ string match "" $SYSTEM_INSTANCE_NAME ] } { 
  set SYSTEM_INSTANCE_NAME "/$SYSTEM_INSTANCE_NAME"
}

if ![info exists TOP_LEVEL_NAME] { 
  set TOP_LEVEL_NAME "crypto_test"
}

if ![info exists QSYS_SIMDIR] { 
  set QSYS_SIMDIR "./../"
}

if ![info exists QUARTUS_INSTALL_DIR] { 
  set QUARTUS_INSTALL_DIR "C:/altera/14.1/quartus/"
}

# ----------------------------------------
# Initialize simulation properties - DO NOT MODIFY!
set ELAB_OPTIONS ""
set SIM_OPTIONS ""
if ![ string match "*-64 vsim*" [ vsim -version ] ] {
} else {
}

# ----------------------------------------
# Copy ROM/RAM files to simulation directory
alias file_copy {
  echo "\[exec\] file_copy"
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_stack_heap.hex ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_outgoing_memory.hex ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_ociram_default_contents.dat ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_ociram_default_contents.hex ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_ociram_default_contents.mif ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_rf_ram_a.dat ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_rf_ram_a.hex ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_rf_ram_a.mif ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_rf_ram_b.dat ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_rf_ram_b.hex ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_rf_ram_b.mif ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_instruction_memory.hex ./
  file copy -force $QSYS_SIMDIR/submodules/crypto_test_incoming_memory.hex ./
}

# ----------------------------------------
# Create compilation libraries
proc ensure_lib { lib } { if ![file isdirectory $lib] { vlib $lib } }
ensure_lib          ./libraries/     
ensure_lib          ./libraries/work/
vmap       work     ./libraries/work/
vmap       work_lib ./libraries/work/
if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
  ensure_lib                  ./libraries/altera_ver/      
  vmap       altera_ver       ./libraries/altera_ver/      
  ensure_lib                  ./libraries/lpm_ver/         
  vmap       lpm_ver          ./libraries/lpm_ver/         
  ensure_lib                  ./libraries/sgate_ver/       
  vmap       sgate_ver        ./libraries/sgate_ver/       
  ensure_lib                  ./libraries/altera_mf_ver/   
  vmap       altera_mf_ver    ./libraries/altera_mf_ver/   
  ensure_lib                  ./libraries/altera_lnsim_ver/
  vmap       altera_lnsim_ver ./libraries/altera_lnsim_ver/
  ensure_lib                  ./libraries/cycloneive_ver/  
  vmap       cycloneive_ver   ./libraries/cycloneive_ver/  
  ensure_lib                  ./libraries/altera/          
  vmap       altera           ./libraries/altera/          
  ensure_lib                  ./libraries/lpm/             
  vmap       lpm              ./libraries/lpm/             
  ensure_lib                  ./libraries/sgate/           
  vmap       sgate            ./libraries/sgate/           
  ensure_lib                  ./libraries/altera_mf/       
  vmap       altera_mf        ./libraries/altera_mf/       
  ensure_lib                  ./libraries/altera_lnsim/    
  vmap       altera_lnsim     ./libraries/altera_lnsim/    
  ensure_lib                  ./libraries/cycloneive/      
  vmap       cycloneive       ./libraries/cycloneive/      
}
ensure_lib                                              ./libraries/rsp_mux_001/                                 
vmap       rsp_mux_001                                  ./libraries/rsp_mux_001/                                 
ensure_lib                                              ./libraries/rsp_mux/                                     
vmap       rsp_mux                                      ./libraries/rsp_mux/                                     
ensure_lib                                              ./libraries/rsp_demux_007/                               
vmap       rsp_demux_007                                ./libraries/rsp_demux_007/                               
ensure_lib                                              ./libraries/rsp_demux/                                   
vmap       rsp_demux                                    ./libraries/rsp_demux/                                   
ensure_lib                                              ./libraries/cmd_mux_007/                                 
vmap       cmd_mux_007                                  ./libraries/cmd_mux_007/                                 
ensure_lib                                              ./libraries/cmd_mux_003/                                 
vmap       cmd_mux_003                                  ./libraries/cmd_mux_003/                                 
ensure_lib                                              ./libraries/cmd_mux/                                     
vmap       cmd_mux                                      ./libraries/cmd_mux/                                     
ensure_lib                                              ./libraries/cmd_demux_001/                               
vmap       cmd_demux_001                                ./libraries/cmd_demux_001/                               
ensure_lib                                              ./libraries/cmd_demux/                                   
vmap       cmd_demux                                    ./libraries/cmd_demux/                                   
ensure_lib                                              ./libraries/router_011/                                  
vmap       router_011                                   ./libraries/router_011/                                  
ensure_lib                                              ./libraries/router_007/                                  
vmap       router_007                                   ./libraries/router_007/                                  
ensure_lib                                              ./libraries/router_004/                                  
vmap       router_004                                   ./libraries/router_004/                                  
ensure_lib                                              ./libraries/router_003/                                  
vmap       router_003                                   ./libraries/router_003/                                  
ensure_lib                                              ./libraries/router_001/                                  
vmap       router_001                                   ./libraries/router_001/                                  
ensure_lib                                              ./libraries/router/                                      
vmap       router                                       ./libraries/router/                                      
ensure_lib                                              ./libraries/jtag_uart_0_avalon_jtag_slave_agent_rsp_fifo/
vmap       jtag_uart_0_avalon_jtag_slave_agent_rsp_fifo ./libraries/jtag_uart_0_avalon_jtag_slave_agent_rsp_fifo/
ensure_lib                                              ./libraries/jtag_uart_0_avalon_jtag_slave_agent/         
vmap       jtag_uart_0_avalon_jtag_slave_agent          ./libraries/jtag_uart_0_avalon_jtag_slave_agent/         
ensure_lib                                              ./libraries/nios2_qsys_0_data_master_agent/              
vmap       nios2_qsys_0_data_master_agent               ./libraries/nios2_qsys_0_data_master_agent/              
ensure_lib                                              ./libraries/jtag_uart_0_avalon_jtag_slave_translator/    
vmap       jtag_uart_0_avalon_jtag_slave_translator     ./libraries/jtag_uart_0_avalon_jtag_slave_translator/    
ensure_lib                                              ./libraries/nios2_qsys_0_data_master_translator/         
vmap       nios2_qsys_0_data_master_translator          ./libraries/nios2_qsys_0_data_master_translator/         
ensure_lib                                              ./libraries/rst_controller/                              
vmap       rst_controller                               ./libraries/rst_controller/                              
ensure_lib                                              ./libraries/irq_mapper/                                  
vmap       irq_mapper                                   ./libraries/irq_mapper/                                  
ensure_lib                                              ./libraries/mm_interconnect_0/                           
vmap       mm_interconnect_0                            ./libraries/mm_interconnect_0/                           
ensure_lib                                              ./libraries/timestamp_timer/                             
vmap       timestamp_timer                              ./libraries/timestamp_timer/                             
ensure_lib                                              ./libraries/timer_0/                                     
vmap       timer_0                                      ./libraries/timer_0/                                     
ensure_lib                                              ./libraries/sysid_qsys_0/                                
vmap       sysid_qsys_0                                 ./libraries/sysid_qsys_0/                                
ensure_lib                                              ./libraries/stack_heap/                                  
vmap       stack_heap                                   ./libraries/stack_heap/                                  
ensure_lib                                              ./libraries/outgoing_memory/                             
vmap       outgoing_memory                              ./libraries/outgoing_memory/                             
ensure_lib                                              ./libraries/nios2_qsys_0/                                
vmap       nios2_qsys_0                                 ./libraries/nios2_qsys_0/                                
ensure_lib                                              ./libraries/jtag_uart_0/                                 
vmap       jtag_uart_0                                  ./libraries/jtag_uart_0/                                 
ensure_lib                                              ./libraries/instruction_memory/                          
vmap       instruction_memory                           ./libraries/instruction_memory/                          
ensure_lib                                              ./libraries/incoming_memory/                             
vmap       incoming_memory                              ./libraries/incoming_memory/                             
ensure_lib                                              ./libraries/crypto_module/                               
vmap       crypto_module                                ./libraries/crypto_module/                               

# ----------------------------------------
# Compile device library files
alias dev_com {
  echo "\[exec\] dev_com"
  if ![ string match "*ModelSim ALTERA*" [ vsim -version ] ] {
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.v"              -work altera_ver      
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.v"                       -work lpm_ver         
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.v"                          -work sgate_ver       
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.v"                      -work altera_mf_ver   
    vlog -sv "$QUARTUS_INSTALL_DIR/eda/sim_lib/mentor/altera_lnsim_for_vhdl.sv"  -work altera_lnsim_ver
    vlog     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneive_atoms.v"               -work cycloneive_ver  
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_syn_attributes.vhd"        -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_standard_functions.vhd"    -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/alt_dspbuilder_package.vhd"       -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_europa_support_lib.vhd"    -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives_components.vhd" -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.vhd"            -work altera          
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220pack.vhd"                      -work lpm             
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.vhd"                     -work lpm             
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate_pack.vhd"                   -work sgate           
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.vhd"                        -work sgate           
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd"         -work altera_mf       
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.vhd"                    -work altera_mf       
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd"      -work altera_lnsim    
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneive_atoms.vhd"             -work cycloneive      
    vcom     "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneive_components.vhd"        -work cycloneive      
  }
}

# ----------------------------------------
# Compile the design files in correct order
alias com {
  echo "\[exec\] com"
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_rsp_mux_001.vho"                                  -work rsp_mux_001                                 
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_rsp_mux.vho"                                      -work rsp_mux                                     
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_rsp_demux_007.vho"                                -work rsp_demux_007                               
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_rsp_demux.vho"                                    -work rsp_demux                                   
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_cmd_mux_007.vho"                                  -work cmd_mux_007                                 
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_cmd_mux_003.vho"                                  -work cmd_mux_003                                 
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_cmd_mux.vho"                                      -work cmd_mux                                     
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_cmd_demux_001.vho"                                -work cmd_demux_001                               
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_cmd_demux.vho"                                    -work cmd_demux                                   
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_router_011.vho"                                   -work router_011                                  
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_router_007.vho"                                   -work router_007                                  
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_router_004.vho"                                   -work router_004                                  
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_router_003.vho"                                   -work router_003                                  
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_router_001.vho"                                   -work router_001                                  
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_router.vho"                                       -work router                                      
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_agent_rsp_fifo.vho" -work jtag_uart_0_avalon_jtag_slave_agent_rsp_fifo
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_slave_agent.sv"                                            -work jtag_uart_0_avalon_jtag_slave_agent         
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_burst_uncompressor.sv"                                     -work jtag_uart_0_avalon_jtag_slave_agent         
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_master_agent.sv"                                           -work nios2_qsys_0_data_master_agent              
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_slave_translator.sv"                                       -work jtag_uart_0_avalon_jtag_slave_translator    
  vlog -sv "$QSYS_SIMDIR/submodules/mentor/altera_merlin_master_translator.sv"                                      -work nios2_qsys_0_data_master_translator         
  vlog     "$QSYS_SIMDIR/submodules/mentor/altera_reset_controller.v"                                               -work rst_controller                              
  vlog     "$QSYS_SIMDIR/submodules/mentor/altera_reset_synchronizer.v"                                             -work rst_controller                              
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_irq_mapper.vho"                                                     -work irq_mapper                                  
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0.vhd"                                              -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_translator.vhd"     -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_sysid_qsys_0_control_slave_translator.vhd"        -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_crypto_module_csr_translator.vhd"                 -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_nios2_qsys_0_jtag_debug_module_translator.vhd"    -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_instruction_memory_s1_translator.vhd"             -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_timer_0_s1_translator.vhd"                        -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_stack_heap_s1_translator.vhd"                     -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_nios2_qsys_0_data_master_translator.vhd"          -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_crypto_module_read_master_translator.vhd"         -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_crypto_module_write_master_translator.vhd"        -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_mm_interconnect_0_nios2_qsys_0_instruction_master_translator.vhd"   -work mm_interconnect_0                           
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_timestamp_timer.vhd"                                                -work timestamp_timer                             
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_timer_0.vhd"                                                        -work timer_0                                     
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_sysid_qsys_0.vho"                                                   -work sysid_qsys_0                                
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_stack_heap.vhd"                                                     -work stack_heap                                  
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_outgoing_memory.vhd"                                                -work outgoing_memory                             
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0.vhd"                                                   -work nios2_qsys_0                                
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_jtag_debug_module_sysclk.vhd"                          -work nios2_qsys_0                                
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_jtag_debug_module_tck.vhd"                             -work nios2_qsys_0                                
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_jtag_debug_module_wrapper.vhd"                         -work nios2_qsys_0                                
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_oci_test_bench.vhd"                                    -work nios2_qsys_0                                
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_nios2_qsys_0_test_bench.vhd"                                        -work nios2_qsys_0                                
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_jtag_uart_0.vhd"                                                    -work jtag_uart_0                                 
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_instruction_memory.vhd"                                             -work instruction_memory                          
  vcom     "$QSYS_SIMDIR/submodules/crypto_test_incoming_memory.vhd"                                                -work incoming_memory                             
  vcom     "$QSYS_SIMDIR/submodules/ted_crypto.vhd"                                                                 -work crypto_module                               
  vcom     "$QSYS_SIMDIR/submodules/ted_crypto_fifo.vhd"                                                            -work crypto_module                               
  vcom     "$QSYS_SIMDIR/crypto_test.vhd"                                                                                                                             
}

# ----------------------------------------
# Elaborate top level design
alias elab {
  echo "\[exec\] elab"
  eval vsim -t ps $ELAB_OPTIONS -L work -L work_lib -L rsp_mux_001 -L rsp_mux -L rsp_demux_007 -L rsp_demux -L cmd_mux_007 -L cmd_mux_003 -L cmd_mux -L cmd_demux_001 -L cmd_demux -L router_011 -L router_007 -L router_004 -L router_003 -L router_001 -L router -L jtag_uart_0_avalon_jtag_slave_agent_rsp_fifo -L jtag_uart_0_avalon_jtag_slave_agent -L nios2_qsys_0_data_master_agent -L jtag_uart_0_avalon_jtag_slave_translator -L nios2_qsys_0_data_master_translator -L rst_controller -L irq_mapper -L mm_interconnect_0 -L timestamp_timer -L timer_0 -L sysid_qsys_0 -L stack_heap -L outgoing_memory -L nios2_qsys_0 -L jtag_uart_0 -L instruction_memory -L incoming_memory -L crypto_module -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive $TOP_LEVEL_NAME
}

# ----------------------------------------
# Elaborate the top level design with novopt option
alias elab_debug {
  echo "\[exec\] elab_debug"
  eval vsim -novopt -t ps $ELAB_OPTIONS -L work -L work_lib -L rsp_mux_001 -L rsp_mux -L rsp_demux_007 -L rsp_demux -L cmd_mux_007 -L cmd_mux_003 -L cmd_mux -L cmd_demux_001 -L cmd_demux -L router_011 -L router_007 -L router_004 -L router_003 -L router_001 -L router -L jtag_uart_0_avalon_jtag_slave_agent_rsp_fifo -L jtag_uart_0_avalon_jtag_slave_agent -L nios2_qsys_0_data_master_agent -L jtag_uart_0_avalon_jtag_slave_translator -L nios2_qsys_0_data_master_translator -L rst_controller -L irq_mapper -L mm_interconnect_0 -L timestamp_timer -L timer_0 -L sysid_qsys_0 -L stack_heap -L outgoing_memory -L nios2_qsys_0 -L jtag_uart_0 -L instruction_memory -L incoming_memory -L crypto_module -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneive $TOP_LEVEL_NAME
}

# ----------------------------------------
# Compile all the design files and elaborate the top level design
alias ld "
  dev_com
  com
  elab
"

# ----------------------------------------
# Compile all the design files and elaborate the top level design with -novopt
alias ld_debug "
  dev_com
  com
  elab_debug
"

# ----------------------------------------
# Print out user commmand line aliases
alias h {
  echo "List Of Command Line Aliases"
  echo
  echo "file_copy                     -- Copy ROM/RAM files to simulation directory"
  echo
  echo "dev_com                       -- Compile device library files"
  echo
  echo "com                           -- Compile the design files in correct order"
  echo
  echo "elab                          -- Elaborate top level design"
  echo
  echo "elab_debug                    -- Elaborate the top level design with novopt option"
  echo
  echo "ld                            -- Compile all the design files and elaborate the top level design"
  echo
  echo "ld_debug                      -- Compile all the design files and elaborate the top level design with -novopt"
  echo
  echo 
  echo
  echo "List Of Variables"
  echo
  echo "TOP_LEVEL_NAME                -- Top level module name."
  echo
  echo "SYSTEM_INSTANCE_NAME          -- Instantiated system module name inside top level module."
  echo
  echo "QSYS_SIMDIR                   -- Qsys base simulation directory."
  echo
  echo "QUARTUS_INSTALL_DIR           -- Quartus installation directory."
}
file_copy
h

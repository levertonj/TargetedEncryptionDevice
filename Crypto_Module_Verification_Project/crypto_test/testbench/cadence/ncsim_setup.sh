
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

# ACDS 14.1 190 win32 2015.03.23.23:45:07

# ----------------------------------------
# ncsim - auto-generated simulation script

# ----------------------------------------
# initialize variables
TOP_LEVEL_NAME="crypto_test_tb"
QSYS_SIMDIR="./../"
QUARTUS_INSTALL_DIR="C:/altera/14.1/quartus/"
SKIP_FILE_COPY=0
SKIP_DEV_COM=0
SKIP_COM=0
SKIP_ELAB=0
SKIP_SIM=0
USER_DEFINED_ELAB_OPTIONS=""
USER_DEFINED_SIM_OPTIONS="-input \"@run 100; exit\""

# ----------------------------------------
# overwrite variables - DO NOT MODIFY!
# This block evaluates each command line argument, typically used for 
# overwriting variables. An example usage:
#   sh <simulator>_setup.sh SKIP_ELAB=1 SKIP_SIM=1
for expression in "$@"; do
  eval $expression
  if [ $? -ne 0 ]; then
    echo "Error: This command line argument, \"$expression\", is/has an invalid expression." >&2
    exit $?
  fi
done

# ----------------------------------------
# initialize simulation properties - DO NOT MODIFY!
ELAB_OPTIONS=""
SIM_OPTIONS=""
if [[ `ncsim -version` != *"ncsim(64)"* ]]; then
  :
else
  :
fi

# ----------------------------------------
# create compilation libraries
mkdir -p ./libraries/work/
mkdir -p ./libraries/rsp_mux_001/
mkdir -p ./libraries/rsp_mux/
mkdir -p ./libraries/rsp_demux_007/
mkdir -p ./libraries/rsp_demux/
mkdir -p ./libraries/cmd_mux_007/
mkdir -p ./libraries/cmd_mux_003/
mkdir -p ./libraries/cmd_mux/
mkdir -p ./libraries/cmd_demux_001/
mkdir -p ./libraries/cmd_demux/
mkdir -p ./libraries/router_011/
mkdir -p ./libraries/router_007/
mkdir -p ./libraries/router_004/
mkdir -p ./libraries/router_003/
mkdir -p ./libraries/router_001/
mkdir -p ./libraries/router/
mkdir -p ./libraries/jtag_uart_0_avalon_jtag_slave_agent_rsp_fifo/
mkdir -p ./libraries/irq_mapper/
mkdir -p ./libraries/mm_interconnect_0/
mkdir -p ./libraries/timestamp_timer/
mkdir -p ./libraries/timer_0/
mkdir -p ./libraries/sysid_qsys_0/
mkdir -p ./libraries/stack_heap/
mkdir -p ./libraries/outgoing_memory/
mkdir -p ./libraries/nios2_qsys_0/
mkdir -p ./libraries/jtag_uart_0/
mkdir -p ./libraries/instruction_memory/
mkdir -p ./libraries/incoming_memory/
mkdir -p ./libraries/crypto_module/
mkdir -p ./libraries/crypto_test_inst_reset_bfm/
mkdir -p ./libraries/crypto_test_inst_clk_bfm/
mkdir -p ./libraries/crypto_test_inst/
mkdir -p ./libraries/altera/
mkdir -p ./libraries/lpm/
mkdir -p ./libraries/sgate/
mkdir -p ./libraries/altera_mf/
mkdir -p ./libraries/altera_lnsim/
mkdir -p ./libraries/cycloneive/

# ----------------------------------------
# copy RAM/ROM files to simulation directory
if [ $SKIP_FILE_COPY -eq 0 ]; then
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_stack_heap.hex ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_outgoing_memory.hex ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_ociram_default_contents.dat ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_ociram_default_contents.hex ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_ociram_default_contents.mif ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_rf_ram_a.dat ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_rf_ram_a.hex ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_rf_ram_a.mif ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_rf_ram_b.dat ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_rf_ram_b.hex ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_rf_ram_b.mif ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_instruction_memory.hex ./
  cp -f $QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_incoming_memory.hex ./
fi

# ----------------------------------------
# compile device library files
if [ $SKIP_DEV_COM -eq 0 ]; then
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_syn_attributes.vhd"        -work altera      
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_standard_functions.vhd"    -work altera      
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/alt_dspbuilder_package.vhd"       -work altera      
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_europa_support_lib.vhd"    -work altera      
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives_components.vhd" -work altera      
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_primitives.vhd"            -work altera      
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/220pack.vhd"                      -work lpm         
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/220model.vhd"                     -work lpm         
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate_pack.vhd"                   -work sgate       
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/sgate.vhd"                        -work sgate       
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf_components.vhd"         -work altera_mf   
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_mf.vhd"                    -work altera_mf   
  ncvlog -sv  "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim.sv"                  -work altera_lnsim
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/altera_lnsim_components.vhd"      -work altera_lnsim
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneive_atoms.vhd"             -work cycloneive  
  ncvhdl -v93 "$QUARTUS_INSTALL_DIR/eda/sim_lib/cycloneive_components.vhd"        -work cycloneive  
fi

# ----------------------------------------
# compile design files in correct order
if [ $SKIP_COM -eq 0 ]; then
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_rsp_mux_001.vho"                                  -work rsp_mux_001                                  -cdslib ./cds_libs/rsp_mux_001.cds.lib                                 
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_rsp_mux.vho"                                      -work rsp_mux                                      -cdslib ./cds_libs/rsp_mux.cds.lib                                     
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_rsp_demux_007.vho"                                -work rsp_demux_007                                -cdslib ./cds_libs/rsp_demux_007.cds.lib                               
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_rsp_demux.vho"                                    -work rsp_demux                                    -cdslib ./cds_libs/rsp_demux.cds.lib                                   
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_cmd_mux_007.vho"                                  -work cmd_mux_007                                  -cdslib ./cds_libs/cmd_mux_007.cds.lib                                 
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_cmd_mux_003.vho"                                  -work cmd_mux_003                                  -cdslib ./cds_libs/cmd_mux_003.cds.lib                                 
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_cmd_mux.vho"                                      -work cmd_mux                                      -cdslib ./cds_libs/cmd_mux.cds.lib                                     
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_cmd_demux_001.vho"                                -work cmd_demux_001                                -cdslib ./cds_libs/cmd_demux_001.cds.lib                               
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_cmd_demux.vho"                                    -work cmd_demux                                    -cdslib ./cds_libs/cmd_demux.cds.lib                                   
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_router_011.vho"                                   -work router_011                                   -cdslib ./cds_libs/router_011.cds.lib                                  
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_router_007.vho"                                   -work router_007                                   -cdslib ./cds_libs/router_007.cds.lib                                  
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_router_004.vho"                                   -work router_004                                   -cdslib ./cds_libs/router_004.cds.lib                                  
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_router_003.vho"                                   -work router_003                                   -cdslib ./cds_libs/router_003.cds.lib                                  
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_router_001.vho"                                   -work router_001                                   -cdslib ./cds_libs/router_001.cds.lib                                  
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_router.vho"                                       -work router                                       -cdslib ./cds_libs/router.cds.lib                                      
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_agent_rsp_fifo.vho" -work jtag_uart_0_avalon_jtag_slave_agent_rsp_fifo -cdslib ./cds_libs/jtag_uart_0_avalon_jtag_slave_agent_rsp_fifo.cds.lib
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_irq_mapper.vho"                                                     -work irq_mapper                                   -cdslib ./cds_libs/irq_mapper.cds.lib                                  
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0.vhd"                                              -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_jtag_uart_0_avalon_jtag_slave_translator.vhd"     -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_sysid_qsys_0_control_slave_translator.vhd"        -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_crypto_module_csr_translator.vhd"                 -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_nios2_qsys_0_jtag_debug_module_translator.vhd"    -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_instruction_memory_s1_translator.vhd"             -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_timer_0_s1_translator.vhd"                        -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_stack_heap_s1_translator.vhd"                     -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_nios2_qsys_0_data_master_translator.vhd"          -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_crypto_module_read_master_translator.vhd"         -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_crypto_module_write_master_translator.vhd"        -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_mm_interconnect_0_nios2_qsys_0_instruction_master_translator.vhd"   -work mm_interconnect_0                            -cdslib ./cds_libs/mm_interconnect_0.cds.lib                           
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_timestamp_timer.vhd"                                                -work timestamp_timer                              -cdslib ./cds_libs/timestamp_timer.cds.lib                             
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_timer_0.vhd"                                                        -work timer_0                                      -cdslib ./cds_libs/timer_0.cds.lib                                     
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_sysid_qsys_0.vho"                                                   -work sysid_qsys_0                                 -cdslib ./cds_libs/sysid_qsys_0.cds.lib                                
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_stack_heap.vhd"                                                     -work stack_heap                                   -cdslib ./cds_libs/stack_heap.cds.lib                                  
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_outgoing_memory.vhd"                                                -work outgoing_memory                              -cdslib ./cds_libs/outgoing_memory.cds.lib                             
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0.vhd"                                                   -work nios2_qsys_0                                 -cdslib ./cds_libs/nios2_qsys_0.cds.lib                                
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_jtag_debug_module_sysclk.vhd"                          -work nios2_qsys_0                                 -cdslib ./cds_libs/nios2_qsys_0.cds.lib                                
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_jtag_debug_module_tck.vhd"                             -work nios2_qsys_0                                 -cdslib ./cds_libs/nios2_qsys_0.cds.lib                                
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_jtag_debug_module_wrapper.vhd"                         -work nios2_qsys_0                                 -cdslib ./cds_libs/nios2_qsys_0.cds.lib                                
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_oci_test_bench.vhd"                                    -work nios2_qsys_0                                 -cdslib ./cds_libs/nios2_qsys_0.cds.lib                                
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_nios2_qsys_0_test_bench.vhd"                                        -work nios2_qsys_0                                 -cdslib ./cds_libs/nios2_qsys_0.cds.lib                                
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_jtag_uart_0.vhd"                                                    -work jtag_uart_0                                  -cdslib ./cds_libs/jtag_uart_0.cds.lib                                 
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_instruction_memory.vhd"                                             -work instruction_memory                           -cdslib ./cds_libs/instruction_memory.cds.lib                          
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test_incoming_memory.vhd"                                                -work incoming_memory                              -cdslib ./cds_libs/incoming_memory.cds.lib                             
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/ted_crypto.vhd"                                                                 -work crypto_module                                -cdslib ./cds_libs/crypto_module.cds.lib                               
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/ted_crypto_fifo.vhd"                                                            -work crypto_module                                -cdslib ./cds_libs/crypto_module.cds.lib                               
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/altera_avalon_reset_source.vhd"                                                 -work crypto_test_inst_reset_bfm                   -cdslib ./cds_libs/crypto_test_inst_reset_bfm.cds.lib                  
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/altera_avalon_clock_source.vhd"                                                 -work crypto_test_inst_clk_bfm                     -cdslib ./cds_libs/crypto_test_inst_clk_bfm.cds.lib                    
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/submodules/crypto_test.vhd"                                                                -work crypto_test_inst                             -cdslib ./cds_libs/crypto_test_inst.cds.lib                            
  ncvhdl -v93 "$QSYS_SIMDIR/crypto_test_tb/simulation/crypto_test_tb.vhd"                                                                                                                                                                                                  
fi

# ----------------------------------------
# elaborate top level design
if [ $SKIP_ELAB -eq 0 ]; then
  ncelab -access +w+r+c -namemap_mixgen -relax $ELAB_OPTIONS $USER_DEFINED_ELAB_OPTIONS $TOP_LEVEL_NAME
fi

# ----------------------------------------
# simulate
if [ $SKIP_SIM -eq 0 ]; then
  eval ncsim -licqueue $SIM_OPTIONS $USER_DEFINED_SIM_OPTIONS $TOP_LEVEL_NAME
fi

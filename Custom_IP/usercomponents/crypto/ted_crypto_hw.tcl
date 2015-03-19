# TCL File Generated by Component Editor 14.1
# Sat Mar 07 11:38:09 EST 2015
# DO NOT MODIFY


# 
# ted_crypto "ted_cypto" v2.0
# Blake Mackey 2015.03.07.11:38:09
# 
# 

# 
# request TCL package from ACDS 14.1
# 
package require -exact qsys 14.1


# 
# module ted_crypto
# 
set_module_property DESCRIPTION ""
set_module_property NAME ted_crypto
set_module_property VERSION 2.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property GROUP Crypto
set_module_property AUTHOR "Blake Mackey"
set_module_property DISPLAY_NAME ted_cypto
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL ted_crypto
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file ted_crypto_fifo.vhd VHDL PATH ted_crypto_fifo.vhd
add_fileset_file ted_crypto.vhd VHDL PATH ted_crypto.vhd TOP_LEVEL_FILE

add_fileset SIM_VERILOG SIM_VERILOG "" ""
set_fileset_property SIM_VERILOG TOP_LEVEL ted_crypto
set_fileset_property SIM_VERILOG ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VERILOG ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file ted_crypto_fifo.vhd VHDL PATH ted_crypto_fifo.vhd
add_fileset_file ted_crypto.vhd VHDL PATH ted_crypto.vhd

add_fileset SIM_VHDL SIM_VHDL "" ""
set_fileset_property SIM_VHDL TOP_LEVEL ted_crypto
set_fileset_property SIM_VHDL ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property SIM_VHDL ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file ted_crypto.vhd VHDL PATH ted_crypto.vhd
add_fileset_file ted_crypto_fifo.vhd VHDL PATH ted_crypto_fifo.vhd


# 
# parameters
# 


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock csi_clock_clk clk Input 1


# 
# connection point clock_reset
# 
add_interface clock_reset reset end
set_interface_property clock_reset associatedClock clock
set_interface_property clock_reset synchronousEdges DEASSERT
set_interface_property clock_reset ENABLED true
set_interface_property clock_reset EXPORT_OF ""
set_interface_property clock_reset PORT_NAME_MAP ""
set_interface_property clock_reset CMSIS_SVD_VARIABLES ""
set_interface_property clock_reset SVD_ADDRESS_GROUP ""

add_interface_port clock_reset csi_clock_reset reset Input 1


# 
# connection point read_master
# 
add_interface read_master avalon start
set_interface_property read_master addressUnits SYMBOLS
set_interface_property read_master associatedClock clock
set_interface_property read_master associatedReset clock_reset
set_interface_property read_master bitsPerSymbol 8
set_interface_property read_master burstOnBurstBoundariesOnly false
set_interface_property read_master burstcountUnits WORDS
set_interface_property read_master doStreamReads false
set_interface_property read_master doStreamWrites false
set_interface_property read_master holdTime 0
set_interface_property read_master linewrapBursts false
set_interface_property read_master maximumPendingReadTransactions 0
set_interface_property read_master maximumPendingWriteTransactions 0
set_interface_property read_master readLatency 0
set_interface_property read_master readWaitTime 1
set_interface_property read_master setupTime 0
set_interface_property read_master timingUnits Cycles
set_interface_property read_master writeWaitTime 0
set_interface_property read_master ENABLED true
set_interface_property read_master EXPORT_OF ""
set_interface_property read_master PORT_NAME_MAP ""
set_interface_property read_master CMSIS_SVD_VARIABLES ""
set_interface_property read_master SVD_ADDRESS_GROUP ""

add_interface_port read_master avm_read_master_read read Output 1
add_interface_port read_master avm_read_master_address address Output 32
add_interface_port read_master avm_read_master_readdata readdata Input 32
add_interface_port read_master avm_read_master_waitrequest waitrequest Input 1


# 
# connection point write_master
# 
add_interface write_master avalon start
set_interface_property write_master addressUnits SYMBOLS
set_interface_property write_master associatedClock clock
set_interface_property write_master associatedReset clock_reset
set_interface_property write_master bitsPerSymbol 8
set_interface_property write_master burstOnBurstBoundariesOnly false
set_interface_property write_master burstcountUnits WORDS
set_interface_property write_master doStreamReads false
set_interface_property write_master doStreamWrites false
set_interface_property write_master holdTime 0
set_interface_property write_master linewrapBursts false
set_interface_property write_master maximumPendingReadTransactions 0
set_interface_property write_master maximumPendingWriteTransactions 0
set_interface_property write_master readLatency 0
set_interface_property write_master readWaitTime 1
set_interface_property write_master setupTime 0
set_interface_property write_master timingUnits Cycles
set_interface_property write_master writeWaitTime 0
set_interface_property write_master ENABLED true
set_interface_property write_master EXPORT_OF ""
set_interface_property write_master PORT_NAME_MAP ""
set_interface_property write_master CMSIS_SVD_VARIABLES ""
set_interface_property write_master SVD_ADDRESS_GROUP ""

add_interface_port write_master avm_write_master_write write Output 1
add_interface_port write_master avm_write_master_address address Output 32
add_interface_port write_master avm_write_master_writedata writedata Output 32
add_interface_port write_master avm_write_master_waitrequest waitrequest Input 1


# 
# connection point csr
# 
add_interface csr avalon end
set_interface_property csr addressUnits WORDS
set_interface_property csr associatedClock clock
set_interface_property csr associatedReset clock_reset
set_interface_property csr bitsPerSymbol 8
set_interface_property csr burstOnBurstBoundariesOnly false
set_interface_property csr burstcountUnits WORDS
set_interface_property csr explicitAddressSpan 0
set_interface_property csr holdTime 0
set_interface_property csr linewrapBursts false
set_interface_property csr maximumPendingReadTransactions 0
set_interface_property csr maximumPendingWriteTransactions 0
set_interface_property csr readLatency 0
set_interface_property csr readWaitTime 1
set_interface_property csr setupTime 0
set_interface_property csr timingUnits Cycles
set_interface_property csr writeWaitTime 0
set_interface_property csr ENABLED true
set_interface_property csr EXPORT_OF ""
set_interface_property csr PORT_NAME_MAP ""
set_interface_property csr CMSIS_SVD_VARIABLES ""
set_interface_property csr SVD_ADDRESS_GROUP ""

add_interface_port csr avs_csr_address address Input 3
add_interface_port csr avs_csr_readdata readdata Output 32
add_interface_port csr avs_csr_write write Input 1
add_interface_port csr avs_csr_writedata writedata Input 32
set_interface_assignment csr embeddedsw.configuration.isFlash 0
set_interface_assignment csr embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment csr embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment csr embeddedsw.configuration.isPrintableDevice 0


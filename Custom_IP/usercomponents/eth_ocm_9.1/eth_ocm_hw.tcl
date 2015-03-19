# +-----------------------------------
# | module eth_ocm
# | 
set_module_property DESCRIPTION "OpenCores 10/100 Ethernet MAC with Avalon Interface."
set_module_property NAME eth_ocm
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property GROUP "Interface Protocols/Ethernet"
set_module_property AUTHOR "Blake Mackey"
set_module_property DISPLAY_NAME "Avalon OpenCores 10/100 Ethernet MAC Avalon"
set_module_property TOP_LEVEL_HDL_FILE eth_ocm.v
set_module_property TOP_LEVEL_HDL_MODULE eth_ocm
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property ANALYZE_HDL TRUE
set_module_property ELABORATION_CALLBACK my_elaboration_callback
# | 
# +-----------------------------------

# +-----------------------------------
# | files
# | 
add_file eth_ocm.v {SYNTHESIS SIMULATION}
# | 
# +-----------------------------------

# +-----------------------------------
# | parameters
# | 
set description {Selects the width of the MAC's Transmit and Receive memory master ports.
    Ideally you should match this to the width of your memory interface for maximum efficiency.
    Increased values result in increased resource utilization and may negatively impact fmax.}
add_parameter MEM_WIDTH INTEGER 32 ""
set_parameter_property MEM_WIDTH DEFAULT_VALUE 32
set_parameter_property MEM_WIDTH DISPLAY_NAME "Memory Interface Width"
set_parameter_property MEM_WIDTH UNITS None
set_parameter_property MEM_WIDTH ALLOWED_RANGES {32 64 128 256}
set_parameter_property MEM_WIDTH DESCRIPTION $description
set_parameter_property MEM_WIDTH DISPLAY_HINT ""
set_parameter_property MEM_WIDTH AFFECTS_GENERATION false
set_parameter_property MEM_WIDTH AFFECTS_ELABORATION true
set_parameter_property MEM_WIDTH HDL_PARAMETER true

set description {Selects the total number of DMA 
    descriptors for the MAC (both Transmit and Receive).
    The value must be between 2 and 128}
add_parameter TOTAL_DESCRIPTORS INTEGER 128
set_parameter_property TOTAL_DESCRIPTORS DEFAULT_VALUE 128
set_parameter_property TOTAL_DESCRIPTORS ALLOWED_RANGES "2:128"
set_parameter_property TOTAL_DESCRIPTORS DISPLAY_NAME "Total descriptor count (RX + TX)"
set_parameter_property TOTAL_DESCRIPTORS UNITS None
set_parameter_property TOTAL_DESCRIPTORS DESCRIPTION $description
set_parameter_property TOTAL_DESCRIPTORS DISPLAY_HINT ""
set_parameter_property TOTAL_DESCRIPTORS AFFECTS_GENERATION false
set_parameter_property TOTAL_DESCRIPTORS AFFECTS_ELABORATION true
set_parameter_property TOTAL_DESCRIPTORS HDL_PARAMETER true

set description {Selects the amount by which to divide 
    the system clock to obtain the clock for the MDIO 
    interface to the PHY. 2.5MHz is typically the desired
    clock rate for the PHY interface. As an example, if the
    system clock is 100MHz, a divider value of 40 would give
    a clock rate of 2.5MHz}

add_parameter MDIO_CLOCK_DIVIDER INTEGER 100
set_parameter_property MDIO_CLOCK_DIVIDER DEFAULT_VALUE 100
set_parameter_property MDIO_CLOCK_DIVIDER ALLOWED_RANGES "2:254"
set_parameter_property MDIO_CLOCK_DIVIDER DISPLAY_NAME "PHY MDIO clock divider"
set_parameter_property MDIO_CLOCK_DIVIDER UNITS None
set_parameter_property MDIO_CLOCK_DIVIDER DESCRIPTION $description
set_parameter_property MDIO_CLOCK_DIVIDER DISPLAY_HINT ""
set_parameter_property MDIO_CLOCK_DIVIDER AFFECTS_GENERATION false
set_parameter_property MDIO_CLOCK_DIVIDER AFFECTS_ELABORATION true

set description {Configures the depth of the transmit FIFO. The width of the FIFO
    is specified by the "Memory Interface Width" parameter. The purpose of the 
    transmit FIFO is to prevent an underrun while transmitting data. A large value
    here does not make much sense because packets are transmitted synchronously. 
    A value of 128 is sufficcient for most applications}
add_parameter TX_FIFO_DEPTH INTEGER 128
set_parameter_property TX_FIFO_DEPTH DEFAULT_VALUE 128
set_parameter_property TX_FIFO_DEPTH ALLOWED_RANGES "128 256 512 1024 2048 4096 8192 16384"
set_parameter_property TX_FIFO_DEPTH DISPLAY_NAME "Transmit FIFO depth (in words)"
set_parameter_property TX_FIFO_DEPTH UNITS None
set_parameter_property TX_FIFO_DEPTH DESCRIPTION $description
set_parameter_property TX_FIFO_DEPTH DISPLAY_HINT ""
set_parameter_property TX_FIFO_DEPTH AFFECTS_ELABORATION true
set_parameter_property TX_FIFO_DEPTH AFFECTS_GENERATION false
set_parameter_property TX_FIFO_DEPTH HDL_PARAMETER true

add_parameter TX_BURST_ENABLE BOOLEAN true ""
set_parameter_property TX_BURST_ENABLE DISPLAY_NAME "Enable Burst Transfers on TX master"
set_parameter_property TX_BURST_ENABLE UNITS None
set_parameter_property TX_BURST_ENABLE DESCRIPTION "Enables or disables bursting on the Transmit memory master port"
set_parameter_property TX_BURST_ENABLE DISPLAY_HINT ""
set_parameter_property TX_BURST_ENABLE AFFECTS_GENERATION true
set_parameter_property TX_BURST_ENABLE AFFECTS_ELABORATION true
set_parameter_property TX_BURST_ENABLE HDL_PARAMETER true

set description {Configures the burst target (desired burst count) for the Transmit memory master port.
    The memory master will read this number of words each burst unless fewer words are needed. The burst
    target can be no more than half the size of the Transmit FIFO depth.}
add_parameter TX_BURST_TARGET INTEGER 8
set_parameter_property TX_BURST_TARGET DEFAULT_VALUE 8
set_parameter_property TX_BURST_TARGET ALLOWED_RANGES "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192"
set_parameter_property TX_BURST_TARGET DISPLAY_NAME "TX Burst target (in words)"
set_parameter_property TX_BURST_TARGET DESCRIPTION $description
set_parameter_property TX_BURST_TARGET UNITS None
set_parameter_property TX_BURST_TARGET DISPLAY_HINT ""
set_parameter_property TX_BURST_TARGET AFFECTS_GENERATION false
set_parameter_property TX_BURST_TARGET AFFECTS_ELABORATION true
set_parameter_property TX_BURST_TARGET HDL_PARAMETER true

add_display_item "Transmit Interface" TX_FIFO_DEPTH parameter 
add_display_item "Transmit Interface" TX_BURST_ENABLE parameter 
add_display_item "Transmit Interface" TX_BURST_TARGET parameter 

set description {Configures the depth of the receive FIFO. The width of the FIFO
    is specified by the "Memory Interface Width" parameter. The receive FIFO
    serves two purposes: 1 - It prevents an overrun as data is received from the PHY.
    2 - It can act as a packet buffer for incoming packets in the event that the
    processor interface is too busy to handle the incoming packets. The larger the FIFO,
    the more packet data can be buffered but increases FIFO RAM usage.}
add_parameter RX_FIFO_DEPTH INTEGER 1024
set_parameter_property RX_FIFO_DEPTH DEFAULT_VALUE 1024
set_parameter_property RX_FIFO_DEPTH ALLOWED_RANGES "128 256 512 1024 2048 4096 8192 16384"
set_parameter_property RX_FIFO_DEPTH DISPLAY_NAME "Receive FIFO depth (in words)"
set_parameter_property RX_FIFO_DEPTH DESCRIPTION $description
set_parameter_property RX_FIFO_DEPTH UNITS None
set_parameter_property RX_FIFO_DEPTH DISPLAY_HINT ""
set_parameter_property RX_FIFO_DEPTH AFFECTS_ELABORATION true
set_parameter_property RX_FIFO_DEPTH AFFECTS_GENERATION false
set_parameter_property RX_FIFO_DEPTH HDL_PARAMETER true

add_parameter RX_BURST_ENABLE BOOLEAN true ""
set_parameter_property RX_BURST_ENABLE DISPLAY_NAME "Enable Burst Transfers on RX master"
set_parameter_property RX_BURST_ENABLE UNITS None
set_parameter_property RX_BURST_ENABLE DESCRIPTION "Enables or disables bursting on the Receive memory master port"
set_parameter_property RX_BURST_ENABLE DISPLAY_HINT ""
set_parameter_property RX_BURST_ENABLE AFFECTS_GENERATION true
set_parameter_property RX_BURST_ENABLE AFFECTS_ELABORATION true
set_parameter_property RX_BURST_ENABLE HDL_PARAMETER true

set description {Configures the burst target (desired burst count) for the Receive memory master port.
    The memory master will write this number of words each burst unless fewer words are needed. The burst
    target can be no more than half the size of the Receive FIFO depth.}
add_parameter RX_BURST_TARGET INTEGER 8
set_parameter_property RX_BURST_TARGET DEFAULT_VALUE 8
set_parameter_property RX_BURST_TARGET ALLOWED_RANGES "2 4 8 16 32 64 128 256 512 1024 2048 4096 8192"
set_parameter_property RX_BURST_TARGET DISPLAY_NAME "RX Burst target (in words)"
set_parameter_property RX_BURST_TARGET DESCRIPTION $description
set_parameter_property RX_BURST_TARGET UNITS None
set_parameter_property RX_BURST_TARGET DISPLAY_HINT ""
set_parameter_property RX_BURST_TARGET AFFECTS_GENERATION false
set_parameter_property RX_BURST_TARGET AFFECTS_ELABORATION true
set_parameter_property RX_BURST_TARGET HDL_PARAMETER true

add_display_item "Receive Interface" RX_FIFO_DEPTH parameter 
add_display_item "Receive Interface" RX_BURST_ENABLE parameter 
add_display_item "Receive Interface" RX_BURST_TARGET parameter 
# | 
# +-----------------------------------


# +-----------------------------------
# | connection point control_port
# | 
add_interface control_port avalon end
set_interface_assignment control_port embeddedsw.configuration.isEthernetMacDevice 1
set_interface_property control_port addressAlignment DYNAMIC
set_interface_property control_port associatedClock avalon_clock
set_interface_property control_port burstOnBurstBoundariesOnly false
set_interface_property control_port explicitAddressSpan 0
set_interface_property control_port holdTime 0
set_interface_property control_port isMemoryDevice false
set_interface_property control_port isNonVolatileStorage false
set_interface_property control_port linewrapBursts false
set_interface_property control_port maximumPendingReadTransactions 0
set_interface_property control_port printableDevice false
set_interface_property control_port readLatency 0
set_interface_property control_port readWaitTime 1
set_interface_property control_port setupTime 0
set_interface_property control_port timingUnits Cycles
set_interface_property control_port writeWaitTime 0

set_interface_property control_port ASSOCIATED_CLOCK avalon_clock
set_interface_property control_port ENABLED true

add_interface_port control_port av_chipselect chipselect Input 1
add_interface_port control_port av_write write Input 1
add_interface_port control_port av_read read Input 1
add_interface_port control_port av_writedata writedata Input 32
add_interface_port control_port av_readdata readdata Output 32
add_interface_port control_port av_waitrequest_n waitrequest_n Output 1
add_interface_port control_port av_address address Input 10
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point avalon_clock
# | 
add_interface avalon_clock clock end

set_interface_property avalon_clock ENABLED true

add_interface_port avalon_clock av_clk clk Input 1
add_interface_port avalon_clock av_reset reset Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point tx_master
# | 
add_interface tx_master avalon start
set_interface_property tx_master associatedClock avalon_clock
set_interface_property tx_master burstOnBurstBoundariesOnly false
set_interface_property tx_master doStreamReads false
set_interface_property tx_master doStreamWrites false
set_interface_property tx_master linewrapBursts false

set_interface_property tx_master ASSOCIATED_CLOCK avalon_clock
set_interface_property tx_master ENABLED true

add_interface_port tx_master av_tx_readdata readdata Input MEM_WIDTH
add_interface_port tx_master av_tx_waitrequest waitrequest Input 1
add_interface_port tx_master av_tx_readdatavalid readdatavalid Input 1
add_interface_port tx_master av_tx_address address Output 32
add_interface_port tx_master av_tx_read read Output 1
# add_interface_port tx_master av_tx_burstcount burstcount Output -1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point rx_master
# | 
add_interface rx_master avalon start
set_interface_property rx_master associatedClock avalon_clock
set_interface_property rx_master burstOnBurstBoundariesOnly false
set_interface_property rx_master doStreamReads false
set_interface_property rx_master doStreamWrites false
set_interface_property rx_master linewrapBursts false

set_interface_property rx_master ASSOCIATED_CLOCK avalon_clock
set_interface_property rx_master ENABLED true

add_interface_port rx_master av_rx_waitrequest waitrequest Input 1
add_interface_port rx_master av_rx_address address Output 32
add_interface_port rx_master av_rx_write write Output 1
add_interface_port rx_master av_rx_writedata writedata Input MEM_WIDTH
add_interface_port rx_master av_rx_byteenable byteenable Output -1
# add_interface_port rx_master av_rx_burstcount burstcount Output -1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point global
# | 
add_interface global conduit end

set_interface_property global ENABLED true

add_interface_port global mtx_clk_pad_i export Input 1
add_interface_port global mtxd_pad_o export Output 4
add_interface_port global mtxen_pad_o export Output 1
add_interface_port global mtxerr_pad_o export Output 1
add_interface_port global mrx_clk_pad_i export Input 1
add_interface_port global mrxd_pad_i export Input 4
add_interface_port global mrxdv_pad_i export Input 1
add_interface_port global mrxerr_pad_i export Input 1
add_interface_port global mcoll_pad_i export Input 1
add_interface_port global mcrs_pad_i export Input 1
add_interface_port global mdc_pad_o export Output 1
add_interface_port global md_pad_i export Input 1
add_interface_port global md_pad_o export Output 1
add_interface_port global md_padoe_o export Output 1
add_interface_port global mtx_clk_pad_i export Input 1
# | 
# +-----------------------------------

# +-----------------------------------
# | connection point control_irq
# | 
add_interface control_irq interrupt end
set_interface_property control_irq associatedAddressablePoint control_port

set_interface_property control_irq ASSOCIATED_CLOCK avalon_clock
set_interface_property control_irq ENABLED true

add_interface_port control_irq av_irq irq Output 1
# | 
# +-----------------------------------

add_parameter SYS_CLOCK_RATE INTEGER 0
set_parameter_property SYS_CLOCK_RATE SYSTEM_INFO CLOCK_DOMAIN
set_parameter_property SYS_CLOCK_RATE VISIBLE false
set_parameter_property SYS_CLOCK_RATE AFFECTS_ELABORATION true

proc my_elaboration_callback {} {
    # Add software defines
    set_module_assignment embeddedsw.CMacro.TOTAL_DESCRIPTORS [get_parameter_value TOTAL_DESCRIPTORS]
    set_module_assignment embeddedsw.CMacro.SYS_CLOCK_RATE [get_parameter_value SYS_CLOCK_RATE]
    set_module_assignment embeddedsw.CMacro.MDIO_CLOCK_DIVIDER [get_parameter_value MDIO_CLOCK_DIVIDER]

    # set byteenable width for receive master
    set mem_width [get_parameter_value MEM_WIDTH]
    set mem_width [expr {$mem_width / 8}]
    add_interface_port rx_master av_rx_byteenable byteenable Output $mem_width

    # Take care of TX bursting
    set tx_burst_enable    [get_parameter_value TX_BURST_ENABLE]
    if { $tx_burst_enable } {
        set_parameter_property TX_BURST_TARGET ENABLED TRUE 
        set tx_burst_target    [get_parameter_value TX_BURST_TARGET]
        set tx_fifo_depth [get_parameter_value TX_FIFO_DEPTH];

        set max_burst_size [expr {$tx_fifo_depth / 2}]

        if { [expr {$tx_burst_target > $max_burst_size} ] } {
            set tx_burst_target $max_burst_size
            send_message Error "TX burst target must be less than or equal to half the TX FIFO word depth ($max_burst_size)"
        }

    } else {
        set_parameter_property TX_BURST_TARGET ENABLED FALSE
        set tx_burst_target 1
        # send_message INFO "TX bursting is disabled. Ensure your memory arbitration scheme is sufficient to allow efficient memory access"
    }

    set bc_width 0
    while { [ expr {$tx_burst_target > 0} ] } {
        set bc_width [expr {$bc_width + 1}]
        set tx_burst_target [expr {$tx_burst_target >> 1}]
    }
    if { $tx_burst_enable } {
        # Set widths for burstcount ports
        add_interface_port tx_master av_tx_burstcount burstcount Output $bc_width 
    }

    # Take care of RX bursting
    set rx_burst_enable    [get_parameter_value RX_BURST_ENABLE]
    if { $rx_burst_enable } {
        set_parameter_property RX_BURST_TARGET ENABLED TRUE 
        set rx_burst_target    [get_parameter_value RX_BURST_TARGET]
        set rx_fifo_depth [get_parameter_value RX_FIFO_DEPTH];
        set max_burst_size [expr {$rx_fifo_depth / 2}]

        if { [expr {$rx_burst_target > $max_burst_size} ] } {
            set rx_burst_target $max_burst_size
            send_message Error "RX burst target must be less than or equal to half the RX FIFO word depth ($max_burst_size)"
        }

    } else {
        set_parameter_property RX_BURST_TARGET ENABLED FALSE
        set rx_burst_target 1
        # send_message INFO "RX bursting is disabled. Ensure your memory arbitration scheme is sufficient to allow efficient memory access"
    }
    set bc_width 0
    while { [ expr {$rx_burst_target > 0} ] } {
        set bc_width [expr {$bc_width + 1}]
        set rx_burst_target [expr {$rx_burst_target >> 1}]
    }
    if { $rx_burst_enable } {
        # Set widths for burstcount ports
        add_interface_port rx_master av_rx_burstcount burstcount Output $bc_width 
    }

} 



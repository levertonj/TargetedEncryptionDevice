##############################################################################
# SDC (Timing Constrains File) for the DE2-115 board by Terasic
# Blake Mackey, August 2014

##############################################################################
# create clock based on input crystal
create_clock -name CLOCK_50 -period "50 MHz" [get_ports CLOCK_50]

##############################################################################
# create fake clock for human input
create_clock -period "1MHz" -name human_clk

##############################################################################
# create ethernet clocks


##############################################################################
# min delay on pins = 1/4 period

##############################################################################
# create generated clocks (generated using PLLs internal to the FPGA)

derive_pll_clocks -create_base_clocks -use_net_name

##############################################################################
# derive clock uncertainty (jitter, etc.) of the PLLs automatically

derive_clock_uncertainty

##############################################################################
# identify independent clocks (i.e. clocks or groups of clocks which
# are asynchronous with respect to each other
#set_clock_groups -asynchronous \
                 -group $pll_clocks \
                 -group { human_clk } \
                 -group { altera_reserved_tck }
set_clock_groups  -exclusive \
                  -group [get_clocks my_pll:pll_inst|altpll:altpll_component|my_pll_altpll:auto_generated|wire_pll1_clk[0]] \
                  -group [get_clocks my_pll:pll_inst|altpll:altpll_component|my_pll_altpll:auto_generated|wire_pll1_clk[1]] \
                  -group [get_clocks my_pll:pll_inst|altpll:altpll_component|my_pll_altpll:auto_generated|wire_pll1_clk[2]] \
                  -group [get_clocks my_pll:pll_inst|altpll:altpll_component|my_pll_altpll:auto_generated|wire_pll1_clk[3]] \
                  -group [get_clocks my_pll:pll_inst|altpll:altpll_component|my_pll_altpll:auto_generated|wire_pll1_clk[4]]] 

##############################################################################
# human input delays

set_input_delay  -clock { human_clk } 0 [ get_ports { KEY* } ]
set_input_delay  -clock { human_clk } 0 [ get_ports { SW* } ]

set_output_delay -clock { human_clk } 0 [ get_ports { LED* } ]
set_output_delay -clock { human_clk } 0 [ get_ports { HEX* } ]


##############################################################################
# Altera suggests specifying the clock but this often seems to be already specified:
#   create_clock     -name { tck } -period "100MHz" [get_ports altera_reserved_tck]
# Altera suggest making the clock "exclusive" but I believe that it should be "asynchronous"
# with respect to the other clocks (see the clock grouping section)
#   set_clock_groups -exclusive -group [get_clocks tck]
set_input_delay  -clock { altera_reserved_tck } 20 [get_ports altera_reserved_tdi]
set_input_delay  -clock { altera_reserved_tck } 20 [get_ports altera_reserved_tms]
set_output_delay -clock { altera_reserved_tck } 20 [get_ports altera_reserved_tdo]

##############################################################################
# The End
##############################################################################
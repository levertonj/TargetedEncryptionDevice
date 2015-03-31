module TEDv3(
	// Clock
	input         CLOCK_50,
	
	// KEY
	input   [3:0] KEY,

	// Switches
	input  [17:0] SW,
	  
	// LEDs
	output [17:0] LEDR,
	output  [8:0] LEDG,

	// LCD
	output	    	LCD_BLON,
	inout		[7:0]	LCD_DATA,
	output	    	LCD_EN,
	output	    	LCD_ON,
	output	    	LCD_RS,
	output	    	LCD_RW,
	  
	// Seven Segment
	output  [6:0] HEX0,
	output	[6:0]	HEX1,
	output	[6:0]	HEX2,
	output	[6:0]	HEX3,
	output	[6:0]	HEX4,
	output	[6:0]	HEX5,
	output	[6:0]	HEX6,
	output	[6:0]	HEX7,
	
	// Ethernet 0
	output        ENET0_GTX_CLK,
	output        ENET0_MDC,
	inout         ENET0_MDIO,
	output        ENET0_RESET_N,
	input         ENET0_RX_CLK,
	input  [3: 0] ENET0_RX_DATA,
	input         ENET0_RX_DV,
	output [3: 0] ENET0_TX_DATA,
	output        ENET0_TX_EN,
	
	// Ethernet 1
	output        ENET1_GTX_CLK,
	output        ENET1_MDC,
	inout         ENET1_MDIO,
	output        ENET1_RESET_N,
	input         ENET1_RX_CLK,
	input  [3: 0] ENET1_RX_DATA,
	input         ENET1_RX_DV,
	output [3: 0] ENET1_TX_DATA,
	output        ENET1_TX_EN
);

//=======================================================
//  REG/WIRE declarations
//=======================================================
wire [31:0] in_port_to_the_input_port     = {14'b0,SW[17:0]};
wire [31:0] out_port_from_the_output_port;
wire [31:0] Q_export_from_the_hex;
wire sys_clk, clk_125, clk_25, clk_2p5;
wire core_reset_n;
wire red_tx_clk;
wire red_mdc, red_mdio_in, red_mdio_oen, red_mdio_out;
wire red_eth_mode, red_ena_10;
wire black_tx_clk;
wire black_mdc, black_mdio_in, black_mdio_oen, black_mdio_out;
wire black_eth_mode, black_ena_10;
	
wire master_reset;
wire grounded;

wire red_XON;
wire red_XOFF;
wire black_XON;
wire black_XOFF;
  
//=======================================================
//  REG/WIRE assignments
//=======================================================  

  //Red Interface = Ethernet0
  assign ENET0_RESET_N  = core_reset_n;
  assign red_mdio_in    = ENET0_MDIO;
  assign ENET0_MDIO     = red_mdio_oen ? 1'bz : red_mdio_out;
  assign ENET0_MDC      = red_mdc;
  assign red_tx_clk     = red_eth_mode ? clk_125 :       // GbE Mode   = 125MHz clock
                          red_ena_10   ? clk_2p5 :       // 10Mb Mode  = 2.5MHz clock
                                         clk_25;         // 100Mb Mode = 25 MHz clock                          

	
  //Black Interface = Ethernet1
  assign ENET1_RESET_N  = core_reset_n;
  assign black_mdio_in  = ENET1_MDIO;
  assign ENET1_MDC      = black_mdc;
  assign ENET1_MDIO     = black_mdio_oen ? 1'bz : black_mdio_out;
  assign black_tx_clk   = black_eth_mode ? clk_125 :     // GbE Mode   = 125MHz clock
                          black_ena_10   ? clk_2p5 :     // 10Mb Mode  = 2.5MHz clock
                                           clk_25;       // 100Mb Mode = 25 MHz clock
  
  //LED Assignments
  assign LEDR[17]     = SW[17];
  assign LEDR[16:12]  = 5'b0;
  assign LEDR[11:0]   = SW[11:0];
  assign LEDG[8:0]    = out_port_from_the_output_port[8:0];
  
  assign master_reset = (core_reset_n & KEY[0]);
  assign grounded = 1'b0;
  
//=======================================================
//  Module declarations
//=======================================================
	my_ddio ddio_out_inst0(
		.datain_h(1'b1),
		.datain_l(1'b0),
		.outclock(red_tx_clk),
		.dataout(ENET0_GTX_CLK)
	);
  
  my_ddio ddio_out_inst1(
    .datain_h(1'b1),
    .datain_l(1'b0),
    .outclock(black_tx_clk),
    .dataout(ENET1_GTX_CLK)
  );
  
  my_pll pll_inst(
		.areset	(~KEY[0]),
		.inclk0	(CLOCK_50),
		.c0		(sys_clk),
		.c1		(clk_125),
		.c2		(clk_25),
		.c3		(clk_2p5),
		.locked	(core_reset_n)
	); 
	
  TEDv3_architecture system_inst (
    .clk_clk                                               (sys_clk),                                     //                                               clk.clk
    .reset_reset_n                                         (core_reset_n),                                //                                             reset.reset_n
	  
    .hex_conduit_hex_conduit                               (Q_export_from_the_hex),                       //                                       hex_conduit.hex_conduit
    .output_port_external_connection_export                (out_port_from_the_output_port),               //                   output_port_external_connection.export
    .input_port_external_connection_export                 (in_port_to_the_input_port),                   //           
 
    .lcd_clk_areset_conduit_export                         (grounded),                                    //                            lcd_clk_areset_conduit.export
    .lcd_external_interface_DATA                           (LCD_DATA),                                    //                            lcd_external_interface.DATA
    .lcd_external_interface_ON                             (LCD_ON),                                      //                                                  .ON
    .lcd_external_interface_BLON                           (LCD_BLON),                                    //                                                  .BLON
    .lcd_external_interface_EN                             (LCD_EN),                                      //                                                  .EN
    .lcd_external_interface_RS                             (LCD_RS),                                      //                                                  .RS
    .lcd_external_interface_RW                             (LCD_RW),                                       //                                                  .RW 
    .black_interface_pcs_mac_tx_clock_connection_clk 		   (black_tx_clk), 				                        // eth_black_interface_0_pcs_mac_tx_clock_connection.clk
    .black_interface_pcs_mac_rx_clock_connection_clk 		   (ENET1_RX_CLK), 		                            // eth_black_interface_0_pcs_mac_rx_clock_connection.clk
    .black_interface_mac_mdio_connection_mdc               (black_mdc),             	                    //               black_interface_mac_mdio_connection.mdc
    .black_interface_mac_mdio_connection_mdio_in           (black_mdio_in),                               //                                                  .mdio_in
    .black_interface_mac_mdio_connection_mdio_out          (black_mdio_out),                              //                                                  .mdio_out
    .black_interface_mac_mdio_connection_mdio_oen          (black_mdio_oen),                              //                                                  .mdio_oen
    .black_interface_mac_rgmii_connection_rgmii_in         (ENET1_RX_DATA),                               //              black_interface_mac_rgmii_connection.rgmii_in
    .black_interface_mac_rgmii_connection_rgmii_out        (ENET1_TX_DATA),                               //                                                  .rgmii_out
    .black_interface_mac_rgmii_connection_rx_control       (ENET1_RX_DV),                                 //                                                  .rx_control
    .black_interface_mac_rgmii_connection_tx_control       (ENET1_TX_EN),                                 //                                                  .tx_control
    .black_interface_mac_misc_connection_ff_tx_crc_fwd (grounded),                                              //               black_interface_mac_misc_connection.ff_tx_crc_fwd        
	 .black_interface_mac_misc_connection_xon_gen       (grounded),       //         black_interface_mac_misc_connection.xon_gen
    .black_interface_mac_misc_connection_xoff_gen      (grounded),      //                                            .xoff_gen
	 //.black_interface_mac_misc_connection_ff_tx_septy   (),                                              //                                                  .ff_tx_septy
    //.black_interface_mac_misc_connection_tx_ff_uflow   (),                                              //                                                  .tx_ff_uflow
    //.black_interface_mac_misc_connection_ff_tx_a_full  (),                                              //                                                  .ff_tx_a_full
    //.black_interface_mac_misc_connection_ff_tx_a_empty (),                                              //                                                  .ff_tx_a_empty
    //.black_interface_mac_misc_connection_rx_err_stat   (),                                              //                                                  .rx_err_stat
    //.black_interface_mac_misc_connection_rx_frm_type   (),                                              //                                                  .rx_frm_type
    //.black_interface_mac_misc_connection_ff_rx_dsav    (),                                              //                                                  .ff_rx_dsav
    .black_interface_mac_misc_connection_ff_rx_a_full  (black_XOFF),                                              //                                                  .ff_rx_a_full
    .black_interface_mac_misc_connection_ff_rx_a_empty (black_XON),                                              //                                                  .ff_rx_a_empty
    .black_interface_mac_status_connection_eth_mode        (black_eth_mode),        	                   //                                                  .eth_mode
    .black_interface_mac_status_connection_ena_10          (black_ena_10),          	                   //                                                  .ena_10	  

    .red_interface_pcs_mac_tx_clock_connection_clk 	       (red_tx_clk), 		                         // eth_black_interface_0_pcs_mac_tx_clock_connection.clk
    .red_interface_pcs_mac_rx_clock_connection_clk 	       (ENET0_RX_CLK), 	                          	 // eth_black_interface_0_pcs_mac_rx_clock_connection.clk
    .red_interface_mac_mdio_connection_mdc                 (red_mdc),                                     //               black_interface_mac_mdio_connection.mdc
    .red_interface_mac_mdio_connection_mdio_in             (red_mdio_in),                                 //                                                  .mdio_in
    .red_interface_mac_mdio_connection_mdio_out            (red_mdio_out),                                //                                                  .mdio_out
    .red_interface_mac_mdio_connection_mdio_oen            (red_mdio_oen),                                //                                                  .mdio_oen
    .red_interface_mac_rgmii_connection_rgmii_in           (ENET0_RX_DATA),                               //              black_interface_mac_rgmii_connection.rgmii_in
    .red_interface_mac_rgmii_connection_rgmii_out          (ENET0_TX_DATA),                               //                                                  .rgmii_out
    .red_interface_mac_rgmii_connection_rx_control         (ENET0_RX_DV),                                 //                                                  .rx_control
    .red_interface_mac_rgmii_connection_tx_control         (ENET0_TX_EN),                                 //                                                  .tx_control
    .red_interface_mac_misc_connection_ff_tx_crc_fwd   (grounded),                                              //               black_interface_mac_misc_connection.ff_tx_crc_fwd
	 .red_interface_mac_misc_connection_xon_gen         (grounded),         //           red_interface_mac_misc_connection.xon_gen
	 .red_interface_mac_misc_connection_xoff_gen        (grounded),        //                                            .xoff_gen

    //.red_interface_mac_misc_connection_ff_tx_septy     (),                                              //                                                  .ff_tx_septy
    //.red_interface_mac_misc_connection_tx_ff_uflow     (),                                              //                                                  .tx_ff_uflow
    //.red_interface_mac_misc_connection_ff_tx_a_full    (),                                              //                                                  .ff_tx_a_full
    //.red_interface_mac_misc_connection_ff_tx_a_empty   (),                                              //                                                  .ff_tx_a_empty
    //.red_interface_mac_misc_connection_rx_err_stat     (),                                              //                                                  .rx_err_stat
    //.red_interface_mac_misc_connection_rx_frm_type     (),                                              //                                                  .rx_frm_type
    //.red_interface_mac_misc_connection_ff_rx_dsav      (),                                              //                                                  .ff_rx_dsav
    .red_interface_mac_misc_connection_ff_rx_a_full    (red_XOFF),                                              //                                                  .ff_rx_a_full
    .red_interface_mac_misc_connection_ff_rx_a_empty   (red_XON),                                              //                                                  .ff_rx_a_empty
    .red_interface_mac_status_connection_eth_mode          (red_eth_mode),        	                      //                                                  .eth_mode
    .red_interface_mac_status_connection_ena_10            (red_ena_10),          	                      //                                                  .ena_10	    
  );
 
  hex7seg h0(
    .hex              (Q_export_from_the_hex[3:0]),
    .display          (HEX0)
  );
  hex7seg h1(
    .hex              (Q_export_from_the_hex[7:4]),
    .display          (HEX1)
  );
  hex7seg h2(
    .hex              (Q_export_from_the_hex[11:8]),
    .display          (HEX2)
  );
  hex7seg h3(
    .hex              (Q_export_from_the_hex[15:12]),
    .display          (HEX3)
  );
  hex7seg h4(
    .hex              (Q_export_from_the_hex[19:16]),
    .display          (HEX4)
  );
  hex7seg h5(
    .hex              (Q_export_from_the_hex[23:20]),
    .display          (HEX5)
  );
  hex7seg h6(
    .hex              (Q_export_from_the_hex[27:24]),
    .display          (HEX6)
  );
  hex7seg h7(
    .hex              (Q_export_from_the_hex[31:28]),
    .display          (HEX7)
  );
      
      
endmodule
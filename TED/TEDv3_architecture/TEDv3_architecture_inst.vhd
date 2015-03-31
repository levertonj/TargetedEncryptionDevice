	component TEDv3_architecture is
		port (
			black_interface_mac_mdio_connection_mdc           : out   std_logic;                                        -- mdc
			black_interface_mac_mdio_connection_mdio_in       : in    std_logic                     := 'X';             -- mdio_in
			black_interface_mac_mdio_connection_mdio_out      : out   std_logic;                                        -- mdio_out
			black_interface_mac_mdio_connection_mdio_oen      : out   std_logic;                                        -- mdio_oen
			black_interface_mac_misc_connection_xon_gen       : in    std_logic                     := 'X';             -- xon_gen
			black_interface_mac_misc_connection_xoff_gen      : in    std_logic                     := 'X';             -- xoff_gen
			black_interface_mac_misc_connection_ff_tx_crc_fwd : in    std_logic                     := 'X';             -- ff_tx_crc_fwd
			black_interface_mac_misc_connection_ff_tx_septy   : out   std_logic;                                        -- ff_tx_septy
			black_interface_mac_misc_connection_tx_ff_uflow   : out   std_logic;                                        -- tx_ff_uflow
			black_interface_mac_misc_connection_ff_tx_a_full  : out   std_logic;                                        -- ff_tx_a_full
			black_interface_mac_misc_connection_ff_tx_a_empty : out   std_logic;                                        -- ff_tx_a_empty
			black_interface_mac_misc_connection_rx_err_stat   : out   std_logic_vector(17 downto 0);                    -- rx_err_stat
			black_interface_mac_misc_connection_rx_frm_type   : out   std_logic_vector(3 downto 0);                     -- rx_frm_type
			black_interface_mac_misc_connection_ff_rx_dsav    : out   std_logic;                                        -- ff_rx_dsav
			black_interface_mac_misc_connection_ff_rx_a_full  : out   std_logic;                                        -- ff_rx_a_full
			black_interface_mac_misc_connection_ff_rx_a_empty : out   std_logic;                                        -- ff_rx_a_empty
			black_interface_mac_rgmii_connection_rgmii_in     : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- rgmii_in
			black_interface_mac_rgmii_connection_rgmii_out    : out   std_logic_vector(3 downto 0);                     -- rgmii_out
			black_interface_mac_rgmii_connection_rx_control   : in    std_logic                     := 'X';             -- rx_control
			black_interface_mac_rgmii_connection_tx_control   : out   std_logic;                                        -- tx_control
			black_interface_mac_status_connection_set_10      : in    std_logic                     := 'X';             -- set_10
			black_interface_mac_status_connection_set_1000    : in    std_logic                     := 'X';             -- set_1000
			black_interface_mac_status_connection_eth_mode    : out   std_logic;                                        -- eth_mode
			black_interface_mac_status_connection_ena_10      : out   std_logic;                                        -- ena_10
			black_interface_pcs_mac_rx_clock_connection_clk   : in    std_logic                     := 'X';             -- clk
			black_interface_pcs_mac_tx_clock_connection_clk   : in    std_logic                     := 'X';             -- clk
			clk_clk                                           : in    std_logic                     := 'X';             -- clk
			hex_conduit_hex_conduit                           : out   std_logic_vector(31 downto 0);                    -- hex_conduit
			input_port_external_connection_export             : in    std_logic_vector(31 downto 0) := (others => 'X'); -- export
			lcd_clk_areset_conduit_export                     : in    std_logic                     := 'X';             -- export
			lcd_clk_locked_conduit_export                     : out   std_logic;                                        -- export
			lcd_clk_phasedone_conduit_export                  : out   std_logic;                                        -- export
			lcd_external_interface_DATA                       : inout std_logic_vector(7 downto 0)  := (others => 'X'); -- DATA
			lcd_external_interface_ON                         : out   std_logic;                                        -- ON
			lcd_external_interface_BLON                       : out   std_logic;                                        -- BLON
			lcd_external_interface_EN                         : out   std_logic;                                        -- EN
			lcd_external_interface_RS                         : out   std_logic;                                        -- RS
			lcd_external_interface_RW                         : out   std_logic;                                        -- RW
			output_port_external_connection_export            : out   std_logic_vector(31 downto 0);                    -- export
			red_interface_mac_mdio_connection_mdc             : out   std_logic;                                        -- mdc
			red_interface_mac_mdio_connection_mdio_in         : in    std_logic                     := 'X';             -- mdio_in
			red_interface_mac_mdio_connection_mdio_out        : out   std_logic;                                        -- mdio_out
			red_interface_mac_mdio_connection_mdio_oen        : out   std_logic;                                        -- mdio_oen
			red_interface_mac_misc_connection_xon_gen         : in    std_logic                     := 'X';             -- xon_gen
			red_interface_mac_misc_connection_xoff_gen        : in    std_logic                     := 'X';             -- xoff_gen
			red_interface_mac_misc_connection_ff_tx_crc_fwd   : in    std_logic                     := 'X';             -- ff_tx_crc_fwd
			red_interface_mac_misc_connection_ff_tx_septy     : out   std_logic;                                        -- ff_tx_septy
			red_interface_mac_misc_connection_tx_ff_uflow     : out   std_logic;                                        -- tx_ff_uflow
			red_interface_mac_misc_connection_ff_tx_a_full    : out   std_logic;                                        -- ff_tx_a_full
			red_interface_mac_misc_connection_ff_tx_a_empty   : out   std_logic;                                        -- ff_tx_a_empty
			red_interface_mac_misc_connection_rx_err_stat     : out   std_logic_vector(17 downto 0);                    -- rx_err_stat
			red_interface_mac_misc_connection_rx_frm_type     : out   std_logic_vector(3 downto 0);                     -- rx_frm_type
			red_interface_mac_misc_connection_ff_rx_dsav      : out   std_logic;                                        -- ff_rx_dsav
			red_interface_mac_misc_connection_ff_rx_a_full    : out   std_logic;                                        -- ff_rx_a_full
			red_interface_mac_misc_connection_ff_rx_a_empty   : out   std_logic;                                        -- ff_rx_a_empty
			red_interface_mac_rgmii_connection_rgmii_in       : in    std_logic_vector(3 downto 0)  := (others => 'X'); -- rgmii_in
			red_interface_mac_rgmii_connection_rgmii_out      : out   std_logic_vector(3 downto 0);                     -- rgmii_out
			red_interface_mac_rgmii_connection_rx_control     : in    std_logic                     := 'X';             -- rx_control
			red_interface_mac_rgmii_connection_tx_control     : out   std_logic;                                        -- tx_control
			red_interface_mac_status_connection_set_10        : in    std_logic                     := 'X';             -- set_10
			red_interface_mac_status_connection_set_1000      : in    std_logic                     := 'X';             -- set_1000
			red_interface_mac_status_connection_eth_mode      : out   std_logic;                                        -- eth_mode
			red_interface_mac_status_connection_ena_10        : out   std_logic;                                        -- ena_10
			red_interface_pcs_mac_rx_clock_connection_clk     : in    std_logic                     := 'X';             -- clk
			red_interface_pcs_mac_tx_clock_connection_clk     : in    std_logic                     := 'X';             -- clk
			reset_reset_n                                     : in    std_logic                     := 'X'              -- reset_n
		);
	end component TEDv3_architecture;

	u0 : component TEDv3_architecture
		port map (
			black_interface_mac_mdio_connection_mdc           => CONNECTED_TO_black_interface_mac_mdio_connection_mdc,           --         black_interface_mac_mdio_connection.mdc
			black_interface_mac_mdio_connection_mdio_in       => CONNECTED_TO_black_interface_mac_mdio_connection_mdio_in,       --                                            .mdio_in
			black_interface_mac_mdio_connection_mdio_out      => CONNECTED_TO_black_interface_mac_mdio_connection_mdio_out,      --                                            .mdio_out
			black_interface_mac_mdio_connection_mdio_oen      => CONNECTED_TO_black_interface_mac_mdio_connection_mdio_oen,      --                                            .mdio_oen
			black_interface_mac_misc_connection_xon_gen       => CONNECTED_TO_black_interface_mac_misc_connection_xon_gen,       --         black_interface_mac_misc_connection.xon_gen
			black_interface_mac_misc_connection_xoff_gen      => CONNECTED_TO_black_interface_mac_misc_connection_xoff_gen,      --                                            .xoff_gen
			black_interface_mac_misc_connection_ff_tx_crc_fwd => CONNECTED_TO_black_interface_mac_misc_connection_ff_tx_crc_fwd, --                                            .ff_tx_crc_fwd
			black_interface_mac_misc_connection_ff_tx_septy   => CONNECTED_TO_black_interface_mac_misc_connection_ff_tx_septy,   --                                            .ff_tx_septy
			black_interface_mac_misc_connection_tx_ff_uflow   => CONNECTED_TO_black_interface_mac_misc_connection_tx_ff_uflow,   --                                            .tx_ff_uflow
			black_interface_mac_misc_connection_ff_tx_a_full  => CONNECTED_TO_black_interface_mac_misc_connection_ff_tx_a_full,  --                                            .ff_tx_a_full
			black_interface_mac_misc_connection_ff_tx_a_empty => CONNECTED_TO_black_interface_mac_misc_connection_ff_tx_a_empty, --                                            .ff_tx_a_empty
			black_interface_mac_misc_connection_rx_err_stat   => CONNECTED_TO_black_interface_mac_misc_connection_rx_err_stat,   --                                            .rx_err_stat
			black_interface_mac_misc_connection_rx_frm_type   => CONNECTED_TO_black_interface_mac_misc_connection_rx_frm_type,   --                                            .rx_frm_type
			black_interface_mac_misc_connection_ff_rx_dsav    => CONNECTED_TO_black_interface_mac_misc_connection_ff_rx_dsav,    --                                            .ff_rx_dsav
			black_interface_mac_misc_connection_ff_rx_a_full  => CONNECTED_TO_black_interface_mac_misc_connection_ff_rx_a_full,  --                                            .ff_rx_a_full
			black_interface_mac_misc_connection_ff_rx_a_empty => CONNECTED_TO_black_interface_mac_misc_connection_ff_rx_a_empty, --                                            .ff_rx_a_empty
			black_interface_mac_rgmii_connection_rgmii_in     => CONNECTED_TO_black_interface_mac_rgmii_connection_rgmii_in,     --        black_interface_mac_rgmii_connection.rgmii_in
			black_interface_mac_rgmii_connection_rgmii_out    => CONNECTED_TO_black_interface_mac_rgmii_connection_rgmii_out,    --                                            .rgmii_out
			black_interface_mac_rgmii_connection_rx_control   => CONNECTED_TO_black_interface_mac_rgmii_connection_rx_control,   --                                            .rx_control
			black_interface_mac_rgmii_connection_tx_control   => CONNECTED_TO_black_interface_mac_rgmii_connection_tx_control,   --                                            .tx_control
			black_interface_mac_status_connection_set_10      => CONNECTED_TO_black_interface_mac_status_connection_set_10,      --       black_interface_mac_status_connection.set_10
			black_interface_mac_status_connection_set_1000    => CONNECTED_TO_black_interface_mac_status_connection_set_1000,    --                                            .set_1000
			black_interface_mac_status_connection_eth_mode    => CONNECTED_TO_black_interface_mac_status_connection_eth_mode,    --                                            .eth_mode
			black_interface_mac_status_connection_ena_10      => CONNECTED_TO_black_interface_mac_status_connection_ena_10,      --                                            .ena_10
			black_interface_pcs_mac_rx_clock_connection_clk   => CONNECTED_TO_black_interface_pcs_mac_rx_clock_connection_clk,   -- black_interface_pcs_mac_rx_clock_connection.clk
			black_interface_pcs_mac_tx_clock_connection_clk   => CONNECTED_TO_black_interface_pcs_mac_tx_clock_connection_clk,   -- black_interface_pcs_mac_tx_clock_connection.clk
			clk_clk                                           => CONNECTED_TO_clk_clk,                                           --                                         clk.clk
			hex_conduit_hex_conduit                           => CONNECTED_TO_hex_conduit_hex_conduit,                           --                                 hex_conduit.hex_conduit
			input_port_external_connection_export             => CONNECTED_TO_input_port_external_connection_export,             --              input_port_external_connection.export
			lcd_clk_areset_conduit_export                     => CONNECTED_TO_lcd_clk_areset_conduit_export,                     --                      lcd_clk_areset_conduit.export
			lcd_clk_locked_conduit_export                     => CONNECTED_TO_lcd_clk_locked_conduit_export,                     --                      lcd_clk_locked_conduit.export
			lcd_clk_phasedone_conduit_export                  => CONNECTED_TO_lcd_clk_phasedone_conduit_export,                  --                   lcd_clk_phasedone_conduit.export
			lcd_external_interface_DATA                       => CONNECTED_TO_lcd_external_interface_DATA,                       --                      lcd_external_interface.DATA
			lcd_external_interface_ON                         => CONNECTED_TO_lcd_external_interface_ON,                         --                                            .ON
			lcd_external_interface_BLON                       => CONNECTED_TO_lcd_external_interface_BLON,                       --                                            .BLON
			lcd_external_interface_EN                         => CONNECTED_TO_lcd_external_interface_EN,                         --                                            .EN
			lcd_external_interface_RS                         => CONNECTED_TO_lcd_external_interface_RS,                         --                                            .RS
			lcd_external_interface_RW                         => CONNECTED_TO_lcd_external_interface_RW,                         --                                            .RW
			output_port_external_connection_export            => CONNECTED_TO_output_port_external_connection_export,            --             output_port_external_connection.export
			red_interface_mac_mdio_connection_mdc             => CONNECTED_TO_red_interface_mac_mdio_connection_mdc,             --           red_interface_mac_mdio_connection.mdc
			red_interface_mac_mdio_connection_mdio_in         => CONNECTED_TO_red_interface_mac_mdio_connection_mdio_in,         --                                            .mdio_in
			red_interface_mac_mdio_connection_mdio_out        => CONNECTED_TO_red_interface_mac_mdio_connection_mdio_out,        --                                            .mdio_out
			red_interface_mac_mdio_connection_mdio_oen        => CONNECTED_TO_red_interface_mac_mdio_connection_mdio_oen,        --                                            .mdio_oen
			red_interface_mac_misc_connection_xon_gen         => CONNECTED_TO_red_interface_mac_misc_connection_xon_gen,         --           red_interface_mac_misc_connection.xon_gen
			red_interface_mac_misc_connection_xoff_gen        => CONNECTED_TO_red_interface_mac_misc_connection_xoff_gen,        --                                            .xoff_gen
			red_interface_mac_misc_connection_ff_tx_crc_fwd   => CONNECTED_TO_red_interface_mac_misc_connection_ff_tx_crc_fwd,   --                                            .ff_tx_crc_fwd
			red_interface_mac_misc_connection_ff_tx_septy     => CONNECTED_TO_red_interface_mac_misc_connection_ff_tx_septy,     --                                            .ff_tx_septy
			red_interface_mac_misc_connection_tx_ff_uflow     => CONNECTED_TO_red_interface_mac_misc_connection_tx_ff_uflow,     --                                            .tx_ff_uflow
			red_interface_mac_misc_connection_ff_tx_a_full    => CONNECTED_TO_red_interface_mac_misc_connection_ff_tx_a_full,    --                                            .ff_tx_a_full
			red_interface_mac_misc_connection_ff_tx_a_empty   => CONNECTED_TO_red_interface_mac_misc_connection_ff_tx_a_empty,   --                                            .ff_tx_a_empty
			red_interface_mac_misc_connection_rx_err_stat     => CONNECTED_TO_red_interface_mac_misc_connection_rx_err_stat,     --                                            .rx_err_stat
			red_interface_mac_misc_connection_rx_frm_type     => CONNECTED_TO_red_interface_mac_misc_connection_rx_frm_type,     --                                            .rx_frm_type
			red_interface_mac_misc_connection_ff_rx_dsav      => CONNECTED_TO_red_interface_mac_misc_connection_ff_rx_dsav,      --                                            .ff_rx_dsav
			red_interface_mac_misc_connection_ff_rx_a_full    => CONNECTED_TO_red_interface_mac_misc_connection_ff_rx_a_full,    --                                            .ff_rx_a_full
			red_interface_mac_misc_connection_ff_rx_a_empty   => CONNECTED_TO_red_interface_mac_misc_connection_ff_rx_a_empty,   --                                            .ff_rx_a_empty
			red_interface_mac_rgmii_connection_rgmii_in       => CONNECTED_TO_red_interface_mac_rgmii_connection_rgmii_in,       --          red_interface_mac_rgmii_connection.rgmii_in
			red_interface_mac_rgmii_connection_rgmii_out      => CONNECTED_TO_red_interface_mac_rgmii_connection_rgmii_out,      --                                            .rgmii_out
			red_interface_mac_rgmii_connection_rx_control     => CONNECTED_TO_red_interface_mac_rgmii_connection_rx_control,     --                                            .rx_control
			red_interface_mac_rgmii_connection_tx_control     => CONNECTED_TO_red_interface_mac_rgmii_connection_tx_control,     --                                            .tx_control
			red_interface_mac_status_connection_set_10        => CONNECTED_TO_red_interface_mac_status_connection_set_10,        --         red_interface_mac_status_connection.set_10
			red_interface_mac_status_connection_set_1000      => CONNECTED_TO_red_interface_mac_status_connection_set_1000,      --                                            .set_1000
			red_interface_mac_status_connection_eth_mode      => CONNECTED_TO_red_interface_mac_status_connection_eth_mode,      --                                            .eth_mode
			red_interface_mac_status_connection_ena_10        => CONNECTED_TO_red_interface_mac_status_connection_ena_10,        --                                            .ena_10
			red_interface_pcs_mac_rx_clock_connection_clk     => CONNECTED_TO_red_interface_pcs_mac_rx_clock_connection_clk,     --   red_interface_pcs_mac_rx_clock_connection.clk
			red_interface_pcs_mac_tx_clock_connection_clk     => CONNECTED_TO_red_interface_pcs_mac_tx_clock_connection_clk,     --   red_interface_pcs_mac_tx_clock_connection.clk
			reset_reset_n                                     => CONNECTED_TO_reset_reset_n                                      --                                       reset.reset_n
		);


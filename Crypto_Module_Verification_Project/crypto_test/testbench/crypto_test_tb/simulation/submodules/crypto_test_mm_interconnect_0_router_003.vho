--IP Functional Simulation Model
--VERSION_BEGIN 14.1 cbx_mgl 2015:01:19:16:18:34:SJ cbx_simgen 2015:01:19:16:14:35:SJ  VERSION_END


-- Copyright (C) 1991-2015 Altera Corporation. All rights reserved.
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, the Altera Quartus II License Agreement,
-- the Altera MegaCore Function License Agreement, or other 
-- applicable license agreement, including, without limitation, 
-- that your use is for the sole purpose of programming logic 
-- devices manufactured by Altera and sold by Altera or its 
-- authorized distributors.  Please refer to the applicable 
-- agreement for further details.

-- You may only use these simulation model output files for simulation
-- purposes and expressly not for synthesis or any other purposes (in which
-- event Altera disclaims all warranties of any kind).


--synopsys translate_off

--synthesis_resources = mux21 4 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  crypto_test_mm_interconnect_0_router_003 IS 
	 PORT 
	 ( 
		 clk	:	IN  STD_LOGIC;
		 reset	:	IN  STD_LOGIC;
		 sink_data	:	IN  STD_LOGIC_VECTOR (109 DOWNTO 0);
		 sink_endofpacket	:	IN  STD_LOGIC;
		 sink_ready	:	OUT  STD_LOGIC;
		 sink_startofpacket	:	IN  STD_LOGIC;
		 sink_valid	:	IN  STD_LOGIC;
		 src_channel	:	OUT  STD_LOGIC_VECTOR (9 DOWNTO 0);
		 src_data	:	OUT  STD_LOGIC_VECTOR (109 DOWNTO 0);
		 src_endofpacket	:	OUT  STD_LOGIC;
		 src_ready	:	IN  STD_LOGIC;
		 src_startofpacket	:	OUT  STD_LOGIC;
		 src_valid	:	OUT  STD_LOGIC
	 ); 
 END crypto_test_mm_interconnect_0_router_003;

 ARCHITECTURE RTL OF crypto_test_mm_interconnect_0_router_003 IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_003_src_channel_26m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_003_src_channel_27m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_003_src_data_29m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_003_src_data_30m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_w_lg_w_sink_data_range143w345w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range146w344w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_003_src_channel_0_306_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_003_src_channel_1_327_dataout :	STD_LOGIC;
	 SIGNAL  wire_w_sink_data_range143w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range146w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
 BEGIN

	wire_w_lg_w_sink_data_range143w345w(0) <= wire_w_sink_data_range143w(0) AND wire_w_lg_w_sink_data_range146w344w(0);
	wire_w1w(0) <= NOT s_wire_crypto_test_mm_interconnect_0_router_003_src_channel_0_306_dataout;
	wire_w_lg_w_sink_data_range146w344w(0) <= NOT wire_w_sink_data_range146w(0);
	s_wire_crypto_test_mm_interconnect_0_router_003_src_channel_0_306_dataout <= (((((((wire_w_lg_w_sink_data_range143w345w(0) AND (NOT sink_data(49))) AND sink_data(50)) AND sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_crypto_test_mm_interconnect_0_router_003_src_channel_1_327_dataout <= ((NOT sink_data(54)) AND sink_data(55));
	sink_ready <= src_ready;
	src_channel <= ( "0" & "0" & "0" & "0" & "0" & "0" & "0" & "0" & wire_crypto_test_mm_interconnect_0_router_003_src_channel_26m_dataout & wire_crypto_test_mm_interconnect_0_router_003_src_channel_27m_dataout);
	src_data <= ( sink_data(109 DOWNTO 97) & "0" & wire_crypto_test_mm_interconnect_0_router_003_src_data_29m_dataout & wire_crypto_test_mm_interconnect_0_router_003_src_data_30m_dataout & "0" & sink_data(92 DOWNTO 0));
	src_endofpacket <= sink_endofpacket;
	src_startofpacket <= sink_startofpacket;
	src_valid <= sink_valid;
	wire_w_sink_data_range143w(0) <= sink_data(47);
	wire_w_sink_data_range146w(0) <= sink_data(48);
	wire_crypto_test_mm_interconnect_0_router_003_src_channel_26m_dataout <= wire_w1w(0) OR s_wire_crypto_test_mm_interconnect_0_router_003_src_channel_1_327_dataout;
	wire_crypto_test_mm_interconnect_0_router_003_src_channel_27m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_003_src_channel_0_306_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_003_src_channel_1_327_dataout);
	wire_crypto_test_mm_interconnect_0_router_003_src_data_29m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_003_src_channel_0_306_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_003_src_channel_1_327_dataout);
	wire_crypto_test_mm_interconnect_0_router_003_src_data_30m_dataout <= wire_w1w(0) OR s_wire_crypto_test_mm_interconnect_0_router_003_src_channel_1_327_dataout;

 END RTL; --crypto_test_mm_interconnect_0_router_003
--synopsys translate_on
--VALID FILE

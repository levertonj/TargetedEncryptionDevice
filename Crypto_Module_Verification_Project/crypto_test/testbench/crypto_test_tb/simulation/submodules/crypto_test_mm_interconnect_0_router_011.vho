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

--synthesis_resources = mux21 2 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  crypto_test_mm_interconnect_0_router_011 IS 
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
 END crypto_test_mm_interconnect_0_router_011;

 ARCHITECTURE RTL OF crypto_test_mm_interconnect_0_router_011 IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_011_src_channel_35m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_011_src_channel_36m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_w_lg_w_lg_w_lg_w_lg_w_sink_data_range2w3w6w9w12w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_lg_w_lg_w_sink_data_range2w15w16w17w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_lg_w_lg_w_sink_data_range2w3w6w9w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_lg_w_sink_data_range2w15w16w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_lg_w_sink_data_range2w3w6w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range14w18w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range1w13w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range2w15w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w19w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range2w3w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range4w5w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range7w8w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range10w11w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_011_always0_14_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_011_always0_26_dataout :	STD_LOGIC;
	 SIGNAL  wire_w_sink_data_range14w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range2w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range4w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range7w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range10w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
 BEGIN

	wire_w_lg_w_lg_w_lg_w_lg_w_sink_data_range2w3w6w9w12w(0) <= wire_w_lg_w_lg_w_lg_w_sink_data_range2w3w6w9w(0) AND wire_w_lg_w_sink_data_range10w11w(0);
	wire_w_lg_w_lg_w_lg_w_sink_data_range2w15w16w17w(0) <= wire_w_lg_w_lg_w_sink_data_range2w15w16w(0) AND wire_w_lg_w_sink_data_range10w11w(0);
	wire_w_lg_w_lg_w_lg_w_sink_data_range2w3w6w9w(0) <= wire_w_lg_w_lg_w_sink_data_range2w3w6w(0) AND wire_w_lg_w_sink_data_range7w8w(0);
	wire_w_lg_w_lg_w_sink_data_range2w15w16w(0) <= wire_w_lg_w_sink_data_range2w15w(0) AND wire_w_lg_w_sink_data_range7w8w(0);
	wire_w_lg_w_lg_w_sink_data_range2w3w6w(0) <= wire_w_lg_w_sink_data_range2w3w(0) AND wire_w_lg_w_sink_data_range4w5w(0);
	wire_w_lg_w_sink_data_range14w18w(0) <= wire_w_sink_data_range14w(0) AND wire_w_lg_w_lg_w_lg_w_sink_data_range2w15w16w17w(0);
	wire_w_lg_w_sink_data_range1w13w(0) <= wire_w_sink_data_range1w(0) AND wire_w_lg_w_lg_w_lg_w_lg_w_sink_data_range2w3w6w9w12w(0);
	wire_w_lg_w_sink_data_range2w15w(0) <= wire_w_sink_data_range2w(0) AND wire_w_lg_w_sink_data_range4w5w(0);
	wire_w19w(0) <= NOT s_wire_crypto_test_mm_interconnect_0_router_011_always0_14_dataout;
	wire_w_lg_w_sink_data_range2w3w(0) <= NOT wire_w_sink_data_range2w(0);
	wire_w_lg_w_sink_data_range4w5w(0) <= NOT wire_w_sink_data_range4w(0);
	wire_w_lg_w_sink_data_range7w8w(0) <= NOT wire_w_sink_data_range7w(0);
	wire_w_lg_w_sink_data_range10w11w(0) <= NOT wire_w_sink_data_range10w(0);
	s_wire_crypto_test_mm_interconnect_0_router_011_always0_14_dataout <= wire_w_lg_w_sink_data_range1w13w(0);
	s_wire_crypto_test_mm_interconnect_0_router_011_always0_26_dataout <= wire_w_lg_w_sink_data_range14w18w(0);
	sink_ready <= src_ready;
	src_channel <= ( "0" & "0" & "0" & "0" & "0" & "0" & "0" & s_wire_crypto_test_mm_interconnect_0_router_011_always0_26_dataout & wire_crypto_test_mm_interconnect_0_router_011_src_channel_35m_dataout & wire_crypto_test_mm_interconnect_0_router_011_src_channel_36m_dataout);
	src_data <= ( sink_data(109 DOWNTO 0));
	src_endofpacket <= sink_endofpacket;
	src_startofpacket <= sink_startofpacket;
	src_valid <= sink_valid;
	wire_w_sink_data_range14w(0) <= sink_data(70);
	wire_w_sink_data_range1w(0) <= sink_data(71);
	wire_w_sink_data_range2w(0) <= sink_data(93);
	wire_w_sink_data_range4w(0) <= sink_data(94);
	wire_w_sink_data_range7w(0) <= sink_data(95);
	wire_w_sink_data_range10w(0) <= sink_data(96);
	wire_crypto_test_mm_interconnect_0_router_011_src_channel_35m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_011_always0_14_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_011_always0_26_dataout);
	wire_crypto_test_mm_interconnect_0_router_011_src_channel_36m_dataout <= wire_w19w(0) AND NOT(s_wire_crypto_test_mm_interconnect_0_router_011_always0_26_dataout);

 END RTL; --crypto_test_mm_interconnect_0_router_011
--synopsys translate_on
--VALID FILE

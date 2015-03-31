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

--synthesis_resources = 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  crypto_test_mm_interconnect_0_rsp_demux_007 IS 
	 PORT 
	 ( 
		 clk	:	IN  STD_LOGIC;
		 reset	:	IN  STD_LOGIC;
		 sink_channel	:	IN  STD_LOGIC_VECTOR (9 DOWNTO 0);
		 sink_data	:	IN  STD_LOGIC_VECTOR (109 DOWNTO 0);
		 sink_endofpacket	:	IN  STD_LOGIC;
		 sink_ready	:	OUT  STD_LOGIC;
		 sink_startofpacket	:	IN  STD_LOGIC;
		 sink_valid	:	IN  STD_LOGIC_VECTOR (0 DOWNTO 0);
		 src0_channel	:	OUT  STD_LOGIC_VECTOR (9 DOWNTO 0);
		 src0_data	:	OUT  STD_LOGIC_VECTOR (109 DOWNTO 0);
		 src0_endofpacket	:	OUT  STD_LOGIC;
		 src0_ready	:	IN  STD_LOGIC;
		 src0_startofpacket	:	OUT  STD_LOGIC;
		 src0_valid	:	OUT  STD_LOGIC;
		 src1_channel	:	OUT  STD_LOGIC_VECTOR (9 DOWNTO 0);
		 src1_data	:	OUT  STD_LOGIC_VECTOR (109 DOWNTO 0);
		 src1_endofpacket	:	OUT  STD_LOGIC;
		 src1_ready	:	IN  STD_LOGIC;
		 src1_startofpacket	:	OUT  STD_LOGIC;
		 src1_valid	:	OUT  STD_LOGIC;
		 src2_channel	:	OUT  STD_LOGIC_VECTOR (9 DOWNTO 0);
		 src2_data	:	OUT  STD_LOGIC_VECTOR (109 DOWNTO 0);
		 src2_endofpacket	:	OUT  STD_LOGIC;
		 src2_ready	:	IN  STD_LOGIC;
		 src2_startofpacket	:	OUT  STD_LOGIC;
		 src2_valid	:	OUT  STD_LOGIC
	 ); 
 END crypto_test_mm_interconnect_0_rsp_demux_007;

 ARCHITECTURE RTL OF crypto_test_mm_interconnect_0_rsp_demux_007 IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL  wire_w_lg_w_sink_channel_range1w2w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_channel_range3w4w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_channel_range6w7w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_channel_range1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_channel_range3w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_channel_range6w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
 BEGIN

	wire_w_lg_w_sink_channel_range1w2w(0) <= wire_w_sink_channel_range1w(0) AND src0_ready;
	wire_w_lg_w_sink_channel_range3w4w(0) <= wire_w_sink_channel_range3w(0) AND src1_ready;
	wire_w_lg_w_sink_channel_range6w7w(0) <= wire_w_sink_channel_range6w(0) AND src2_ready;
	sink_ready <= ((wire_w_lg_w_sink_channel_range1w2w(0) OR wire_w_lg_w_sink_channel_range3w4w(0)) OR wire_w_lg_w_sink_channel_range6w7w(0));
	src0_channel <= ( "0" & "0" & "0" & sink_channel(9 DOWNTO 3));
	src0_data <= ( sink_data(109 DOWNTO 0));
	src0_endofpacket <= sink_endofpacket;
	src0_startofpacket <= sink_startofpacket;
	src0_valid <= (sink_valid(0) AND sink_channel(0));
	src1_channel <= ( "0" & "0" & "0" & sink_channel(9 DOWNTO 3));
	src1_data <= ( sink_data(109 DOWNTO 0));
	src1_endofpacket <= sink_endofpacket;
	src1_startofpacket <= sink_startofpacket;
	src1_valid <= (sink_valid(0) AND sink_channel(1));
	src2_channel <= ( "0" & "0" & "0" & sink_channel(9 DOWNTO 3));
	src2_data <= ( sink_data(109 DOWNTO 0));
	src2_endofpacket <= sink_endofpacket;
	src2_startofpacket <= sink_startofpacket;
	src2_valid <= (sink_valid(0) AND sink_channel(2));
	wire_w_sink_channel_range1w(0) <= sink_channel(0);
	wire_w_sink_channel_range3w(0) <= sink_channel(1);
	wire_w_sink_channel_range6w(0) <= sink_channel(2);

 END RTL; --crypto_test_mm_interconnect_0_rsp_demux_007
--synopsys translate_on
--VALID FILE

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

--synthesis_resources = mux21 84 
 LIBRARY ieee;
 USE ieee.std_logic_1164.all;

 ENTITY  crypto_test_mm_interconnect_0_router IS 
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
 END crypto_test_mm_interconnect_0_router;

 ARCHITECTURE RTL OF crypto_test_mm_interconnect_0_router IS

	 ATTRIBUTE synthesis_clearbox : natural;
	 ATTRIBUTE synthesis_clearbox OF RTL : ARCHITECTURE IS 1;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_109m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_110m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_111m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_112m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_113m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_114m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_115m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_116m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_124m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_125m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_126m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_127m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_128m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_129m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_130m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_131m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_132m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_139m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_140m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_141m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_142m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_143m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_144m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_145m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_146m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_147m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_148m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_21m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_23m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_34m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_36m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_38m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_49m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_50m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_51m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_53m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_64m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_65m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_66m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_68m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_69m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_78m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_79m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_80m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_81m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_83m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_84m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_93m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_94m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_95m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_96m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_97m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_98m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_channel_99m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_103m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_104m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_105m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_106m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_119m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_120m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_121m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_122m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_134m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_135m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_136m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_137m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_149m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_150m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_151m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_152m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_29m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_44m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_45m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_46m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_59m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_60m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_61m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_74m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_75m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_76m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_88m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_89m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_90m_dataout	:	STD_LOGIC;
	 SIGNAL	wire_crypto_test_mm_interconnect_0_router_src_data_91m_dataout	:	STD_LOGIC;
	 SIGNAL  wire_w_lg_w_sink_data_range122w432w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range131w386w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range146w358w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range155w347w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w1w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w2w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range125w415w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range134w368w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range149w357w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_lg_w_sink_data_range158w337w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_always1_0_574_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_src_channel_0_427_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_src_channel_1_448_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_src_channel_2_469_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_src_channel_3_490_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout :	STD_LOGIC;
	 SIGNAL  s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout :	STD_LOGIC;
	 SIGNAL  wire_w_sink_data_range122w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range125w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range131w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range134w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range146w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range149w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range155w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
	 SIGNAL  wire_w_sink_data_range158w	:	STD_LOGIC_VECTOR (0 DOWNTO 0);
 BEGIN

	wire_w_lg_w_sink_data_range122w432w(0) <= wire_w_sink_data_range122w(0) AND wire_w_lg_w_sink_data_range125w415w(0);
	wire_w_lg_w_sink_data_range131w386w(0) <= wire_w_sink_data_range131w(0) AND wire_w_lg_w_sink_data_range134w368w(0);
	wire_w_lg_w_sink_data_range146w358w(0) <= wire_w_sink_data_range146w(0) AND wire_w_lg_w_sink_data_range149w357w(0);
	wire_w_lg_w_sink_data_range155w347w(0) <= wire_w_sink_data_range155w(0) AND wire_w_lg_w_sink_data_range158w337w(0);
	wire_w1w(0) <= NOT s_wire_crypto_test_mm_interconnect_0_router_src_channel_0_427_dataout;
	wire_w2w(0) <= NOT s_wire_crypto_test_mm_interconnect_0_router_src_channel_1_448_dataout;
	wire_w_lg_w_sink_data_range125w415w(0) <= NOT wire_w_sink_data_range125w(0);
	wire_w_lg_w_sink_data_range134w368w(0) <= NOT wire_w_sink_data_range134w(0);
	wire_w_lg_w_sink_data_range149w357w(0) <= NOT wire_w_sink_data_range149w(0);
	wire_w_lg_w_sink_data_range158w337w(0) <= NOT wire_w_sink_data_range158w(0);
	s_wire_crypto_test_mm_interconnect_0_router_always1_0_574_dataout <= (((((((((((((((((NOT sink_data(39)) AND wire_w_lg_w_sink_data_range125w415w(0)) AND sink_data(41)) AND (NOT sink_data(42))) AND sink_data(43)) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND sink_data(48)) AND (NOT sink_data(49))) AND sink_data(50)) AND sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout <= (sink_data(71) AND s_wire_crypto_test_mm_interconnect_0_router_always1_0_574_dataout);
	s_wire_crypto_test_mm_interconnect_0_router_src_channel_0_427_dataout <= ((((((NOT sink_data(50)) AND wire_w_lg_w_sink_data_range158w337w(0)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_crypto_test_mm_interconnect_0_router_src_channel_1_448_dataout <= ((((wire_w_lg_w_sink_data_range155w347w(0) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_crypto_test_mm_interconnect_0_router_src_channel_2_469_dataout <= ((((((NOT sink_data(50)) AND sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_crypto_test_mm_interconnect_0_router_src_channel_3_490_dataout <= (((((((wire_w_lg_w_sink_data_range146w358w(0) AND (NOT sink_data(49))) AND sink_data(50)) AND sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout <= ((((((((((((((NOT sink_data(42)) AND wire_w_lg_w_sink_data_range134w368w(0)) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND sink_data(48)) AND (NOT sink_data(49))) AND sink_data(50)) AND sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout <= ((((((((((((wire_w_lg_w_sink_data_range131w386w(0) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND sink_data(48)) AND (NOT sink_data(49))) AND sink_data(50)) AND sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout <= (((((((((((((((NOT sink_data(41)) AND (NOT sink_data(42))) AND sink_data(43)) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND sink_data(48)) AND (NOT sink_data(49))) AND sink_data(50)) AND sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout <= (((((((((((((((wire_w_lg_w_sink_data_range122w432w(0) AND sink_data(41)) AND (NOT sink_data(42))) AND sink_data(43)) AND (NOT sink_data(44))) AND (NOT sink_data(45))) AND (NOT sink_data(46))) AND (NOT sink_data(47))) AND sink_data(48)) AND (NOT sink_data(49))) AND sink_data(50)) AND sink_data(51)) AND (NOT sink_data(52))) AND (NOT sink_data(53))) AND (NOT sink_data(54))) AND (NOT sink_data(55)));
	s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout <= ((NOT sink_data(54)) AND sink_data(55));
	sink_ready <= src_ready;
	src_channel <= ( wire_crypto_test_mm_interconnect_0_router_src_channel_139m_dataout & wire_crypto_test_mm_interconnect_0_router_src_channel_140m_dataout & wire_crypto_test_mm_interconnect_0_router_src_channel_141m_dataout & wire_crypto_test_mm_interconnect_0_router_src_channel_142m_dataout & wire_crypto_test_mm_interconnect_0_router_src_channel_143m_dataout & wire_crypto_test_mm_interconnect_0_router_src_channel_144m_dataout & wire_crypto_test_mm_interconnect_0_router_src_channel_145m_dataout & wire_crypto_test_mm_interconnect_0_router_src_channel_146m_dataout & wire_crypto_test_mm_interconnect_0_router_src_channel_147m_dataout & wire_crypto_test_mm_interconnect_0_router_src_channel_148m_dataout);
	src_data <= ( sink_data(109 DOWNTO 97) & wire_crypto_test_mm_interconnect_0_router_src_data_149m_dataout & wire_crypto_test_mm_interconnect_0_router_src_data_150m_dataout & wire_crypto_test_mm_interconnect_0_router_src_data_151m_dataout & wire_crypto_test_mm_interconnect_0_router_src_data_152m_dataout & sink_data(92 DOWNTO 0));
	src_endofpacket <= sink_endofpacket;
	src_startofpacket <= sink_startofpacket;
	src_valid <= sink_valid;
	wire_w_sink_data_range122w(0) <= sink_data(39);
	wire_w_sink_data_range125w(0) <= sink_data(40);
	wire_w_sink_data_range131w(0) <= sink_data(42);
	wire_w_sink_data_range134w(0) <= sink_data(43);
	wire_w_sink_data_range146w(0) <= sink_data(47);
	wire_w_sink_data_range149w(0) <= sink_data(48);
	wire_w_sink_data_range155w(0) <= sink_data(50);
	wire_w_sink_data_range158w(0) <= sink_data(51);
	wire_crypto_test_mm_interconnect_0_router_src_channel_109m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_93m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_110m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_94m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_111m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_95m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_112m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_96m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_113m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_97m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_114m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_98m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_115m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_99m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_116m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_124m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_109m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_125m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_110m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_126m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_111m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_127m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_112m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_128m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_113m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_129m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_114m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_130m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_115m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_131m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_116m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_132m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_139m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_124m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_140m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_125m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_141m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_126m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_142m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_127m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_143m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_128m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_144m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_129m_dataout OR s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_channel_145m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_130m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_146m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_131m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_147m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_132m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_148m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_21m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_src_channel_0_427_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_1_448_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_23m_dataout <= wire_w1w(0) AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_1_448_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_34m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_src_channel_1_448_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_2_469_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_36m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_21m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_2_469_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_38m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_23m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_2_469_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_49m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_34m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_3_490_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_50m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_src_channel_2_469_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_3_490_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_51m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_36m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_3_490_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_53m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_38m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_3_490_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_64m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_49m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_65m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_50m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_66m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_51m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_68m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_53m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_69m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_src_channel_3_490_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_78m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_79m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_64m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_80m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_65m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_81m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_66m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_83m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_68m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_84m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_69m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_93m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_78m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_94m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_79m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_95m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_80m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_96m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_81m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_97m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_98m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_83m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_channel_99m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_channel_84m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_103m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_88m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_104m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_89m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_105m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_90m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_106m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_91m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_6_553_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_119m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_103m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_120m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_104m_dataout OR s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_data_121m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_105m_dataout OR s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_data_122m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_106m_dataout OR s_wire_crypto_test_mm_interconnect_0_router_always1_108_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_data_134m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_119m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_135m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_120m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_136m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_121m_dataout OR s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_data_137m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_122m_dataout OR s_wire_crypto_test_mm_interconnect_0_router_src_channel_7_595_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_data_149m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_134m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_150m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_135m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_151m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_136m_dataout OR s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_data_152m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_137m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_8_616_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_29m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_src_channel_0_427_dataout OR s_wire_crypto_test_mm_interconnect_0_router_src_channel_1_448_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_data_44m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_29m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_2_469_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_45m_dataout <= wire_w2w(0) AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_2_469_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_46m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_src_channel_1_448_dataout OR s_wire_crypto_test_mm_interconnect_0_router_src_channel_2_469_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_data_59m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_44m_dataout OR s_wire_crypto_test_mm_interconnect_0_router_src_channel_3_490_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_data_60m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_45m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_3_490_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_61m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_46m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_3_490_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_74m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_59m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_75m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_60m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_76m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_61m_dataout OR s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_data_88m_dataout <= s_wire_crypto_test_mm_interconnect_0_router_src_channel_4_511_dataout OR s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout;
	wire_crypto_test_mm_interconnect_0_router_src_data_89m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_74m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_90m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_75m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout);
	wire_crypto_test_mm_interconnect_0_router_src_data_91m_dataout <= wire_crypto_test_mm_interconnect_0_router_src_data_76m_dataout AND NOT(s_wire_crypto_test_mm_interconnect_0_router_src_channel_5_532_dataout);

 END RTL; --crypto_test_mm_interconnect_0_router
--synopsys translate_on
--VALID FILE

-- crypto_test_tb.vhd

-- Generated using ACDS version 14.1 190 at 2015.03.23.23:40:51

library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity crypto_test_tb is
end entity crypto_test_tb;

architecture rtl of crypto_test_tb is
	component crypto_test is
		port (
			clk_clk       : in std_logic := 'X'; -- clk
			reset_reset_n : in std_logic := 'X'  -- reset_n
		);
	end component crypto_test;

	component altera_avalon_clock_source is
		generic (
			CLOCK_RATE : positive := 10;
			CLOCK_UNIT : positive := 1000000
		);
		port (
			clk : out std_logic   -- clk
		);
	end component altera_avalon_clock_source;

	component altera_avalon_reset_source is
		generic (
			ASSERT_HIGH_RESET    : integer := 1;
			INITIAL_RESET_CYCLES : integer := 0
		);
		port (
			reset : out std_logic;        -- reset_n
			clk   : in  std_logic := 'X'  -- clk
		);
	end component altera_avalon_reset_source;

	signal crypto_test_inst_clk_bfm_clk_clk       : std_logic; -- crypto_test_inst_clk_bfm:clk -> [crypto_test_inst:clk_clk, crypto_test_inst_reset_bfm:clk]
	signal crypto_test_inst_reset_bfm_reset_reset : std_logic; -- crypto_test_inst_reset_bfm:reset -> crypto_test_inst:reset_reset_n

begin

	crypto_test_inst : component crypto_test
		port map (
			clk_clk       => crypto_test_inst_clk_bfm_clk_clk,       --   clk.clk
			reset_reset_n => crypto_test_inst_reset_bfm_reset_reset  -- reset.reset_n
		);

	crypto_test_inst_clk_bfm : component altera_avalon_clock_source
		generic map (
			CLOCK_RATE => 50000000,
			CLOCK_UNIT => 1
		)
		port map (
			clk => crypto_test_inst_clk_bfm_clk_clk  -- clk.clk
		);

	crypto_test_inst_reset_bfm : component altera_avalon_reset_source
		generic map (
			ASSERT_HIGH_RESET    => 0,
			INITIAL_RESET_CYCLES => 50
		)
		port map (
			reset => crypto_test_inst_reset_bfm_reset_reset, -- reset.reset_n
			clk   => crypto_test_inst_clk_bfm_clk_clk        --   clk.clk
		);

end architecture rtl; -- of crypto_test_tb
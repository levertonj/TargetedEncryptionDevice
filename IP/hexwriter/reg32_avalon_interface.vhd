library ieee;
use ieee.std_logic_1164.all;
library work;
use work.all;
entity reg32_avalon_interface is
  port (clock, resetn           : in  std_logic;
        read, write, chipselect : in  std_logic;
        writedata               : in  std_logic_vector(31 downto 0);
        byteenable              : in  std_logic_vector(3 downto 0);
        readdata                : out std_logic_vector(31 downto 0);
        Q_export                : out std_logic_vector(31 downto 0));
end reg32_avalon_interface;
architecture Structure of reg32_avalon_interface is
  signal local_byteenable : std_logic_vector(3 downto 0);
  signal to_reg, from_reg : std_logic_vector(31 downto 0);
  component reg16
    port (clock, resetn : in  std_logic;
          D             : in  std_logic_vector(31 downto 0);
          byteenable    : in  std_logic_vector(3 downto 0);
          Q             : out std_logic_vector(31 downto 0));
  end component;
begin
  to_reg <= writedata;
  with (chipselect and write) select
    local_byteenable <= byteenable when '1', "0000" when others;
  reg_instance : reg32 port map (clock, resetn, to_reg, local_byteenable, from_reg);
  readdata <= from_reg;
  Q_export <= from_reg;
end Structure;

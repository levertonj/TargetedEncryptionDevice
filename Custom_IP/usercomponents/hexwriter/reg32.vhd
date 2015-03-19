library ieee;
use ieee.std_logic_1164.all;
entity reg32 is
  port (clock, resetn : in  std_logic;
        D             : in  std_logic_vector(31 downto 0);
        byteenable    : in  std_logic_vector(3 downto 0);
        Q             : out std_logic_vector(31 downto 0));
end reg32;
architecture Behavior of reg32 is
begin
  process
  begin
    wait until clock'event and clock = '1';
    if resetn = '0' then
      Q <= "00000000000000000000000000000000";
    else
      if byteenable(0) = '1' then
        Q(7 downto 0) <= D(7 downto 0); end if;
      if byteenable(1) = '1' then
        Q(15 downto 8) <= D(15 downto 8); end if;
      if byteenable(2) = '1' then
        Q(23 downto 16) <= D(23 downto 16); end if;
      if byteenable(3) = '1' then
        Q(31 downto 24) <= D(31 downto 24); end if;
    end if;
  end process;
end Behavior;

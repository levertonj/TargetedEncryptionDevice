library ieee;
use ieee.std_logic_1164.all;
entity hex7seg is
  port (hex      : in  std_logic_vector(3 downto 0);
         display : out std_logic_vector(6 downto 0));
end hex7seg;
architecture Behavior of hex7seg is
begin
-- – 0 –
-- 5 | | 1
-- – 6 –
-- 4 | | 2
-- – 3 –
  process (hex)
  begin
    case hex is
      when "0000" => display <= "1000000";
      when "0001" => display <= "1111001";
      when "0010" => display <= "0100100";
      when "0011" => display <= "0110000";
      when "0100" => display <= "0011001";
      when "0101" => display <= "0010010";
      when "0110" => display <= "0000010";
      when "0111" => display <= "1111000";
      when "1000" => display <= "0000000";
      when "1001" => display <= "0011000";
      when "1010" => display <= "0001000";
      when "1011" => display <= "0000011";
      when "1100" => display <= "1000110";
      when "1101" => display <= "0100001";
      when "1110" => display <= "0000110";
      when "1111" => display <= "0001110";
    end case;
  end process;
end Behavior;

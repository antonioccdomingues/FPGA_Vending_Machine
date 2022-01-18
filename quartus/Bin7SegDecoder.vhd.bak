library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Bin7SegDecoder is
	port(	binInput	:	in std_logic_vector(11 downto 0);
			decOut_n	:	out std_logic_vector(6 downto 0));

end Bin7SegDecoder;

architecture Behavioral of Bin7SegDecoder is

begin
		decOut_n <= "1111001" when binInput="000000000001" else --1
						"0100100" when binInput="000000000010" else --2
						"0110000" when binInput="000000000011" else --3
						"0011001" when binInput="000000000100" else --4
						"0010010" when binInput="000000000101" else --5
						"0000010" when binInput="000000000110" else --6
						"1111000" when binInput="000000000111" else --7
						"0000000" when binInput="000000001000" else --8
						"0010000" when binInput="000000001001" else --9
						"1000000"; --0
		
end Behavioral;
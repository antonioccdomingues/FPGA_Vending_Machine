library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity divisor is
	port(clkIn : in	std_logic;
		  --k	  : in	std_logic_vector(31 downto 0);
		  clkOut: out 	std_logic);
end divisor;

architecture Behavioral of divisor is

	signal s_counter: natural;
	signal s_halfWay: unsigned(25 downto 0);
	signal k: unsigned(25 downto 0);
	
begin
	k <= "10111110101111000010000000";
	s_halfWay <= (k / 2);
	
	process(clkIn)
	begin
		if(rising_edge(clkIn)) then
			if(s_counter = k - 1) then
				clkOut <= '0';
				s_counter <= 0;
			else
				if(s_counter = k /2 - 1)  then
					clkOut <= '1';
				end if;
				s_counter <= s_counter + 1;
			end if;
		end if;
	end process;
	
end Behavioral;
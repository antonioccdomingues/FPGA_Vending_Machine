library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity LuzPisca is

	port( enable  : in  std_logic;
			clk     : in  std_logic;
			luz     : out std_logic);
			
end LuzPisca;

architecture Behavioral of LuzPisca is
	
	signal s_luz : std_logic := '0';
	
begin

	luz <= s_luz;

	process(clk, enable)
	begin
		if (enable = '1') then
			if(rising_edge(clk)) then
				s_luz <= not s_luz;
			end if;
		else
			s_luz <= '0';
		end if;
	end process;
	
end Behavioral;
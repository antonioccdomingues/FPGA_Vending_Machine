library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity LuzVerde is
	port( clk    : in  std_logic;
			enable : in  std_logic;
			enableOut : out std_logic := '1';
 			verde  : out std_logic);
end LuzVerde;

architecture Behavioral of LuzVerde is

	signal s_cont  : unsigned(1 downto 0) := "00";
	signal s_verde : std_logic := '0';
	
begin

	verde <= s_verde;
	
	process(clk, enable)
	begin
		if (rising_edge(clk)) then
			if (enable = '1') then
				if (s_cont = "11") then
					s_cont <= "00";
					s_verde <= '0';
					enableOut <= '0';
				else
					s_cont <= s_cont + 1;
					s_verde <= '1';
					enableOut <= '1';
				end if;
			else 
				s_cont <= "00";
				s_verde <= '0';
				enableOut <= '1';
			end if;
		end if;
	end process;
end Behavioral;
			
			

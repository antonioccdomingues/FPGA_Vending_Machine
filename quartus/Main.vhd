library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity Main is
	port( clk		: in	std_logic;
		   reset	   : in	std_logic;
		   m1	   	: in	std_logic;
		   m2	   	: in	std_logic;
		   m3	    	: in	std_logic;
		   m4		   : in	std_logic;
			p1       : in  std_logic;
		   p2       : in  std_logic;
		   p3       : in  std_logic;
		   verdeIn  : in  std_logic;
		   verdeOut : out std_logic;
			uCent    : out std_logic_vector(4 downto 0) := "00000"; --vai ser sempre 0
			dCent    : out std_logic_vector(4 downto 0);
		  	cCent    : out std_logic_vector(4 downto 0);
			np1      : out std_logic_vector(4 downto 0);
			np2      : out std_logic_vector(4 downto 0);
			np3      : out std_logic_vector(4 downto 0);
			ledp1    : out std_logic;
			ledp2    : out std_logic;
			ledp3    : out std_logic;
			luz      : out std_logic := '0';
			uplcd    : out std_logic_vector(4 downto 0);
			downlcd  : out std_logic_vector(3 downto 0));
			
end Main;

architecture Behavioral of Main is

	type TState is (SR, S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19, S20, S21, SS);
	signal NState, PState: TState;
	
	signal s_out     : unsigned(4 downto 0); --valor a sair para os displays
	signal s_out2    : unsigned(4 downto 0);
	signal s_cCent   : unsigned(4 downto 0);
	signal s_dCent   : unsigned(4 downto 0);
	signal s_np1     : unsigned(4 downto 0) := "00101";
	signal s_np2     : unsigned(4 downto 0) := "00101";
	signal s_np3     : unsigned(4 downto 0) := "00101";
	signal s_uplcd   : std_logic_vector(4 downto 0);
	signal s_uplcd2  : std_logic_vector(4 downto 0);
	signal s_downlcd : std_logic_vector(3 downto 0);
	signal s_dec1    : std_logic := '0';
	signal s_dec2    : std_logic := '0';
	signal s_dec3    : std_logic := '0';
	signal s_en1     : std_logic := '1';
	signal s_en2     : std_logic := '1';
	signal s_en3     : std_logic := '1';
	signal s_enr     : std_logic := '0';
	
	
	
begin

	uplcd <= s_uplcd2;
	downlcd <= s_downlcd;

	dCent <= std_logic_vector(s_dCent);
	cCent <= std_logic_vector(s_cCent);
	s_dCent <= s_out2 rem 10;
	s_cCent <= s_out2 / 10;
	
	np1 <= std_logic_vector(s_np1);
	np2 <= std_logic_vector(s_np2);
	np3 <= std_logic_vector(s_np3);
	

	sync_proc: process(clk, reset)
	begin
	
		if(reset = '1') then
			PState <= SR;
		else
		
			if(rising_edge(clk)) then
				PState <= NState;
			end if;
			
		end if;
	end process;
	
	
	process(clk, PState, s_np1, s_np2, s_np3, s_dec1, s_dec2, s_dec3, p1, p2, p3)
	begin
		
		if (s_np1 = "00000") then
			ledp1 <= '1';
		else
			ledp1 <= '0';
		end if;
			
		if (s_np2 = "00000") then
			ledp2 <= '1';
		else
			ledp2 <= '0';
		end if;
			
		if (s_np3 = "00000") then
			ledp3 <= '1';
		else
			ledp3 <= '0';
		end if;
		
		
		if (p1 = '1') then
			if (s_np1 = "00101") then
				s_downlcd <= "0000";
			elsif (s_np1 = "00100") then
				s_downlcd <= "0001";
			elsif (s_np1 = "00011") then
				s_downlcd <= "0010";
			elsif (s_np1 = "00010") then
				s_downlcd <= "0011";
			elsif (s_np1 = "00001") then
				s_downlcd <= "0100";
			end if;
		elsif(p2 = '1') then
			if (s_np2 = "00101") then
				s_downlcd <= "0101";
			elsif (s_np2 = "00100") then
				s_downlcd <= "0110";
			elsif (s_np2 = "00011") then
				s_downlcd <= "0111";
			elsif (s_np2 = "00010") then
				s_downlcd <= "1000";
			elsif (s_np2 = "00001") then
				s_downlcd <= "1001";
			else
				s_downlcd <= "1111";
			end if;
		elsif(p3 = '1') then
			if (s_np3 = "00101") then
				s_downlcd <= "1010";
			elsif (s_np3 = "00100") then
				s_downlcd <= "1011";
			elsif (s_np3 = "00011") then
				s_downlcd <= "1100";
			elsif (s_np3 = "00010") then
				s_downlcd <= "1101";
			elsif (s_np3 = "00001") then
				s_downlcd <= "1110";
			else
				s_downlcd <= "1111";
			end if;
		else
			s_downlcd <= "1111";
		end if;
			
		
		if (rising_edge(clk)) then
		
			if (not(PState = SS)) then
				s_out2 <= s_out;
				s_uplcd2 <= s_uplcd;
			end if;
			
			
			if (PState = SR) then
				s_np1 <= "00101";
				s_np2 <= "00101";
				s_np3 <= "00101";
				s_enr <= '1';
			else
			if ((s_dec1 = '1') and (s_en1 = '1')) then
				s_np1 <= s_np1 - 1;
				s_en1 <= '0';
				s_enr <= '0';
			elsif(s_dec1 = '0') then
				s_enr <= '0';
				s_en1 <= '1';
			end if;
			if ((s_dec2 = '1') and (s_en2 = '1')) then
				s_np2 <= s_np2 - 1;
				s_en2 <= '0';
				s_enr <= '0';
			elsif(s_dec2 = '0') then
				s_enr <= '0';
				s_en2 <= '1';
			end if;
			if ((s_dec3 = '1') and (s_en3 = '1')) then
				s_np3 <= s_np3 - 1;
				s_en3 <= '0';
				s_enr <= '0';
			elsif(s_dec3 = '0') then
				s_enr <= '0';
				s_en3 <= '1';
			end if;
			end if;
				
		end if;
		
	end process;
		
	
	comb_proc: process(PState, m1, m2, m3, m4, p1, p2, p3, verdeIn, s_enr)
	begin
		case PState is
		
			when SR =>
				if (s_enr = '1') then
					NState <= s0;
				else
					NState <= SR;
				end if;
		
			when S0 =>
				s_dec1 <= '0';
				s_dec2 <= '0';
				s_dec3 <= '0';
				luz <= '0';
				verdeOut <= '0';
				s_out <= "00000";
				s_uplcd <= "00000";
				if ((p1 = '1') or (p2 = '1') or (p3 = '1')) then
					if(m1 = '1') then
						NState <= S1;
					elsif(m2 = '1') then
						NState <= S2;
					elsif(m3 = '1') then
						NState <= S5;
					elsif(m4 = '1') then
						NState <= S10;
					else
						NState <= S0;
					end if;
				else
					NState <= S0;
				end if;
				
				
			when S1 =>
				verdeOut <= '0';
				s_dec1 <= '0';
				s_dec2 <= '0';
				s_dec3 <= '0';
				s_out <= "00001";
				s_uplcd <= "00001";
				if ((p1 = '1') or (p2 = '1') or (p3 = '1')) then
				if(m1 = '1') then
					NState <= S2;
				elsif(m2 = '1') then
					NState <= S3;
				elsif(m3 = '1') then
					NState <= S6;
				elsif(m4 = '1') then
					NState <= S11;
				else
					NState <= S1;
				end if;
				else
					NState <= S0;
				end if;
				
				
			when S2 =>
				verdeOut <= '0';
				s_dec1 <= '0';
				s_dec2 <= '0';
				s_dec3 <= '0';
				s_out <= "00010";
				s_uplcd <= "00010";
				if ((p1 = '1') or (p2 = '1') or (p3 = '1')) then
				if(m1 = '1') then
					NState <= S3;
				elsif(m2 = '1') then
					NState <= S4;
				elsif(m3 = '1') then
					NState <= S7;
				elsif(m4 = '1') then
					NState <= S12;
				else
					NState <= S2;
				end if;
				else
					NState <= S0;
				end if;
				
				
			when S3 =>
				verdeOut <= '0';
				s_dec1 <= '0';
				s_dec2 <= '0';
				s_dec3 <= '0';
				s_out <= "00011";
				s_uplcd <= "00011";
				if ((p1 = '1') or (p2 = '1') or (p3 = '1')) then
				if(m1 = '1') then
					NState <= S4;
				elsif(m2 = '1') then
					NState <= S5;
				elsif(m3 = '1') then
					NState <= S8;
				elsif(m4 = '1') then
					NState <= S13;
				else
					NState <= S3;
				end if;
				else
					NState <= S0;
				end if;
				
				
			when S4 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					s_dec2 <= '0';
					s_dec3 <= '0';
					verdeOut <= '1';
					s_out <= "00000";
					s_uplcd <= "10110";
					NState <= SS;
				elsif((p2 = '1') or (p3 = '1')) then
					s_out <= "00100";
					s_uplcd <= "00100";
					verdeOut <= '0';
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';  
					if(m1 = '1') then
						NState <= S5;
					elsif(m2 = '1') then
						NState <= S6;
					elsif(m3 = '1') then
						NState <= S9;
					elsif(m4 = '1') then
						NState <= S14;
					else
						NState <= S4;
					end if;
				else
					verdeOut <= '0';
					s_out <= "00100";
					s_uplcd <= "00100";
					NState <= S0;
				end if;
				
				
			when S5 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "00001";
					s_uplcd <= "10111";
					NState <= SS;
				elsif((p2 = '1') or (p3 = '1')) then
					verdeOut <= '0';
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					s_out <= "00101";
					s_uplcd <= "00101";
					if(m1 = '1') then
						NState <= S6;
					elsif(m2 = '1') then
						NState <= S7;
					elsif(m3 = '1') then
						NState <= S10;
					elsif(m4 = '1') then
						NState <= S15;
					else
						NState <= S5;
					end if;
				else
					verdeOut <= '0';
					s_out <= "00101";
					s_uplcd <= "00101";
					NState <= S0;
				end if;
				
			
			when S6 =>
				if (p1 = '1') then
					verdeOut <= '1';
					s_dec1 <= '1';
					s_out <= "00010";
					s_uplcd <= "11000";
					NState <= SS;
				elsif((p2 = '1') or (p3 = '1')) then
					verdeOut <= '0';
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					s_out <= "00110";
					s_uplcd <= "00110";
					if(m1 = '1') then
						NState <= S7;
					elsif(m2 = '1') then
						NState <= S8;
					elsif(m3 = '1') then
						NState <= S11;
					elsif(m4 = '1') then
						NState <= S16;
					else
						NState <= S6;
					end if;
				else
					verdeOut <= '0';
					s_out <= "00110";
					s_uplcd <= "00110";
					NState <= S0;
				end if;
				
				
			when S7 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "00011";
					s_uplcd <= "11001";
					NState <= SS;
				elsif(p2 = '1') then
					verdeOut <= '1';
					s_dec2 <= '1';
					s_out <= "00000";
					s_uplcd <= "10110";
					NState <= SS;
				elsif(p3 = '1') then
					verdeOut <= '0';
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					s_out <= "00111";
					s_uplcd <= "00111";
					if(m1 = '1') then
						NState <= S8;
					elsif(m2 = '1') then
						NState <= S9;
					elsif(m3 = '1') then
						NState <= S12;
					elsif(m4 = '1') then
						NState <= S17;
					else
						NState <= S7;
					end if;
				else
					verdeOut <= '0';
					s_out <= "00111";
					s_uplcd <= "00111";
					NState <= S0;
				end if;
				
				
			when S8 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "00100";
					s_uplcd <= "11010";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "00001";
					s_uplcd <= "10111";
					NState <= SS;
				elsif(p3 = '1') then
					verdeOut <= '0';
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					s_out <= "01000";
					s_uplcd <= "01000";
					if(m1 = '1') then
						NState <= S9;
					elsif(m2 = '1') then
						NState <= S10;
					elsif(m3 = '1') then
						NState <= S13;
					elsif(m4 = '1') then
						NState <= S18;
					else
						NState <= S8;
					end if;
				else
					verdeOut <= '0';
					s_out <= "01000";
					s_uplcd <= "01000";
					NState <= S0;
				end if;
				
				
			when S9 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "00101";
					s_uplcd <= "11011";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "00010";
					s_uplcd <= "11000";
					NState <= SS;
				elsif(p3 = '1') then
					verdeOut <= '0';
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					s_out <= "01001";
					s_uplcd <= "01001";
					if(m1 = '1') then
						NState <= S10;
					elsif(m2 = '1') then
						NState <= S11;
					elsif(m3 = '1') then
						NState <= S14;
					elsif(m4 = '1') then
						NState <= S19;
					else
						NState <= S9;
					end if;
				else
					verdeOut <= '0';
					s_out <= "01001";
					s_uplcd <= "01001";
					NState <= S0;
				end if;
				
			when S10 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "00110";
					s_uplcd <= "11100";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "00011";
					s_uplcd <= "11001";
					NState <= SS;
				elsif(p3 = '1') then
					verdeOut <= '0';
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					s_out <= "01010";
					s_uplcd <= "01010";
					if(m1 = '1') then
						NState <= S11;
					elsif(m2 = '1') then
						NState <= S12;
					elsif(m3 = '1') then
						NState <= S15;
					elsif(m4 = '1') then
						NState <= S20;
					else
						NState <= S10;
					end if;
				else
					verdeOut <= '0';
					s_out <= "01010";
					s_uplcd <= "01010";
					NState <= S0;
				end if;
				
				
			when S11 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "00111";
					s_uplcd <= "11101";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "00100";
					s_uplcd <= "11010";
					NState <= SS;
				elsif(p3 = '1') then
					verdeOut <= '0';
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					s_out <= "01011";
					s_uplcd <= "01011";
					if(m1 = '1') then
						NState <= S12;
					elsif(m2 = '1') then
						NState <= S13;
					elsif(m3 = '1') then
						NState <= S16;
					elsif(m4 = '1') then
						NState <= S21;
					else
						NState <= S11;
					end if;
				else
					verdeOut <= '0';
					s_out <= "01011";
					s_uplcd <= "01011";
					NState <= S0;
				end if;
				
				
			when S12 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "01000";
					s_uplcd <= "11110";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "00101";
					s_uplcd <= "11011";
					NState <= SS;
				elsif(p3 = '1') then
					s_dec3 <= '1';
					verdeOut <= '1';
					s_out <= "00000";
					s_uplcd <= "10110";
					NState <= SS;
				else
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					verdeOut <= '0';
					s_out <= "01100";
					s_uplcd <= "01100";
					NState <= S0;
				end if;
				
				
			when S13 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "01001";
					s_uplcd <= "11111";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "00110";
					s_uplcd <= "11100";
					NState <= SS;
				elsif(p3 = '1') then
					s_dec3 <= '1';
					verdeOut <= '1';
					s_out <= "00001";
					s_uplcd <= "10111";
					NState <= SS;
				else
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					verdeOut <= '0';
					s_out <= "01101";
					s_uplcd <= "01101";
					NState <= S0;
				end if;
				
				
			when S14 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "01010";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "00111";
					s_uplcd <= "11101";
					NState <= SS;
				elsif(p3 = '1') then
					s_dec3 <= '1';
					verdeOut <= '1';
					s_out <= "00010";
					s_uplcd <= "11000";
					NState <= SS;
				else
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					verdeOut <= '0';
					s_out <= "01110";
					s_uplcd <= "01110";
					NState <= S0;
				end if;
				
				
			when S15 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "01011";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "01000";
					s_uplcd <= "11110";
					NState <= SS;
				elsif(p3 = '1') then
					s_dec3 <= '1';
					verdeOut <= '1';
					s_out <= "00011";
					s_uplcd <= "11001";
					NState <= SS;
				else
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					verdeOut <= '0';
					s_out <= "01111";
					s_uplcd <= "01111";
					NState <= S0;
				end if;
				
				
			when S16 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "01100";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "01001";
					s_uplcd <= "11111";
					NState <= SS;
				elsif(p3 = '1') then
					s_dec3 <= '1';
					verdeOut <= '1';
					s_out <= "00100";
					s_uplcd <= "11010";
					NState <= SS;
				else
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					verdeOut <= '0';
					s_out <= "10000";
					s_uplcd <= "10000";
					NState <= S0;
				end if;
				
				
			when S17 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "01101";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "01010";
					NState <= SS;
				elsif(p3 = '1') then
					s_dec3 <= '1';
					verdeOut <= '1';
					s_out <= "00101";
					s_uplcd <= "11011";
					NState <= SS;
				else
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					verdeOut <= '0';
					s_out <= "10001";
					s_uplcd <= "10001";
					NState <= S0;
				end if;
				
				
			when S18 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "01110";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "01011";
					NState <= SS;
				elsif(p3 = '1') then
					s_dec3 <= '1';
					verdeOut <= '1';
					s_out <= "00110";
					s_uplcd <= "11100";
					NState <= SS;
				else
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					verdeOut <= '0';
					s_out <= "10010";
					s_uplcd <= "10010";
					NState <= S0;
				end if;
				
				
			when S19 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "01111";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "01100";
					NState <= SS;
				elsif(p3 = '1') then
					s_dec3 <= '1';
					verdeOut <= '1';
					s_out <= "00111";
					s_uplcd <= "11101";
					NState <= SS;
				else
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					verdeOut <= '0';
					s_out <= "10011";
					s_uplcd <= "10011";
					NState <= S0;
				end if;
				
				
			when S20 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "10000";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "01101";
					NState <= SS;
				elsif(p3 = '1') then
					s_dec3 <= '1';
					s_dec1 <= '0';
					s_dec2 <= '0';
					verdeOut <= '1';
					s_out <= "01000";
					s_uplcd <= "11110";
					NState <= SS;
				else
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					verdeOut <= '0';
					s_out <= "10100";
					s_uplcd <= "10100";
					NState <= S0;
				end if;
				
				
			when S21 =>
				if (p1 = '1') then
					s_dec1 <= '1';
					verdeOut <= '1';
					s_out <= "10001";
					NState <= SS;
				elsif(p2 = '1') then
					s_dec2 <= '1';
					verdeOut <= '1';
					s_out <= "01110";
					NState <= SS;
				elsif(p3 = '1') then
					s_dec3 <= '1';
					verdeOut <= '1';
					s_out <= "01001";
					s_uplcd <= "11111";
					NState <= SS;
				else
					s_dec1 <= '0';
					s_dec2 <= '0';
					s_dec3 <= '0';
					verdeOut <= '0';
					s_out <= "10101";
					s_uplcd <= "10101";
					NState <= S0;
				end if;
				
			
				
			when SS =>
				luz <= '1';
				if (verdeIn = '0') then
					verdeOut <= '0';
					NState <= S0;
				else
					verdeOut <= '1';
					NState <= SS;
				end if;
				
				
			when others =>
				NState <= S0;
				
				
		end case;
	end process;
end Behavioral;
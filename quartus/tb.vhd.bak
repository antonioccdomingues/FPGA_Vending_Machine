library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity maintb is
end maintb;

architecture stimulus of maintb is

	signal 		s_clk	   	: in	std_logic;
	signal	   s_reset	   : in	std_logic;
	signal	   s_m1	   	: in	std_logic;
	signal	   s_m2	   	: in	std_logic;
	signal	   s_m3	    	: in	std_logic;
	signal	   s_m4		   : in	std_logic;
	signal		s_p1        : in  std_logic;
	signal	   s_p2        : in  std_logic;
	signal	   s_p3        : in  std_logic;
	signal	   s_verdeIn   : in  std_logic;
	signal	   s_verdeOut  : out std_logic;
	signal		s_uCent     : out std_logic_vector(4 downto 0) := "00000"; --vai ser sempre 0
	signal		s_dCent     : out std_logic_vector(4 downto 0);
	signal	  	s_cCent     : out std_logic_vector(4 downto 0);
	signal		s_np1       : out std_logic_vector(4 downto 0);
	signal		s_np2       : out std_logic_vector(4 downto 0);
	signal		s_np3       : out std_logic_vector(4 downto 0);
	signal		s_ledp1     : out std_logic;
	signal		s_ledp2     : out std_logic;
	signal		s_ledp3     : out std_logic;
	signal		s_luz       : out std_logic := '0';
	signal		s_uplcd     : out std_logic_vector(4 downto 0);
	signal		s_downlcd   : out std_logic_vector(3 downto 0);
	
begin

	uut: entity work.maintb(Behavioral)
		  port map(clk => s_clk,
					 reset => s_reset,
					 m1 => s_m1,
					 m2 => s_m2,
					 m3 => s_m3,
					 m4 => s_m4,
					 p1 => s_p1,
					 p2 => s_p2,
					 p3 => s_p3,
					 verdeIn => s_verdeIn,
					 verdeOut => s_verdeOut,
					 uCent => s_uCent,
					 dCent => s_dCent,
					 cCent => s_cCent,
					 np1 => s_np1,
					 np2 => s_np2,
					 np3 => s_np3,
					 ledp1 => s_ledp1,
					 ledp2 => s_ledp2,
					 ledp3 => s_ledp3,
					 luz => s_luz,
					 uplcd => s_uplcd,
					 downlcd => s_downlcd);
					 
	stim_proc : process
	begin	
		s_p3<="0";
		s_reset<='1';
		wait for 100ns;
		s_reset<='0';
		wait for 100ns;
		s_reset<='0';
		s_m1<='1';
		wait for 100ns;
		s_uCent<='0';
		s_dCent<='0';
		s_m2<='1';
		wait for 100ns;
		s_m1<='0';
		s_uCent<='0';
		s_dCent<='0';
		s_m2<='1';
		s_m1<='1';
		wait for 100ns;
		s_m1<='0';
		s_uCent<='0';
		s_dCent<='0';
		s_cCent<='1';
		s_m2<='0';
		wait for 100ns;
		s_cCent<='0';
		s_m1<='0';
		wait for 100ns;
	end process;
end Stimulus;
library ieee;
use ieee.std_logic_1164.all;

	--declaration des variables, entr�es et sorties
entity Trig_gen is 
	port ( clk : in std_logic;
			Trigger : out std_logic);
			
end Trig_gen;

architecture Behavioral of Trig_gen is 
component Counter is

	generic ( n: POSITIVE := 10);
	port (clk : in std_logic;
		enable : in std_logic;
		reset : in std_logic;		--Active low
		Counter_output : out std_logic_vector(n-1 downto 0));
	
end component;

signal resetCounter : std_logic;
signal outputCounter : std_logic_vector(23 downto 0);

begin
	trigg : Counter generic map (24) port map (clk, '1', resetCounter, outputCounter);
	process(clk)

constant ms250: std_logic_vector(23 downto 0) := "101111101011110000100000"; --to generate 250ms pulse divide the main FPGA borad clock that is 50MHz with 4Hz 12500000 ms
constant ms250and100us: std_logic_vector(23 downto 0) := "101111101100000000001000";-- to generate (250ms + 100us) pulse divide the main FPGA board clock that is 12501000 ms
	begin
		if( outputCounter > ms250 and outputCounter < ms250and100us) then
			Trigger <= '1';
		else
			Trigger <= '0';
		end if;  
		if(outputCounter = ms250and100us or outputCounter = "XXXXXXXXXXXXXXXXXXXXXXXX") then
			resetCounter <= '0';
		else
			resetCounter <= '1';
		end if;  
	end process;
end Behavioral;
	
	
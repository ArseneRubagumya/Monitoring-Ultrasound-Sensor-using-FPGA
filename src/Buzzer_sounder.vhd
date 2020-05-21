LIBRARY ieee; 
USE ieee.std_logic_1164.all;  
ENTITY Buzzer_sounder is 

PORT ( sounder : in std_logic_vector (2 downto 1); 
	freq1, freq2, freq3, freq4 : in std_logic; 
	buzzer : OUT std_logic); 
END Buzzer_sounder;

architecture behavioral of Buzzer_sounder is
	SIGNAL a,b,c,d,f : std_logic;
begin 
	b <= transport freq4 after 200000us;
    c <= transport freq3 after 80000us;
	d <= transport freq2 after 30000us;
    f <= transport freq1 after 20000us;
   
		--c <= transport freq3 after 6000 ms;
	--d <= transport freq2 after 5000 ms;
	--f <= transport freq1 after 2000 ms;
		 
	with sounder (2 downto 1) select 
	a <= 	b WHEN "11",     
			c WHEN "10",   
			d WHEN "01",    
			f WHEN "00"; 
buzzer <= a;
	
end behavioral;









	
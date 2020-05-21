library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;

entity Distance_Calc is
    port(
		clk: in std_logic;
		Calculation_Reset: in std_logic;
		echo :in std_logic;
		distance: out std_logic_vector(8 downto 0);
		sens : out std_logic; 	--bit declenchant la distance minimale
		sounder : out std_logic_vector(2 downto 1));
		 
end Distance_Calc;


architecture Behavioral of Distance_Calc is
component Counter is
    generic(n: POSITIVE := 10);
    port(clk: in std_logic;
		enable: in std_logic;
		reset: in std_logic;
		Counter_output : out std_logic_vector(n-1 downto 0));
end component;


signal echo_width : STD_LOGIC_VECTOR(21 downto 0);

begin
CounterEcho : Counter generic map(22) port map(clk, echo, not Calculation_reset, echo_width);

Distance_calculation : process(echo)
       
        variable Result : integer; 
        variable Multiplier : STD_LOGIC_VECTOR(23 downto 0);
       
    begin
        if(echo = '0') then
		multiplier := echo_width * "11";
        Result := to_integer(unsigned(Multiplier(23 downto 13)));
				
				
						--sonor ranger
				if(Result > 40) then sounder <="11";	--distance au dela de 40cm
					
					else if(Result <40 and Result >30 ) then sounder <="10"; -- distance entre 30 et 40cm
						
							else if(Result <30 and Result >10 ) then sounder <="01"; 		--distance entre 10 et 30cm
						
									else if(Result <10) then sounder <="00"; --distance en dessus de 10cm
										end if;
							end if;
					end if;
				end if;
								--calcul de la distance minimale
				if(Result < 10) then sens <='1'; --on dit que la distance minimale est de 10cm
						else sens <='0';
					end if;  
				             
				if(Result > 458) then
                   distance <= "111111111";
               
					else
						distance <= STD_LOGIC_VECTOR(to_unsigned(Result,9));
                
					end if;
		end if;
	end process Distance_calculation;
end Behavioral;

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity BCD_Converter is
  port(	Distance_input : in std_logic_vector(8 downto 0);
		hundreds, tens, unit: out std_logic_vector(3 downto 0));
end BCD_Converter;

architecture Behavioral of BCD_Converter is

begin
    process(Distance_input)
    variable i : integer := 0;
    variable bcd : std_logic_vector(20 downto 0);
   
   
	begin
--Initialisation phase: the space for the BCD representation is reserved
        bcd := (others => '0');
        bcd(8 downto 0) := Distance_input;
--"Double-Dabble Algorithm" is used to convert the Distance in binary into BCD      
        
for i in 0 to 8 loop
          --Left shift one bit 
            bcd(19 downto 0) := bcd(18 downto 0) & '0';
				--check phase
             if(i < 8 and bcd(12 downto 9) > "0100") then
                bcd(12 downto 9) := bcd(12 downto 9) + "0011";
            end if;
            if(i < 8 and bcd(16 downto 13) > "0100") then
                bcd(16 downto 13) := bcd(16 downto 13) + "0011";
            end if;
            if(i < 8 and bcd(20 downto 17) > "0100") then
                bcd(20 downto 17) := bcd(20 downto 17) + "0011";
            end if;   
            
        end loop;
   
		--The three BCD numbers are put in output
    hundreds <= bcd(20 downto 17);
    tens <= bcd(16 downto 13);
    unit <= bcd(12 downto 9);
    
    end process;
    
end Behavioral;
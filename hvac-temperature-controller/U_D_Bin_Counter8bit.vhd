library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity U_D_Bin_Counter8bit is port (
 	CLK				: in  std_logic := '0';
   RESET				: in	std_logic := '0';
	CLK_EN			: in	std_logic := '0';
	UP1_DOWN0		: in	std_logic := '0';
	COUNTER_BITS  	: out	std_logic_vector(7 downto 0)							 
	); 
end entity;

architecture one of U_D_Bin_Counter8bit is

signal ud_bin_counter : unsigned(7 downto 0);

begin


PROCESS (CLK) is
 
begin
		
		if (rising_edge(CLK)) then
			
			if (RESET = '1') then
				ud_bin_counter <= "00000000";
				
			elsif (CLK_EN = '1') then
			
				if (UP1_DOWN0 = '1') then
					ud_bin_counter <= (ud_bin_counter + 1); 
				
				else 
					ud_bin_counter <= (ud_bin_counter - 1);
					
				end if;
				
			end if;
			
		end if;
		
		COUNTER_BITS <= std_logic_vector(ud_bin_counter);
end process;

end;
					
		
library ieee;
use ieee.std_logic_1164.all;

entity Energy_Monitor is port (
	comp4x_in : in std_logic_vector(2 downto 0);
	pb_inv : in std_logic_vector(3 downto 0);
	furnace, at_temp, AC, blower, window, door, vacation : out std_logic;
	hvac_in : out std_logic_vector(2 downto 0)
);
end Energy_Monitor;

architecture monitor_logic of Energy_Monitor is

begin

	run_process: process (comp4x_in, pb_inv)
		
		begin
		
		if (comp4x_in(1) = '1' or pb_inv(1) = '1' or pb_inv(0) = '1' or pb_inv(2) = '1') then
				hvac_in(2) <= '0';
		else
				hvac_in(2) <= '1';
		end if;
				
		if (comp4x_in(0) = '1') then
				AC <= '1';
				hvac_in(0) <= '1';
		else
				AC <= '0';
				hvac_in(0) <= '0';
		end if;
				
		if (comp4x_in(2) = '1') then
				furnace <= '1';
				hvac_in(1) <= '1';
		else
				furnace <= '0';
				hvac_in(1) <= '0';
		end if;
				
		if (comp4x_in(1) = '1') then
				at_temp <= '1';
				blower <= '0';
		else
			if (pb_inv(2) = '0' and pb_inv(1) = '0' and pb_inv(0) = '0') then
					blower <= '1';
			else
					blower <= '0';
			end if;
			
			at_temp <= '0';
		end if;
		
		if (pb_inv(0) = '1') then
				door <= '1';
		else 
				door <= '0';
		end if;
				
		if (pb_inv(1) = '1') then
				window <= '1';
		else 
				window <= '0';
		end if;
				
		if (pb_inv(3) = '1') then
				vacation <= '1';
		else 
				vacation <= '0';
		end if;
		
	end process;

end architecture monitor_logic;
				
		
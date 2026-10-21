library ieee;
use ieee.std_logic_1164.all;

entity holding_register is port (

			clk					: in std_logic;
			reset				: in std_logic;
			register_clr		: in std_logic;
			din					: in std_logic;
			dout				: out std_logic
  );
 end holding_register;

 architecture circuit of holding_register is

	Signal sreg				: std_logic;

BEGIN

clk_register: process (clk)

	begin
		if rising_edge(clk) then
			if (reset = '1' or register_clr = '1') then
				sreg <= '0';

			elsif (din = '1') then
				sreg <= '1';

			end if;
		end if;
	end process;

	dout <= sreg;
end;

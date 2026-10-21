library ieee;
use ieee.std_logic_1164.all;

entity hex_mux3 is
port (
	sum, carry, opa, opb    				   : in	std_logic_vector(3 downto 0);
   mux_select 										: in std_logic;
	out1, out2  									: out	std_logic_vector(3 downto 0)

);
end hex_mux3;

architecture mux_logic of hex_mux3 is

begin

	with mux_select select
	out1 <= opa when '0', sum when '1';

	with mux_select select
	out2 <= carry when '1', opb when '0';

end architecture mux_logic;

library ieee;
use ieee.std_logic_1164.all;

entity hex_mux2 is
port (
	logic_in0, logic_in1    				   : in	std_logic_vector(3 downto 0);
   mux_select 										: in std_logic_vector(1 downto 0);
	logic_out  										: out	std_logic_vector(3 downto 0)

);
end hex_mux2;

architecture mux_logic of hex_mux2 is

begin

	with mux_select select
	logic_out <= (logic_in0 AND logic_in1) when "11",
				  (logic_in0 OR logic_in1) when "10",
				  (logic_in0 XOR logic_in1) when "01",
				  (logic_in0 XNOR logic_in1) when "00";

end architecture mux_logic;

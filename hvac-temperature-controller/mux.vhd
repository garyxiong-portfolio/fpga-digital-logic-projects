library ieee;
use ieee.std_logic_1164.all;

entity mux is port (
	mux_select		: in std_logic;
	desired_temp	: in std_logic_vector(3 downto 0);
	vacation_temp	: in std_logic_vector(3 downto 0);
	mux_temp			: out std_logic_vector(3 downto 0)
	
);
end mux;

architecture mux_logic of mux is

begin

	with mux_select select
		mux_temp <= vacation_temp when '1',
						desired_temp when '0';
						
end architecture mux_logic;
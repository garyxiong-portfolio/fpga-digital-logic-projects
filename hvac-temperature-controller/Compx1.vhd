library ieee;
use ieee.std_logic_1164.all;

entity Compx1 is port (

	a, b		: in 	std_logic;
   big, equal, small		: out std_logic

); 
end Compx1;

architecture design of Compx1 is

begin

	big <= a and (not b);
	equal <= a xnor b;
	small <= (not a) and b;
	
end design;
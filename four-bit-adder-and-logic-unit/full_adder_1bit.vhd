library ieee;
use ieee.std_logic_1164.all;


entity full_adder_1bit is port (
   
   input_a, input_b, carry_in	   	:  in  std_logic;
   
	full_adder_sum, full_adder_carry :  out std_logic 
	); 
end full_adder_1bit;

architecture gates of full_adder_1bit is

	signal half_adder_carry 	:	std_logic;
	signal half_adder_sum		:	std_logic;

begin

half_adder_carry <= input_a and input_b;
half_adder_sum <= input_a xor input_b;
full_adder_sum <= half_adder_sum xor carry_in;
full_adder_carry <= half_adder_carry or (carry_in and half_adder_sum);	


end gates; 


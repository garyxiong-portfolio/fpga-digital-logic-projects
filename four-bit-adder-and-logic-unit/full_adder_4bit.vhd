library ieee;
use ieee.std_logic_1164.all;


entity full_adder_4bit is port (
  BUS0_b3			:  in  std_logic;
  BUS1_B3			:  in  std_logic;
  BUS0_b2			:  in  std_logic;
  BUS1_b2			:  in  std_logic;
  BUS0_b1			:  in  std_logic;
  BUS1_b1			:  in  std_logic;
  BUS0_b0			:  in  std_logic;
  BUS1_b0			:  in  std_logic;
  c_in				:  in  std_logic;
  
  SUM					:  out std_logic_vector(3 downto 0);
  Carry_Out3 		:  out std_logic
  
); 
end full_adder_4bit;


architecture gates of full_adder_4bit is
	
	component full_adder_1bit port (
	
		input_a, input_b, carry_in	   	:  in  std_logic;
		full_adder_sum, full_adder_carry :  out std_logic
	);	
	end component;

	signal carry_0, carry_1, carry_2	: std_logic;


begin

INST1: full_adder_1bit port map(BUS0_b0, BUS1_b0, c_in, SUM(0), carry_0);

INST2: full_adder_1bit port map(BUS0_b1, BUS1_b1, carry_0, SUM(1), carry_1);

INST3: full_adder_1bit port map(BUS0_b2, BUS1_b2, carry_1, SUM(2), carry_2);

INST4: full_adder_1bit port map(BUS0_b3, BUS1_b3, carry_2, SUM(3), Carry_Out3);

end gates; 


library ieee;
use ieee.std_logic_1164.all;

entity Compx4 is port (

	A, B		: in 	std_logic_vector(3 downto 0);
   Big, Equal, Small		: out std_logic

); 
end Compx4;

architecture design of Compx4 is

component Compx1 port(

	a, b		: in 	std_logic;
   big, equal, small		: out std_logic

);
end component Compx1;

signal AGTB, AEQB, ALTB	:	std_logic_vector (3 downto 0);

begin

	INST1: Compx1 port map(A(3), B(3), AGTB(3), AEQB(3), ALTB(3));
	INST2: Compx1 port map(A(2), B(2), AGTB(2), AEQB(2), ALTB(2));
	INST3: Compx1 port map(A(1), B(1), AGTB(1), AEQB(1), ALTB(1));
	INST4: Compx1 port map(A(0), B(0), AGTB(0), AEQB(0), ALTB(0));
	
	Big <= AGTB(3) or (AGTB(2) and AEQB(3)) or (AGTB(1) and AEQB(3) and AEQB(2)) or (AGTB(0) and AEQB(3) and AEQB(2) and AEQB(1));
	Equal <= AEQB(3) and AEQB(2) and AEQB(1) and AEQB(0);
	Small <= ALTB(3) or (ALTB(2) and AEQB(3)) or (ALTB(1) and AEQB(3) and AEQB(2)) or (ALTB(0) and AEQB(3) and AEQB(2) and AEQB(1));
	
	
end design;
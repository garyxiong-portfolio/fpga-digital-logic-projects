library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Divide the 50 MHz board clock; simulation mode uses shorter divider taps.
entity Clock_generator is

	port
	(
		 sim_mode			: in boolean;
		 reset				: in std_logic;
       clkin      		: in  std_logic;
		 sm_clken			: out	std_logic;
		 blink		  		: out std_logic
	);

end entity;

architecture rtl of Clock_generator is

signal digital_counter 					: std_logic_vector(25 downto 0);
signal clk_0_7hz, clk_2_8hz					: std_logic;
signal sim_clk_blink, sim_clk_enbl	: std_logic;

signal clk_reg_extend					: std_logic_vector(1 downto 0);
signal blink_sig 							: std_logic;

begin

clk_divider: process (clkin)
	variable   counter	:  unsigned(25 downto 0);

	begin

		if (rising_edge(clkin))  then
			if(reset ='1') then
				counter := "00000000000000000000000000";
			else
				 counter :=  counter + 1;
			end if;
		end if;

		digital_counter <= std_logic_vector(counter);

	end process;

clk_0_7hz 				<= digital_counter(25);
clk_2_8hz 				<= digital_counter(23);
sim_clk_enbl 			<= digital_counter(4);
sim_clk_blink 			<= digital_counter(2);

-- Detect the divided-clock rising edge to produce a one-cycle enable pulse.
clk_extender: process (clkin)
	begin
		if (rising_edge(clkin))  then
			if(reset ='1') then
				clk_reg_extend(1 downto 0) 	<= "00";
				blink_sig 				 			<= '0';
			elsif(sim_mode) then
				 clk_reg_extend(1 downto 0) 	<= clk_reg_extend(0) & sim_clk_enbl;
				 blink_sig 		 					<= sim_clk_blink;
			else
				 clk_reg_extend(1 downto 0) 	<= clk_reg_extend(0) & clk_0_7hz ;
				 blink_sig 				 			<= clk_2_8hz;
				END IF;
		end if;
	end process;

sm_clken	<= clk_reg_extend(0) AND (NOT(clk_reg_extend(1)));
blink 	<= blink_sig;

end rtl;

library ieee;
use ieee.std_logic_1164.all;

entity LogicalStep_Lab3_top is port (
	clkin_50		: in 	std_logic;
	pb_n			: in	std_logic_vector(3 downto 0);
 	sw   			: in  std_logic_vector(7 downto 0);

   leds			: out std_logic_vector(7 downto 0);
   seg7_data 	: out std_logic_vector(6 downto 0);
	seg7_char1  : out	std_logic;
	seg7_char2  : out	std_logic

);
end LogicalStep_Lab3_top;

architecture design of LogicalStep_Lab3_top is

component SevenSegment  port (
   hex	   :  in  std_logic_vector(3 downto 0);
   sevenseg :  out std_logic_vector(6 downto 0)
);
end component SevenSegment;

component segment7_mux port (
          clk        : in  std_logic := '0';
			 DIN2 		: in  std_logic_vector(6 downto 0);
			 DIN1 		: in  std_logic_vector(6 downto 0);
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
        );
end component segment7_mux;

component Tester port (
	MC_TESTMODE				: in  std_logic;
	I1EQI2,I1GTI2,I1LTI2	: in	std_logic;
	input1					: in  std_logic_vector(3 downto 0);
	input2					: in  std_logic_vector(3 downto 0);
	TEST_PASS  				: out	std_logic
	);
	end component;

component HVAC 	port (
	HVAC_SIM					: in boolean;
	clk						: in std_logic;
	run		   			: in std_logic;
	increase, decrease	: in std_logic;
	temp						: out std_logic_vector (3 downto 0)
	);
end component;

component Compx4 port(
	A, B		: in 	std_logic_vector(3 downto 0);
   Big, Equal, Small		: out std_logic
);
end component Compx4;

component Bidir_shift_reg port(
	CLK, RESET, CLK_EN, LEFT0_RIGHT1		: in  std_logic := '0';
	REG_BITS  		: out	std_logic_vector(7 downto 0)
);
end component Bidir_shift_reg;

component U_D_Bin_Counter8bit port (
 	CLK, RESET, CLK_EN, UP1_DOWN0	: in  std_logic := '0';
	COUNTER_BITS  	: out	std_logic_vector(7 downto 0)
);
end component U_D_Bin_Counter8bit;

component PB_inverters port (
   pb_n	   :  in  std_logic_vector(3 downto 0);
   pb :  out std_logic_vector(3	downto 0)
);
end component PB_inverters;

component Energy_Monitor port (
	comp4x_in : in std_logic_vector(2 downto 0);
	pb_inv : in std_logic_vector(3 downto 0);
	furnace, at_temp, AC, blower, window, door, vacation : out std_logic;
	hvac_in : out std_logic_vector(2 downto 0)
);
end component Energy_Monitor;

component mux port (
	mux_select		: in std_logic;
	desired_temp	: in std_logic_vector(3 downto 0);
	vacation_temp	: in std_logic_vector(3 downto 0);
	mux_temp			: out std_logic_vector(3 downto 0)
);
end component mux;

constant HVAC_SIM : boolean := FALSE; -- FALSE for hardware; TRUE for simulation.

signal inverted_PB : std_logic_vector(3 downto 0);
signal compx4_out, HVAC_in : std_logic_vector(2 downto 0);

signal clk_in					: std_logic;
signal hex_A, hex_B 			: std_logic_vector(3 downto 0);
signal hexA_7seg, hexB_7seg: std_logic_vector(6 downto 0);

begin

clk_in <= clkin_50;

inst1: sevensegment port map (hex_A, hexA_7seg);
inst2: sevensegment port map (hex_B, hexB_7seg);
inst3: segment7_mux port map (clk_in, hexA_7seg, hexB_7seg, seg7_data, seg7_char2, seg7_char1);
inst4: Compx4 port map (hex_A, hex_B, compx4_out(2), compx4_out(1), compx4_out(0));

INST7: PB_inverters port map (pb_n, inverted_PB);
INST8: Energy_Monitor port map (compx4_out, inverted_PB, leds(0), leds(1), leds(2), leds(3), leds(4), leds(5), leds(7), HVAC_in);
INST9: HVAC port map (HVAC_SIM, clk_in, HVAC_in(2), HVAC_in(1), HVAC_in(0), hex_B);
INST10: Tester port map (inverted_PB(2), compx4_out(1), compx4_out(2), Compx4_out(0), sw(3 downto 0), hex_B,  leds(6));
INST11: mux port map (inverted_PB(3), sw(3 downto 0), sw(7 downto 4), hex_A);

end design;

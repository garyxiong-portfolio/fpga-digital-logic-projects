library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity LogicalStep_Lab2_top is port (
   clkin_50			: in	std_logic;
	pb_n				: in	std_logic_vector(3 downto 0);
   sw   				: in  std_logic_vector(7 downto 0);
   leds				: out std_logic_vector(7 downto 0);
   seg7_data 		: out std_logic_vector(6 downto 0);
	seg7_char1  	: out	std_logic;
	seg7_char2  	: out	std_logic

);
end LogicalStep_Lab2_top;

architecture SimpleCircuit of LogicalStep_Lab2_top is

  component sevensegment port (
   hex   		:  in  std_logic_vector(3 downto 0);
   sevenseg 	:  out std_logic_vector(6 downto 0)
   );
   end component;

	component segment7_mux port (
		clk 				: in std_logic := '0';
		DIN2				: in std_logic_vector(6 downto 0);
		DIN1				: in std_logic_vector(6 downto 0);
		DOUT				: out std_logic_vector(6 downto 0);
		DIG2				: out std_logic;
		DIG1				: out std_logic
	);
	end component;

	component hex_mux port (
      logic_in0    : in std_logic_vector(3 downto 0);
      logic_in1    : in std_logic_vector(3 downto 0);
      mux_select   : in std_logic_vector(1 downto 0);
      logic_out    : out std_logic_vector(3 downto 0)
	);
	end component;

	component PB_Inverters port (
		pb_n	   :  in  std_logic_vector(3 downto 0);
		pb 		:  out std_logic_vector(3 downto 0)
	);
	end component;

	component full_adder_4bit port (
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
	end component;

	component hex_mux2 port (
		logic_in0, logic_in1    : in	std_logic_vector(3 downto 0);
		mux_select 					: in std_logic_vector(1 downto 0);
		logic_out					: out	std_logic_vector(3 downto 0)
	);
	end component;

	component hex_mux3 port (
		sum, carry, opa, opb    				   : in	std_logic_vector(3 downto 0);
		mux_select 										: in std_logic;
		out1, out2  									: out	std_logic_vector(3 downto 0)
	);
	end component;

	signal hex_A	: std_logic_vector(3 downto 0);
	signal hex_B	: std_logic_vector(3 downto 0);

	signal seg7_A	: std_logic_vector(6 downto 0);
	signal seg7_B	: std_logic_vector(6 downto 0);

	signal pb        : std_logic_vector(3 downto 0);
	signal logic_out : std_logic_vector(3 downto 0);

	signal sum_output : std_logic_vector(3 downto 0);
	signal carry_out3 : std_logic;
   signal carry_4bit : std_logic_vector(3 downto 0);

	signal digit1 : std_logic_vector (3 downto 0);
	signal digit2 : std_logic_vector (3 downto 0);

begin

	hex_A <= sw(3 downto 0);
	hex_B <= sw(7 downto 4);

	INST1: sevensegment port map(digit2, seg7_A);
	INST2: sevensegment port map(digit1, seg7_B);
	INST3: segment7_mux port map(clkin_50, seg7_A, seg7_B, seg7_data, seg7_char2, seg7_char1);
	INST4: PB_inverters port map(pb_n, pb);

	INST6: full_adder_4bit port map(hex_A(3), hex_B(3), hex_A(2), hex_B(2), hex_A(1), hex_B(1), hex_A(0), hex_B(0), '0', sum_output, carry_out3);
	carry_4bit <= "000" & carry_out3;

	INST7: hex_mux2 port map(hex_B, hex_A, pb(1 downto 0), leds(3 downto 0));

	INST8: hex_mux3 port map(carry_4bit, sum_output, hex_B, hex_A, pb(2), digit1, digit2);

end SimpleCircuit;

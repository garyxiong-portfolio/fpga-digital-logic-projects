LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY LogicalStep_Lab4_top IS
   PORT
	(
    clkin_50	    : in	std_logic;
	rst_n			: in	std_logic; -- Active low.
	pb_n			: in	std_logic_vector(3 downto 0); -- Active low.
 	sw   			: in  	std_logic_vector(7 downto 0);
   leds			: out 	std_logic_vector(7 downto 0);

   seg7_data 	: out 	std_logic_vector(6 downto 0);
	seg7_char1  : out	std_logic;
	seg7_char2  : out	std_logic

	);
END LogicalStep_Lab4_top;

ARCHITECTURE SimpleCircuit OF LogicalStep_Lab4_top IS
   component segment7_mux port (
          clk        	: in  	std_logic := '0';
			 DIN2 			: in  	std_logic_vector(6 downto 0);
			 DIN1 			: in  	std_logic_vector(6 downto 0);
			 DOUT			: out	std_logic_vector(6 downto 0);
			 DIG2			: out	std_logic;
			 DIG1			: out	std_logic
   );
   end component;

   component clock_generator port (
			sim_mode			: in boolean;
			reset				: in std_logic;
         clkin      		: in  std_logic;
			sm_clken			: out	std_logic;
			blink		  		: out std_logic
  );
   end component;

    component pb_filters port (
			clkin				: in std_logic;
			rst_n				: in std_logic; -- Active low.
			rst_n_filtered	    : out std_logic;
			pb_n				: in  std_logic_vector (3 downto 0); -- Active low.
			pb_n_filtered	    : out	std_logic_vector(3 downto 0)
 );
   end component;

	component pb_inverters port (
			rst_n				: in  std_logic; -- Active low.
			rst				    : out	std_logic;
			pb_n_filtered	    : in  std_logic_vector (3 downto 0);
			pb					: out	std_logic_vector(3 downto 0)
  );
   end component;

	component state_machine port(
			clk_input, reset, blink, reg1, reg2, mode   		: IN std_logic;
			output1, output2						: OUT std_logic_vector(6 downto 0);
			CLK_EN									: in	std_logic := '0';
			ns_led, ew_led						: out std_logic := '0';
			state_leds										: out std_logic_vector(3 downto 0);
			NS_register_clear, EW_register_clear : out std_logic
	);
	end component;

	component synchronizer port(
			clk					: in std_logic;
			reset					: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
  );
   end component;

  component holding_register port (
			clk					: in std_logic;
			reset					: in std_logic;
			register_clr		: in std_logic;
			din					: in std_logic;
			dout					: out std_logic
  );
  end component;

	CONSTANT	sim_mode								: boolean := FALSE; -- FALSE for hardware; TRUE for simulation.
	SIGNAL rst, rst_n_filtered, synch_rst, synch_1, synch_2			    : std_logic;
	SIGNAL sm_clken, blink_sig : std_logic;
	SIGNAL ns_req, ew_req							: std_logic;
	SIGNAL pb_n_filtered, pb							: std_logic_vector(3 downto 0);
	SIGNAL NS, EW : std_logic_vector(6 downto 0);
	SIGNAL NS_reg_clear, EW_reg_clear : std_logic;
	SIGNAL mode_control : std_logic;

BEGIN

INST0: pb_filters		port map (clkin_50, rst_n, rst_n_filtered, pb_n, pb_n_filtered);
INST1: pb_inverters		port map (rst_n_filtered, rst, pb_n_filtered, pb);
INST3: clock_generator 	port map (sim_mode, synch_rst, clkin_50, sm_clken, blink_sig);

INST2: synchronizer     port map (clkin_50, synch_rst, pb(1), synch_1);
INST6: holding_register port map(clkin_50, synch_rst, EW_reg_clear, synch_1, ew_req);

INST7: synchronizer     port map (clkin_50, synch_rst, pb(0), synch_2);
INST8: holding_register port map(clkin_50, synch_rst, NS_reg_clear, synch_2, ns_req);

INST9: synchronizer  port map (clkin_50, '0', rst, synch_rst);

INST4: state_machine port map(clkin_50, synch_rst, blink_sig, ns_req, ew_req, mode_control, NS, EW, sm_clken, leds(0), leds(2), leds(7 downto 4), NS_reg_clear, EW_reg_clear);
INST5: segment7_mux port map(clkin_50, NS, EW, seg7_data, seg7_char2, seg7_char1);

INST10: synchronizer		port map (clkin_50, synch_rst, sw(0), mode_control);

leds(3) <= ew_req;
leds(1)<= ns_req;

END SimpleCircuit;

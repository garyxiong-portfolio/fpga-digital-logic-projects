library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

Entity state_machine IS Port
(
 clk_input, reset, blink, reg1, reg2, mode    		: IN std_logic;
 output1, output2						: OUT std_logic_vector(6 downto 0);
 CLK_EN									: in	std_logic := '0';
 ns_led, ew_led						: out std_logic;
 state_leds										: out std_logic_vector(3 downto 0);
 NS_register_clear, EW_register_clear : out std_logic
 );
END ENTITY;

 Architecture SM of state_machine is

 TYPE STATE_NAMES IS (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15);

 SIGNAL current_state, next_state	:  STATE_NAMES;

 BEGIN

Register_Section: PROCESS (clk_input, reset)
BEGIN
	IF(rising_edge(clk_input)) THEN

		IF (reset = '1') THEN
			current_state <= S0;

		ELSE

			IF	(CLK_EN = '1') THEN
				current_state <= next_state;

			END IF;

		END IF;

	END IF;

END PROCESS;

Transition_Section: PROCESS (current_state, reg1, reg2, mode)

BEGIN
  CASE current_state IS
        WHEN S0 =>
					if (reg1 = '0' and reg2 = '1') then
						next_state <= s6;
					else
						next_state <= S1;
					end if;

					state_leds <= "0000";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

         WHEN S1 =>
					if (reg1 = '0' and reg2 = '1') then
						next_state <= s6;
					else
						next_state <= S2;
					end if;

					state_leds <= "0001";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

         WHEN S2 =>
					next_state <= S3;
					state_leds <= "0010";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

         WHEN S3 =>
					next_state <= S4;
					state_leds <= "0011";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

         WHEN S4 =>
					next_state <= S5;
					state_leds <= "0100";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

         WHEN S5 =>
					next_state <= S6;
					state_leds <= "0101";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

         WHEN S6 =>
					next_state <= S7;
					state_leds <= "0110";
					EW_register_clear <= '0';

					if (reg1 = '1') then
						NS_register_clear <= '1';
					else
						NS_register_clear <= '0';
					end if;

			WHEN S7 =>
					next_state <= S8;
					state_leds <= "0111";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

			WHEN S8 =>
					if (reg2 = '0' and reg1 = '1') then
						next_state <= s14;
					else
						next_state <= S9;
					end if;

					state_leds <= "1000";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

			WHEN S9 =>
					if (reg2 = '0' and reg1 = '1') then
						next_state <= s14;
					else
						next_state <= S10;
					end if;

					state_leds <= "1001";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

			WHEN S10 =>
					next_state <= S11;
					state_leds <= "1010";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

			WHEN S11 =>
					next_state <= S12;
					state_leds <= "1011";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

			WHEN S12 =>
					next_state <= S13;
					state_leds <= "1100";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

			WHEN S13 =>
					next_state <= S14;
					state_leds <= "1101";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

			WHEN S14 =>
					next_state <= S15;
					state_leds <= "1110";

					if (reg2 = '1') then
						EW_register_clear <= '1';
					else
						EW_register_clear <= '0';
					end if;
					NS_register_clear <= '0';

			WHEN S15 =>
					state_leds <= "1111";
					NS_register_clear <= '0';
					EW_register_clear <= '0';

					if (mode = '1') then
						next_state <= S15;
					else
						next_state <= S0;
					end if;

	  END CASE;
 END PROCESS;

Decoder_Section: PROCESS (current_state)

BEGIN
     CASE current_state IS

         WHEN S0 =>
				if (blink = '1') then
					output1 <= "0001000";
				else
					output1 <= "0000000";
				end if;
			output2 <= "0000001";
			ns_led <= '0';
			ew_led <= '0';

         WHEN S1 =>
				if (blink = '1') then
					output1 <= "0001000";
				else
					output1 <= "0000000";
				end if;
			output2 <= "0000001";
			ns_led <= '0';
			ew_led <= '0';

         WHEN S2 =>
			output1 <= "0001000";
			output2 <= "0000001";
			ns_led <= '1';
			ew_led <= '0';

         WHEN S3 =>
			output1 <= "0001000";
			output2 <= "0000001";
			ns_led <= '1';
			ew_led <= '0';

         WHEN S4 =>
			output1 <= "0001000";
			output2 <= "0000001";
			ns_led <= '1';
			ew_led <= '0';

         WHEN S5 =>
			output1 <= "0001000";
			output2 <= "0000001";
			ns_led <= '1';
			ew_led <= '0';

         WHEN S6 =>
			output1 <= "1000000";
			output2 <= "0000001";
			ns_led <= '0';
			ew_led <= '0';

         WHEN S7 =>
			output1 <= "1000000";
			output2 <= "0000001";
			ns_led <= '0';
			ew_led <= '0';

         WHEN S8 =>
			output1 <= "0000001";
			if (blink = '1') then
				output2 <= "0001000";
			else
				output2 <= "0000000";
			end if;
			ns_led <= '0';
			ew_led <= '0';

			WHEN S9 =>
			output1 <= "0000001";
			if (blink = '1') then
				output2 <= "0001000";
			else
				output2 <= "0000000";
			end if;
			ns_led <= '0';
			ew_led <= '0';

			WHEN S10 =>
			output1 <= "0000001";
			output2 <= "0001000";
			ns_led <= '0';
			ew_led <= '1';

			WHEN S11 =>
			output1 <= "0000001";
			output2 <= "0001000";
			ns_led <= '0';
			ew_led <= '1';

			WHEN S12 =>
			output1 <= "0000001";
			output2 <= "0001000";
			ns_led <= '0';
			ew_led <= '1';

			WHEN S13 =>
			output1 <= "0000001";
			output2 <= "0001000";
			ns_led <= '0';
			ew_led <= '1';

			WHEN S14 =>
			output1 <= "0000001";
			output2 <= "1000000";
			ns_led <= '0';
			ew_led <= '0';

			WHEN S15 =>
			ns_led <= '0';
			ew_led <= '0';
			if (mode = '1') then
				if (blink = '1') then
					output1 <= "0000001";
					output2 <= "1000000";
				else
					output1 <= "0000000";
					output2 <= "0000000";
				end if;
			else
				output1 <= "0000001";
				output2 <= "1000000";
			end if;

	  END CASE;
 END PROCESS;

 END ARCHITECTURE SM;

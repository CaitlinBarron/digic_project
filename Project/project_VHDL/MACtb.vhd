--------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:   12:59:43 11/21/2017
-- Design Name:
-- Module Name:   C:/Users/mjs5127/Documents/lab5/lab5/lab5tb.vhd
-- Project Name:  lab5
-- Target Device:
-- Tool versions:
-- Description:
--
-- VHDL Test Bench Created by ISE for module: MAC
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes:
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;

ENTITY lab5tb IS
END lab5tb;

ARCHITECTURE behavior OF lab5tb IS

    constant N : integer := 32;
    -- Component Declaration for the Unit Under Test (UUT)

    COMPONENT MAC
    PORT(
         A : IN  std_logic_vector((N/2)-1 downto 0);
         B : IN  std_logic_vector((N/2)-1 downto 0);
         clk : IN  std_logic;
         rst : IN  std_logic;
         test_mode : IN  std_logic;
         Result_OUT : out  STD_LOGIC_VECTOR (N-1 downto 0)
        );
    END COMPONENT;


   --Inputs
   signal A : std_logic_vector((N/2)-1 downto 0) := (others => '0');
   signal B : std_logic_vector((N/2)-1 downto 0) := (others => '0');
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal test_mode : std_logic := '0';
   signal Result_OUT : std_logic_vector(N-1 downto 0) := (others => '0');

   -- Clock period definitions
   constant clk_period : time := 100 ns;

BEGIN

	-- Instantiate the Unit Under Test (UUT)
   uut: MAC PORT MAP (
          A => A,
          B => B,
          clk => clk,
          rst => rst,
          test_mode => test_mode,
          Result_OUT => Result_OUT
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;


   -- Stimulus process
   stim_proc: process
   begin
        rst <= '0'; --Reset On
        test_mode <= '0'; --Test Mode Off
		  --MSB*MSB in reset
        A <= (others => '0'); --Clear out all of the A input bits
        B <= (others => '0'); --Clear out all of the B input bits
        A((N/2)-1 downto  (N/2)-1) <= (others => '1'); -- MSB A Bit On
        B((N/2)-1 downto  (N/2)-1) <= (others => '1'); -- MSB A Bit On
		    wait for clk_period;
        rst <= '1'; --Reset off
        wait for clk_period;

		  --Upper Half of input bits A and B all on
        A <= (others => '0'); --Clear out all of the A input bits
        B <= (others => '0'); --Clear out all of the B input bits
        A((N/2)-1 downto  (N/4)) <= (others => '1'); -- A Upper bits on
        B((N/2)-1 downto  (N/4)) <= (others => '1'); -- B Upper bits on
        wait for clk_period;

      --Lower Half of input bits A and B all on
        A <= (others => '0'); --Clear out all of the A input bits
        B <= (others => '0'); --Clear out all of the B input bits
        A((N/4)-1 downto  0) <= (others => '1'); -- A lower bits on
        B((N/4)-1 downto  0) <= (others => '1'); -- B lower bits on
        wait for clk_period;

      --Upper Half of input bits A and lower half of input B
        A <= (others => '0'); --Clear out all of the A input bits
        B <= (others => '0'); --Clear out all of the B input bits
        A((N/2)-1 downto  (N/4)) <= (others => '1'); -- A upper bits on
        B((N/4)-1 downto  0) <= (others => '1'); -- B lower bits on
        wait for clk_period;

      --Lower Half of input bits A and upper half of input B
        A <= (others => '0'); --Clear out all of the A input bits
        B <= (others => '0'); --Clear out all of the B input bits
        A((N/4)-1 downto  0) <= (others => '1'); -- A lower bits on
        B((N/2)-1 downto  (N/4)) <= (others => '1'); -- B upper bits on
        wait for clk_period;

        test_mode <= '1'; -- Test Mode on
        rst <= '0'; --Reset On
        A <= (others => '0'); --Clear out all of the A input bits
        B <= (others => '0'); --Clear out all of the B input bits
        wait for clk_period;

        rst <= '1'; --Reset off
        wait for clk_period*100; -- Wait for signature to be generated

        test_mode <= '0'; -- Test Mode off
        rst <= '0'; -- Reset On
        A <= (others => '0'); --Clear out all of the A input bits
        B <= (others => '0'); --Clear out all of the B input bits
		    wait for clk_period;
        rst <= '1'; -- Reset Off
        wait for clk_period;

      wait;
   end process;

END;

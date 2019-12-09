----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date:    12:00:39 11/21/2017
-- Design Name:
-- Module Name:    LFSR - Behavioral
-- Project Name:
-- Target Devices:
-- Tool versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LFSR is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           bit_pattern : out  STD_LOGIC_VECTOR (31 downto 0));
end LFSR;

architecture Behavioral of LFSR is
signal LFSR_REG : std_logic_vector(31 downto 0);
signal zeroth_in : std_logic := '0';
begin

process(clk, rst, enable)
	begin

	if clk'event and clk = '1' then
		if rst = '0' then
			LFSR_REG <= ("00000000000000000000000000000001"); --Initialize the LFSR if reset

		elsif enable = '1' then
			-- Taps and inputs
			zeroth_in <= LFSR_REG(0); -- Save Zero bit for TAPS
		    LFSR_REG(0)  <= LFSR_REG(1);
		    LFSR_REG(1)  <= LFSR_REG(2);
		    LFSR_REG(2)  <= LFSR_REG(3);
		    LFSR_REG(3)  <= LFSR_REG(4);
		    LFSR_REG(4)  <= LFSR_REG(5);
		    LFSR_REG(5)  <= LFSR_REG(6);
		    LFSR_REG(6)  <= LFSR_REG(7);
		    LFSR_REG(7)  <= LFSR_REG(8);
		    LFSR_REG(8)  <= LFSR_REG(9);
		    LFSR_REG(9)  <= LFSR_REG(10);
		    LFSR_REG(10) <= LFSR_REG(11);
		    LFSR_REG(11) <= LFSR_REG(12);
		    LFSR_REG(12) <= LFSR_REG(13);
		    LFSR_REG(13) <= LFSR_REG(14);
		    LFSR_REG(14) <= LFSR_REG(15);
		    LFSR_REG(15) <= LFSR_REG(16);
		    LFSR_REG(16) <= LFSR_REG(17);
		    LFSR_REG(17) <= LFSR_REG(18);
		    LFSR_REG(18) <= LFSR_REG(19);
		    LFSR_REG(19) <= LFSR_REG(20);
		    LFSR_REG(20) <= LFSR_REG(21);
		    LFSR_REG(21) <= LFSR_REG(22);
		    LFSR_REG(22) <= LFSR_REG(23);
		    LFSR_REG(23) <= LFSR_REG(24);
		    LFSR_REG(24) <= LFSR_REG(25) XOR zeroth_in; -- Tap here 25th bit
		    LFSR_REG(25) <= LFSR_REG(26) XOR zeroth_in; -- Tap here 26th bit
		    LFSR_REG(26) <= LFSR_REG(27);
		    LFSR_REG(27) <= LFSR_REG(28);
		    LFSR_REG(28) <= LFSR_REG(29);
		    LFSR_REG(29) <= LFSR_REG(30) XOR zeroth_in; -- Tap here 30th bit
		    LFSR_REG(30) <= LFSR_REG(31);
		    LFSR_REG(31) <= zeroth_in; -- Tap here 32nd bit
		end if;
	end if;
end process;

	bit_pattern <= LFSR_REG; --Generated pattern

end Behavioral;


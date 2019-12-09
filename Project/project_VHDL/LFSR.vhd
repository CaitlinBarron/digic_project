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
signal LFSR_REG : std_logic_vector(31 downto 0) := ("00000000000000000000000000000001");
begin

process(clk, rst, enable)
	begin

	if clk'event and clk = '1' then
		if rst = '0' then
			LFSR_REG <= ("00000000000000000000000000000001"); --Initialize the LFSR if reset

		elsif enable = '1' then
			-- Taps and inputs
			LFSR_REG <= (LFSR_REG(30 downto 0) & ((LFSR_REG(0) XNOR LFSR_REG(1)) XNOR (LFSR_REG(21) XNOR LFSR_REG(31))));
		end if;
	end if;
end process;

	bit_pattern <= LFSR_REG; --Generated pattern

end Behavioral;


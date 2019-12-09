----------------------------------------------------------------------------------
-- Company: RIT
-- Engineer: Michael Schroeder
--
-- Create Date:    12/05/19
-- Design Name:
-- Module Name:    MISR - Behavioral
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

entity MISR is
    Port ( clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           mult_result : in  STD_LOGIC_VECTOR (31 downto 0);
           signature : out  STD_LOGIC_VECTOR (31 downto 0));
end MISR;

architecture Behavioral of MISR is
signal MISR_REG : std_logic_vector(31 downto 0) := ("00000000000000000000000000000001");
begin

process(clk, rst, enable)
	begin

	if clk'event and clk = '0' then
		if rst = '0' then
			MISR_REG <= ("00000000000000000000000000000001"); -- Initialize MISR values if reset

		elsif enable = '1' then
			MISR_REG <= ((MISR_REG(30 downto 0) XNOR mult_result(30 downto 0)) & ((MISR_REG(0) XNOR 
							MISR_REG(1)) XNOR ((MISR_REG(21) XNOR MISR_REG(31)) XNOR mult_result(31))));
		end if;
	end if;
end process;

	signature <= MISR_REG;

end Behavioral;


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
           mult_resultesult : in  STD_LOGIC_VECTOR (31 downto 0);
           signature : out  STD_LOGIC_VECTOR (31 downto 0));
end MISR;

architecture Behavioral of MISR is
signal MISR_REG : std_logic_vector(31 downto 0) := ("00000000000000000000000000000001");
signal zeroth_in : std_logic := '0';
begin

process(clk, rst, enable)
	begin

	if clk'event and clk = '1' then
		if rst = '0' then
			MISR_REG <= ("00000000000000000000000000000001"); -- Initialize MISR values if reset

		elsif enable = '1' then
			zeroth_in  <= MISR_REG(0); -- Save save the first bit
		    MISR_REG(0)  <= mult_result(0) XOR MISR_REG(1);
		    MISR_REG(1)  <= mult_result(1) XOR MISR_REG(2);
		    MISR_REG(2)  <= mult_result(2) XOR MISR_REG(3);
		    MISR_REG(3)  <= mult_result(3) XOR MISR_REG(4);
		    MISR_REG(4)  <= mult_result(4) XOR MISR_REG(5);
		    MISR_REG(5)  <= mult_result(5) XOR MISR_REG(6);
		    MISR_REG(6)  <= mult_result(6) XOR MISR_REG(7);
		    MISR_REG(7)  <= mult_result(7) XOR MISR_REG(8);
		    MISR_REG(8)  <= mult_result(8) XOR MISR_REG(9);
		    MISR_REG(9)  <= mult_result(9) XOR MISR_REG(10);
		    MISR_REG(10) <= mult_result(10) XOR MISR_REG(11);
		    MISR_REG(11) <= mult_result(11) XOR MISR_REG(12);
		    MISR_REG(12) <= mult_result(12) XOR MISR_REG(13);
		    MISR_REG(13) <= mult_result(13) XOR MISR_REG(14);
		    MISR_REG(14) <= mult_result(14) XOR MISR_REG(15);
		    MISR_REG(15) <= mult_result(15) XOR MISR_REG(16);
		    MISR_REG(16) <= mult_result(16) XOR MISR_REG(17);
		    MISR_REG(17) <= mult_result(17) XOR MISR_REG(18);
		    MISR_REG(18) <= mult_result(18) XOR MISR_REG(19);
		    MISR_REG(19) <= mult_result(19) XOR MISR_REG(20);
		    MISR_REG(20) <= mult_result(20) XOR MISR_REG(21);
		    MISR_REG(21) <= mult_result(21) XOR MISR_REG(22);
		    MISR_REG(22) <= mult_result(22) XOR MISR_REG(23);
		    MISR_REG(23) <= mult_result(23) XOR MISR_REG(24);
		    MISR_REG(24) <= mult_result(24) XOR MISR_REG(25) XOR zeroth_in; -- Tap here 25th bit
		    MISR_REG(25) <= mult_result(25) XOR MISR_REG(26) XOR zeroth_in; -- Tap here 26th bit
		    MISR_REG(26) <= mult_result(26) XOR MISR_REG(27);
		    MISR_REG(27) <= mult_result(27) XOR MISR_REG(28);
		    MISR_REG(28) <= mult_result(28) XOR MISR_REG(29);
		    MISR_REG(29) <= mult_result(29) XOR MISR_REG(30) XOR zeroth_in; -- Tap here 30th bit
		    MISR_REG(30) <= mult_result(30) XOR MISR_REG(31);
		    MISR_REG(31) <= mult_result(31) XOR zeroth_in; -- Tap here last bit
		end if;
	end if;
end process;

	signature <= MISR_REG;

end Behavioral;


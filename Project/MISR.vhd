----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:13:34 11/21/2017 
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
           mult_result : in  STD_LOGIC_VECTOR (7 downto 0);
           signature : out  STD_LOGIC_VECTOR (7 downto 0));
end MISR;

architecture Behavioral of MISR is
signal MISR_REG : std_logic_vector(7 downto 0);
begin

process(clk, rst, enable)
	begin 
	
	if clk'event and clk = '1' then
		if rst = '0' then
			MISR_REG <= ("00000001"); -- Initialize MISR values if reset
		
		elsif enable = '1' then
			MISR_REG <= ((MISR_REG(6 downto 0) XNOR mult_result(6 downto 0)) & (MISR_REG(3) XNOR 
							MISR_REG(4) XNOR MISR_REG(5) XNOR MISR_REG(7) XNOR mult_result(7)));
		end if;
	end if;
end process;

	signature <= MISR_REG;

end Behavioral;


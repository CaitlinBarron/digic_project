----------------------------------------------------------------------------------
-- Company: Rochester Institute of Technology
-- Engineer: Michael Schroeder
-- 
-- Create Date:    12/8/2019 
-- Module Name:    RegisterN - Behavioral 
-- Description:    2N Bit Register with Enable
--
-- Revision: 
-- Revision 0.01 - File Created
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RegisterN is
	generic(N : integer := 8);
	port (
		clk : in std_logic;
		reset : in std_logic;
		enable : in std_logic;
		input : in std_logic_vector( (2*N) downto 0 );
		output : out std_logic_vector( (2*N) downto 0 )
	);
end RegisterN;

architecture Behavioral of RegisterN is
begin
process( clk, reset )
begin
	if reset = '1' then
		output <= ( others => '0' );
	elsif clk'event and clk = '1' then
		if enable = '1' then
			output <= input;
		end if;
	end if;
end process;

end Behavioral;


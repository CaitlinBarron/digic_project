----------------------------------------------------------------------------------
-- Company: RIT
-- Engineer: Michael Schroeder
-- 
-- Create Date:    19:36:12 10/03/2017 
-- Design Name: 
-- Module Name:    RCFA - Behavioral 
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

entity RCFA is
	generic(N : integer := 16);
    Port ( A : in  STD_LOGIC_VECTOR (N-1 downto 0);
           B : in  STD_LOGIC_VECTOR (N-1 downto 0);
           Cin : in  STD_LOGIC;
           Sum : out  STD_LOGIC_VECTOR (N-1 downto 0);
           Cout : out  STD_LOGIC);
end RCFA;

architecture structural of RCFA is
signal bTemp : STD_LOGIC_VECTOR (N-1 downto 0);
signal carry : STD_LOGIC_VECTOR (N downto 0);
begin

with Cin select
		bTemp <=  NOT B when '1',
					 B     when others;

carry(0) <= Cin;				
FAs: for i in 0 to N-1 generate
	adders: entity work.FullAdder
			port map(A=>A(i),B=>bTemp(i),Cin=>carry(i),
						Sum=>Sum(i),Cout=>carry(i+1));
	end generate FAs;

Cout<=carry(N);		

end structural;


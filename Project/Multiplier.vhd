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

entity Multiplier is
	generic(N : integer := 8);
    Port ( A : in  STD_LOGIC_VECTOR ((N/2)-1 downto 0);
           B : in  STD_LOGIC_VECTOR ((N/2)-1 downto 0);
           Product : out  STD_LOGIC_VECTOR (N-1 downto 0));
          
end Multiplier;

architecture structural of Multiplier is
	type and_array is array((N/2)-1 downto 0) of STD_LOGIC_VECTOR((N/2)-1 downto 0);
	type sum_array is array((N/2)-1 downto 1) of STD_LOGIC_VECTOR((N/2)-1 downto 0);
	type carry_array is array((N/2)-1 downto 1) of STD_LOGIC_VECTOR((N/2)-1 downto 0);

	signal ands : and_array;
	signal sums : sum_array;
	signal carrys : carry_array;
begin

	rows : for row in 0 to (N/2)-1 generate 
		columns : for col in 0 to (N/2)-1 generate
		
			AndGates : ands(row)(col) <= A(col) AND B(row);
			
			--First row of FA's
			
			r1c0 : if col = 0 and row = 1 generate
				adder : entity work.FullAdder
					port map(A=>ands(1)(0), B=>ands(0)(1), Cin=>'0', Sum=>sums(1)(0), Cout=>carrys(1)(0));
			end generate r1c0;
			
			r1center_col : if col>0 and col<(N/2)-1 and row = 1 generate
				adder : entity work.FullAdder
					port map(A=>ands(row)(col), B=>ands(row-1)(col+1), Cin=>ands(row+1)(col-1), Sum=>sums(row)(col), Cout=>carrys(row)(col));
			end generate r1center_col;
			
			r1cEnd : if col = (N/2)-1 and row = 1 generate
				adder : entity work.FullAdder
					port map(A=>ands(row)(col), B=>'0', Cin=>ands(row+1)(col-1), Sum=>sums(row)(col), Cout=>carrys(row)(col));
			end generate r1cEnd;
			
			--Mid rows of FA's
			
			rMidc0 : if col = 0 and row > 1 and row < (N/2)-1 generate
				adder : entity work.FullAdder
					port map(A=>'0', B=>sums(row-1)(col+1), Cin=>carrys(row-1)(col), Sum=>sums(row)(col), Cout=>carrys(row)(col));
			end generate rMidc0;
			
			rMidcMid : if col>0 and col<(N/2)-1 and row > 1 and row < (N/2)-1 generate
				adder : entity work.FullAdder
					port map(A=>ands(row+1)(col-1), B=>sums(row-1)(col+1), Cin=>carrys(row-1)(col), Sum=>sums(row)(col), Cout=>carrys(row)(col));
			end generate rMidcMid;
			
			rMidcEnd : if col = (N/2)-1 and row > 1 and row < (N/2)-1 generate
				adder : entity work.FullAdder
					port map(A=>ands(row+1)(col-1), B=>ands(row)(col), Cin=>carrys(row-1)(col), Sum=>sums(row)(col), Cout=>carrys(row)(col));
			end generate rMidcEnd;
			
			--Last row of FA's
			
			rEndc0 : if col=0 and row = (N/2)-1 generate
				adder : entity work.FullAdder
					port map(A=>carrys(row-1)(col), B=>sums(row-1)(col+1), Cin=>'0', Sum=>sums(row)(col), Cout=>carrys(row)(col));
			end generate rEndc0;
			
			rEndcMid : if col>0 and col<(N/2)-1 and row = (N/2)-1 generate
				adder : entity work.FullAdder
					port map(A=>carrys(row-1)(col), B=>sums(row-1)(col+1), Cin=>carrys(row)(col-1), Sum=>sums(row)(col), Cout=>carrys(row)(col));
			end generate rEndcMid;
			
			rEndcEnd : if col = (N/2)-1 and row = (N/2)-1 generate
				adder : entity work.FullAdder
					port map(A=>carrys(row-1)(col), B=>ands(row)(col), Cin=>carrys(row)(col-1), Sum=>sums(row)(col), Cout=>carrys(row)(col));
			end generate rEndcEnd;
			
		end generate columns;
	end generate rows;

process(ands, sums, carrys) is begin

for i in 0 to N-1 loop

	if i = 0 then
	
		Product(i)<= ands(0)(0);
		
	elsif i > 0 and i < (N/2)-1 then
		
		Product(i)<= sums(i)(0);
		
	elsif i >= (N/2)-1 and i < N-1 then
	
		Product(i)<= sums((N/2)-1)(i-((N/2)-1));
		
	else Product(i)<= carrys((N/2)-1)((N/2)-1);
	
	end if;
end loop;
end process;

end structural;


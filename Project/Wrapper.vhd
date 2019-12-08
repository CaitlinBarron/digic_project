----------------------------------------------------------------------------------
-- Company: RIT
-- Engineer: Michael Schroeder
-- 
-- Create Date:    12/5/2019 
-- Design Name: 
-- Module Name:    MAC - Behavioral 
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
use work.bin_bcd.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity MAC is
	generic (N : integer :=8);
    Port ( A : in  STD_LOGIC_VECTOR ((N/2)-1 downto 0);
           B : in  STD_LOGIC_VECTOR ((N/2)-1 downto 0);
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           test_mode : in  STD_LOGIC;
end MAC;

architecture structural of MAC is

signal MultIn1 : std_logic_vector((N/2)-1 downto 0);
signal MultIn2 : std_logic_vector((N/2)-1 downto 0);
signal LFSR_OUT : std_logic_vector(N downto 0);
signal MISR_OUT : std_logic_vector(N downto 0);
signal MULT_OUT : std_logic_vector(N downto 0);
signal Result_OUT: std_logic_vector(N downto 0);
signal clk_cnt  : integer := 0;
signal MISR_EN : std_logic;

begin

-----------------------------------
--Choose inputs and outputs based on test_mode
InputSelect: process(test_mode, A, B, MISR_OUT, MULT_OUT, LFSR_OUT)
begin
if test_mode = '1' then
	MultIn1 <= LFSR_OUT(N downto (N/2)-1);
	MultIn2 <= LFSR_OUT((N/2)-1 downto 0);
	Result_OUT <= MISR_OUT;
else 
	MultIn1 <= A;
	MultIn2 <= B;
	Result_OUT <= MULT_OUT;
end if;
end process;
---------------------------------------
--Component Mapping
Multiplier0 : entity work.Multiplier
		generic map (N=> N)
		port map (A=> MultIn1 , B=> MultIn2, Product=>MULT_OUT);
		
LFSR0 : entity work.LFSR
		port map (clk=> clk , rst=> rst, enable=>test_mode, bit_pattern=>LFSR_OUT);
		
MISR0 : entity work.MISR
		port map (clk=> clk , rst=> rst, enable=>MISR_EN, mult_result=>MULT_OUT , signature=>MISR_OUT);
		

------------------------------------------------------------------------------------
SIGNATURE_PROC: process(clk) is begin 
	if clk'event and clk = '1' then
	
		if rst = '1' and test_mode = '1' then 
		
			if clk_cnt >= 75 then 
				MISR_EN <= '0';
			else
				if clk_cnt >= 5 then
				MISR_EN <= '1';
				end if;
				if test_mode = '1' then 
					clk_cnt <= clk_cnt + 1;
				end if;
			end if;
		else clk_cnt <= 0;
		end if;
	end if;
end process;

end structural;


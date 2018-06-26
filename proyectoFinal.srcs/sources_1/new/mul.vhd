----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2018 22:50:22
-- Design Name: 
-- Module Name: mul - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use work.package_dsed.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mul is
    Port ( a : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           b : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           y : out STD_LOGIC_VECTOR(sample_size-1 downto 0));
end mul;

architecture Behavioral of mul is
begin
process(a,b)
variable producto : STD_LOGIC_VECTOR(15 downto 0):="0000000000000000";
begin
producto:=std_logic_vector(signed(a)*signed(b));
y<=producto(14 downto 7);
end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2018 22:50:22
-- Design Name: 
-- Module Name: suma - Behavioral
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

entity suma is
    Port ( a : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           b : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           y : out STD_LOGIC_VECTOR(sample_size-1 downto 0));
end suma;

architecture Behavioral of suma is

begin

process(a,b)
begin
y <= STD_LOGIC_VECTOR(signed(a)+signed(b));
end process;
end Behavioral;

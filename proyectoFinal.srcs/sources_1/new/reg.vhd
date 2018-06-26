----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2018 22:50:22
-- Design Name: 
-- Module Name: reg - Behavioral
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

entity reg is
    Port ( clk : in std_logic;
           en : in std_logic;
           x : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           y : out STD_LOGIC_VECTOR(sample_size-1 downto 0));
end reg;

architecture Behavioral of reg is

begin
process(clk)
begin
if (rising_edge(clk))then
    if en = '1' then
        y<=x;
    end if;
end if;
end process;
end Behavioral;

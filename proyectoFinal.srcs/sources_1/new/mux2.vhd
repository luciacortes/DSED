----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2018 22:50:22
-- Design Name: 
-- Module Name: mux2 - Behavioral
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

entity mux2 is
    Port ( a : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           b : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           M : in std_logic;
           y : out STD_LOGIC_VECTOR(sample_size-1 downto 0));
end mux2;

architecture Behavioral of mux2 is

begin
process(M)
begin
if(M='0')then
    y<=a;
elsif(M='1')then
    y<=b;
else
    y<= (others=>'0');
end if;
end process;

end Behavioral;

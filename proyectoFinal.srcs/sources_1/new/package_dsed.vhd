----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2018 03:39:08
-- Design Name: 
-- Module Name: package_dsed - package
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

package package_dsed is
    constant sample_size : integer := 8;
    signal record_enable_p, play_enable_p : STD_LOGIC;
    constant c0_b, c4_b : std_logic_vector(sample_size-1 downto 0) := "00000100";
    constant c1_b, c3_b : std_logic_vector(sample_size-1 downto 0) := "00011111";
    constant c2_b : std_logic_vector(sample_size-1 downto 0) := "00111000";
    constant c0_a, c4_a : std_logic_vector(sample_size-1 downto 0) := "11111111";
    constant c1_a, c3_a : std_logic_vector(sample_size-1 downto 0) := "11100110";
    constant c2_a : std_logic_vector(sample_size-1 downto 0) := "01001100";
end package_dsed;


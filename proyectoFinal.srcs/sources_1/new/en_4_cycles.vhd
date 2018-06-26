----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2018 03:28:28
-- Design Name: 
-- Module Name: en_4_cycles - Behavioral
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

entity en_4_cycles is
    Port ( clk_12megas : in STD_LOGIC;
           reset       : in STD_LOGIC;
           clk_3megas  : out STD_LOGIC;
           en_2_cycles : out STD_LOGIC;
           en_4_cycles : out STD_LOGIC);
end en_4_cycles;

architecture Behavioral of en_4_cycles is

    signal en2_s,en4_s,m3_s: STD_LOGIC:='0';
    begin
        process(clk_12megas)
            variable en2, en4, m3: integer:=0;
            
            begin
                if(rising_edge(clk_12megas)) then
                    if(reset='1') then
                        en2 := 0;
                        en4 := 0;
                        m3  := 0;
                        m3_s  <= '0';
                        en2_s <= '0';
                        en4_s <= '0';
                    else
                        en2_s <= not en2_s;
                        en4 := en4+1;
                        m3  := m3+1;
                    end if;
                    
                    if (m3 = 2) then
                        m3 := 0;
                        m3_s <= not m3_s;
                    end if;
                    
                    if(en4 = 2) then
                        en4_s <= not en4_s;
                    elsif en4 = 3 then
                        en4_s <= not en4_s;
                    elsif en4 = 4 then
                        en4 := 0;
                    end if;
                end if;
        end process;
    
    clk_3megas  <= m3_s;
    en_2_cycles <= en2_s;
    en_4_cycles <= en4_s;
    
end Behavioral;

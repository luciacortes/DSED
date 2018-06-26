----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2018 03:28:28
-- Design Name: 
-- Module Name: pwm - Behavioral
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

entity pwm is
    Port ( clk_12megas : in STD_LOGIC;
           reset : in STD_LOGIC;
           en_2_cycles : in STD_LOGIC;
           sample_in : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_request : out STD_LOGIC;
           pwm_pulse : out STD_LOGIC);
end pwm;

architecture Behavioral of pwm is

    signal r_reg    : std_logic_vector(23 downto 0) := (others=>'0') ;
    signal r_next   : std_logic_vector(23 downto 0) := (others=>'0') ; 
    signal buf_reg  : std_logic := '0' ;
    signal buf_next : std_logic ; 
    
    begin
    
    process (clk_12megas, reset)
        begin
        if (reset='1') then
            r_reg <= (others=>'0');
            buf_reg <= '0';           
        elsif rising_edge(clk_12megas) then           
            if(en_2_cycles='1')then 
                r_reg <= r_next;
                buf_reg <= buf_next ;
            end if;
        end if;
    end process;
    
    process (r_reg)
    begin
    if(unsigned(r_reg)=299)then
            r_next<=(others=>'0');
            else
             r_next <= std_logic_vector(unsigned(r_reg) + 1);
        end if;
        if(unsigned(r_reg)=299)then
            sample_request<='1';
        else
            sample_request<='0';
        end if;
    end process;
    
    process (r_reg, sample_in)
        begin
            --output logic
            if (unsigned(r_reg)<=unsigned(sample_in))then
                buf_next <='1';
            else
                buf_next <='0';
            end if;
            pwm_pulse <= buf_reg;
    end process; 

end Behavioral;

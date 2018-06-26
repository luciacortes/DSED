----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 21.06.2018 18:38:40
-- Design Name: 
-- Module Name: tb_controlador - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_controlador is
end tb_controlador;

architecture Behavioral of tb_controlador is

component controlador 
    Port ( clk_100Mhz   : in STD_LOGIC;
           reset        : in STD_LOGIC;
           micro_data   : in STD_LOGIC;
           micro_clk    : out STD_LOGIC;
           micro_LR     : out STD_LOGIC;
           jack_sd      : out STD_LOGIC;
           jack_pwm     : out STD_LOGIC);
end component;

signal clk_100MHz_s     : STD_LOGIC; 
signal reset_s            : STD_LOGIC := '1';
signal micro_clk_s        : STD_LOGIC;
signal micro_data_s       : STD_LOGIC;
signal micro_LR_s         : STD_LOGIC := '1';
signal jack_sd_s          : STD_LOGIC := '1';
signal jack_pwm_s         : STD_LOGIC;
signal a                  : STD_LOGIC := '0';
signal b                  : STD_LOGIC := '0';
signal c                  : STD_LOGIC := '0';
constant clk_period       : time := 1us;

begin
UUT_controlador: controlador port map(
           clk_100Mhz   => clk_100MHz_s,
           reset        => reset_s,
           micro_data   => micro_data_s,
           micro_clk    => micro_clk_s,
           micro_LR     => micro_LR_s,
           jack_sd      => jack_sd_s,
           jack_pwm     => jack_pwm_s
  );

reset_p: process
     begin  
        wait for 1000ns; 
        reset_s <= '0';  
 end process;
 
 clk_p:process  --generates a 100 MHz clock.
     begin
        clk_100MHz_s <= '0';
        wait for clk_period/2;  
        clk_100MHz_s <= '1';
        wait for clk_period/2;  
 end process;

a_p: process
    begin
        wait for 7000ns;
        a <= not a;
    
end process;

b_p: process
    begin
        wait for 1100ns;
        b <= not b;
       
end process;

c_p: process
    begin
        wait for 1700ns;
        c <= not c;
        
end process;

micro_data_p: process(a,b,c)
    begin
      micro_data_s <= a xor b xor c;  
end process; 

end Behavioral;

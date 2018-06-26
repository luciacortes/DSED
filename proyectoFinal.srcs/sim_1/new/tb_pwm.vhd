----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 16:22:17
-- Design Name: 
-- Module Name: tb_pwm - Behavioral
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

entity tb_pwm is
end tb_pwm;

architecture Behavioral of tb_pwm is

component pwm is
    Port ( clk_12megas      : in STD_LOGIC;
           reset            : in STD_LOGIC;
           en_2_cycles      : in STD_LOGIC;
           sample_in        : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_request   : out STD_LOGIC;
           pwm_pulse        : out STD_LOGIC);
end component;

component en_4_cycles
    Port ( clk_12megas : in STD_LOGIC;
           reset       : in STD_LOGIC;
           clk_3megas  : out STD_LOGIC;
           en_2_cycles : out STD_LOGIC;
           en_4_cycles : out STD_LOGIC);
end component;

signal clk_12megas_s    : STD_LOGIC;
signal reset_s          : STD_LOGIC := '1';
signal en_2_cycles_s    : STD_LOGIC;
signal sample_in_s      : STD_LOGIC_VECTOR(sample_size-1 downto 0);
signal sample_request_s : STD_LOGIC;
signal pwm_pulse_s      : STD_LOGIC;
signal clk_3megas_s     : STD_LOGIC;
signal en_4_cycles_s    : STD_LOGIC;
constant clk_period     : time := 83 ns;


begin

UUT: pwm PORT MAP (
           clk_12megas      => clk_12megas_s,
           reset            => reset_s,
           en_2_cycles      => en_2_cycles_s,
           sample_in        => sample_in_s,
           sample_request   => sample_request_s,
           pwm_pulse        => pwm_pulse_s
);

UUT1:  en_4_cycles PORT MAP (
          clk_12megas => clk_12megas_s,
          reset       => reset_s,
          clk_3megas  => clk_3megas_s,
          en_2_cycles => en_2_cycles_s,
          en_4_cycles => en_4_cycles_s
);


reset_p: process
     begin  
        wait for 10ns; 
        reset_s <= '0';  
 end process;
   
clk_p: process 
    begin
       clk_12megas_s <= '0';
       wait for clk_period/2;  
       clk_12megas_s <= '1';
       wait for clk_period/2;  
end process;

sample_in_p: process
 begin
   sample_in_s <= "00000000";
   wait for 50us; 
   sample_in_s <= "10110101";
   wait for 50us;
   sample_in_s <= "11111111";
   wait for 50us;
 end process;
 
end Behavioral;

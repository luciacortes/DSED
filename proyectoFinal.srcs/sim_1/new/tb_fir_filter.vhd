----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 25.06.2018 17:45:39
-- Design Name: 
-- Module Name: tb_fir_filter - Behavioral
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

entity tb_fir_filter is
end tb_fir_filter;

architecture Behavioral of tb_fir_filter is

component fir_filter 
    Port ( clk              : in STD_LOGIC;
           reset            : in STD_LOGIC;
           sample_in        : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_in_enable : in STD_LOGIC;
           filter_select    : in STD_LOGIC;
           sample_out       : out STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_out_ready : out STD_LOGIC);
end component;

signal clk_12megas_s               : STD_LOGIC;
signal reset_s             : STD_LOGIC := '1';
signal sample_in_s         :  STD_LOGIC_VECTOR(sample_size-1 downto 0);
signal  sample_in_enable_s : STD_LOGIC := '0';
signal filter_select_s     : STD_LOGIC := '1';
signal sample_out_s        : STD_LOGIC_VECTOR(sample_size-1 downto 0);       
signal  sample_out_ready_s : STD_LOGIC;

constant clk_period        : time := 83 us;

begin

UUT_fir: fir_filter port map (
    clk                 => clk_12megas_s,
    reset               => reset_s,
    sample_in           => sample_in_s,
    sample_in_enable    => sample_in_enable_s,
    filter_select       => filter_select_s,
    sample_out          => sample_out_s,
    sample_out_ready    => sample_out_ready_s
);

reset_p: process
     begin  
        wait for 500ns; 
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
   wait for 650us; 
   sample_in_enable_s <= '1';
   sample_in_s <= "10110101";
   wait for 650us;
   sample_in_s <= "11111111";
   wait for 650us;
 end process;

--filter_select_p: process
-- begin
--    filter_select_s <= '0';
--    wait for 1000us;
--    filter_select_s <= '1';
--    wait for 500us;
-- end process;

end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.06.2018 17:33:51
-- Design Name: 
-- Module Name: tb_FSMD_microphone - Behavioral
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

entity tb_FSMD_microphone is
end tb_FSMD_microphone;

architecture Behavioral of tb_FSMD_microphone is

component FSMD_microphone
    Port ( clk_12megas      : in STD_LOGIC;
           reset            : in STD_LOGIC;
           enable_4_cycles  : in STD_LOGIC;
           micro_data       : in STD_LOGIC;
           sample_out       : out STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_out_ready : out STD_LOGIC);
end component;

component en_4_cycles
    Port ( clk_12megas  : in STD_LOGIC;
           reset        : in STD_LOGIC;
           clk_3megas   : out STD_LOGIC;
           en_2_cycles  : out STD_LOGIC;
           en_4_cycles  : out STD_LOGIC);
end component;

   
signal clk_12megas_s      : STD_LOGIC;
signal reset_s            : STD_LOGIC := '1';
signal enable_4_cycles_s  : STD_LOGIC;
signal micro_data_s       : STD_LOGIC := '0';
signal clk_3megas_s       : STD_LOGIC;
signal en_2_cycles_s      : STD_LOGIC;
signal sample_out_s       : STD_LOGIC_VECTOR(sample_size-1 downto 0);
signal sample_out_ready_s : STD_LOGIC;
constant clk_period       : time := 83 ns;


begin

UUT_FSMD: FSMD_microphone PORT MAP (
        clk_12megas      => clk_12megas_s,
        reset            => reset_s,
        enable_4_cycles  => enable_4_cycles_s,
        micro_data       => micro_data_s,
        sample_out       => sample_out_s,
        sample_out_ready => sample_out_ready_s
);

UUT_en_4: en_4_cycles PORT MAP (
          clk_12megas => clk_12megas_s,
          reset       => reset_s,
          clk_3megas  => clk_3megas_s,
          en_2_cycles => en_2_cycles_s,
          en_4_cycles => enable_4_cycles_s
);


reset_p: process
     begin  
        wait for 10us; 
        reset_s <= '0';
        micro_data_s <= '1';  
 end process;
   
clk_p: process 
    begin
       clk_12megas_s <= '0';
       wait for clk_period/2;  
       clk_12megas_s <= '1';
       wait for clk_period/2;  
end process;

end Behavioral;

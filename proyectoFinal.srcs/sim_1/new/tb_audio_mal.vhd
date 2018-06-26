----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19.06.2018 18:02:09
-- Design Name: 
-- Module Name: tb_audio_interface - Behavioral
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

entity tb_audio_mal is
end tb_audio_mal;

architecture Behavioral of tb_audio_mal is

component FSMD_microphone
    Port ( clk_12megas      : in STD_LOGIC;
           reset            : in STD_LOGIC;
           enable_4_cycles  : in STD_LOGIC;
           micro_data       : in STD_LOGIC;
           sample_out       : out STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_out_ready : out STD_LOGIC);
end component;

component en_4_cycles
    Port ( clk_12megas : in STD_LOGIC;
           reset       : in STD_LOGIC;
           clk_3megas  : out STD_LOGIC;
           en_2_cycles : out STD_LOGIC;
           en_4_cycles : out STD_LOGIC);
end component;

component pwm is
    Port ( clk_12megas      : in STD_LOGIC;
           reset            : in STD_LOGIC;
           en_2_cycles      : in STD_LOGIC;
           sample_in        : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_request   : out STD_LOGIC;
           pwm_pulse        : out STD_LOGIC);
end component;

signal clk_12megas_s      : STD_LOGIC;
signal reset_s            : STD_LOGIC := '1';
signal clk_3megas_s       : STD_LOGIC := '0';

signal en_4_cycles_s      : STD_LOGIC := '0';
signal en_2_cycles_s      : STD_LOGIC := '0';


signal record_enable_s    : STD_LOGIC := '0';
signal micro_LR_s         : STD_LOGIC := '1';
signal play_enable_s      : STD_LOGIC := '0';
signal jack_sd_s          : STD_LOGIC := '1';

signal micro_data_s       : STD_LOGIC;
signal sample_out_s       : STD_LOGIC_VECTOR(sample_size-1 downto 0);
signal sample_out_ready_s : STD_LOGIC;
signal sample_in_s        : STD_LOGIC_VECTOR(sample_size-1 downto 0);
signal sample_request_s   : STD_LOGIC;
signal pwm_pulse_s        : STD_LOGIC;

signal a                  : STD_LOGIC := '0';
signal b                  : STD_LOGIC := '0';
signal c                  : STD_LOGIC := '0';

constant clk_period       : time := 83 ns;

begin


UUT_FSMD: FSMD_microphone PORT MAP (
        clk_12megas      => clk_12megas_s,
        reset            => reset_s,
        enable_4_cycles  => en_4_cycles_s,
        micro_data       => micro_data_s,
        sample_out       => sample_out_s,
        sample_out_ready => sample_out_ready_s
);

UUT_en4:  en_4_cycles PORT MAP (
          clk_12megas => clk_12megas_s,
          reset       => reset_s,
          clk_3megas  => clk_3megas_s,
          en_2_cycles => en_2_cycles_s,
          en_4_cycles => en_4_cycles_s
   );
UUT_pwm: pwm PORT MAP (
              clk_12megas      => clk_12megas_s,
              reset            => reset_s,
              en_2_cycles      => en_2_cycles_s,
              sample_in        => sample_in_s,
              sample_request   => sample_request_s,
              pwm_pulse        => pwm_pulse_s
   );

reset_p: process
     begin  
        wait for 10ns; 
        reset_s <= '0';  
 end process;
   
clk_p:process  --generates a 12 MHz clock.
    begin
       clk_12megas_s <= '0';
       wait for clk_period/2;  
       clk_12megas_s <= '1';
       wait for clk_period/2;  
end process;

a_p: process
    begin
        wait for 700ns;
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
      --  record_enable <= '1'
        micro_data_s <= a xor b xor c;
        
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

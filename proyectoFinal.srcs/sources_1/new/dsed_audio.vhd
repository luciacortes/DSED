----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2018 03:28:28
-- Design Name: 
-- Module Name: dsed_audio - Behavioral
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

entity dsed_audio is
    Port ( clk_100Mhz : in STD_LOGIC;
           reset : in STD_LOGIC;
           BTNL : in STD_LOGIC;
           BTNC : in STD_LOGIC;
           BTNR : in STD_LOGIC;
           SW0 : in STD_LOGIC;
           SW1 : in STD_LOGIC;
           micro_clk : out STD_LOGIC;
           micro_data : in STD_LOGIC;
           micro_LR : out STD_LOGIC;
           jack_sd : out STD_LOGIC;
           jack_pwm : out STD_LOGIC);
end dsed_audio;

architecture Behavioral of dsed_audio is


component audio_interface is
    Port ( clk_12megas : in STD_LOGIC;
           reset : in STD_LOGIC;
           record_enable : in STD_LOGIC;
           sample_out : out STD_LOGIC_VECTOR(sample_size-1 downto 0); 
           sample_out_ready : out STD_LOGIC;
           micro_clk : out STD_LOGIC;
           micro_data : in STD_LOGIC;
           micro_LR : out STD_LOGIC;
           play_enable : in STD_LOGIC;
           sample_in : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_request : out STD_LOGIC;
           jack_sd : out STD_LOGIC;
           jack_pwm : out STD_LOGIC);
end component;
component control_placa is
     Port ( clk : in STD_LOGIC;
            BTNL : in STD_LOGIC;
            BTNC : in STD_LOGIC;
            BTNR : in STD_LOGIC;
            SW0,SW1 : in STD_LOGIC;
            reset : in STD_LOGIC;
            sample_in_fir : out signed(sample_size-1 downto 0);
            sample_in_enable_fir : out STD_LOGIC;
            filter_select_fir : out STD_LOGIC;
            sample_out_fir : in signed(sample_size-1 downto 0);
            sample_out_ready_fir : in STD_LOGIC;
            record_enable_ia : out STD_LOGIC;
            sample_out_ia : in STD_LOGIC_VECTOR(sample_size-1 downto 0); 
            sample_out_ready_ia : in STD_LOGIC;
            play_enable_ia : out STD_LOGIC;
            sample_in_ia : out STD_LOGIC_VECTOR(sample_size-1 downto 0);
            sample_request_ia : in STD_LOGIC;
            ena : out STD_LOGIC;
            wea : out STD_LOGIC_VECTOR(0 DOWNTO 0);
            addra : out STD_LOGIC_VECTOR(18 DOWNTO 0);
            dina : out STD_LOGIC_VECTOR(7 DOWNTO 0);
            douta : in STD_LOGIC_VECTOR(7 DOWNTO 0));
 end component;
component fir_filter is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           sample_in : in signed(sample_size-1 downto 0);
           sample_in_enable : in STD_LOGIC;
           filter_select : in STD_LOGIC;
           sample_out : out signed(sample_size-1 downto 0);
           sample_out_ready : out STD_LOGIC);
end component;

component blk_mem_gen_0 IS
  PORT (
    clka : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
  );
END component;

component clk_12M is
 port(
  clk_out1: OUT STD_LOGIC;
  reset:in STD_LOGIC;
  clk_in1:in STD_LOGIC
 );
 end component;

 

-- reloj
signal clk12M_s : STD_LOGIC := '0';
-- ram
signal ena_RAM_s : STD_LOGIC := '0';
signal wea_RAM_s : STD_LOGIC_VECTOR(0 DOWNTO 0) := "0";
signal addra_RAM_s : STD_LOGIC_VECTOR(18 DOWNTO 0) := "0000000000000000000";
signal dina_RAM_s, douta_RAM_s : STD_LOGIC_VECTOR(7 DOWNTO 0) := "00000000";
-- fir
signal entrada_fir_s, salida_fir_s : signed(sample_size-1 downto 0):="00000000";
signal entrada_en_fir_s, filter_select_s, salida_act_s : STD_LOGIC := '0';
-- audio
signal record_enable_s,sample_out_ready_s,play_enable_s,sample_request_s : STD_LOGIC := '0';
signal sample_out_ai_a,sample_in_ai_s : STD_LOGIC_VECTOR(sample_size-1 downto 0):="00000000"; 
begin

CLK12M:clk_12M port map(
    clk_out1 => clk12M_s,
    reset => reset,
    clk_in1 => clk_100Mhz
);
RAM :blk_mem_gen_0 port map(
    clka => clk_100Mhz,
    ena => ena_RAM_s,
    wea => wea_RAM_s,
    addra => addra_RAM_s,
    dina => dina_RAM_s,
    douta => douta_RAM_s
);
FIR:fir_filter port map(
    clk => clk_100Mhz,
    reset => reset,
    sample_in => entrada_fir_s,
    sample_in_enable => entrada_en_fir_s,
    filter_select => filter_select_s,
    sample_out => salida_fir_s,
    sample_out_ready => salida_act_s
);
AUDIO:audio_interface port map(
    clk_12megas => clk12M_s,
    reset => reset,
    record_enable => record_enable_s,
    sample_out => sample_out_ai_a,
    sample_out_ready => sample_out_ready_s,
    micro_clk => micro_clk,
    micro_data => micro_data,
    micro_LR => micro_LR,
    play_enable => play_enable_s,
    sample_in => sample_in_ai_s,
    sample_request => sample_request_s,
    jack_sd => jack_sd,
    jack_pwm => jack_pwm
);
CONTROL:control_placa port map(
    clk => clk_100Mhz,
    BTNL => BTNL,
    BTNC => BTNC,
    BTNR => BTNR,
    SW0 => SW0,
    SW1 => SW1,
    reset => reset,
    sample_in_fir => entrada_fir_s,
    sample_in_enable_fir => entrada_en_fir_s,
    filter_select_fir => filter_select_s,
    sample_out_fir => salida_fir_s,
    sample_out_ready_fir => salida_act_s,
    record_enable_ia => record_enable_s,
    sample_out_ia => sample_out_ai_a,
    sample_out_ready_ia => sample_out_ready_s,
    play_enable_ia => play_enable_s,
    sample_in_ia => sample_in_ai_s,
    sample_request_ia => sample_request_s,
    ena => ena_RAM_s,
    wea => wea_RAM_s,
    addra => addra_RAM_s,
    dina => dina_RAM_s,
    douta => douta_RAM_s
);
end Behavioral;

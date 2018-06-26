----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2018 03:28:28
-- Design Name: 
-- Module Name: controlador - Behavioral
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

entity controlador is
    Port ( clk_100Mhz   : in STD_LOGIC;
           reset        : in STD_LOGIC;
           micro_data   : in STD_LOGIC;
           micro_clk    : out STD_LOGIC;
           micro_LR     : out STD_LOGIC;
           jack_sd      : out STD_LOGIC;
           jack_pwm     : out STD_LOGIC);
end controlador;

architecture Behavioral of controlador is
component audio_interface is
    Port ( clk_12megas : in STD_LOGIC;
           reset            : in STD_LOGIC;
           record_enable    : in STD_LOGIC;
           sample_out       : out STD_LOGIC_VECTOR(sample_size-1 downto 0); 
           sample_out_ready : out STD_LOGIC;
           micro_clk        : out STD_LOGIC;
           micro_data       : in STD_LOGIC;
           micro_LR         : out STD_LOGIC;
           play_enable      : in STD_LOGIC;
           sample_in        : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_request   : out STD_LOGIC;
           jack_sd          : out STD_LOGIC;
           jack_pwm         : out STD_LOGIC);
end component;

component clk_12M is 
    Port(
        clk_out1    : out STD_LOGIC;-- Clock out ports
        reset       : in STD_LOGIC;-- Status and control signals
        clk_in1     : in STD_LOGIC ); -- Clock in ports
end component;

--component fir_filter is
--    Port ( clk : in STD_LOGIC;
--           reset : in STD_LOGIC;
--           sample_in : in signed(sample_size-1 downto 0);
--           sample_in_enable : in STD_LOGIC;
--           filter_select : in STD_LOGIC;
--           sample_out : out signed(sample_size-1 downto 0);
--           sample_out_ready : out STD_LOGIC);
--end component;


--component control_placa is
--    Port ( clk : in STD_LOGIC;
--           BTNL : in STD_LOGIC;
--           BTNC : in STD_LOGIC;
--           BTNR : in STD_LOGIC;
--           SW0,SW1 : in STD_LOGIC;
--           sample_in_fir : out signed(sample_size-1 downto 0);
--           sample_in_enable_fir : out STD_LOGIC;
--           filter_select_fir : out STD_LOGIC;
--           sample_out_fir : in signed(sample_size-1 downto 0);
--           sample_out_ready_fir : in STD_LOGIC;
--           record_enable_ia : in STD_LOGIC;
--           sample_out_ia : out STD_LOGIC_VECTOR(sample_size-1 downto 0); 
--           sample_out_ready_ia : out STD_LOGIC;
--           play_enable_ia : in STD_LOGIC;
--           sample_in_ia : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
--           sample_request_ia : out STD_LOGIC
--           );
--end component;

--component blk_mem_gen_0 IS
--  PORT (
--    clka : IN STD_LOGIC;
--    ena : IN STD_LOGIC;
--    wea : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
--    addra : IN STD_LOGIC_VECTOR(18 DOWNTO 0);
--    dina : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
--    douta : OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
--  );
--END component;


signal clk_12megas_s, sample_out_ready_s, sample_request_s : STD_LOGIC :='0';
signal sample_mid_s : STD_LOGIC_VECTOR(sample_size-1 downto 0);

--signal ena_RAM : STD_LOGIC := '0';
--signal  wea_s : STD_LOGIC_VECTOR(0 DOWNTO 0) := "0";
--signal addra_s :  STD_LOGIC_VECTOR(18 DOWNTO 0) := "0000000000000000000";
--signal dina_s, douta_s :  STD_LOGIC_VECTOR(7 DOWNTO 0) := "0000000";

begin

CLK12MHz: clk_12M port map(
    clk_out1   => clk_12megas_s,
    reset      => reset,
    clk_in1    => clk_100Mhz
);
InterfazAudio:audio_interface port map(
    clk_12megas         => clk_12megas_s,
    reset               => reset,
    record_enable       => record_enable_p,
    sample_out          => sample_mid_s,
    sample_out_ready    => sample_out_ready_s,
    micro_clk           => micro_clk,
    micro_data          => micro_data,
    micro_LR            => micro_LR,
    play_enable         => play_enable_p,
    sample_in           => sample_mid_s,
    sample_request      => sample_request_s,
    jack_sd             => jack_sd,
    jack_pwm            => jack_pwm
);

--FIR: fir_filter Port Map(
--    clk => clk_100Mhz,
--    reset => reset,
--    sample_in => sample_out_s,
--    sample_in_enable => sample_out_ready_s,
--    filter_select => ,
--    sample_out => ,
--    sample_out_ready => 
--);


--RAM: blk_mem_gen_0 Port Map(
 --   clka => clk_100Mhz,
 --   ena => ena_RAM,
  --  wea => wea_s,
 --   addra => addra_s,
 --   dina => dina_s,
 --   douta => douta_s
--);

--CONTROL : control_placa port map();

--end process;
end Behavioral;

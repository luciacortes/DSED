----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2018 03:28:28
-- Design Name: 
-- Module Name: audio_interface - Behavioral
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

entity audio_interface is
    Port ( clk_12megas :      in STD_LOGIC;        --reloj global
           reset :            in STD_LOGIC;        --reset global
          --GRABAR
          --del controlador
           record_enable :    in STD_LOGIC;        --booleano que indica si está grabando
           sample_out :       out STD_LOGIC_VECTOR(sample_size-1 downto 0); --dato de 8 bits cogido del microfono
           sample_out_ready : out STD_LOGIC;       --señal de control que da un pulso de duranción un pulso de reloj cada vez que se digitaliza un dato
          --del microfono
           micro_clk :        out STD_LOGIC;       --salida del reloj del microfono(3MHz)
           micro_data :       in STD_LOGIC;        --señal PDM del microfono
           micro_LR :         out STD_LOGIC;       --salida del microfono que dice si se toman las muetsras en el flanco de subida o de bajada (nosotros a 1)
          --REPRODUCIR
          --del controlador
           play_enable :      in STD_LOGIC;        --booleano para decir que se va a reproducir
           sample_in :        in STD_LOGIC_VECTOR(sample_size-1 downto 0);  --dato de 8 bits de la señal a reproducir
           sample_request :   out STD_LOGIC;       --señal de control que indica cuando se necesita un dato de sample_in
           --del jack
           jack_sd :          out STD_LOGIC;       --esto a 1
           jack_pwm :         out STD_LOGIC);      --señal PWM generada a partir de sample in
end audio_interface;

architecture Behavioral of audio_interface is

component en_4_cycles is
    Port ( clk_12megas :  in STD_LOGIC;
           reset :        in STD_LOGIC; 
           clk_3megas :  out STD_LOGIC; --salida para el microfono
           en_2_cycles : out STD_LOGIC; --señal equivalente a 6MHz para la interfaz de salida
           en_4_cycles : out STD_LOGIC);--señal activa 1 ciclo de cada 4.
end component;

component FSMD_microphone is
    Port ( clk_12megas : in STD_LOGIC;
           reset :             in STD_LOGIC;
           enable_4_cycles :   in STD_LOGIC;
           micro_data :        in STD_LOGIC;
           sample_out :       out STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_out_ready : out STD_LOGIC);
end component;

component pwm is
    Port ( clk_12megas :     in STD_LOGIC;
           reset :           in STD_LOGIC;
           en_2_cycles :     in STD_LOGIC;
           sample_in :       in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_request : out STD_LOGIC;
           pwm_pulse :      out STD_LOGIC);
end component;
SIGNAL en_4_cycles_s,en_2_cycles_s,clk_3megas_s, en_4_s, en_2_s : STD_LOGIC:='0';
--SIGNAL sample_s : STD_LOGIC_VECTOR(sample_size-1 downto 0):= "00000000";
begin
Enables: en_4_cycles port map (
    clk_12megas => clk_12megas,
    reset => reset,
    clk_3megas => clk_3megas_s,
    en_2_cycles => en_2_cycles_s,
    en_4_cycles => en_4_cycles_s
);
Microfono: FSMD_microphone port map (
    clk_12megas => clk_12megas,
    reset => reset,
    enable_4_cycles => en_4_cycles_s,
    micro_data => micro_data,
    sample_out => sample_out,
    sample_out_ready => sample_out_ready
);
Sonido: pwm port map (
    clk_12megas => clk_12megas,    
    reset => reset,
    en_2_cycles => en_2_cycles_s,
    sample_in => sample_in,
    sample_request => sample_request,
    pwm_pulse =>jack_pwm
);
en_4_s <= (en_4_cycles_s and record_enable);
en_2_s <= (en_2_cycles_s and play_enable);
micro_clk <= clk_3megas_s;
jack_sd <= '1';
micro_LR <= '1';
end Behavioral;

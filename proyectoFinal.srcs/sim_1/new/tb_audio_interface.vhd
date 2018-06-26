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

entity tb_audio_interface is
end tb_audio_interface;

architecture Behavioral of tb_audio_interface is

component audio_interface
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
end component;

signal clk_12megas_s :       STD_LOGIC;        
signal reset_s :             STD_LOGIC;       
signal record_enable_s :     STD_LOGIC := '0';      
signal sample_out_s :        STD_LOGIC_VECTOR(sample_size-1 downto 0); 
signal sample_out_ready_s :  STD_LOGIC;       
signal micro_clk_s :         STD_LOGIC;       
signal micro_data_s :        STD_LOGIC;        
signal micro_LR_s :          STD_LOGIC := '1';      
signal play_enable_s :       STD_LOGIC := '0';       
signal sample_in_s :         STD_LOGIC_VECTOR(sample_size-1 downto 0);  
signal sample_request_s :    STD_LOGIC;       
signal jack_sd_s :           STD_LOGIC := '1';       
signal jack_pwm_s :          STD_LOGIC;
signal a                  : STD_LOGIC := '0';
signal b                  : STD_LOGIC := '0';
signal c                  : STD_LOGIC := '0';
constant clk_period : time := 83 ns;

begin

UUT_audio_if: audio_interface port map (
    clk_12megas => clk_12megas_s,     
    reset=> reset_s,       
    record_enable=> record_enable_s,     
    sample_out=> sample_out_s,       
    sample_out_ready=>sample_out_ready_s,  
    micro_clk=>micro_clk_s,       
    micro_data=>micro_data_s,       
    micro_LR=> micro_LR_s,         
    play_enable=>play_enable_s,      
    sample_in=> sample_in_s,        
    sample_request =>sample_request_s,    
    jack_sd=> jack_sd_s,           
    jack_pwm =>jack_pwm_s);

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
   --record_enable_s <= '1';
 end process;


enables_p: process
begin
   wait for 25us;
   record_enable_s <= '1';
   wait for 500us;
   record_enable_s <= '0'; 
   play_enable_s <= '1'; 
   wait for 500us;
   play_enable_s <= '0';
end process;



end Behavioral;
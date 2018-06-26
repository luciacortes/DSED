----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.01.2018 22:50:22
-- Design Name: 
-- Module Name: controlador_fir - Behavioral
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

entity controlador_fir is
    Port ( clk : in std_logic;
           filter_select : in STD_LOGIC;
           sample_in_enable : in STD_LOGIC;
           m1,m2,m5,m6 : out std_logic;
           m3,m4 : out std_logic_vector(1 downto 0);
           en1,en2,en3 : out std_logic;
           c0,c1,c2,c3,c4 : out std_logic_vector(sample_size-1 downto 0);
           sample_out_ready : out STD_LOGIC);
end controlador_fir;

architecture Behavioral of controlador_fir is
type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8);
signal state, next_state : state_type:= S0; 
begin
SYNC_PROC : process (clk) 
begin
if rising_edge(clk) then
    state <= next_state;
end if;
end process;

OUTPUT_DECODE : process (state)
begin 

case (state) is
    when S0 =>
       m1<='0';
       m2<='0';
       m3<="00";
       m4<="00";
       m5<='1';
       m6<='0';
       en1<='0';
       en2<='0';
       en3<='0';
       sample_out_ready<='0';
    when S1 =>
       m1<='0';
       m2<='0';
       m3<="00";
       m4<="00";
       m5<='1';
       m6<='0';
       en1<='0';
       en2<='0';
       en3<='0';
       sample_out_ready<='0';
    when S2 =>
       m1<='0';
       m2<='0';
       m3<="00";
       m4<="00";
       m5<='1';
       m6<='0';
       en1<='1';
       en2<='1';
       en3<='0';
       sample_out_ready<='0';
    when S3 =>
       m1<='1';
       m2<='1';
       m3<="01";
       m4<="01";
       m5<='1';
       m6<='0';
       en1<='0';
       en2<='0';
       en3<='0';
       sample_out_ready<='0';
    when S4 =>
       m1<='1';
       m2<='1';
       m3<="01";
       m4<="01";
       m5<='1';
       m6<='0';
       en1<='1';
       en2<='1';
       en3<='1';
       sample_out_ready<='0';
    when S5 =>
       m1<='0';
       m2<='0';
       m3<="10";
       m4<="10";
       m5<='0';
       m6<='0';
       en1<='0';
       en2<='0';
       en3<='0';
       sample_out_ready<='0';
    when S6 =>
       m1<='0';
       m2<='0';
       m3<="10";
       m4<="10";
       m5<='0';
       m6<='0';
       en1<='1';
       en2<='1';
       en3<='1';
       sample_out_ready<='0';
   when S7 =>
       m1<='0';
       m2<='0';
       m3<="11";
       m4<="11";
       m5<='0';
       m6<='1';
       en1<='1';
       en2<='1';
       en3<='0';  
       sample_out_ready<='0'; 
   when S8 =>
       m1<='0';
       m2<='0';
       m3<="11";
       m4<="11";
       m5<='0';
       m6<='0';
       en1<='0';
       en2<='0';
       en3<='1'; 
       sample_out_ready<='1';
   when others =>
       
end case;
end process;
NEXT_STATE_DECODE : process (state,sample_in_enable,filter_select)
begin

    case (state) is
        when S0 =>
            if(filter_select='0')then
                c0<= c0_b;
                c1<= c1_b;
                c2<= c2_b;
                c3<= c3_b;
                c4<= c4_b;
            else
                c0<= c0_a;
                c1<= c1_a;
                c2<= c2_a;
                c3<= c3_a;
                c4<= c4_a;
            end if;
            if(sample_in_enable='1')then
                next_state <= S1;
            end if;        
        when S1 =>
                next_state <= S2;
        when S2 =>
                next_state <= S3;
        when S3 =>
                next_state <= S4;
        when S4 =>
                next_state <= S5;
        when S5 =>
                next_state <= S6;
        when S6 =>
                next_state <= S7;
        when S7 =>
                next_state <= S8;
        when S8 =>
                next_state <= S0;        
        when others =>
            next_state <= S0;
end case;
end process;
end Behavioral;

----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11.01.2018 19:46:39
-- Design Name: 
-- Module Name: control_placa - Behavioral
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

entity control_placa is
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
end control_placa;

architecture Behavioral of control_placa is

type state_type is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10,S11, S12);
signal state, next_state : state_type:= S0; 
signal puntero_fin, puntero : unsigned(18 DOWNTO 0):="0000000000000000000";
begin

SYNC_PROC : process (clk,reset) 
begin
if rising_edge(clk) then
    if reset = '1' then
        state <= S0;
        next_state <= S0;
        sample_in_fir <= "00000000";
        sample_in_enable_fir <= '0';
        filter_select_fir <= '0';
        record_enable_ia <= '0';
        play_enable_ia <= '0';
        sample_in_ia <= "00000000";
        ena <= '0';
        wea <= "0";
        addra <= "0000000000000000000";
        dina <= "00000000";
        puntero_fin <= "0000000000000000000";
    else
        state <= next_state;
    end if;
end if;
end process;
OUTPUT_DECODE : process (state)
begin 

case (state) is
    when S0 =>
       sample_in_fir <= "00000000";
       sample_in_enable_fir <= '0';
       filter_select_fir <= '0';
       record_enable_ia <= '0';
       play_enable_ia <= '0';
       sample_in_ia <= "00000000";
       ena <= '0';
       addra <= "0000000000000000000";
       dina <= "00000000";  
    when S1 =>
       puntero_fin <= "0000000000000000000";
    when S2 =>
       record_enable_ia <= '1';
       wea <= "1";
       ena <= '0';
    when S3 =>
       play_enable_ia <= '1';
    when S4 =>
       play_enable_ia <= '1';
    when S5 =>
       filter_select_fir <= '0';
    when S6 =>
       filter_select_fir <= '1';
    when S7 =>
        ena <= '1';
        dina <= sample_out_ia;
        addra <= std_logic_vector(puntero_fin);
        puntero_fin <= puntero_fin + 1;
    when S8 =>
       wea <= "0";
       ena <= '1';
       addra <= std_logic_vector(puntero);
       play_enable_ia <= '1';
       sample_in_ia <= douta;
       puntero <= puntero + 1;
    when S9 =>
       wea <= "0";
       ena <= '1';
       addra <= std_logic_vector(puntero-1);
       play_enable_ia <= '1';
       sample_in_ia <= douta;
       puntero <= puntero - 1;
    when S10 =>
       wea <= "0";
       ena <= '1';
       addra <= std_logic_vector(puntero);
       --play_enable_ia <= '0';
       sample_in_fir <= signed(douta);
       sample_in_enable_fir <= '1';
       --puntero <= puntero + 1;
    when S11 =>
       ena <= '0';
       play_enable_ia <= '1';
    when S12 =>
       sample_in_ia <= std_logic_vector(sample_out_fir);
       puntero <= puntero + 1;
   when others =>
       
end case;
end process;
NEXT_STATE_DECODE : process (state,BTNC,BTNL,BTNR,SW0,SW1,sample_out_ready_ia,puntero,sample_out_ready_fir,sample_request_ia)
begin

    case (state) is
        when S0 =>
            if (BTNC = '1') then
                next_state <= S1; 
            elsif(BTNL='1') then
                next_state <= S2;
            elsif(BTNR ='1') then
                if ( SW0 = '0' and SW1 = '0')then
                    puntero <= "0000000000000000000";
                    next_state <= S3;
                elsif ( SW0 = '1' and SW1 = '0')then
                    puntero <= puntero_fin+1;
                    next_state <= S4;
                elsif ( SW0 = '0' and SW1 = '1')then
                    puntero <= "0000000000000000000";
                    next_state <= S5;
                elsif ( SW0 = '1' and SW1 = '1')then
                    puntero <= "0000000000000000000";
                    next_state <= S6;
                end if;
            else
                next_state <= S0;
            end if;
             
        when S1 =>
           next_state <= S0;
        when S2 =>
            if sample_out_ready_ia = '1' then
                next_state <= S7;
            else 
                next_state <= S2;
            end if;
        when S3 =>
            if sample_request_ia = '1' then
                next_state <= S8;
            else
                next_state <= S3;
            end if;
        when S4 =>
            if sample_request_ia = '1' then
                next_state <= S9;
            else
                next_state <= S4;
            end if;
        when S5 =>
            next_state <= S10;
        when S6 =>
            next_state <= S10;
        when S7 =>
            if(BTNL='1')then
                next_state <= S2;
            else
                next_state <= S0;
            end if;
        when S8 =>
            if puntero < puntero_fin then
                next_state <= S3;
            else
                next_state <= S0;
            end if;
        when S9 =>
            if puntero = "0000000000000000000" then
                next_state <= S0;
            else 
                next_state <= S4; 
            end if;
        when S10 =>
            if (sample_out_ready_fir = '1')then
                next_state <= S11;
            else
                next_state <= S10;
            end if;
        when S11 =>
            if (sample_request_ia = '1') then
                next_state <= S12;
            else
                next_state <= S11;
            end if;
        when S12 =>
            if puntero < puntero_fin then
                next_state <= S10;
            else
                next_state <= S0;
            end if;
        when others =>
            next_state <= S0;
end case;
end process;
end Behavioral;

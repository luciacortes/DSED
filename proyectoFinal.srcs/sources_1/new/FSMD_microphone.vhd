----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2018 03:28:28
-- Design Name: 
-- Module Name: FSMD_microphone - Behavioral
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

entity FSMD_microphone is
    Port ( clk_12megas      : in STD_LOGIC;
           reset            : in STD_LOGIC;
           enable_4_cycles  : in STD_LOGIC;
           micro_data       : in STD_LOGIC;
           sample_out       : out STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_out_ready : out STD_LOGIC);
end FSMD_microphone;

architecture Behavioral of FSMD_microphone is

    type state_type is (S1, S2, S3, S4);
    
    signal state, next_state : state_type; 
    signal primer_ciclo      : std_logic:='0';
    signal dato1      : std_logic_vector(sample_size-1 downto 0) := (others=>'0');
    signal dato2      : std_logic_vector(sample_size-1 downto 0) := (others=>'0');
    signal cuenta            : std_logic_vector(8 downto 0) := (others=>'0');
    
    begin
    
    SYNC_PROC : process (clk_12megas, reset) 
        begin        
            if rising_edge(clk_12megas) then
                if (reset = '1') then                   
                    cuenta <= (others=>'0');
                    primer_ciclo <= '0';
                    state <= S1;
                    sample_out <= "00000000";
                    --sample_out_ready <= '0';
                else
                    cuenta <= std_logic_vector(unsigned(cuenta) + 1);
                    state <= next_state;
                    if unsigned(cuenta)=300 then
                        cuenta <= (others=>'0');
                    end if; 
                end if;
            end if;
    end process;
    
    OUTPUT_DECODE : process (state, micro_data)    
        begin             
            case (state) is
--                when S0 =>
--                   sample_out_ready <= '0';
--                   dato1 <= (others=>'0');
--                   dato2 <= (others=>'0');
--                   sample_out <= "00000000";
                   
                when S1 =>
                   if(micro_data = '1') then
                        dato1 <= std_logic_vector(unsigned(dato1) + 1);
                        dato2 <= std_logic_vector(unsigned(dato2) + 1);
                   end if;
                   
                when S2 =>
                   if(micro_data = '1') then
                        dato1 <=  std_logic_vector(unsigned(dato1) + 1);
                        dato2 <= dato2;
                   end if;                   
                   if (primer_ciclo = '1' and unsigned(cuenta) = 107) then
                        sample_out <= dato2;
                        dato2 <= (others=>'0');
                        sample_out_ready <= enable_4_cycles;
                   else 
                        sample_out_ready <= '0';
                   end if;
                    
                when S3 =>
                    if(micro_data = '1') then
                        dato1 <= std_logic_vector(unsigned(dato1) + 1);
                        dato2 <= std_logic_vector(unsigned(dato2) + 1);
                    end if;
                    
                when S4 =>
                    if(micro_data = '1') then
                        dato1 <= std_logic_vector(unsigned(dato1) + 1);
                    end if;
                     if ( unsigned(cuenta) = 257 ) then
                         sample_out <= dato1;
                         dato1 <= (others=>'0');
                         sample_out_ready <= enable_4_cycles;
                    else 
                         sample_out_ready <= '0';
                    end if;
                 
                 when others =>
                   
            end case;
    end process;
    
    NEXT_STATE_DECODE : process (state, cuenta)
    begin    
        case (state) is
--            when S0 =>
--                next_state <= S1; 
                             
            when S1 =>
                if (unsigned(cuenta) < 106) then
                    next_state <= S1;
                else 
                    next_state <= S2;
                end if;
                
            when S2 =>
               if (unsigned(cuenta) < 150) then
                    next_state <= S2;
                else 
                    next_state <= S3;
                end if;
                
            when S3 =>
                if (unsigned(cuenta) < 256) then
                    next_state <= S3;
                else 
                    next_state <= S4;
                end if;
                
            when S4 =>
                if (unsigned(cuenta) < 300) then
                   next_state <= S4;
                else 
                   next_state <= S1;
                end if;
            when others =>
                next_state <= S1;
        end case;
    end process;
end Behavioral;

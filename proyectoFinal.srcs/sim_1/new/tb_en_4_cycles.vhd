--FUNCIONA PERO NO ESTÁ BIEN EL RESULTADO

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity tb_en_4_cycles is
end tb_en_4_cycles;

architecture Behavioral of tb_en_4_cycles is

component en_4_cycles
    Port ( clk_12megas : in STD_LOGIC;
           reset       : in STD_LOGIC;
           clk_3megas  : out STD_LOGIC;
           en_2_cycles : out STD_LOGIC;
           en_4_cycles : out STD_LOGIC);
end component;

signal clk_12megas_s  : STD_LOGIC;
signal reset_s        : STD_LOGIC := '1';
signal clk_3megas_s   : STD_LOGIC;
signal en_2_cycles_s  : STD_LOGIC;
signal en_4_cycle_s   : STD_LOGIC;
constant clk_period   : time := 83 ns;

begin
UUT:  en_4_cycles PORT MAP (
          clk_12megas => clk_12megas_s,
          reset       => reset_s,
          clk_3megas  => clk_3megas_s,
          en_2_cycles => en_2_cycles_s,
          en_4_cycles => en_4_cycle_s
   );
   
reset_p: process
       begin       
           wait for 10ns; 
           reset_s <= '0';       
   end process;
   
clock_p: process  
        begin
           clk_12megas_s <= '0';
           wait for clk_period/2;  
           clk_12megas_s <= '1';
           wait for clk_period/2;  
    end process;

end Behavioral;
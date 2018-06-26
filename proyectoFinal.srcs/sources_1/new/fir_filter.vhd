----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.01.2018 03:28:28
-- Design Name: 
-- Module Name: fir_filter - Behavioral
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

entity fir_filter is
    Port ( clk              : in STD_LOGIC;
           reset            : in STD_LOGIC;
           sample_in        : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_in_enable : in STD_LOGIC;
           filter_select    : in STD_LOGIC;
           sample_out       : out STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_out_ready : out STD_LOGIC);
end fir_filter;

architecture Behavioral of fir_filter is
component mul is
    Port ( a : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           b : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           y : out STD_LOGIC_VECTOR(sample_size-1 downto 0));
end component;
component mux2 is
    Port ( a : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           b : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           M : in std_logic;
           y : out STD_LOGIC_VECTOR(sample_size-1 downto 0));
end component;
component mux3 is
    Port ( a : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           b : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           c : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           M : in std_logic_vector (1 downto 0);
           y : out STD_LOGIC_VECTOR(sample_size-1 downto 0));
end component;
component reg is
    Port ( clk : in std_logic;
           en  : in std_logic;
           x   : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           y   : out STD_LOGIC_VECTOR(sample_size-1 downto 0));
end component;
component suma is
    Port ( a : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           b : in STD_LOGIC_VECTOR(sample_size-1 downto 0);
           y : out STD_LOGIC_VECTOR(sample_size-1 downto 0));
end component;
component controlador_fir is
    Port(  clk : in std_logic;
           filter_select    : in STD_LOGIC;
           sample_in_enable : in STD_LOGIC;
           m1,m2,m5,m6      : out std_logic;
           m3,m4            : out std_logic_vector(1 downto 0);
           en1,en2,en3      : out std_logic;
           c0,c1,c2,c3,c4   : out STD_LOGIC_VECTOR(sample_size-1 downto 0);
           sample_out_ready : out STD_LOGIC
           );
end component;

signal x1, x2, x3, x4 : STD_LOGIC_VECTOR(sample_size-1 downto 0);
signal c0_s, c1_s, c2_s, c3_s, c4_s : STD_LOGIC_VECTOR(sample_size-1 downto 0);
signal  m1_s,m2_s,m5_s,m6_s : std_logic;
signal m3_s,m4_s :  std_logic_vector(1 downto 0);
signal a1_s, a2_s, a3_s,a4_s, a5_s, a6_s, a7_s, a8_s, a9_s , a10_s, a11_s, a12_s: STD_LOGIC_VECTOR(sample_size-1 downto 0);
signal  en1_s,en2_s,en3_s : std_logic;
begin

M1: mux2 port map(
    a => c0_s,
    b => c2_s,
    M => m1_s,
    y => a1_s
);
M2: mux2 port map(
    a => sample_in,
    b => x2,
    M => m1_s,
    y => a2_s
);
M3: mux3 port map(
    a => c1_s,
    b => c3_s,
    c => c4_s,
    M => m3_s,
    y => a3_s
);
M4: mux3 port map(
    a => x1,
    b => x3,
    c => x4,
    M => m4_s,
    y => a4_s
);
mul1: mul port map(
    a => a1_s,
    b => a2_s,
    y => a5_s
);
mul2: mul port map(
    a => a3_s,
    b => a4_s,
    y => a6_s
);
M5: mux2 port map(
    a => a11_s,
    b => a5_s,
    M => m5_s,
    y => a7_s
);
R1: reg port map(
    clk => clk,
    en  => en1_s,
    x   => a7_s,
    y   => a8_s
);
R2: reg port map(
    clk => clk,
    en  => en2_s,
    x   => a6_s,
    y   => a9_s
);
M6: mux2 port map(
    a => a9_s,
    b => a12_s,
    M => m6_s,
    y => a10_s
);
sum1: suma port map(
    a => a8_s,
    b => a10_s,
    y => a11_s
);
R3: reg port map(
    clk => clk,
    en  => en3_s,
    x   => a11_s,
    y   => a12_s
);
control: controlador_fir port map (
    clk              => clk,
    filter_select    => filter_select,
    sample_in_enable => sample_in_enable,
    m1               => m1_s,
    m2               => m2_s,
    m5               => m5_s,
    m6               => m6_s,
    m3               => m3_s,
    m4               => m4_s,
    en1              => en1_s,
    en2              => en2_s,
    en3              => en3_s,
    c0               => c0_s,
    c1               => c1_s,
    c2               => c2_s,
    c3               => c3_s,
    c4               => c4_s,
    sample_out_ready => sample_out_ready
);

sample_out <= a12_s;

end Behavioral;

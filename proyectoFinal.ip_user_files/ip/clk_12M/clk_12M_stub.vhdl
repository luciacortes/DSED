-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
-- Date        : Sat Jan  6 18:22:59 2018
-- Host        : Alonso-PC running 64-bit Service Pack 1  (build 7601)
-- Command     : write_vhdl -force -mode synth_stub
--               g:/DSED/proyectoFinal/proyectoFinal/proyectoFinal.srcs/sources_1/ip/clk_12M/clk_12M_stub.vhdl
-- Design      : clk_12M
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a100tcsg324-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity clk_12M is
  Port ( 
    clk_out1 : out STD_LOGIC;
    reset : in STD_LOGIC;
    clk_in1 : in STD_LOGIC
  );

end clk_12M;

architecture stub of clk_12M is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clk_out1,reset,clk_in1";
begin
end;

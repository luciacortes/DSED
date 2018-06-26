// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.2 (win64) Build 1909853 Thu Jun 15 18:39:09 MDT 2017
// Date        : Sat Jan  6 18:22:59 2018
// Host        : Alonso-PC running 64-bit Service Pack 1  (build 7601)
// Command     : write_verilog -force -mode synth_stub
//               g:/DSED/proyectoFinal/proyectoFinal/proyectoFinal.srcs/sources_1/ip/clk_12M/clk_12M_stub.v
// Design      : clk_12M
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a100tcsg324-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module clk_12M(clk_out1, reset, clk_in1)
/* synthesis syn_black_box black_box_pad_pin="clk_out1,reset,clk_in1" */;
  output clk_out1;
  input reset;
  input clk_in1;
endmodule

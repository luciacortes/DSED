-makelib ies/xil_defaultlib -sv \
  "D:/Programas/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "D:/Programas/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib ies/xpm \
  "D:/Programas/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib ies/xil_defaultlib \
  "../../../../proyectoFinal.srcs/sources_1/ip/clk_12M/clk_12M_sim_netlist.vhdl" \
-endlib
-makelib ies/xil_defaultlib \
  glbl.v
-endlib


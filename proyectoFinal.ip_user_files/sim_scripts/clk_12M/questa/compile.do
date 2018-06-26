vlib work
vlib msim

vlib msim/xil_defaultlib
vlib msim/xpm

vmap xil_defaultlib msim/xil_defaultlib
vmap xpm msim/xpm

vlog -work xil_defaultlib -64 -sv "+incdir+../../../../proyectoFinal.srcs/sources_1/ip/clk_12M" "+incdir+../../../../proyectoFinal.srcs/sources_1/ip/clk_12M" \
"D:/Programas/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Programas/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93 \
"D:/Programas/Xilinx/Vivado/2017.2/data/ip/xpm/xpm_VCOMP.vhd" \

vcom -work xil_defaultlib -64 -93 \
"../../../../proyectoFinal.srcs/sources_1/ip/clk_12M/clk_12M_sim_netlist.vhdl" \

vlog -work xil_defaultlib \
"glbl.v"


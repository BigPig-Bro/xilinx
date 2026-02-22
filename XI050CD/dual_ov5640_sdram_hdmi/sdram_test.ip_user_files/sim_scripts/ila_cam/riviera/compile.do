transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

vlib work
vlib riviera/xpm
vlib riviera/xil_defaultlib

vmap xpm riviera/xpm
vmap xil_defaultlib riviera/xil_defaultlib

vlog -work xpm  -incr "+incdir+../../../../sdram_test.gen/sources_1/ip/ila_cam/hdl/verilog" -l xpm -l xil_defaultlib \
"D:/Xilinx20242/Vivado/2024.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"D:/Xilinx20242/Vivado/2024.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93  -incr \
"D:/Xilinx20242/Vivado/2024.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -incr -v2k5 "+incdir+../../../../sdram_test.gen/sources_1/ip/ila_cam/hdl/verilog" -l xpm -l xil_defaultlib \
"../../../../sdram_test.gen/sources_1/ip/ila_cam/sim/ila_cam.v" \

vlog -work xil_defaultlib \
"glbl.v"


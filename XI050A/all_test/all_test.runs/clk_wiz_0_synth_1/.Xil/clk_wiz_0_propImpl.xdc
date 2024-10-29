set_property SRC_FILE_INFO {cfile:e:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050A/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc rfile:../../../all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc id:1 order:EARLY scoped_inst:inst} [current_design]
current_instance inst
set_property src_info {type:SCOPED_XDC file:1 line:54 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1]] 0.400

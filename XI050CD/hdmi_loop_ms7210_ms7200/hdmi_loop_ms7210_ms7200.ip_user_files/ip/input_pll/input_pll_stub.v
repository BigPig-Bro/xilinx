// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
// Date        : Sat Sep 13 12:22:57 2025
// Host        : DESKTOP-9MNJBAS running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/hdmi_loop_ms7210_ms7200/hdmi_loop_ms7210_ms7200.gen/sources_1/ip/input_pll/input_pll_stub.v
// Design      : input_pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a50tfgg484-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* CORE_GENERATION_INFO = "input_pll,clk_wiz_v6_0_15_0_0,{component_name=input_pll,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,enable_axi=0,feedback_source=FDBK_AUTO,PRIMITIVE=MMCM,num_out_clk=1,clkin1_period=40.000,clkin2_period=10.0,use_power_down=false,use_reset=false,use_locked=false,use_inclk_stopped=false,feedback_type=SINGLE,CLOCK_MGR_TYPE=NA,manual_override=false}" *) 
module input_pll(c0, inclk0)
/* synthesis syn_black_box black_box_pad_pin="inclk0" */
/* synthesis syn_force_seq_prim="c0" */;
  output c0 /* synthesis syn_isclock = 1 */;
  input inclk0;
endmodule

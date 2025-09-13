-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- Copyright 2022-2024 Advanced Micro Devices, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2024.2 (win64) Build 5239630 Fri Nov 08 22:35:27 MST 2024
-- Date        : Sat Sep 13 12:22:57 2025
-- Host        : DESKTOP-9MNJBAS running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/hdmi_loop_ms7210_ms7200/hdmi_loop_ms7210_ms7200.gen/sources_1/ip/sys_pll/sys_pll_stub.vhdl
-- Design      : sys_pll
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a50tfgg484-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity sys_pll is
  Port ( 
    c0 : out STD_LOGIC;
    locked : out STD_LOGIC;
    inclk0 : in STD_LOGIC
  );

  attribute CORE_GENERATION_INFO : string;
  attribute CORE_GENERATION_INFO of sys_pll : entity is "sys_pll,clk_wiz_v6_0_15_0_0,{component_name=sys_pll,use_phase_alignment=true,use_min_o_jitter=false,use_max_i_jitter=false,use_dyn_phase_shift=false,use_inclk_switchover=false,use_dyn_reconfig=false,enable_axi=0,feedback_source=FDBK_AUTO,PRIMITIVE=MMCM,num_out_clk=1,clkin1_period=40.000,clkin2_period=10.0,use_power_down=false,use_reset=false,use_locked=true,use_inclk_stopped=false,feedback_type=SINGLE,CLOCK_MGR_TYPE=NA,manual_override=false}";
end sys_pll;

architecture stub of sys_pll is
  attribute syn_black_box : boolean;
  attribute black_box_pad_pin : string;
  attribute syn_black_box of stub : architecture is true;
  attribute black_box_pad_pin of stub : architecture is "c0,locked,inclk0";
begin
end;

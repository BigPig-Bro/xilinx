
s
Sourcing tcl script '%s'
201*common26
4D:/Xilinx20241/Vivado/2024.1/scripts/Vivado_init.tclZ17-201h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
create_project: 2

00:00:062

00:00:062	
531.3092	
202.676Z17-268h px� 
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.srcs/utils_1/imports/synth_1/top.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2c
aE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.srcs/utils_1/imports/synth_1/top.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
_
Command: %s
53*	vivadotcl2.
,synth_design -top top -part xc7k325tffg676-2Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
{
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2

xc7k325tZ17-347h px� 
k
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2

xc7k325tZ17-349h px� 
E
Loading part %s157*device2
xc7k325tffg676-2Z21-403h px� 
[
$Part: %s does not have CEAM library.966*device2
xc7k325tffg676-2Z21-9227h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
4Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
20712Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1459.195 ; gain = 448.367
h px� 
�
synthesizing module '%s'%s4497*oasys2
top2
 2B
>E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/top.sv2
18@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
hdmi_colorbar_top2
 2T
PE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/hdmi_colorbar_top.v2
238@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
	clk_wiz_02
 2�
�E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.runs/synth_1/.Xil/Vivado-111124-DESKTOP-9MNJBAS/realtime/clk_wiz_0_stub.v2
68@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	clk_wiz_02
 2
02
12�
�E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.runs/synth_1/.Xil/Vivado-111124-DESKTOP-9MNJBAS/realtime/clk_wiz_0_stub.v2
68@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
video_driver2
 2O
KE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/video_driver.v2
248@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
video_driver2
 2
02
12O
KE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/video_driver.v2
248@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
video_display2
 2P
LE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/video_display.v2
238@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
video_display2
 2
02
12P
LE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/video_display.v2
238@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
dvi_transmitter_top2
 2V
RE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/dvi_transmitter_top.v2
238@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
asyn_rst_syn2
 2O
KE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/asyn_rst_syn.v2
238@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
asyn_rst_syn2
 2
02
12O
KE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/asyn_rst_syn.v2
238@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
dvi_encoder2
 2N
JE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/dvi_encoder.v2
218@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
dvi_encoder2
 2
02
12N
JE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/dvi_encoder.v2
218@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
serializer_10_to_12
 2U
QE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/serializer_10_to_1.v2
258@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
	OSERDESE22
 2>
:D:/Xilinx20241/Vivado/2024.1/scripts/rt/data/unisim_comp.v2

1007098@Z8-6157h px� 
P
%s
*synth28
6	Parameter DATA_RATE_OQ bound to: DDR - type: string 
h p
x
� 
P
%s
*synth28
6	Parameter DATA_RATE_TQ bound to: SDR - type: string 
h p
x
� 
N
%s
*synth26
4	Parameter DATA_WIDTH bound to: 10 - type: integer 
h p
x
� 
R
%s
*synth2:
8	Parameter SERDES_MODE bound to: MASTER - type: string 
h p
x
� 
O
%s
*synth27
5	Parameter TBYTE_CTL bound to: FALSE - type: string 
h p
x
� 
O
%s
*synth27
5	Parameter TBYTE_SRC bound to: FALSE - type: string 
h p
x
� 
Q
%s
*synth29
7	Parameter TRISTATE_WIDTH bound to: 1 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	OSERDESE22
 2
02
12>
:D:/Xilinx20241/Vivado/2024.1/scripts/rt/data/unisim_comp.v2

1007098@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
OSERDESE2__parameterized02
 2>
:D:/Xilinx20241/Vivado/2024.1/scripts/rt/data/unisim_comp.v2

1007098@Z8-6157h px� 
P
%s
*synth28
6	Parameter DATA_RATE_OQ bound to: DDR - type: string 
h p
x
� 
P
%s
*synth28
6	Parameter DATA_RATE_TQ bound to: SDR - type: string 
h p
x
� 
N
%s
*synth26
4	Parameter DATA_WIDTH bound to: 10 - type: integer 
h p
x
� 
Q
%s
*synth29
7	Parameter SERDES_MODE bound to: SLAVE - type: string 
h p
x
� 
O
%s
*synth27
5	Parameter TBYTE_CTL bound to: FALSE - type: string 
h p
x
� 
O
%s
*synth27
5	Parameter TBYTE_SRC bound to: FALSE - type: string 
h p
x
� 
Q
%s
*synth29
7	Parameter TRISTATE_WIDTH bound to: 1 - type: integer 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
OSERDESE2__parameterized02
 2
02
12>
:D:/Xilinx20241/Vivado/2024.1/scripts/rt/data/unisim_comp.v2

1007098@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
serializer_10_to_12
 2
02
12U
QE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/serializer_10_to_1.v2
258@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
OBUFDS2
 2>
:D:/Xilinx20241/Vivado/2024.1/scripts/rt/data/unisim_comp.v2	
964728@Z8-6157h px� 
R
%s
*synth2:
8	Parameter IOSTANDARD bound to: TMDS_33 - type: string 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
OBUFDS2
 2
02
12>
:D:/Xilinx20241/Vivado/2024.1/scripts/rt/data/unisim_comp.v2	
964728@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
dvi_transmitter_top2
 2
02
12V
RE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/dvi_transmitter_top.v2
238@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
hdmi_colorbar_top2
 2
02
12T
PE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/hdmi/hdmi_colorbar_top.v2
238@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
top2
 2
02
12B
>E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/top.sv2
18@Z8-6155h px� 
~
9Port %s in module %s is either unconnected or has no load4866*oasys2
pixel_ypos[10]2
video_displayZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2
pixel_ypos[9]2
video_displayZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2
pixel_ypos[8]2
video_displayZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2
pixel_ypos[7]2
video_displayZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2
pixel_ypos[6]2
video_displayZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2
pixel_ypos[5]2
video_displayZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2
pixel_ypos[4]2
video_displayZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2
pixel_ypos[3]2
video_displayZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2
pixel_ypos[2]2
video_displayZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2
pixel_ypos[1]2
video_displayZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2
pixel_ypos[0]2
video_displayZ8-7129h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:06 ; elapsed = 00:00:05 . Memory (MB): peak = 1571.371 ; gain = 560.543
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:06 ; elapsed = 00:00:05 . Memory (MB): peak = 1571.371 ; gain = 560.543
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:06 ; elapsed = 00:00:05 . Memory (MB): peak = 1571.371 ; gain = 560.543
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0082

1571.3712
0.000Z17-268h px� 
S
-Analyzing %s Unisim elements for replacement
17*netlist2
4Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2~
ze:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0/clk_wiz_0_in_context.xdc2"
hdmi_colorbar_top_m0/clk_wiz_0	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2~
ze:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0/clk_wiz_0_in_context.xdc2"
hdmi_colorbar_top_m0/clk_wiz_0	8Z20-847h px� 
�
Parsing XDC File [%s]
179*designutils2C
?E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/top.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2C
?E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/top.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2A
?E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/top.xdc2
.Xil/top_propImpl.xdcZ1-236h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1672.2582
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0042

1672.2582
0.000Z17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Loading part: xc7k325tffg676-2
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   11 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input   10 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   5 Input    5 Bit       Adders := 6     
h p
x
� 
F
%s
*synth2.
,	   4 Input    5 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   8 Input    4 Bit       Adders := 6     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit       Adders := 3     
h p
x
� 
&
%s
*synth2
+---XORs : 
h p
x
� 
H
%s
*synth20
.	   2 Input      1 Bit         XORs := 42    
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	               24 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               12 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	               11 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	               10 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                9 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                5 Bit    Registers := 3     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 9     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 22    
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   24 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   5 Input   24 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   11 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input   10 Bit        Muxes := 7     
h p
x
� 
F
%s
*synth2.
,	   5 Input   10 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit        Muxes := 15    
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 27    
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
s
%s
*synth2[
YPart Resources:
DSPs: 840 (col length:140)
BRAMs: 890 (col length: RAMB18 140 RAMB36 70)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:14 ; elapsed = 00:00:14 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:19 ; elapsed = 00:00:19 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:19 ; elapsed = 00:00:19 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:19 ; elapsed = 00:00:19 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2x
vFinished IO Insertion : Time (s): cpu = 00:00:22 ; elapsed = 00:00:22 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:22 ; elapsed = 00:00:22 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:22 ; elapsed = 00:00:22 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:22 ; elapsed = 00:00:22 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:22 ; elapsed = 00:00:22 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:22 ; elapsed = 00:00:22 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
=
%s
*synth2%
#|      |BlackBox name |Instances |
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
=
%s
*synth2%
#|1     |clk_wiz_0     |         1|
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
5
%s*synth2
+------+----------+------+
h px� 
5
%s*synth2
|      |Cell      |Count |
h px� 
5
%s*synth2
+------+----------+------+
h px� 
5
%s*synth2
|1     |clk_wiz   |     1|
h px� 
5
%s*synth2
|2     |CARRY4    |     7|
h px� 
5
%s*synth2
|3     |LUT1      |     6|
h px� 
5
%s*synth2
|4     |LUT2      |    17|
h px� 
5
%s*synth2
|5     |LUT3      |    19|
h px� 
5
%s*synth2
|6     |LUT4      |    11|
h px� 
5
%s*synth2
|7     |LUT5      |    22|
h px� 
5
%s*synth2
|8     |LUT6      |    34|
h px� 
5
%s*synth2
|9     |OSERDESE2 |     8|
h px� 
5
%s*synth2
|11    |FDCE      |    24|
h px� 
5
%s*synth2
|12    |FDPE      |     2|
h px� 
5
%s*synth2
|13    |FDRE      |    72|
h px� 
5
%s*synth2
|14    |IBUF      |     6|
h px� 
5
%s*synth2
|15    |OBUF      |    23|
h px� 
5
%s*synth2
|16    |OBUFDS    |     4|
h px� 
5
%s*synth2
+------+----------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:22 ; elapsed = 00:00:22 . Memory (MB): peak = 1672.258 ; gain = 661.430
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
`
%s
*synth2H
FSynthesis finished with 0 errors, 0 critical warnings and 1 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:15 ; elapsed = 00:00:21 . Memory (MB): peak = 1672.258 ; gain = 560.543
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:22 ; elapsed = 00:00:23 . Memory (MB): peak = 1672.258 ; gain = 661.430
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1672.2582
0.000Z17-268h px� 
T
-Analyzing %s Unisim elements for replacement
17*netlist2
11Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
U
1Inserted %s IBUFs to IO ports without IO buffers.100*opt2
1Z31-140h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002

00:00:002

1672.2582
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

e8334d2fZ4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
492
122
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:282

00:00:292

1672.2582

1126.602Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0012

1672.2582
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2S
QE:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.runs/synth_1/top.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2Q
Oreport_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Sat Dec 21 16:05:24 2024Z17-206h px� 


End Record
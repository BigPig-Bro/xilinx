
]
Command: %s
53*	vivadotcl2,
*link_design -top top -part xc7a50tfgg484-1Z4-113h px� 
U
#Design is defaulting to srcset: %s
437*	planAhead2
	sources_1Z12-437h px� 
X
&Design is defaulting to constrset: %s
434*	planAhead2
	constrs_1Z12-434h px� 
D
Loading part %s157*device2
xc7a50tfgg484-1Z21-403h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2b
`e:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/tf_pll/tf_pll.dcp2
	tf_pll_m0Z1-454h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2h
fe:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp2 
hdmi_colorbar_top_m0/clk_wiz_0Z1-454h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0062	
592.7302
0.000Z17-268h px� 
T
-Analyzing %s Unisim elements for replacement
17*netlist2
25Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
T
Netlist was created with %s %s291*project2
Vivado2
2024.2Z1-479h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
�
LRemoving redundant IBUF, %s, from the path connected to top-level port: %s 
35*opt22
0hdmi_colorbar_top_m0/clk_wiz_0/inst/clkin1_ibufg2
i_clkZ31-35h px� 
�
LRemoving redundant IBUF, %s, from the path connected to top-level port: %s 
35*opt2
tf_pll_m0/inst/clkin1_ibufg2
i_clkZ31-35h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. '%s' is ignored for synthesis but preserved for implementation.
528*constraints2
IBUF_LOW_PWR2*
&hdmi_colorbar_top_m0/clk_wiz_0/clk_in12
IBUF_LOW_PWR8Z18-550h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. '%s' is ignored for synthesis but preserved for implementation.
528*constraints2
IBUF_LOW_PWR2
tf_pll_m0/clk_in12
IBUF_LOW_PWR8Z18-550h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2j
fe:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/tf_pll/tf_pll_board.xdc2
tf_pll_m0/inst	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2j
fe:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/tf_pll/tf_pll_board.xdc2
tf_pll_m0/inst	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2d
`e:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/tf_pll/tf_pll.xdc2
tf_pll_m0/inst	8Z20-848h px� 
�
%Done setting XDC timing constraints.
35*timing2d
`e:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/tf_pll/tf_pll.xdc2
548@Z38-35h px� 
�
Deriving generated clocks
2*timing2d
`e:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/tf_pll/tf_pll.xdc2
548@Z38-2h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2d
`e:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/tf_pll/tf_pll.xdc2
tf_pll_m0/inst	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2p
le:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc2'
#hdmi_colorbar_top_m0/clk_wiz_0/inst	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2p
le:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc2'
#hdmi_colorbar_top_m0/clk_wiz_0/inst	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2j
fe:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc2'
#hdmi_colorbar_top_m0/clk_wiz_0/inst	8Z20-848h px� 
�
Deriving generated clocks
2*timing2j
fe:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc2
548@Z38-2h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2j
fe:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc2'
#hdmi_colorbar_top_m0/clk_wiz_0/inst	8Z20-847h px� 
�
Parsing XDC File [%s]
179*designutils2D
@E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/src/top.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2D
@E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI050CD/all_test/src/top.xdc8Z20-178h px� 
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

1296.3752
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
~
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
122
42
02
0Z4-41h px� 
K
%s completed successfully
29*	vivadotcl2
link_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
link_design: 2

00:00:082

00:00:082

1296.3752	
912.902Z17-268h px� 


End Record
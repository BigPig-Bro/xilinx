
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
create_project: 2

00:00:062

00:00:062	
532.3482	
201.039Z17-268h px� 
^
Command: %s
53*	vivadotcl2-
+link_design -top top -part xc7k325tffg676-2Z4-113h px� 
U
#Design is defaulting to srcset: %s
437*	planAhead2
	sources_1Z12-437h px� 
X
&Design is defaulting to constrset: %s
434*	planAhead2
	constrs_1Z12-434h px� 
E
Loading part %s157*device2
xc7k325tffg676-2Z21-403h px� 
[
$Part: %s does not have CEAM library.966*device2
xc7k325tffg676-2Z21-9227h px� 
�
-Reading design checkpoint '%s' for cell '%s'
275*project2g
ee:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.dcp2 
hdmi_colorbar_top_m0/clk_wiz_0Z1-454h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1029.9382
0.000Z17-268h px� 
T
-Analyzing %s Unisim elements for replacement
17*netlist2
12Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
T
Netlist was created with %s %s291*project2
Vivado2
2024.1Z1-479h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
�
LRemoving redundant IBUF, %s, from the path connected to top-level port: %s 
35*opt22
0hdmi_colorbar_top_m0/clk_wiz_0/inst/clkin1_ibufg2
i_clkZ31-35h px� 
�
�Could not create '%s' constraint because net '%s' is not directly connected to top level port. '%s' is ignored for synthesis but preserved for implementation.
528*constraints2
IBUF_LOW_PWR2*
&hdmi_colorbar_top_m0/clk_wiz_0/clk_in12
IBUF_LOW_PWR8Z18-550h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2o
ke:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc2'
#hdmi_colorbar_top_m0/clk_wiz_0/inst	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2o
ke:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0_board.xdc2'
#hdmi_colorbar_top_m0/clk_wiz_0/inst	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2i
ee:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc2'
#hdmi_colorbar_top_m0/clk_wiz_0/inst	8Z20-848h px� 
�
%Done setting XDC timing constraints.
35*timing2i
ee:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc2
548@Z38-35h px� 
�
Deriving generated clocks
2*timing2i
ee:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc2
548@Z38-2h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
get_clocks: 2

00:00:052

00:00:052

1777.4962	
626.152Z17-268h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2i
ee:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/all_test.gen/sources_1/ip/clk_wiz_0/clk_wiz_0.xdc2'
#hdmi_colorbar_top_m0/clk_wiz_0/inst	8Z20-847h px� 
�
Parsing XDC File [%s]
179*designutils2C
?E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/top.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2C
?E:/FPGA_work/FPGA_Boards_Git/Xilinx/XI325A/all_test/src/top.xdc8Z20-178h px� 
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

1777.4962
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
~
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
112
22
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

00:00:112

00:00:122

1777.4962

1229.082Z17-268h px� 


End Record
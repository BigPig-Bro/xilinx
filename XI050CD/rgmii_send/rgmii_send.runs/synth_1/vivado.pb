
�
Command: %s
1870*	planAhead2�
read_checkpoint -auto_incremental -incremental D:/Users/HUIP/Desktop/rgmii_send/rgmii_send.srcs/utils_1/imports/synth_1/top.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2R
PD:/Users/HUIP/Desktop/rgmii_send/rgmii_send.srcs/utils_1/imports/synth_1/top.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
^
Command: %s
53*	vivadotcl2-
+synth_design -top top -part xc7a50tfgg484-1Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
z
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2	
xc7a50tZ17-347h px� 
j
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2	
xc7a50tZ17-349h px� 
D
Loading part %s157*device2
xc7a50tfgg484-1Z21-403h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
87864Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1038.957 ; gain = 475.688
h px� 
�
Pparameter '%s' becomes localparam in '%s' with formal parameter declaration list7326*oasys2
IP_HEAD_CODE2
	GMII_send25
1D:/Users/HUIP/Desktop/rgmii_send/src/GMII_send.sv2
278@Z8-11065h px� 
�
Pparameter '%s' becomes localparam in '%s' with formal parameter declaration list7326*oasys2
DES_MAC_CODE2
	GMII_send25
1D:/Users/HUIP/Desktop/rgmii_send/src/GMII_send.sv2
288@Z8-11065h px� 
�
Pparameter '%s' becomes localparam in '%s' with formal parameter declaration list7326*oasys2
BOARD_MAC_CODE2
	GMII_send25
1D:/Users/HUIP/Desktop/rgmii_send/src/GMII_send.sv2
298@Z8-11065h px� 
�
Pparameter '%s' becomes localparam in '%s' with formal parameter declaration list7326*oasys2
	DATA_TYPE2
	GMII_send25
1D:/Users/HUIP/Desktop/rgmii_send/src/GMII_send.sv2
308@Z8-11065h px� 
�
Pparameter '%s' becomes localparam in '%s' with formal parameter declaration list7326*oasys2

MAC_DATA2
	GMII_send25
1D:/Users/HUIP/Desktop/rgmii_send/src/GMII_send.sv2
318@Z8-11065h px� 
�
.redeclaration of ANSI port '%s' is not allowed7382*oasys2

gmii_rxd2=
9D:/Users/HUIP/Desktop/rgmii_send/src/util_gmii_to_rgmii.v2
468@Z8-11121h px� 
�
.redeclaration of ANSI port '%s' is not allowed7382*oasys2

gmii_rx_dv2=
9D:/Users/HUIP/Desktop/rgmii_send/src/util_gmii_to_rgmii.v2
478@Z8-11121h px� 
�
.redeclaration of ANSI port '%s' is not allowed7382*oasys2

gmii_rx_er2=
9D:/Users/HUIP/Desktop/rgmii_send/src/util_gmii_to_rgmii.v2
488@Z8-11121h px� 
�
synthesizing module '%s'%s4497*oasys2
top2
 2/
+D:/Users/HUIP/Desktop/rgmii_send/src/top.sv2
18@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
	GMII_send2
 25
1D:/Users/HUIP/Desktop/rgmii_send/src/GMII_send.sv2
18@Z8-6157h px� 
�
-case statement is not full and has no default155*oasys25
1D:/Users/HUIP/Desktop/rgmii_send/src/GMII_send.sv2
798@Z8-155h px� 
�
synthesizing module '%s'%s4497*oasys2
crc2
 2.
*D:/Users/HUIP/Desktop/rgmii_send/src/crc.v2
38@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
crc2
 2
02
12.
*D:/Users/HUIP/Desktop/rgmii_send/src/crc.v2
38@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
	GMII_send2
 2
02
125
1D:/Users/HUIP/Desktop/rgmii_send/src/GMII_send.sv2
18@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
util_gmii_to_rgmii2
 2=
9D:/Users/HUIP/Desktop/rgmii_send/src/util_gmii_to_rgmii.v2
28@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
ODDR22
 2>
:D:/Xilinx20242/Vivado/2024.2/scripts/rt/data/unisim_comp.v2

1030988@Z8-6157h px� 
P
%s
*synth28
6	Parameter DDR_ALIGNMENT bound to: C0 - type: string 
h p
x
� 
:
%s
*synth2"
 	Parameter INIT bound to: 1'b0 
h p
x
� 
L
%s
*synth24
2	Parameter SRTYPE bound to: ASYNC - type: string 
h p
x
� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
ODDR22
 2
02
12>
:D:/Xilinx20242/Vivado/2024.2/scripts/rt/data/unisim_comp.v2

1030988@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
BUFG2
 2>
:D:/Xilinx20242/Vivado/2024.2/scripts/rt/data/unisim_comp.v2
26768@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
BUFG2
 2
02
12>
:D:/Xilinx20242/Vivado/2024.2/scripts/rt/data/unisim_comp.v2
26768@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
util_gmii_to_rgmii2
 2
02
12=
9D:/Users/HUIP/Desktop/rgmii_send/src/util_gmii_to_rgmii.v2
28@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
top2
 2
02
12/
+D:/Users/HUIP/Desktop/rgmii_send/src/top.sv2
18@Z8-6155h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
gmii_tx_er_r_d1_reg2=
9D:/Users/HUIP/Desktop/rgmii_send/src/util_gmii_to_rgmii.v2
848@Z8-6014h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2

gmii_rxd2
util_gmii_to_rgmii2=
9D:/Users/HUIP/Desktop/rgmii_send/src/util_gmii_to_rgmii.v2
178@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2

gmii_rx_dv2
util_gmii_to_rgmii2=
9D:/Users/HUIP/Desktop/rgmii_send/src/util_gmii_to_rgmii.v2
188@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2

gmii_rx_er2
util_gmii_to_rgmii2=
9D:/Users/HUIP/Desktop/rgmii_send/src/util_gmii_to_rgmii.v2
198@Z8-3848h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
gmii_rxd[7]2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
gmii_rxd[6]2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
gmii_rxd[5]2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
gmii_rxd[4]2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
gmii_rxd[3]2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
gmii_rxd[2]2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
gmii_rxd[1]2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
gmii_rxd[0]2
util_gmii_to_rgmiiZ8-7129h px� 

9Port %s in module %s is either unconnected or has no load4866*oasys2

gmii_rx_dv2
util_gmii_to_rgmiiZ8-7129h px� 

9Port %s in module %s is either unconnected or has no load4866*oasys2

gmii_rx_er2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
rgmii_rd[3]2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
rgmii_rd[2]2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
rgmii_rd[1]2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
rgmii_rd[0]2
util_gmii_to_rgmiiZ8-7129h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2
rgmii_rx_ctl2
util_gmii_to_rgmiiZ8-7129h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1149.742 ; gain = 586.473
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
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1149.742 ; gain = 586.473
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
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1149.742 ; gain = 586.473
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
00:00:00.0122

1149.7422
0.000Z17-268h px� 
S
-Analyzing %s Unisim elements for replacement
17*netlist2
6Z29-17h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12 
util_gmii_to_rgmii_m0/U3_ODDR22
ODDR22
ODDR2
C10Z29-151h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12
util_gmii_to_rgmii_m0/U_ODDR22
ODDR22
ODDR2
C10Z29-151h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12/
-util_gmii_to_rgmii_m0/gen_tx_data[0].U2_ODDR22
ODDR22
ODDR2
C10Z29-151h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12/
-util_gmii_to_rgmii_m0/gen_tx_data[1].U2_ODDR22
ODDR22
ODDR2
C10Z29-151h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12/
-util_gmii_to_rgmii_m0/gen_tx_data[2].U2_ODDR22
ODDR22
ODDR2
C10Z29-151h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12/
-util_gmii_to_rgmii_m0/gen_tx_data[3].U2_ODDR22
ODDR22
ODDR2
C10Z29-151h px� 
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
q
Parsing XDC File [%s]
179*designutils20
,D:/Users/HUIP/Desktop/rgmii_send/src/top.xdc8Z20-179h px� 
�
No ports matched '%s'.
584*	planAhead2

clk_test20
,D:/Users/HUIP/Desktop/rgmii_send/src/top.xdc2
108@Z12-584h px�
�
"'%s' expects at least one object.
55*common2
set_property20
,D:/Users/HUIP/Desktop/rgmii_send/src/top.xdc2
108@Z17-55h px�
�
No clocks matched '%s'.
627*	planAhead2
	rgmii_txc20
,D:/Users/HUIP/Desktop/rgmii_send/src/top.xdc2
178@Z12-627h px�
�
aNo clocks found. Please use 'create_clock' or 'create_generated_clock' command to create clocks.
626*	planAhead20
,D:/Users/HUIP/Desktop/rgmii_send/src/top.xdc2
178@Z12-626h px�
�
&%s:No valid object(s) found for '%s'.
2779*	planAhead2
set_output_delay2
-clock [get_clocks rgmii_txc]20
,D:/Users/HUIP/Desktop/rgmii_send/src/top.xdc2
178@Z12-4739h px�
�
No clocks matched '%s'.
627*	planAhead2
	rgmii_txc20
,D:/Users/HUIP/Desktop/rgmii_send/src/top.xdc2
188@Z12-627h px�
�
aNo clocks found. Please use 'create_clock' or 'create_generated_clock' command to create clocks.
626*	planAhead20
,D:/Users/HUIP/Desktop/rgmii_send/src/top.xdc2
188@Z12-626h px�
�
&%s:No valid object(s) found for '%s'.
2779*	planAhead2
set_output_delay2
-clock [get_clocks rgmii_txc]20
,D:/Users/HUIP/Desktop/rgmii_send/src/top.xdc2
188@Z12-4739h px�
z
Finished Parsing XDC File [%s]
178*designutils20
,D:/Users/HUIP/Desktop/rgmii_send/src/top.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2.
,D:/Users/HUIP/Desktop/rgmii_send/src/top.xdc2
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

1234.1602
0.000Z17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2J
H  A total of 6 instances were transformed.
  ODDR2 => ODDR: 6 instances
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0032

1234.1602
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
Finished Constraint Validation : Time (s): cpu = 00:00:11 ; elapsed = 00:00:11 . Memory (MB): peak = 1234.160 ; gain = 670.891
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
8
%s
*synth2 
Loading part: xc7a50tfgg484-1
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
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:11 ; elapsed = 00:00:11 . Memory (MB): peak = 1234.160 ; gain = 670.891
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
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:11 ; elapsed = 00:00:11 . Memory (MB): peak = 1234.160 ; gain = 670.891
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
m
3inferred FSM for state register '%s' in module '%s'802*oasys2
	state_reg2
	GMII_sendZ8-802h px� 
�
RFound unconnected internal register '%s' and it is trimmed from '%s' to '%s' bits.3455*oasys2
gmii_txd_r_d1_reg2
82
42=
9D:/Users/HUIP/Desktop/rgmii_send/src/util_gmii_to_rgmii.v2
828@Z8-3936h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                    IDLE |                         00000001 |                             0000
h p
x
� 
y
%s
*synth2a
_               CHECK_SUM |                         00000010 |                             0001
h p
x
� 
y
%s
*synth2a
_             PACKET_HEAD |                         00000100 |                             0010
h p
x
� 
y
%s
*synth2a
_                SEND_MAC |                         00001000 |                             0011
h p
x
� 
y
%s
*synth2a
_             SEND_HEADER |                         00010000 |                             0100
h p
x
� 
y
%s
*synth2a
_               SEND_DATA |                         00100000 |                             0101
h p
x
� 
y
%s
*synth2a
_                SEND_CRC |                         01000000 |                             0110
h p
x
� 
y
%s
*synth2a
_                   DELAY |                         10000000 |                             0111
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
	state_reg2	
one-hot2
	GMII_sendZ8-3354h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:11 ; elapsed = 00:00:12 . Memory (MB): peak = 1234.160 ; gain = 670.891
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
,	   2 Input   32 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	  10 Input   20 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   16 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   11 Bit       Adders := 1     
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
.	   2 Input      1 Bit         XORs := 9     
h p
x
� 
H
%s
*synth20
.	   3 Input      1 Bit         XORs := 6     
h p
x
� 
H
%s
*synth20
.	   6 Input      1 Bit         XORs := 7     
h p
x
� 
H
%s
*synth20
.	   8 Input      1 Bit         XORs := 1     
h p
x
� 
H
%s
*synth20
.	   5 Input      1 Bit         XORs := 4     
h p
x
� 
H
%s
*synth20
.	   7 Input      1 Bit         XORs := 7     
h p
x
� 
H
%s
*synth20
.	  10 Input      1 Bit         XORs := 2     
h p
x
� 
H
%s
*synth20
.	   9 Input      1 Bit         XORs := 3     
h p
x
� 
H
%s
*synth20
.	  12 Input      1 Bit         XORs := 1     
h p
x
� 
H
%s
*synth20
.	   4 Input      1 Bit         XORs := 1     
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
.	               32 Bit    Registers := 9     
h p
x
� 
H
%s
*synth20
.	               11 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 10    
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
,	   2 Input   32 Bit        Muxes := 4     
h p
x
� 
F
%s
*synth2.
,	   4 Input   32 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   8 Input   32 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input   16 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input   16 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   11 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   8 Input   11 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input    8 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   8 Input    8 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit        Muxes := 7     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input    1 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   8 Input    1 Bit        Muxes := 6     
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
q
%s
*synth2Y
WPart Resources:
DSPs: 120 (col length:60)
BRAMs: 150 (col length: RAMB18 60 RAMB36 30)
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
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:13 ; elapsed = 00:00:14 . Memory (MB): peak = 1234.160 ; gain = 670.891
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
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:17 ; elapsed = 00:00:18 . Memory (MB): peak = 1345.156 ; gain = 781.887
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
}Finished Timing Optimization : Time (s): cpu = 00:00:18 ; elapsed = 00:00:18 . Memory (MB): peak = 1376.301 ; gain = 813.031
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
|Finished Technology Mapping : Time (s): cpu = 00:00:18 ; elapsed = 00:00:18 . Memory (MB): peak = 1376.816 ; gain = 813.547
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
%s*synth2y
wFinished IO Insertion : Time (s): cpu = 00:00:20 ; elapsed = 00:00:21 . Memory (MB): peak = 1571.730 ; gain = 1008.461
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
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:20 ; elapsed = 00:00:21 . Memory (MB): peak = 1571.730 ; gain = 1008.461
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
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:20 ; elapsed = 00:00:21 . Memory (MB): peak = 1571.730 ; gain = 1008.461
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
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:20 ; elapsed = 00:00:21 . Memory (MB): peak = 1571.730 ; gain = 1008.461
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
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:20 ; elapsed = 00:00:21 . Memory (MB): peak = 1571.730 ; gain = 1008.461
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
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:20 ; elapsed = 00:00:21 . Memory (MB): peak = 1571.730 ; gain = 1008.461
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
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
| |BlackBox name |Instances |
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|      |Cell   |Count |
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|1     |BUFG   |     1|
h px� 
2
%s*synth2
|2     |CARRY4 |    13|
h px� 
2
%s*synth2
|3     |LUT1   |    26|
h px� 
2
%s*synth2
|4     |LUT2   |    32|
h px� 
2
%s*synth2
|5     |LUT3   |    45|
h px� 
2
%s*synth2
|6     |LUT4   |    24|
h px� 
2
%s*synth2
|7     |LUT5   |    26|
h px� 
2
%s*synth2
|8     |LUT6   |    93|
h px� 
2
%s*synth2
|9     |ODDR2  |     6|
h px� 
2
%s*synth2
|10    |FDPE   |    32|
h px� 
2
%s*synth2
|11    |FDRE   |    88|
h px� 
2
%s*synth2
|12    |FDSE   |     1|
h px� 
2
%s*synth2
|13    |IBUF   |     2|
h px� 
2
%s*synth2
|14    |OBUF   |     7|
h px� 
2
%s*synth2
+------+-------+------+
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
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:20 ; elapsed = 00:00:21 . Memory (MB): peak = 1571.730 ; gain = 1008.461
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
FSynthesis finished with 0 errors, 0 critical warnings and 2 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:14 ; elapsed = 00:00:20 . Memory (MB): peak = 1571.730 ; gain = 924.043
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:21 ; elapsed = 00:00:21 . Memory (MB): peak = 1571.730 ; gain = 1008.461
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
00:00:00.0042

1571.7302
0.000Z17-268h px� 
T
-Analyzing %s Unisim elements for replacement
17*netlist2
19Z29-17h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12 
util_gmii_to_rgmii_m0/U3_ODDR22
ODDR22
ODDR2
CLKZ29-151h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12
util_gmii_to_rgmii_m0/U_ODDR22
ODDR22
ODDR2
CLKZ29-151h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12/
-util_gmii_to_rgmii_m0/gen_tx_data[0].U2_ODDR22
ODDR22
ODDR2
CLKZ29-151h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12/
-util_gmii_to_rgmii_m0/gen_tx_data[1].U2_ODDR22
ODDR22
ODDR2
CLKZ29-151h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12/
-util_gmii_to_rgmii_m0/gen_tx_data[2].U2_ODDR22
ODDR22
ODDR2
CLKZ29-151h px� 
�
�Pin '%s' on instance '%s' of cell type '%s' does not have an equivalent function on the new cell type '%s'. Net '%s' that is connected to this pin will not be connected to the replacement instance.326*netlist2
C12/
-util_gmii_to_rgmii_m0/gen_tx_data[3].U2_ODDR22
ODDR22
ODDR2
CLKZ29-151h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
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

1584.5592
0.000Z17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2J
H  A total of 6 instances were transformed.
  ODDR2 => ODDR: 6 instances
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

32d8effaZ4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 

G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
402
442
32
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:242

00:00:272

1584.5592

1211.012Z17-268h px� 
c
%s6*runtcl2G
ESynthesis results are not added to the cache due to CRITICAL_WARNING
h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002

00:00:002

1584.5592
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2B
@D:/Users/HUIP/Desktop/rgmii_send/rgmii_send.runs/synth_1/top.dcpZ17-1381h px� 
�
Executing command : %s
56330*	planAhead2Q
Oreport_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pbZ12-24828h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Mon Mar 31 22:25:47 2025Z17-206h px� 


End Record
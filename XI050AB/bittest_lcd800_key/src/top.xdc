set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K4} [get_ports {i_clk}]


set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN T18} [get_ports {o_lcd_rgb[16]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN R17} [get_ports {o_lcd_rgb[17]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U18} [get_ports {o_lcd_rgb[18]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN R18} [get_ports {o_lcd_rgb[19]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N18} [get_ports {o_lcd_rgb[20]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN R19} [get_ports {o_lcd_rgb[21]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N19} [get_ports {o_lcd_rgb[22]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N15} [get_ports {o_lcd_rgb[23]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN M16} [get_ports {o_lcd_rgb[8]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN M15} [get_ports {o_lcd_rgb[9]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN L15} [get_ports {o_lcd_rgb[10]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN L16} [get_ports {o_lcd_rgb[11]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K14} [get_ports {o_lcd_rgb[12]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N22} [get_ports {o_lcd_rgb[13]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J14} [get_ports {o_lcd_rgb[14]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J15} [get_ports {o_lcd_rgb[15]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J19} [get_ports {o_lcd_rgb[0]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN H13} [get_ports {o_lcd_rgb[1]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN H14} [get_ports {o_lcd_rgb[2]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN H17} [get_ports {o_lcd_rgb[3]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN H15} [get_ports {o_lcd_rgb[4]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN G18} [get_ports {o_lcd_rgb[5]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN G17} [get_ports {o_lcd_rgb[6]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN G16} [get_ports {o_lcd_rgb[7]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN F16} [get_ports {o_lcd_clk}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN F15} [get_ports {o_lcd_hs}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN E17} [get_ports {o_lcd_vs}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN E16} [get_ports {o_lcd_de}]


#====================================================================
# 编码器按键约束：每组均为 B / A / ENTER 三个IO
# 对应端口位定义：i_key_*[0]=A，[1]=B，[2]=ENTER（与Encoder_key.sv一致）
#--------------------------------------------------------------------
# 编码器A（第一组）：B=D15, A=C17, ENTER=B17
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN C17} [get_ports {i_key_A[0]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN D15} [get_ports {i_key_A[1]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN B17} [get_ports {i_key_A[2]}]

# 编码器B（第二组）：B=D16, A=C18, ENTER=B20
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN C18} [get_ports {i_key_B[0]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN D16} [get_ports {i_key_B[1]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN B20} [get_ports {i_key_B[2]}]

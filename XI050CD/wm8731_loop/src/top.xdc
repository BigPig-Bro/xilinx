create_clock -period 40.000 [get_ports {i_clk}]

set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN W19} [get_ports {i_clk}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V18} [get_ports {i_rst_n}]

# WM8731 音频模块 HDMI侧 排针
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N4} [get_ports {o_i2c_sclk}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K1} [get_ports {io_i2c_sdat}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K2} [get_ports {io_aud_adclrck}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN M6} [get_ports {i_aud_adcdat}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J1} [get_ports {o_aud_daclrck}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN L5} [get_ports {o_aud_dacdat}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J6} [get_ports {io_aud_bclk}]

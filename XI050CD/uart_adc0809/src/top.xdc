set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 1 [current_design]
set_property CONFIG_MODE SPIx1 [current_design]
set_property BITSTREAM.CONFIG.CONFIGRATE 50 [current_design]
set_property BITSTREAM.CONFIG.SPI_32BIT_ADDR NO [current_design]

#====================================================================
# 系统时钟与复位
#--------------------------------------------------------------------
create_clock -period 40.000 [get_ports {i_clk_25m}]

set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN W19} [get_ports {i_clk_25m}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V18} [get_ports {i_rst_n}]

#====================================================================
# LED指示灯 与 串口
#--------------------------------------------------------------------
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN P17} [get_ports {o_led[0]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V20} [get_ports {o_led[1]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V22} [get_ports {o_led[2]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN U21} [get_ports {o_led[3]}]

set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN V17} [get_ports {o_uart_tx}]

#====================================================================
# ADC0809 采集模块，接 H1 排针（TF卡侧 exter_io2）
#--------------------------------------------------------------------

set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN N4} [get_ports {o_adc0809_oe}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K1} [get_ports {o_adc0809_clk}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN P4} [get_ports {o_adc0809_st}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K2} [get_ports {i_adc0809_eoc}]

set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN M6} [get_ports {o_adc0809_addr[1]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J1} [get_ports {o_adc0809_addr[0]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN L5} [get_ports {o_adc0809_ale}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J6} [get_ports {o_adc0809_addr[2]}]

set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN L3} [get_ports {i_adc0809_db[6]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J4} [get_ports {i_adc0809_db[7]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN L6} [get_ports {i_adc0809_db[4]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN J5} [get_ports {i_adc0809_db[5]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K6} [get_ports {i_adc0809_db[2]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN H4} [get_ports {i_adc0809_db[3]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN K4} [get_ports {i_adc0809_db[0]}]
set_property -dict { IOSTANDARD LVCMOS33 PACKAGE_PIN H3} [get_ports {i_adc0809_db[1]}]

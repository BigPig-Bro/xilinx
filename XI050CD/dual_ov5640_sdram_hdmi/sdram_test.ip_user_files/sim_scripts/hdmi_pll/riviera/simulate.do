transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+hdmi_pll  -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.hdmi_pll xil_defaultlib.glbl

do {hdmi_pll.udo}

run 1000ns

endsim

quit -force

transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+input_pll  -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.input_pll xil_defaultlib.glbl

do {input_pll.udo}

run 1000ns

endsim

quit -force

transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+ila_sdram  -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ila_sdram xil_defaultlib.glbl

do {ila_sdram.udo}

run 1000ns

endsim

quit -force

transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+write_fifo  -L xil_defaultlib -L xpm -L fifo_generator_v13_2_11 -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.write_fifo xil_defaultlib.glbl

do {write_fifo.udo}

run 1000ns

endsim

quit -force

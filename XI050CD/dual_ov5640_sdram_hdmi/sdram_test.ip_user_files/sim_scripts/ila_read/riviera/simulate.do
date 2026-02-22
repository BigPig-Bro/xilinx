transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+ila_read  -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ila_read xil_defaultlib.glbl

do {ila_read.udo}

run 1000ns

endsim

quit -force

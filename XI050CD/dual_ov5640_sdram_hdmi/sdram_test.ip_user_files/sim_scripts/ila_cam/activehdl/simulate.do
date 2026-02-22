transcript off
onbreak {quit -force}
onerror {quit -force}
transcript on

asim +access +r +m+ila_cam  -L xil_defaultlib -L xpm -L unisims_ver -L unimacro_ver -L secureip -O5 xil_defaultlib.ila_cam xil_defaultlib.glbl

do {ila_cam.udo}

run 1000ns

endsim

quit -force

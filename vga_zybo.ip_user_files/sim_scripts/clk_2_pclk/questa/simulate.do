onbreak {quit -f}
onerror {quit -f}

vsim -t 1ps -lib xil_defaultlib clk_2_pclk_opt

do {wave.do}

view wave
view structure
view signals

do {clk_2_pclk.udo}

run -all

quit -force

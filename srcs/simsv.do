
vlib work
vmap work work
vcom -mixedsvvh -work work mult_div.vhd
vcom -mixedsvvh -work work MIPS-MC_SingleEdge.vhd
vlog -mixedsvvh -work work mp.sv
vlog -mixedsvvh -work work cache.sv
vlog -mixedsvvh -work work MIPS-MC_SingleEdge_tb.sv

vsim -voptargs=+acc work.cpu_tb
do wave.do
run 14us
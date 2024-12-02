
vlib work
vmap work work
vcom -mixedsvvh -work work mult_div.vhd
vcom -mixedsvvh -work work MIPS-MC_SingleEdge.vhd
vlog -mixedsvvh -work work ram.sv
vlog -mixedsvvh -work work MIPS-MC_SingleEdge_tb.sv

vsim -voptargs=+acc work.cpu_tb
do wave.do
run 14us
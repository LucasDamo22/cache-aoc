vlib work
vmap work work
vcom -mixedsvvh -work work mult_div.vhd

vcom -mixedsvvh -work work MIPS-MC_SingleEdge.vhd
vcom -mixedsvvh -work work MIPS-MC_SingleEdge_tb.vhd

vsim -voptargs=+acc work.CPU_tb
do wave.do
run 14us
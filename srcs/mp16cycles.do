
vlib work
vmap work work
vcom -mixedsvvh -work work rtl/mult_div.vhd

vcom -mixedsvvh -work work rtl/MIPS-MC_SingleEdge.vhd
vlog -mixedsvvh -work work rtl/ram.sv
vlog -mixedsvvh -work work rtl/MIPS-MP16-tb.sv

vsim -voptargs=+acc work.cpu_tb
do wave.do
run 14us
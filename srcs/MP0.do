
vlib work
vmap work work
vcom -mixedsvvh -work work rtl/mult_div.vhd

vcom -mixedsvvh -work work rtl/MIPS-MC_SingleEdge.vhd
vlog -mixedsvvh -work work rtl/ram.sv
vlog -mixedsvvh -work work rtl/MIPS-MP0-tb.sv

vsim -voptargs=+acc work.cpu_tb
do wavemp0.do
run 14us
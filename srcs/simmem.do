if {[file isdirectory work]} { vdel -all -lib work }
vlib work
vmap work work

vlog -mixedsvvh -work work ram.sv
vlog -mixedsvvh -work work tbmem.sv

vsim -voptargs=+acc work.tbmem
do wave.do
run 14us
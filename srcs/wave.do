onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /cpu_tb/cpu/clock
add wave -noupdate /cpu_tb/cpu/reset
add wave -noupdate /cpu_tb/cpu/hold
add wave -noupdate /cpu_tb/cpu/ce
add wave -noupdate /cpu_tb/cpu/rw
add wave -noupdate /cpu_tb/cpu/bw
add wave -noupdate /cpu_tb/cpu/i_address
add wave -noupdate /cpu_tb/cpu/d_address
add wave -noupdate /cpu_tb/cpu/instruction
add wave -noupdate /cpu_tb/cpu/data
add wave -noupdate /cpu_tb/cpu/IR
add wave -noupdate /cpu_tb/cpu/NPC
add wave -noupdate /cpu_tb/cpu/RESULT
add wave -noupdate /cpu_tb/cpu/uins
add wave -noupdate /cpu_tb/cpu/inst_branch
add wave -noupdate /cpu_tb/cpu/salta
add wave -noupdate /cpu_tb/cpu/end_mul
add wave -noupdate /cpu_tb/cpu/end_div
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {23413846 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {119700 ns}

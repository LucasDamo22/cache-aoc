onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group cpu /cpu_tb/cpu/clock
add wave -noupdate -group cpu /cpu_tb/cpu/reset
add wave -noupdate -group cpu /cpu_tb/cpu/hold
add wave -noupdate -group cpu /cpu_tb/cpu/ce
add wave -noupdate -group cpu /cpu_tb/cpu/rw
add wave -noupdate -group cpu /cpu_tb/cpu/bw
add wave -noupdate -group cpu /cpu_tb/cpu/i_address
add wave -noupdate -group cpu /cpu_tb/cpu/d_address
add wave -noupdate -group cpu /cpu_tb/cpu/instruction
add wave -noupdate -group cpu /cpu_tb/cpu/data
add wave -noupdate -group cpu /cpu_tb/cpu/IR
add wave -noupdate -group cpu /cpu_tb/cpu/NPC
add wave -noupdate -group cpu /cpu_tb/cpu/RESULT
add wave -noupdate -group cpu /cpu_tb/cpu/uins
add wave -noupdate -group cpu /cpu_tb/cpu/inst_branch
add wave -noupdate -group cpu /cpu_tb/cpu/salta
add wave -noupdate -group cpu /cpu_tb/cpu/end_mul
add wave -noupdate -group cpu /cpu_tb/cpu/end_div
add wave -noupdate -group data-ram /cpu_tb/data_ram/HOLD_CYLES
add wave -noupdate -group data-ram /cpu_tb/data_ram/MEM_WIDHT
add wave -noupdate -group data-ram /cpu_tb/data_ram/START_ADRESS
add wave -noupdate -group data-ram /cpu_tb/data_ram/clk
add wave -noupdate -group data-ram /cpu_tb/data_ram/reset_n
add wave -noupdate -group data-ram /cpu_tb/data_ram/addr
add wave -noupdate -group data-ram /cpu_tb/data_ram/data
add wave -noupdate -group data-ram /cpu_tb/data_ram/ce_n
add wave -noupdate -group data-ram /cpu_tb/data_ram/we_n
add wave -noupdate -group data-ram /cpu_tb/data_ram/oe_n
add wave -noupdate -group data-ram /cpu_tb/data_ram/bw
add wave -noupdate -group data-ram /cpu_tb/data_ram/hold_o
add wave -noupdate -group data-ram /cpu_tb/data_ram/data_out
add wave -noupdate -group data-ram /cpu_tb/data_ram/fd
add wave -noupdate -group data-ram /cpu_tb/data_ram/addr_view
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/HOLD_CYLES
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/MEM_WIDHT
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/START_ADRESS
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/clk
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/reset_n
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/addr
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/data
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/ce_n
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/we_n
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/oe_n
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/bw
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/hold_o
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/RAM
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/data_out
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/fd
add wave -noupdate -group inst-ram /cpu_tb/inst_ram/addr_view
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {33936923 ps} 0}
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

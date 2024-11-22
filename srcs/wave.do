onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group cpu /cpu_tb/cpu/clock
add wave -noupdate -expand -group cpu /cpu_tb/cpu/reset
add wave -noupdate -expand -group cpu /cpu_tb/cpu/hold
add wave -noupdate -expand -group cpu /cpu_tb/cpu/ce
add wave -noupdate -expand -group cpu /cpu_tb/cpu/rw
add wave -noupdate -expand -group cpu /cpu_tb/cpu/bw
add wave -noupdate -expand -group cpu /cpu_tb/cpu/i_address
add wave -noupdate -expand -group cpu /cpu_tb/cpu/instruction
add wave -noupdate -expand -group cpu /cpu_tb/cpu/d_address
add wave -noupdate -expand -group cpu /cpu_tb/cpu/data
add wave -noupdate -expand -group data_mem /cpu_tb/Data_mem/ce_n
add wave -noupdate -expand -group data_mem /cpu_tb/Data_mem/we_n
add wave -noupdate -expand -group data_mem /cpu_tb/Data_mem/oe_n
add wave -noupdate -expand -group data_mem /cpu_tb/Data_mem/bw
add wave -noupdate -expand -group data_mem /cpu_tb/Data_mem/address
add wave -noupdate -expand -group data_mem /cpu_tb/Data_mem/data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {5242 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 150
configure wave -valuecolwidth 134
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
WaveRestoreZoom {5178 ns} {5414 ns}

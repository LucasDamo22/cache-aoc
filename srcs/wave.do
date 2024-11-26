onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group ram /tbmem/ram/MEM_WIDHT
add wave -noupdate -expand -group ram /tbmem/ram/START_ADRESS
add wave -noupdate -expand -group ram /tbmem/ram/clk
add wave -noupdate -expand -group ram /tbmem/ram/addr
add wave -noupdate -expand -group ram /tbmem/ram/data
add wave -noupdate -expand -group ram /tbmem/ram/ce_n
add wave -noupdate -expand -group ram /tbmem/ram/we_n
add wave -noupdate -expand -group ram /tbmem/ram/oe_n
add wave -noupdate -expand -group ram /tbmem/ram/bw
add wave -noupdate -expand -group ram /tbmem/ram/data_out
add wave -noupdate -expand -group ram /tbmem/ram/RAM
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {119 ns} 0}
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
WaveRestoreZoom {0 ns} {385 ns}

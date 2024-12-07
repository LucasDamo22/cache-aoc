onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -group cpu_tb /cpu_tb/cpu/clock
add wave -noupdate -group cpu_tb /cpu_tb/cpu/reset
add wave -noupdate -group cpu_tb /cpu_tb/cpu/hold
add wave -noupdate -group cpu_tb /cpu_tb/cpu/ce
add wave -noupdate -group cpu_tb /cpu_tb/cpu/rw
add wave -noupdate -group cpu_tb /cpu_tb/cpu/bw
add wave -noupdate -group cpu_tb /cpu_tb/cpu/i_address
add wave -noupdate -group cpu_tb /cpu_tb/cpu/d_address
add wave -noupdate -group cpu_tb /cpu_tb/cpu/instruction
add wave -noupdate -group cpu_tb /cpu_tb/cpu/data
add wave -noupdate -group cpu_tb /cpu_tb/cpu/IR
add wave -noupdate -group cpu_tb /cpu_tb/cpu/NPC
add wave -noupdate -group cpu_tb /cpu_tb/cpu/RESULT
add wave -noupdate -group cpu_tb /cpu_tb/cpu/uins
add wave -noupdate -group cpu_tb /cpu_tb/cpu/inst_branch
add wave -noupdate -group cpu_tb /cpu_tb/cpu/salta
add wave -noupdate -group cpu_tb /cpu_tb/cpu/end_mul
add wave -noupdate -group cpu_tb /cpu_tb/cpu/end_div
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/HOLD_CYLES_MISS
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/MP_WIDHT
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/START_ADRESS
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/clk
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/reset_n
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/addr
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/data
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/ce_n
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/we_n
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/oe_n
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/bw
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/hold_o
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/CACHE_1
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/CACHE_2
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/CACHE_3
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/CACHE_4
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/CACHE_5
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/CACHE_6
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/CACHE_7
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/CACHE_8
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/valid_bit
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/tag
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/data_out
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/data_out_ram
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/address_line
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/address_word
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/address_tag
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/we_n1_fake
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/oe_n_read
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/hold_wire
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/hold_cache
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/mr_e
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/finished_reading
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/hit
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/miss
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/EA
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/PE
add wave -noupdate -group {L1 CACHE} /cpu_tb/cache_l1/we_n_fake
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
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/HOLD_CYLES_MISS
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/MEM_WIDHT
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/START_ADRESS
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/CACHE_WIDTH
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/clk
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/reset_n
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/addr
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/data
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/ce_n
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/we_n
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/oe_n
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/bw
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/multiple_read
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/cache_data
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/cache_read_full
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/hold_o
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/RAM
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/data_out
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/cache_data_out
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/cache_data_out_real
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/cache_temp_fill
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/fd
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/count
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/count_cache
add wave -noupdate -group MP-INST /cpu_tb/cache_l1/main_memory_inst/addr_view
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {70024779 ps} 0}
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
WaveRestoreZoom {0 ps} {329700 ns}

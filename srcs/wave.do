onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/HOLD_CYLES
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/MEM_WIDHT
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/START_ADRESS
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/clk
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/reset_n
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/addr
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/data
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/ce_n
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/we_n
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/oe_n
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/bw
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/hold_o
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/CACHE_1
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/CACHE_2
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/CACHE_3
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/CACHE_4
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/CACHE_5
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/CACHE_6
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/CACHE_7
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/CACHE_8
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/valid_bit
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/tag
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/data_out
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/data_out_ram
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/address_line
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/address_word
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/address_tag
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/we_n1_fake
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/oe_n_read
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/hold_wire
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/hold_cache
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/mr_e
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/finished_reading
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/hit
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/miss
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/EA
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/PE
add wave -noupdate -expand -group l1 -radix hexadecimal /cpu_tb/cache_l1/we_n_fake
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/HOLD_CYLES
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/MEM_WIDHT
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/START_ADRESS
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/CACHE_WIDTH
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/clk
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/reset_n
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/addr
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/data
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/ce_n
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/we_n
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/oe_n
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/bw
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/multiple_read
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/cache_data
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/cache_read_full
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/hold_o
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/RAM
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/data_out
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/cache_data_out
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/cache_data_out_real
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/cache_temp_fill
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/fd
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/count
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/count_cache
add wave -noupdate -expand -group mp -radix hexadecimal /cpu_tb/cache_l1/main_memory_inst/addr_view
add wave -noupdate -group data /cpu_tb/main_memory_data/HOLD_CYLES
add wave -noupdate -group data /cpu_tb/main_memory_data/MEM_WIDHT
add wave -noupdate -group data /cpu_tb/main_memory_data/START_ADRESS
add wave -noupdate -group data /cpu_tb/main_memory_data/CACHE_WIDTH
add wave -noupdate -group data /cpu_tb/main_memory_data/clk
add wave -noupdate -group data /cpu_tb/main_memory_data/reset_n
add wave -noupdate -group data /cpu_tb/main_memory_data/addr
add wave -noupdate -group data /cpu_tb/main_memory_data/data
add wave -noupdate -group data /cpu_tb/main_memory_data/ce_n
add wave -noupdate -group data /cpu_tb/main_memory_data/we_n
add wave -noupdate -group data /cpu_tb/main_memory_data/oe_n
add wave -noupdate -group data /cpu_tb/main_memory_data/bw
add wave -noupdate -group data /cpu_tb/main_memory_data/multiple_read
add wave -noupdate -group data /cpu_tb/main_memory_data/cache_data
add wave -noupdate -group data /cpu_tb/main_memory_data/cache_read_full
add wave -noupdate -group data /cpu_tb/main_memory_data/hold_o
add wave -noupdate -group data /cpu_tb/main_memory_data/RAM
add wave -noupdate -group data /cpu_tb/main_memory_data/data_out
add wave -noupdate -group data /cpu_tb/main_memory_data/cache_data_out
add wave -noupdate -group data /cpu_tb/main_memory_data/cache_data_out_real
add wave -noupdate -group data /cpu_tb/main_memory_data/cache_temp_fill
add wave -noupdate -group data /cpu_tb/main_memory_data/fd
add wave -noupdate -group data /cpu_tb/main_memory_data/count
add wave -noupdate -group data /cpu_tb/main_memory_data/count_cache
add wave -noupdate -group data /cpu_tb/main_memory_data/addr_view
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/clock
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/reset
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/hold
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/ce
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/rw
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/bw
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/i_address
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/d_address
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/instruction
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/data
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/IR
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/NPC
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/RESULT
add wave -noupdate -expand -group cpu -radix hexadecimal -childformat {{/cpu_tb/cpu/uins.CY1 -radix hexadecimal} {/cpu_tb/cpu/uins.CY2 -radix hexadecimal} {/cpu_tb/cpu/uins.walu -radix hexadecimal} {/cpu_tb/cpu/uins.wmdr -radix hexadecimal} {/cpu_tb/cpu/uins.wpc -radix hexadecimal} {/cpu_tb/cpu/uins.wreg -radix hexadecimal} {/cpu_tb/cpu/uins.whilo -radix hexadecimal} {/cpu_tb/cpu/uins.ce -radix hexadecimal} {/cpu_tb/cpu/uins.rw -radix hexadecimal} {/cpu_tb/cpu/uins.bw -radix hexadecimal} {/cpu_tb/cpu/uins.i -radix hexadecimal} {/cpu_tb/cpu/uins.rst_md -radix hexadecimal}} -expand -subitemconfig {/cpu_tb/cpu/uins.CY1 {-height 16 -radix hexadecimal} /cpu_tb/cpu/uins.CY2 {-height 16 -radix hexadecimal} /cpu_tb/cpu/uins.walu {-height 16 -radix hexadecimal} /cpu_tb/cpu/uins.wmdr {-height 16 -radix hexadecimal} /cpu_tb/cpu/uins.wpc {-height 16 -radix hexadecimal} /cpu_tb/cpu/uins.wreg {-height 16 -radix hexadecimal} /cpu_tb/cpu/uins.whilo {-height 16 -radix hexadecimal} /cpu_tb/cpu/uins.ce {-height 16 -radix hexadecimal} /cpu_tb/cpu/uins.rw {-height 16 -radix hexadecimal} /cpu_tb/cpu/uins.bw {-height 16 -radix hexadecimal} /cpu_tb/cpu/uins.i {-height 16 -radix hexadecimal} /cpu_tb/cpu/uins.rst_md {-height 16 -radix hexadecimal}} /cpu_tb/cpu/uins
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/inst_branch
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/salta
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/end_mul
add wave -noupdate -expand -group cpu -radix hexadecimal /cpu_tb/cpu/end_div
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1042994 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 157
configure wave -valuecolwidth 237
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
WaveRestoreZoom {0 ps} {5892914 ps}

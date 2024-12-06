`timescale 1ns/1ps
module cpu_tb;
logic clk = 1;
logic reset_n;
logic reset;

always  begin
    #5 clk = 0;
    #5 clk = 1;
end

initial begin
    reset_n = 0;
    #10
    reset_n = 1;  
end

initial begin
    reset = 1;
    #10
    reset = 0;
end

logic i_ce_n;
logic d_ce_n;

logic [31:0]i_addr;
logic [31:0]d_addr;

logic i_we_n;
logic d_we_n;

logic d_oe_n;
logic i_oe_n;

logic i_bw;
logic d_bw;

wire logic [31:0]instruction;
wire logic [31:0]data;

logic rw;
logic ce;

logic mult_read;
logic hold;

assign d_ce_n = !ce;
assign d_we_n = (ce && !rw) ? 0 : 1;
assign d_oe_n = (ce && rw) ? 0 : 1;

assign i_ce_n = 0;
assign i_oe_n = !reset_n ? 1 : 0;
assign i_we_n = 1;
assign i_bw   = 1;
assign mult_read = 1;

cache #(
    .HOLD_CYLES(0),
    .START_ADRESS(32'h00400000),
    .MEM_WIDHT(128),
    .BIN_FILE("../apps/text.bin")
) cache_l1 (
    .clk    (clk),
    .reset_n(reset_n),
    .addr   (i_addr),
    .data   (instruction),
    .ce_n   (i_ce_n),
    .we_n   (i_we_n),
    .oe_n   (i_oe_n),
    .hold_o (hold),
    .bw     (i_bw)
);

mp #(
    .MEM_WIDHT(128),
    .BIN_FILE("../apps/data.bin")
) main_memory_data (
    .clk    (clk),
    .reset_n(reset_n),
    .addr   (d_addr),
    .data   (data),
    .ce_n   (d_ce_n),
    .we_n   (d_we_n),
    .oe_n   (d_oe_n),
    .multiple_read (mult_read),
    .cache_data(),
    .hold_o (),
    .cache_read_full(),
    .bw     (d_bw)
);

MIPS_S cpu (
    .clock(clk),
    .reset(reset),
    .ce(ce),
    .bw(d_bw),
    .rw(rw),
    .hold(hold),
    .i_address(i_addr),
    .d_address(d_addr),
    .instruction(instruction),
    .data(data)
);

endmodule
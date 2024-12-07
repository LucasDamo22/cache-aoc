`timescale 1ns/1ps
module cpu_tb;
logic clk = 1;
logic reset_n;

always  begin
    #5 clk = 0;
    #5 clk = 1;
end
initial begin
    reset_n = 0;
    #37
    reset_n = 1;    
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

logic hold;

assign d_ce_n = !ce;
assign d_we_n = (ce && !rw) ? 0 : 1;
assign d_oe_n = (ce && rw) ? 0 : 1;

assign i_ce_n = 0;
assign i_oe_n = !reset_n ? 1 : 0;
assign i_we_n = 1;
assign i_bw   = 1;

localparam MEM_WIDHT_INST = 8192;
localparam MEM_WIDHT_DATA = 2_147_483_647;





//localparam MEM_WIDHT_DATA = 10;

ram #(
    .START_ADRESS(32'h00400000),
    .MEM_WIDHT(MEM_WIDHT_INST),
    .BIN_FILE("../apps/localidade-espacial-high-miss/bebacafe-localidade-espacial-highmiss-text.bin")
) inst_ram (
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
ram #(
    .MEM_WIDHT(MEM_WIDHT_DATA),
    .BIN_FILE("../apps/localidade-espacial-high-miss/bebacafe-localidade-espacial-highmiss-data.bin")
) data_ram (
    .clk    (clk),
    .reset_n(reset_n),
    .addr   (d_addr),
    .data   (data),
    .ce_n   (d_ce_n),
    .we_n   (d_we_n),
    .oe_n   (d_oe_n),
    .hold_o (),
    .bw     (d_bw)
);

MIPS_S cpu (
    .clock(clk),
    .reset(!reset_n),
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
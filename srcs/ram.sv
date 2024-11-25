module ram#(
    parameter bit HOLD_CYCLES = 0,
    parameter int MEM_WIDHT = 128,
    parameter START_ADRESS = 32'h10010000,
    parameter string BIN_FILE = "../apps/text-data-sections.txt"
)
(
    input logic clk,
    input logic[31:0] addr,
    inout logic[31:0] data
    input logic ce_n,
    input logic we_n,
    input logic oe_n,
    input logic bw
);

logic [31:0] RAM [0:MEM_WIDHT];

/*READ FROM MEM*/
always_ff @(posedge clk) begin
    if(!ce_n && !oe_n) begin
        data <= RAM[addr];
    end else begin
        data <= 'Z;
    end
end


/*WRITE TO MEM*/
always_ff @(posedge clk) begin
    if (!ce_n && !we_n) begin
        if(!bw) begin 
            // mask for byte-write
            RAM[addr] <= data & ~32'hffffff00;
        end else begin
            RAM[addr] <= data;
        end
    end
end 



endmodule
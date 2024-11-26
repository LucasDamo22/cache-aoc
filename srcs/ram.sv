module ram 
#(
    parameter int MEM_WIDHT = 128,
    parameter int START_ADRESS = 32'h10010000,
    parameter string BIN_FILE = ""
)
(
    input logic clk,
    input logic reset_n,
    input logic[31:0] addr,
    inout logic[31:0] data,
    input logic ce_n,
    input logic we_n,
    input logic oe_n,
    input logic bw
);
function automatic [31:0] conv_addr;
        input [31:0]  addr;
        begin
            conv_addr = addr - START_ADRESS;  // Subtract the two 32-bit addresses
        end
endfunction

logic [31:0] RAM [0:MEM_WIDHT];

logic [31:0]data_out;


always_comb begin
    if(!ce_n && !oe_n) begin
        data_out <= RAM[conv_addr(addr)];
    end 
end

/*WRITE TO MEM*/
always_comb begin
    if(!reset_n) begin
        for(int i = 0; i < MEM_WIDHT; i ++) begin
            RAM[i] <= '0;
        end  
    end
    if (!ce_n && !we_n) begin
        if(!bw) begin 
            // mask for byte-write
            RAM[conv_addr(addr)] <= data & ~32'hffffff00;
        end else begin
            RAM[conv_addr(addr)] <= data;
        end
    end
end 

assign    data = !oe_n ? data_out : 'z;




endmodule
module ram 
#(
    parameter int HOLD_CYLES = 0,
    parameter int MEM_WIDHT = 128,
    parameter int START_ADRESS = 32'h10010000,
    parameter string BIN_FILE = ""
)
(
    input logic clk,
    input logic reset_n,
    input logic[31:0] addr,
    inout wire logic[31:0] data,
    input logic ce_n,
    input logic we_n,
    input logic oe_n,
    input logic bw,
    output logic hold_o
);
function automatic [15:0] conv_addr;
        input [31:0]  addr;
        begin
            conv_addr = {'0,(addr - START_ADRESS)};  // Subtract the two 32-bit addresses
        end
endfunction

logic  [7:0] RAM [0:MEM_WIDHT];
logic [31:0] data_out;

int fd;
always_comb begin
    if(!reset_n) begin
        fd = $fopen (BIN_FILE, "r");
        if (fd == '0) begin
            $display("[%d] [RAM_mem] ERROR: %s not found.", $time(), BIN_FILE);
            $finish();
        end
        void'($fread(RAM, fd));
    end else begin
    if(!ce_n && !oe_n) begin
        data_out[31:24] = RAM[conv_addr(addr[15:0]) + 3];
        data_out[23:16] = RAM[conv_addr(addr[15:0]) + 2];
        data_out[15:8]  = RAM[conv_addr(addr[15:0]) + 1];
        data_out[7:0]   = RAM[conv_addr(addr[15:0])];
    end 
    else if (!ce_n && !we_n) begin
        if(bw) begin 
           RAM[conv_addr(addr[15:0])+3] = data[31:24];
           RAM[conv_addr(addr[15:0])+2] = data[23:16];
           RAM[conv_addr(addr[15:0])+1] = data[15:8]; 
        end 
        RAM[conv_addr(addr[15:0])] <= data[7:0];
    end 
    end
end 

if (HOLD_CYLES > 0) begin : hold_gen
    logic [$clog2(HOLD_CYLES)-1:0] count;
    always_ff @(posedge clk or negedge reset_n) begin
        if(!reset_n) begin
            count <= HOLD_CYLES;
            hold_o <= 1;
        end else begin
            if(!ce_n && !oe_n) begin
                if(count > 0) begin 
                    hold_o <= 1;
                end else begin
                    hold_o <= 0;
                end
                count <= count - 1;
            end
        end
    end
end else begin
    assign hold_o = 0;
end

logic [31:0] addr_view;
assign addr_view = conv_addr(addr[15:0]);
assign data = !oe_n ? data_out : 'z;



endmodule
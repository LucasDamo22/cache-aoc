module mp 
#(
    parameter int HOLD_CYLES_MISS = 0,
    parameter int MEM_WIDHT = 128,
    parameter int START_ADRESS = 32'h10010000,
    parameter int CACHE_WIDTH = 256,
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
    input logic multiple_read,
    output wire logic[(CACHE_WIDTH - 1): 0] cache_data,
    output logic cache_read_full,
    output logic hold_o
);
function automatic [15:0] conv_addr;
        input [31:0]  addr;
        begin
            conv_addr = {'0,(addr - START_ADRESS)};  // Subtract the two 32-bit addresses
        end
endfunction

logic  [7:0] RAM [0:MEM_WIDHT]= '{default :'0};
logic [31:0] data_out;
logic [31:0] cache_data_out [0:7];
logic [31:0] cache_data_out_real [0:7];
logic [31:0] cache_temp_fill;

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
    if(!ce_n && !oe_n && multiple_read) begin
        data_out[31:24] = RAM[conv_addr(addr[15:0]) + 3];
        data_out[23:16] = RAM[conv_addr(addr[15:0]) + 2];
        data_out[15:8]  = RAM[conv_addr(addr[15:0]) + 1];
        data_out[7:0]   = RAM[conv_addr(addr[15:0])];
    end 
    else if (!ce_n && !oe_n && !multiple_read) begin
            for(int i = 0; i < 8; i++) begin
                cache_temp_fill[31: 24] = RAM[conv_addr(addr[15:0]) + ((i*4) + 3)];       
                cache_temp_fill[23: 16] = RAM[conv_addr(addr[15:0]) + ((i*4) + 2)];
                cache_temp_fill[15:  8] = RAM[conv_addr(addr[15:0]) + ((i*4) + 1)];
                cache_temp_fill[ 7:  0] = RAM[conv_addr(addr[15:0]) + ((i*4) + 0)];
                cache_data_out[i] = cache_temp_fill;
            end
    end
    else if (!ce_n && !we_n) begin
        if(bw) begin // bw = 1 escrevendo uma word, bw = 0 escrevendo byte
           RAM[conv_addr(addr[15:0])+3] = data[31:24];
           RAM[conv_addr(addr[15:0])+2] = data[23:16];
           RAM[conv_addr(addr[15:0])+1] = data[15:8]; 
        end 
        RAM[conv_addr(addr[15:0])] = data[7:0];
    end 
    end
end 

    logic [3:0] count;
    logic [3:0] count_cache;

    always_ff @(posedge clk or negedge reset_n) begin
        if(!reset_n) begin
            count <=       4'hF;
            count_cache <= 4'hF;
            hold_o <= 1;
            cache_read_full <= 1;
        end else begin
            if(!ce_n && !oe_n && multiple_read) begin
                if(count > 0) begin 
                    hold_o <= 1;
                end else begin
                    hold_o <= 0;
                end
                count <= count - 1;
                count_cache <= HOLD_CYLES_MISS;
            end
            else if(!ce_n && !oe_n && !multiple_read) begin
                if(count_cache > 0) begin
                    hold_o <= 1;
                    cache_read_full <= 1;
                end else begin
                    hold_o <= 0;
                    cache_read_full <= 0;
                end
                count_cache <= count_cache - 1;
            end
            else begin
                count_cache <= HOLD_CYLES_MISS;
            end
        end
    end

    //Enjambramento
    //always_comb begin
    //    if(count <= 0) begin
    //        cache_data_out_real[7] = cache_data_out[7];
    //        cache_data_out_real[6] = cache_data_out[6];
    //        cache_data_out_real[5] = cache_data_out[5];
    //        cache_data_out_real[4] = cache_data_out[4];
    //        cache_data_out_real[3] = cache_data_out[3];
    //        cache_data_out_real[2] = cache_data_out[2];
    //        cache_data_out_real[1] = cache_data_out[1];
    //        cache_data_out_real[0] = cache_data_out[0];
    //    end
    //end

logic [31:0] addr_view;
assign addr_view = conv_addr(addr[15:0]);
assign data = !oe_n ? data_out : 'z;

//Emjambramento
assign cache_data[255:224] = cache_data_out_real[7];
assign cache_data[223:192] = cache_data_out_real[6];
assign cache_data[191:160] = cache_data_out_real[5];
assign cache_data[159:128] = cache_data_out_real[4];
assign cache_data[127: 96] = cache_data_out_real[3];
assign cache_data[ 95: 64] = cache_data_out_real[2];
assign cache_data[ 63: 32] = cache_data_out_real[1];
assign cache_data[ 31:  0] = cache_data_out_real[0];

assign cache_data_out_real[7] = cache_data_out[7];
assign cache_data_out_real[6] = cache_data_out[6];
assign cache_data_out_real[5] = cache_data_out[5];
assign cache_data_out_real[4] = cache_data_out[4];
assign cache_data_out_real[3] = cache_data_out[3];
assign cache_data_out_real[2] = cache_data_out[2];
assign cache_data_out_real[1] = cache_data_out[1];
assign cache_data_out_real[0] = cache_data_out[0];

endmodule
module cache 
#(
    parameter int HOLD_CYLES = 0,
    parameter int MEM_WIDHT = 128,
    parameter int START_ADRESS = 32'h00400000,
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

//////////////////////////////////////////////////////////
// ALL REGISTERS AND WIRES

logic [255:0] CACHE_1;
logic [255:0] CACHE_2;
logic [255:0] CACHE_3;
logic [255:0] CACHE_4;
logic [255:0] CACHE_5;
logic [255:0] CACHE_6;
logic [255:0] CACHE_7;
logic [255:0] CACHE_8;

logic  [7:0]  valid_bit;     //First Column of CACHE
logic  [23:0] tag [0:7];     //Tag

logic [31:0]  data_out;
logic [255:0] data_out_ram;

logic  [2:0] address_line;
logic  [2:0] address_word;
logic [23:0] address_tag;

logic we_n_fake;        //Never Write
logic oe_n_read;        //In order to get data from RAM 

logic hold_wire;       //Connected to the MP
logic hold_cache;      //Hold from Cache
logic mr_e;            //Multiple Read Enabled from MP
logic finished_reading;


logic hit;

logic [1:0] EA;
logic [1:0] PE; 
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
mp #(
    .HOLD_CYLES(16),
    .START_ADRESS(32'h00400000),
    .MEM_WIDHT(128),
    .BIN_FILE("../apps/text.bin")
) main_memory_inst (
    .clk             (clk),
    .reset_n         (reset_n),
    .addr            ({addr[31:5], 5'b0}),
    .data            (),
    .ce_n            (ce_n),
    .we_n            (we_n_fake),
    .oe_n            (oe_n_read),
    .multiple_read   (mr_e),
    .cache_data      (data_out_ram),
    .cache_read_full (finished_reading),
    .hold_o          (hold_wire),
    .bw              (bw)
);
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
//Address Converter
function automatic [15:0] conv_addr;
        input [31:0]  addr;
        begin
            conv_addr = {'0,(addr - START_ADRESS)};  // Subtract the two 32-bit addresses
        end
endfunction
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
// FSM Updater
always_ff @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        EA <= 2'b0;
    end else begin
        EA <= PE;
    end
end
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
// FSM State Changer
always_comb FSM_Logic: begin
    case (EA)
        2'b00: begin
            if(!ce_n && !oe_n) begin
                if(!hit) begin
                    PE = 2'b01;
                end else begin  
                    PE = 2'b10;
                end
            end else begin
                PE = 2'b00;
            end
        end
        2'b01: begin
            PE = 2'b00;
        end
        2'b10: begin
            PE = 2'b11;
        end
        2'b11: begin
            if(!hit && hold_wire) begin
                PE = 2'b01;
            end else begin
                PE = 2'b11;
            end
        end 
        default begin
            PE = 2'b00;
        end
    endcase
end
//////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////
// Hold Logic
always_comb Value_Logic: begin
    oe_n_read = 1'b1;
    mr_e = 1'b1;
    hold_cache = 1'b1;

    case (EA)
            2'b00: begin
                if(!oe_n && !ce_n && hit) begin
                    hold_cache = 1'b0;
                end
            end
            2'b01: begin
                hold_cache = 1'b1;
            end
            2'b10: begin
                hold_cache = 1'b0;
            end 
            2'b11: begin
                hold_cache = 1'b0;
                oe_n_read = 1'b0;   //Ler da MP
                mr_e = 1'b0;
            end
    endcase
end
//////////////////////////////////////////////////////////

always_comb DATA_CACHE_FILL: begin
    if(!reset_n) begin                      //Zerando tudo que da
        CACHE_1 = 0;
        CACHE_2 = 0;
        CACHE_3 = 0;
        CACHE_4 = 0;
        CACHE_5 = 0;
        CACHE_6 = 0;
        CACHE_7 = 0;
        CACHE_8 = 0;
        valid_bit = 0;
        data_out = 0;
        for(int i = 0; i < 8; i++) begin
            tag[i] = 0;
        end
    end else begin
        if(!hit) begin
            case (address_line) 
                3'b000: data_out = CACHE_1[address_word*32 +: 32];
                3'b001: data_out = CACHE_2[address_word*32 +: 32];
                3'b010: data_out = CACHE_3[address_word*32 +: 32];
                3'b011: data_out = CACHE_4[address_word*32 +: 32];
                3'b100: data_out = CACHE_5[address_word*32 +: 32];
                3'b101: data_out = CACHE_6[address_word*32 +: 32];
                3'b110: data_out = CACHE_7[address_word*32 +: 32];
                3'b111: data_out = CACHE_8[address_word*32 +: 32];
            endcase
        end else begin      
            if(EA == 2'b11) begin
                if(hold_wire) begin
                    valid_bit[address_line] <= 1'b1;
                    tag[address_line]       <= address_tag;

                    case(address_line) 
                        3'b000: CACHE_1 = data_out_ram;
                        3'b001: CACHE_2 = data_out_ram;
                        3'b010: CACHE_3 = data_out_ram;
                        3'b011: CACHE_4 = data_out_ram;
                        3'b100: CACHE_5 = data_out_ram;
                        3'b101: CACHE_6 = data_out_ram;
                        3'b110: CACHE_7 = data_out_ram;
                        3'b111: CACHE_8 = data_out_ram;                        
                    endcase
                end
            end
        end
    end
end

//////////////////////////////////////////////////////////
// ASSIGNS

assign address_line = addr[7:5] ;
assign address_word = addr[4:2] ;
assign address_tag  = addr[31:8];

//Certamente está correto
assign hold_o = hit;
assign hit = ((tag[address_line] == address_tag) && valid_bit[address_line])? 1'b0 : 1'b1;
assign we_n_fake = 1;                                           //Não queremos nunca escrever na Memoria de Instrucoes
assign data = (!oe_n && !hit)? data_out : 'z;

//Pode estar incorreto

//////////////////////////////////////////////////////////

endmodule
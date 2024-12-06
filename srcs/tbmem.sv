module tbmem;

logic clk;
logic reset_n;
wire logic [31:0]data_pins;
logic [31:0]data_w;
logic [31:0]data_r;
logic [31:0]addr;
logic ce_n;
logic we_n;
logic oe_n;
logic bw;

assign data_pins = data_w;
assign data_r = data_pins;

always begin
    #5.0 clk <= 0;
    #5.0 clk <= 1;
end

ram #(
 .BIN_FILE("../apps/text.bin")
) ram (
    .clk (clk),
    .reset_n(reset_n),
    .addr(addr),
    .data(data_pins),
    .ce_n(ce_n),
    .we_n(we_n),
    .oe_n(oe_n),
    .bw  (bw  )
);

initial begin
    clk = 0;
    reset_n = 0;
    ce_n = 1;
    we_n = 1;
    oe_n = 1;
    bw = 1;
    addr = 32'h10010000;
    data_w = 'z;
    #10
    reset_n = 1;
    #20
    oe_n = 0;
    ce_n = 0;
    #10
    oe_n = 1;
    ce_n = 1;
    
    #20
    ce_n = 0;
    data_w = 32'h37373737;
    we_n = 0;
    #10
    ce_n = 1;
    we_n = 1;
    data_w = 'z;
end

endmodule
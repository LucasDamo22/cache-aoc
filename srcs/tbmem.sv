module tbmem;

logic clk;
logic reset_n;
wire logic [31:0]data;
logic [31:0]addr;
logic ce_n;
logic we_n;
logic oe_n;
logic bw;

always begin
    #5.0 clk <= 0;
    #5.0 clk <= 1;
end

ram #(
 .BIN_FILE("/home/lucas.damo/Documents/org-arq/MIPS_MultiCiclo_Hold/apps/text.bin")
) ram (
    .clk (clk),
    .reset_n(reset_n),
    .addr(addr),
    .data(data),
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
    #10
    reset_n = 1;
    #20
    oe_n = 0;
    ce_n = 0;
    #10
    oe_n = 1;
    ce_n = 1;
    

end

endmodule
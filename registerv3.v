// 32 x 32 register file
module register_v3(
    input clk, write, reset,
    input [4:0] dest_reg, source_reg1, source_reg2,
    input[31:0] wrData,
    output[31:0] rdData1, rdData2
);

integer k;

reg [31:0] regfile[0:31];

assign rdData1 = regfile[source_reg1];
assign rdData2 = regfile[source_reg2];

always@(posedge clk) begin
    if (reset) begin
        for(k=0; k<32; k=k+1) begin
            regfile[k] <= 32'd0;
        end
    end

    else begin
        if(write) regfile[dest_reg] <= wrData;
    end
end
endmodule
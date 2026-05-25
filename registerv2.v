module regbank_v2(
    input clk, write,
    input [1:0] dest_reg, source_reg1, source_reg2,
    input[31:0] wrData,
    output[31:0] rdData1, rdData2
);

reg [31:0] R0, R1, R2, R3;

assign rdData1 = (source_reg1 == 0) ? R0: 
                 (source_reg1 == 1) ? R1: 
                 (source_reg1 == 2) ? R2: 
                 (source_reg1 == 3) ? R3:0; 

assign rdData2 = (source_reg2 == 0) ? R0: 
                 (source_reg2 == 1) ? R1: 
                 (source_reg2 == 2) ? R2: 
                 (source_reg2 == 3) ? R3:0; 

always@(posedge clk) begin
    case(dest_reg)
        0: R0 <= wrData ;
        1: R1 <= wrData ;
        2: R2 <= wrData ;
        3: R3 <= wrData ;
    endcase
end
endmodule

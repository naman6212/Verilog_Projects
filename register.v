// 4x32 register file
// quite tedious because if you have 32 registers the code becomes huge
module regbank_v1(
    input clk, write,
    input [1:0] dest_reg, source_reg1, source_reg2,
    input[31:0] wrData,
    output reg [31:0] rdData1, rdData2
);

reg [31:0] R0, R1, R2, R3;

always@(*) begin
    case(source_reg1)
        0: rdData1 = R0;
        1: rdData1 = R1;
        2: rdData1 = R2;
        3: rdData1 = R3;
        default: rdData1 = 32'hxxxxx;
    endcase
end

always@(*) begin
    case(source_reg2)
        0: rdData2 = R0;
        1: rdData2 = R1;
        2: rdData2 = R2;
        3: rdData2 = R3;
        default: rdData2 = 32'hxxxxx
    endcase
end

always@(posedge clk) begin
    case(dest_reg)
        0: R0 <= wrData ;
        1: R1 <= wrData ;
        2: R2 <= wrData ;
        3: R3 <= wrData ;
    endcase
end
endmodule

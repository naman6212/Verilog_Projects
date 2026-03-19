module fft(
    input clk,
    input signed[N+1:0] f0,f1,f2,f3, 
    output reg signed[N+3:0] F0_re, F0_im,
    output reg signed[N+3:0] F1_re, F1_im,
    output reg signed[N+3:0] F2_re, F2_im,
    output reg signed[N+3:0] F3_re, F3_im
);
    parameter N=3;
    //intermediate wire
    reg signed [N+2:0]G0,G1,G2;
    reg signed [N+2:0]G3_re,G3_im;
    //Intermediate stage dec
    //at the first clk edge
    always@(posedge clk) begin
        G0<=f0+f2;
        G1<=f0-f2;
        G2<=f1+f3;
        G3_re<=0;
        G3_im<=-(f1-f3);
    end
    //final stage value dec
    //at second clk edge
    always@(posedge clk) begin
        F0_re=G2+G0;
        F0_im=0;
        F2_re=G0-G2;
        F2_im=0;
        F1_re=G1+G3_re;
        F1_im=G3_im;
        F3_re=-G3_re+G1;
        F3_im=-G3_im;
    end
endmodule
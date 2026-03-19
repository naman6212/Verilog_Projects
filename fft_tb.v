module fft_tb;
    parameter N=3;
    reg clk;
    reg signed[N+1:0]f0,f1,f2,f3;
    wire signed[N+3:0]F0_re, F0_im,F1_re, F1_im,F2_re, F2_im,F3_re, F3_im;
    fft DUT(
        .clk(clk),
        .f0(f0), 
        .f1(f1), 
        .f2(f2), 
        .f3(f3), 
        .F0_re(F0_re), .F0_im(F0_im),
        .F1_re(F1_re), .F1_im(F1_im),
        .F2_re(F2_re), .F2_im(F2_im),
        .F3_re(F3_re), .F3_im(F3_im)
    );
    always #5 clk=~clk;


    initial 
    begin
        $dumpfile("FFT.vcd");
        $dumpvars(0, fft_tb);
        clk=0;
        f0 = 0; f1 = 0; f2 = 0; f3 = 0;
    
        #10;
        @(posedge clk);
        f0 = 10; f1 = 9; f2 = 6; f3 = 7;

        @(posedge clk);

        @(posedge clk);
        $display("Input: [f0=%d, f1=%d, f2=%d, f3=%d]", f0,f1,f2,f3);
        $display("Output F0: %d + %dj", F0_re, F0_im);
        $display("Output F1: %d + %dj", F1_re, F1_im);
        $display("Output F2: %d + %dj", F2_re, F2_im);
        $display("Output F3: %d + %dj", F3_re, F3_im);
        #10 $finish;
    end 
endmodule

module regbank_tb;

// Testbench Signals
reg [4:0] dest_reg, source_reg1, source_reg2;
reg [31:0] wrData;
reg write, reset, clk;
wire [31:0] rdData1, rdData2;
integer k;

// Device Under Test (DUT) Instantiation
register_v3 REG(
    .clk(clk), 
    .write(write), 
    .reset(reset), 
    .dest_reg(dest_reg), 
    .source_reg1(source_reg1), 
    .source_reg2(source_reg2), 
    .wrData(wrData), 
    .rdData1(rdData1), 
    .rdData2(rdData2)
);

// Clock Generation (10ns period)
initial clk = 1'b0;
always #5 clk = ~clk;

// VCD Dumping
initial begin
    $dumpfile("regfile.vcd");
    $dumpvars(0, regbank_tb);
end

// Main Stimulus Block
initial begin
    // Initialize signals
    reset = 1;
    write = 0;
    dest_reg = 0;
    source_reg1 = 0;
    source_reg2 = 0;
    wrData = 0;

    // Hold reset for a bit, then release it
    #10;
    reset = 0;
    @(posedge clk); // Sync to clock after reset

    // --- WRITE PHASE ---
    // Loop through all 32 registers and write (10 * k) to each
    for (k = 0; k < 32; k = k + 1) begin
        dest_reg = k; 
        wrData = 10 * k; 
        write = 1;
        @(posedge clk); // Wait for the clock edge to capture the write
    end

    // De-assert write so we don't accidentally keep overwriting memory
    write = 0; 
    dest_reg = 0;
    wrData = 0;
    @(posedge clk);

    // --- READ PHASE ---
    // Read registers in pairs (0 & 1, 2 & 3, etc.)
    for (k = 0; k < 32; k = k + 2) begin
        source_reg1 = k; 
        source_reg2 = k + 1;
        
        // Wait for a clock edge or small delay to let combinational outputs settle
        #5; 
        $display("reg[%2d] = %d, reg[%2d] = %d", source_reg1, rdData1, source_reg2, rdData2);
    end

    // Finish simulation
    #100;
    $finish;
end

endmodule
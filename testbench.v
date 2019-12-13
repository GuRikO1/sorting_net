`default_nettype none

module testbench();
    reg clk, pc;
    wire [31:0] writedata, dataadr;
    wire memwrite;
    wire [32*32-1:0] d;

    wire [31:0] dd[32-1:0];
    genvar i;
    generate
        for (i = 0; i < 32; i = i + 1) begin
            assign dd[i] = d[(i+1)*32-1:i*32];
        end
    endgenerate
    
    top top(clk, d);

    always begin
        clk <= 1; #5; clk <= 0; #5;
    end

    always @(negedge clk) begin
        // $monitor("f=%d", top.sort.dd[0]);
        $monitor("c1=%d, c2=%d, c3=%d, c4=%d", dd[28], dd[29], dd[30], dd[31]);
        if (top.pc[8:2] == 96) begin
               $stop;
        end
    end


endmodule

`default_nettype wire
`default_nettype none

module mem(input wire clk,
           input wire [6:0] a,
           output wire [32*32-1:0] rd);

    reg [31:0] mem[127:0];
    reg [31:0] rrd[32-1:0];

    genvar i;
    generate
        for (i = 0;i < 32;i = i + 1) begin
            assign rd[(i+1)*32-1:i*32] = rrd[i];
        end
    endgenerate
    
    
    
    initial begin
        $readmemh("numseries.dat", mem);
    end
    
    integer j;

    always @(posedge clk) begin
        for (j = 0; j < 32; j = j + 1) begin
            rrd[j] <= mem[a+j];
        end
    end

 
endmodule

`default_nettype wire
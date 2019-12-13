`default_nettype none

module top(input wire clk,
           output wire [32*32-1:0] d);

    wire [31:0] pc;
    wire [32*32-1:0] a;

    count cnt(clk, pc);
    mem mem(clk, pc[8:2], a);
    sort32 sort(a, d);


endmodule

`default_nettype wire
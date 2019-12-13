`default_nettype none

module sort4(input wire [32*4-1:0] a,
             output wire [32*4-1:0] d);

    wire [31:0] b[3:0];
    wire [31:0] c[3:0];
    wire [31:0] aa[3:0];
    wire [31:0] dd[3:0];

    genvar i;
    generate
        for (i = 0; i < 4; i = i + 1) begin
            assign aa[i] = a[(i+1)*32-1:i*32];
            assign d[(i+1)*32-1:i*32] = dd[i];
        end
    endgenerate

    comparator cmp1(aa[0], aa[1], b[0], b[1]);
    comparator cmp2(aa[2], aa[3], b[2], b[3]);
    comparator cmp3(b[0], b[2], dd[0], c[2]);
    comparator cmp4(b[1], b[3], c[1], dd[3]);
    comparator cmp5(c[1], c[2], dd[1], dd[2]);

endmodule

`default_nettype wire
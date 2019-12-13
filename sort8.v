`default_nettype none

module sort8(input wire [32*8-1:0] a,
             output wire [32*8-1:0] e);

    wire [32*4-1:0] bb[1:0];
    wire [31:0] b[7:0];
    wire [31:0] c[7:0];
    wire [31:0] d[7:0];
    wire [32*4-1:0] aa[1:0];
    wire [31:0] ee[7:0];

    genvar i, j;
    generate
        for (i = 0; i < 2; i = i + 1) begin
            assign aa[i] = a[(i+1)*32*4-1:i*32*4];
            sort4 sort(aa[i], bb[i]);
            for (j = 0; j < 4; j = j + 1) begin
                assign b[4 * i + j] = bb[i][(j+1)*32-1:j*32];
            end
        end
    endgenerate

    generate
        for (i = 0; i < 4; i = i + 1) begin
            comparator cmp(b[i], b[i+4], c[i], c[i+4]);
        end
    endgenerate

    generate
        for (i = 2; i < 4; i = i + 1) begin
            comparator cmp(c[i], c[i+2], d[i], d[i+2]);
        end
    endgenerate

    generate
        for (i = 0; i < 2; i = i + 1) begin
            assign d[i] = c[i];
        end
    endgenerate
    generate
        for (i = 6; i < 8; i = i + 1) begin
            assign d[i] = c[i];
        end
    endgenerate

    generate
        for (i = 1; i < 6; i = i + 2) begin
            comparator cmp(d[i], d[i+1], ee[i], ee[i+1]);
        end
    endgenerate

    generate
        for (i = 0; i < 8; i = i + 7) begin
            assign ee[i] = d[i];
        end
    endgenerate

    generate
        for (i = 0; i < 8; i = i + 1) begin
            assign e[(i+1)*32-1:i*32] = ee[i];
        end
    endgenerate

endmodule

`default_nettype wire
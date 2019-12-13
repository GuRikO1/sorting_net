`default_nettype none

module sort32(input wire [32*32-1:0] a,
              output wire [32*32-1:0] g);

    wire [32*16-1:0] aa[1:0];
    wire [32*16-1:0] bb[1:0];
    wire [31:0] b[31:0];
    wire [31:0] c[31:0];
    wire [31:0] d[31:0];  
    wire [31:0] e[31:0];
    wire [31:0] f[31:0];
    wire [31:0] gg[31:0];

    genvar i, j;
    generate
        for (i = 0; i < 2; i = i + 1) begin
            assign aa[i] = a[(i+1)*32*16-1:i*32*16];
            sort16 sort(aa[i], bb[i]);
            for (j = 0; j < 16; j = j + 1) begin
                assign b[16 * i + j] = bb[i][(j+1)*32-1:j*32];
            end
        end
    endgenerate

    generate
        for (i = 0; i < 16; i = i + 1) begin
            comparator cmp(b[i], b[i+16], c[i], c[i+16]);
        end
    endgenerate

    generate
        for (i = 8; i < 16; i = i + 1) begin
            comparator cmp(c[i], c[i+8], d[i], d[i+8]);
        end
    endgenerate

    generate
        for (i = 0; i < 25; i = i + 24) begin
            for (j = 0; j < 8; j = j + 1) begin
                assign d[i+j] = c[i+j];
            end
        end
    endgenerate

    generate
        for (i = 4; i < 24; i = i + 8) begin
            for (j = 0; j < 4; j = j + 1) begin
                comparator cmp(d[i+j], d[i+j+4], e[i+j], e[i+j+4]);
            end
        end
    endgenerate

    generate
        for (i = 0; i < 29; i = i + 28) begin
            for (j = 0; j < 4; j = j + 1) begin
                assign e[i+j] = d[i+j];
            end
        end
    endgenerate

    generate
        for (i = 2; i < 28; i = i + 4) begin
            for (j = 0; j < 2; j = j + 1) begin
                comparator cmp(e[i+j], e[i+j+2], f[i+j], f[i+j+2]);
            end
        end
    endgenerate

    generate
        for (i = 0; i < 31; i = i + 30) begin
            for (j = 0; j < 2; j = j + 1) begin
                assign f[i+j] = e[i+j];
            end
        end
    endgenerate

    generate
        for (i = 1; i < 30; i = i + 2) begin
            comparator cmp(f[i], f[i+1], gg[i], gg[i+1]);
        end
    endgenerate

    generate
        for (i = 0; i < 32; i = i + 31) begin
            assign gg[i] = f[i];
        end
    endgenerate

    generate
        for (i = 0; i < 32; i = i + 1) begin
            assign g[(i+1)*32-1:i*32] = gg[i];
        end
    endgenerate

endmodule

`default_nettype wire
`default_nettype none

module sort16(input wire [32*16-1:0] a,
             output wire [32*16-1:0] f);

    wire [32*8-1:0] aa[1:0];
    wire [32*8-1:0] bb[1:0];
    wire [31:0] b[15:0];
    wire [31:0] c[15:0];
    wire [31:0] d[15:0];  
    wire [31:0] e[15:0];
    wire [31:0] ff[15:0];

    genvar i, j;
    generate
        for (i = 0; i < 2; i = i + 1) begin
            assign aa[i] = a[(i+1)*32*8-1:i*32*8];
            sort8 sort(aa[i], bb[i]);
            for (j = 0; j < 8; j = j + 1) begin
                assign b[8 * i + j] = bb[i][(j+1)*32-1:j*32];
            end
        end
    endgenerate

    generate
        for (i = 0; i < 8; i = i + 1) begin
            comparator cmp(b[i], b[i+8], c[i], c[i+8]);
        end
    endgenerate

    generate
        for (i = 4; i < 8; i = i + 1) begin
            comparator cmp(c[i], c[i+4], d[i], d[i+4]);
        end
    endgenerate

    generate
        for (i = 0; i < 13; i = i + 12) begin
            for (j = 0; j < 4; j = j + 1) begin
                assign d[i+j] = c[i+j];
            end
        end
    endgenerate

    generate
        for (i = 2; i < 11; i = i + 4) begin
            for (j = 0; j < 2; j = j + 1) begin
                comparator cmp(d[i+j], d[i+j+2], e[i+j], e[i+j+2]);
            end
        end
    endgenerate

    generate
        for (i = 0; i < 15; i = i + 14) begin
            for (j = 0; j < 2; j = j + 1) begin
                assign e[i+j] = d[i+j];
            end
        end
    endgenerate

    generate
        for (i = 0; i < 16; i = i + 15) begin
            assign ff[i] = e[i];
        end
    endgenerate

    generate
        for (i = 1; i < 14; i = i + 2) begin
            comparator cmp(e[i], e[i+1], ff[i], ff[i+1]);
        end
    endgenerate

    generate
        for (i = 0; i < 16; i = i + 1) begin
            assign f[(i+1)*32-1:i*32] = ff[i];
        end
    endgenerate

endmodule

`default_nettype wire
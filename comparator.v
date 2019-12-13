`default_nettype none

module comparator(input wire [31:0] inup, indown,
                  output wire [31:0] outup, outdown);

    assign outup = (inup < indown) ? inup : indown;
    assign outdown = (inup > indown) ? inup : indown;

endmodule

`default_nettype wire
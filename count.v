`default_nettype none

module count(input wire clk,
          output reg [31:0] pc);

     initial begin
          #5 pc = 0;
     end     

     always @(posedge clk) begin
          pc = pc + 32 * 4;
     end

endmodule

`default_nettype wire
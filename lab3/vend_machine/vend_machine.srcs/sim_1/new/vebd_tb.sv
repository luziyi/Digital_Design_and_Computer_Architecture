`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2023/05/17 19:46:24
// Design Name: 
// Module Name: vend_tb
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module vend_tb();
logic sys_clk; 
logic sys_rst_n;
logic coin5, coin10;
logic [3:0] an; 
logic [7:0] a_to_g;
logic open;

vend u_vend(
    .sys_clk(sys_clk),
    .sys_rst_n(sys_rst_n),
    .coin5(coin5),
    .coin10(coin10),
    .an(an), 
    .a_to_g(a_to_g),
    .open(open)
);


initial begin
    sys_clk = 1'b0;
    forever #5 sys_clk = ~sys_clk;
end

initial begin
    sys_rst_n = 1'b0;
    #10 sys_rst_n = 1'b1;
    coin5 = 1'b0;
    coin10 = 1'b0;
    #10 coin5 = 1'b1;
    #10 coin5 = 1'b0;
    #10 coin10 = 1'b1;
    #10 coin10 = 1'b0;
    #10 coin5 = 1'b1;
    #10 coin5 = 1'b0;
    #10 coin10 = 1'b1;
    #10 coin10 = 1'b0;
    #10 coin5 = 1'b1;
    #10 coin5 = 1'b0;
    #10 coin10 = 1'b1;
    #10 coin10 = 1'b0;
    #10 coin5 = 1'b1;
    #10 coin5 = 1'b0;
    #10 coin10 = 1'b1;
    #10 coin10 = 1'b0;
    #10 coin5 = 1'b1;
    #10 coin5 = 1'b0;
    #10 coin10 = 1'b1;
    #10 coin10 = 1'b0;
    #10 coin5 = 1'b1;
    #10 coin5 = 1'b0;
    #10 coin10 = 1'b1;
    #10 coin10 = 1'b0;
    #10 coin5 = 1'b1;
    #10 coin5 = 1'b0;
    #10 coin10 = 1'b1;
    #10 coin10 = 1'b0;
    #10 coin5 = 1'b1;
    #10 coin5 = 1'b0;
    #10 coin10 = 1'b1;
    #10 coin10 = 1'b0;
    #10 coin5 = 1'b1;
    #10 coin5 = 1'b0;
    #10 coin10 = 1'b1;
    #10 coin10 = 1'b0;
    #10 coin5 = 1'b1;
    #10 coin5 = 1'b0;
    #10 coin10 = 1'b1;
    #10 coin10 = 1'b0;
    #10 coin5 = 1'b1;
    #10 coin5 = 1'b0;

end




endmodule

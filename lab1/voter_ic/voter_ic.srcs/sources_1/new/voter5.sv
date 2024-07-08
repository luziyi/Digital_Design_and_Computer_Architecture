`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/15 16:09:03
// Design Name: 
// Module Name: voter5
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


module voter5(
    input [4:0] I,
    output  pass
    );
    logic [7:0] y1;
    logic [3:0] y2;
    
    dec_74LS138 DUT1(.G(1'b1),.G_2A(1'b0),.G_2B(1'b0),.D(I[4:2]),.Y(y1));
    dec_74LS139 DUT2(.S(1'b0),.D(I[1:0]),.Y(y2));
    
    assign pass=~y1[7]|(~y1[3]|~y1[5]|~y1[6])&(~y2[1]|~y2[2]|~y2[3])|~y2[3]&(~y1[1]|~y1[2]|~y1[4]);
endmodule

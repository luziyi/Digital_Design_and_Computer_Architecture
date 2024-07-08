`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/15 16:21:54
// Design Name: 
// Module Name: dec_74LS139
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


module dec_74LS139(
    input S,
    input [1:0] D,
    output [3:0] Y
    );
    reg [3:0] y;
    always @* begin
        if (~S)
            case (D)
                2'b00: y = 4'b1110;
                2'b01: y = 4'b1101;
                2'b10: y = 4'b1011;
                2'b11: y = 4'b0111;
            endcase
    end
    assign Y = y;
endmodule

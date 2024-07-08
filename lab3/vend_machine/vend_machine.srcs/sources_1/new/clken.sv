`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/03 18:28:53
// Design Name: 
// Module Name: clken
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


module clken (
input logic sys_clk, 
input logic sys_rst_n, 
output logic clk_1MS
);

reg [19:0] cnt;

always_ff @( posedge sys_clk ) begin 
    if (!sys_rst_n) begin
        clk_1MS <= 1'b0;
        cnt <= 0;
    end else begin
        if (cnt == 24999) begin
            clk_1MS <= 1;
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
            clk_1MS <= 0;
        end
    end
end
endmodule

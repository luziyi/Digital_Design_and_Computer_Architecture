`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/30 14:22:43
// Design Name: 
// Module Name: pc
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


module pc(

    input cpu_clk,
    input cpu_rst_n,
    input [31:0] current_addr,
    output logic [31:0] next_addr
    
);
    always @(posedge cpu_clk) begin
    
       if(cpu_rst_n)
           next_addr <= current_addr;
       else 
           next_addr <= 0;
           
    end
    
endmodule

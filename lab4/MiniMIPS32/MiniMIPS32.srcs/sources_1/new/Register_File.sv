`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/06/30 14:23:36
// Design Name: 
// Module Name: Register_File
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


module Register_File(

    input               sys_clk,WE3,sys_rst_n,
    input        [4:0]  A1,A2,
    output logic [31:0] RD1,RD2,
    input        [4:0]  A3,
    input        [31:0] WD3
    
);

    logic [31:0] r [31:0];
    int i;
    
    always @(posedge sys_clk) begin
    
        if(!sys_rst_n) begin
            for(i = 0 ; i < 32 ; i = i + 1)begin
                r[i] <= 32'b0000_0000_0000_0000_0000_0000_0000_0000;
            end
        end
        else if(WE3) begin
            r[A3] <= WD3;
        end
        
    end
    
    assign RD1 = r[A1];
    assign RD2 = r[A2];
    
endmodule


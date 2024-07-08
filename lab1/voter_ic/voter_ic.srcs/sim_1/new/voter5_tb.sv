`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/04/15 16:33:55
// Design Name: 
// Module Name: voter5_tb
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


module voter5_tb( );
    logic [4:0] I;
    logic  pass ;
    int i;
    

    initial begin
        for(i=0;i<32;i=i+1) begin
            I=i;
            #20;
        end
    end
    voter5 DUT_tb(.I(I),.pass(pass));
    
    initial begin 
    $timeformat(-9, 0, "ns", 5);
    $monitor("At time %t: I = %b, pass = %b ", $time,I, pass);
    end
        
endmodule

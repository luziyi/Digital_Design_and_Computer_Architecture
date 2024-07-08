module vend(
    input sys_clk, sys_rst_n,
    input coin5, coin10,
    output [3 : 0] an,
    output [7 : 0] a_to_g,
    output open
    );
    
    logic clk_1MS;
    logic coin5_pluse, coin10_pluse;
    logic [4 : 0] price, change;
    logic [7 : 0] dis_price, dis_change;
    logic [3 : 0] x7seg_data;
    
    clken U0(
        .sys_clk    (sys_clk)   ,
        .sys_rst_n  (sys_rst_n) ,
        .clk_1MS    (clk_1MS)   
    );
        
    edge_det U1(
        .sys_clk        (sys_clk)       ,
        .sys_rst_n      (sys_rst_n)     ,
        .coin5          (coin5)         ,
        .coin10         (coin10)        ,
        .coin5_pluse    (coin5_pluse)   ,
        .coin10_pluse   (coin10_pluse)
    );
    
    vend_fsm U2(
        .sys_clk     (sys_clk)  ,
        .sys_rst_n   (sys_rst_n),
        .coin5       (coin5_pluse)    , 
        .coin10      (coin10_pluse)   ,
        .price       (price)    , 
        .change      (change)   ,
        .open        (open)
    );
    
    bin2bcd_0 U3(
        .bin({3'b000, price}), 
        .bcd(dis_price)
    );
    
    bin2bcd_0 U4(
        .bin({3'b000, change}), 
        .bcd(dis_change)
    );
    
    x7seg_scan U5(
        .sys_clk    (sys_clk),
        .sys_rst_n  (sys_rst_n), 
        .clk_flag   (clk_1MS),
        .dis_price  (dis_price),
        .dis_change (dis_change),
        .x7seg_data (x7seg_data),
        .an         (an)
    );
    
    x7seg_dec U6(
        .D      (x7seg_data),
        .a_to_g (a_to_g)
    );
    
endmodule
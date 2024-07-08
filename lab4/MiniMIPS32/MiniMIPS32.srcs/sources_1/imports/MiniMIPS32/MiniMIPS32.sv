`include "defines.sv"

module MiniMIPS32(

    input  logic        cpu_clk,
    input  logic        cpu_rst_n,
    output logic [31:0] iaddr,
    input  logic [31:0] inst,
    output logic [31:0] daddr, 
    output logic        we,   
    output logic [31:0] din,     
    input  logic [31:0] dout    
    
);

   logic [31:0] Instruction ;
   logic [5:0] op, funct;
   logic [4:0] rs, rt, rd;
   logic [15:0] imm;
   logic [25:0] instr_index;
   logic pcflag,regdst,mem_to_reg,j_flag;
   logic [1:0] alusrc;                //alusrc  0-RD2   1-exend   2-extend_0
   logic we3;
   
   assign Instruction = {inst[7:0],inst[15:8],inst[23:16],inst[31:24]};
   assign op = Instruction[31:26];
   assign rs = Instruction[25:21];
   assign rt = Instruction[20:16];
   assign rd = Instruction[15:11];
   assign imm = Instruction[15:0];
   assign funct = Instruction[5:0];
   assign instr_index = Instruction[25:0];
   
   logic [31:0] current_addr;
   logic [31:0] next_addr;  
   logic [1:0]  AluControl;
   logic [31:0] aluresult;
   logic [31:0] extend;
   logic [31:0] extend_0;
   logic [31:0] alu1;
   logic [31:0] alu2;
   logic [31:0] RD1;
   logic [31:0] RD2;
   logic [31:0] RD;
   logic [31:0] WD3;
   logic [4:0]  A3;
       
   always_comb begin
   
        case(op)
             6'b100011: begin    //lw
                we=0;
                we3=1;
                pcflag=0;
                regdst=0;
                alusrc=2'b01;
                mem_to_reg=1;
                j_flag=0;
                AluControl=2'b00;
             end
             6'b101011: begin    //sw
                if(daddr[31:16] == 16'h8000 || daddr[31:16] == 16'h8004) 
                    we=0;
                else 
                    we=1;
                we3=0;
                pcflag=0;
                regdst=0;
                alusrc=2'b01;
                mem_to_reg=0;
                j_flag=0;
                AluControl=2'b00;
             end  
             6'b001111: begin    //lui
                we=0;
                we3=1;
                pcflag=0;
                regdst=0;
                alusrc=2'b10;
                mem_to_reg=0;
                j_flag=0;
                AluControl=2'b10;
             end
             6'b001101: begin    //ori
                we=0;
                we3=1;
                pcflag=0;
                regdst=0;
                alusrc=2'b10;
                mem_to_reg=0;
                j_flag=0;
                AluControl=2'b01;
             end
             6'b001001: begin    //addiu
                we=0;
                we3=1;
                pcflag=0;
                regdst=0;
                alusrc=2'b01;
                mem_to_reg=0;
                j_flag=0;
                AluControl=2'b00;
             end
             6'b000000: begin       
                if(funct==6'b100001) begin      //addu
                    we=0;
                    we3=1;
                    pcflag=0;
                    regdst=1;
                    alusrc=2'b00;
                    mem_to_reg=0;
                    j_flag=0;
                    AluControl=2'b00;
                end
                else if(funct==6'b101010) begin     //slt
                    we=0;
                    we3=1;
                    pcflag=0;
                    regdst=1;
                    alusrc=2'b00;
                    mem_to_reg=0;
                    j_flag=0;
                    AluControl=2'b11;
                end
             end
             6'b000100: begin
                we=0;
                we3=0;
                if(RD1==RD2)
                    pcflag=1;
                else
                    pcflag=0;
                regdst=0;
                alusrc=2'b00;
                mem_to_reg=0;
                j_flag=0;
                AluControl=2'b00;
             end
             6'b000101: begin
                we=0;
                we3=0;
                if(RD1!=RD2)
                    pcflag=1;
                else
                    pcflag=0;
                regdst=0;
                alusrc=2'b00;
                mem_to_reg=0;
                j_flag=0;
                AluControl=2'b00;              
             end
             6'b000010: begin
                we=0;
                we3=0;
                j_flag=1;
             end
             default 
                pcflag=0; 
        endcase
        
    end
    
    Register_File rf(
        .sys_clk(cpu_clk), 
        .WE3(we3), 
        .sys_rst_n(cpu_rst_n),
        .A1(rs),
        .A2(rt),
        .RD1(RD1), 
        .RD2(RD2),
        .A3(A3),
        .WD3(WD3)
    );
    
    
    always_comb begin  
      
        int i;
        for(i = 16 ; i < 32 ; i = i + 1)
            extend[i]=imm[15];
        extend[15:0] = imm ;
        for(i = 16 ; i < 32 ; i = i + 1)
            extend_0[i]=0;
        extend_0[15:0]=imm;
          
        alu1 = RD1;
        if(alusrc == 2'b00)
            alu2 = RD2;
        else if(alusrc == 2'b01)
            alu2 = extend;
        else 
            alu2 = extend_0;
        if(AluControl == 2'b00)
            aluresult = alu1 + alu2;
        else if(AluControl == 2'b01)
            aluresult=alu1|alu2;
        else if(AluControl == 2'b10)
            aluresult = alu2 << 16;
        else if(AluControl == 2'b11) begin
            if(alu1[31] == 1 && alu2[31] == 0) aluresult = 32'b1;
            else if(alu1[31] == 0 && alu2[31] == 1) aluresult = 32'b0;
            else aluresult = alu1[30:0] < alu2[30:0]? 32'b1:32'b0;;
        end
  
        if(regdst==1)
            A3=rd;
        else
            A3=rt;
     
        if(mem_to_reg==0)
            WD3 = aluresult;
        else
            WD3 = {dout[7:0],dout[15:8],dout[23:16],dout[31:24]};
         
        if(!j_flag) begin
            if(pcflag == 0)
                current_addr = next_addr + 4;
            else if(pcflag==1)
                current_addr = next_addr + 4 + (extend << 2);
        end
        else begin
            logic[31:0] mid;
            mid = next_addr + 4;
            current_addr = {mid[31:28],instr_index[25:0],2'b00};
        end   
            
    end 
    
    assign daddr = aluresult;                                             //A
    assign {din[7:0],din[15:8],din[23:16],din[31:24]} = RD2;             //WD
                                                  
    pc pc_count(
        .cpu_clk(cpu_clk),
        .cpu_rst_n(cpu_rst_n),
        .current_addr(current_addr),
        .next_addr(next_addr)
        );
    assign iaddr = next_addr;
      
    
endmodule


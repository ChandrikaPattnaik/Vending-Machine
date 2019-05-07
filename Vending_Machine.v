

module Vending_Machine(A_o,B_o,C_o,Total_Amount,clk,R,A,B,C,D,Q,I,N);

input clk,R;
input D,Q,I,N;
input A,B,C;

output reg A_o,B_o,C_o;
output Total_Amount;

reg [1:0] ps,ns;
reg [6:0] count;
reg Lid;
reg [6:0]Total_Amount;


always@(posedge clk or posedge R)
begin
	if(R)
	  ps <= 2'b00;
 
	else
	  ps <= ns;
end

 
always@(ps or N or I or Q or D)
	case(ps)
	  2'b00:begin
				
				A_o <= 1'b0;
				B_o <= 1'b0;
				C_o <= 1'b0;
				
				Total_Amount <= count;
				count <= 3'b0;

				ns <= 2'b01;
				end
				
	 2'b01:begin

				if(N)
				count = count + 7'b101;	
				else if(I)
				count = count + 7'b1010;
				else if(Q)
				count = count + 7'b11001;
				else if(D)
				count = count + 7'd1000100;
				else
				count = count;

								
				if(count >= 7'b1000110)
					ns = 2'b10;
				else
					ns = 2'b01;
				end 
				
	  2'b10:begin
	  	
				if (A == 1'b1 && B == 1'b0 && C == 1'b0)
					A_o <= 1'b1;

				else if (A == 1'b0 && B == 1'b1 && C == 1'b0)
					B_o <= 1'b1;
			 
				else if (A == 1'b0 && B == 1'b0 && C == 1'b1)
					C_o <= 1'b1;
					
				else 
					begin
					A_o <= 1'b0;
					B_o <= 1'b0;
					C_o <= 1'b0;
					end	
				
				end
	endcase
	
endmodule	


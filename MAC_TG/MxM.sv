`timescale 1ns / 1ps
`include "../Header/MAC_H.vh" 

module MxM #(parameter W = 8, N = 1000)( //W = bit-width, N = common inner dimension of the matrices: (MxN)x(NxP) -> (MxP)
	input clk, rst,
	input [W-1:0] A, X,
	output reg [W-1:0] Y
);
	
	reg [W-1:0] Y0, Y1; 
	reg [log2(N)-1:0] n; 
	
	MAC #(.N(W)) _MAC(
		.A(A),
		.X(X),
		.Y0(Y0),
		.Y(Y1)
	);
	
	always @(posedge clk)
		if(rst) begin
			n <= 0; 
		end
		else begin		
			n <= n+1;	
			if (n == N-1) n <= 0; 

			if (n == 0) begin
				Y0 <= 0;
				Y <= Y1;
			end
			else Y0 <= Y1;
		end
	
endmodule
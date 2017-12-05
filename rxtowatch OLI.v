`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:47:33 06/26/2016 
// Design Name: 
// Module Name:    txtowatch 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module rxtowatch(
    input [7:0] datarx,
	 input clk,
	 input ra,
	 output reg r,g,c,u,p
    );
	 
	reg [7:0]olddatarx;
	
	localparam Cl=8'b01000011, cl=8'b01100011,//clear
	           Go=8'b01000111, go=8'b01100111, //go
				  Pa=8'b01010000, pa=8'b01110000,//pause
	           Up=8'b01010101, up=8'b01110101, //up/down
				  Re=8'b01010010, re=8'b01110010;//receive
				  
	always @(*)
	    begin
	    g=0;
		 c=0;
		 p=0;
		 u=0;
		 r=0;
	     case(olddatarx)
		     Cl: begin c=1;g=0; end
			  cl: begin c=1;g=0; end
			  Go: begin g=1; end
			  go: begin g=1; end
			  Pa: begin p=~p;g=1;end
			  pa: begin p=~p;g=1;end
			  Up: begin u=~u;g=1;end
			  up: begin u=~u;g=1;end
			  Re: begin r=1;g=1; end
			  re: begin r=1;g=1; end
			  endcase
			if(ra)r=0;
			  end

	 always @(posedge clk)
	      olddatarx <= datarx;


endmodule

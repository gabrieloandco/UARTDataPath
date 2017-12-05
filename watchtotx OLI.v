`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:00:01 06/26/2016 
// Design Name: 
// Module Name:    watchtotx 
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
module watchtotx(
	 input wire clk,
	 input wire r,
	 input wire [3:0]d0,d1,d2,d3, //datos del watch
	 output reg we,
	 output reg [7:0]datatx,//datos a transmitir
	 output reg ra
    );
	 
	 reg [7:0]ascid0,ascid1,ascid2,ascid3;
	 
	 localparam dot=8'b101110,cero=8'b110000,
				  uno=8'b110001,dos=8'b110010,
				  tres=8'b110011,cuatro=8'b110100,
				  cinco=8'b110101,seis=8'b110110,
				  siete=8'b110111,ocho=8'b111000,
				  nueve=8'b111001; //VALORES ASCII
				  
	localparam E0=3'b0,E1=3'b1,E2=3'b10,E3=3'b11,E4=3'b100,E5=3'b101,E6=3'b110;
	reg [2:0]Eold,Enew;
	
	//Conversion decimal to ASCII
	always @(*)
	begin
		    ascid0=d0+cero;
		    ascid1=d1+cero;
		    ascid2=d2+cero;
		    ascid3=d3+cero;
			 ra=0;
	//Combitional state logic
	    begin	 
		    case(Eold)
		        E0: begin Enew=E1; datatx=ascid3;we=1;ra=1; end
			     E1: begin Enew=E2; datatx=dot;we=1;ra=1;end
			     E2: begin Enew=E3; datatx=ascid2;we=1;ra=1;end
			     E3: begin Enew=E4; datatx=ascid1;we=1;ra=1;end
			     E4: begin Enew=E5; datatx=dot;we=1;ra=1; end
			     E5: begin Enew=E6; datatx=ascid0;we=1;ra=1;end
				  E6: begin Enew=E6; datatx=0;we=0; ra=1; end
				  default: begin Enew=3'bxxx; datatx=0;we=0; ra=0;end
		    endcase 
		 end
		end
	//New state sequential logic
	always @(posedge clk or posedge r)
	    begin
	      Eold <= Enew;
		   if(r) Eold <= E0;
		   end
endmodule

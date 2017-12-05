`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:47:49 06/26/2016 
// Design Name: 
// Module Name:    MAESTRO 
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
module MAESTRO(
    input wire clk,
	 input wire rx,
	 input wire reset, //quitar luego colocar en watchtotx 
    output wire tx,
	 output wire [7:0] led,
    output wire [3:0] an,
    output wire [7:0] sseg
    );
	 
	 wire g,c,u,p,r; //comandos stopwatch
	 
	 wire [3:0] d3,d2,d1,d0; //output
	 wire [7:0]datarx,datatx; //wire cepcion y wire transmision 
   // instantiate 7-seg LED display module
	wire we;wire ra;
	
   disp_hex_mux disp_unit
      (.clk(clk), .reset(1'b0),
       .hex3(d3), .hex2(d2), .hex1(d1), .hex0(d0),
       .dp_in(4'b0101), .an(an), .sseg(sseg));

   // instantiate stopwatch
   stop_watch_if stopwatch
      (.clk(clk),
		.d3(d3),
       .d2(d2), .d1(d1), .d0(d0),.g(g), .c(c), .u(u),.p(p));
	 
	 //instantiate the uart
	 uart_test uart (
    .clk(clk), 
    .reset(reset), 
	 .r(we),
    .rx(rx), 
    .tx(tx), 
    .rec_data1(datatx), 
    .led(led), 
    .rec_data(datarx)
    );
	 
	 //reception to stopwatch conversor
	 rxtowatch rxtowatch (
    .datarx(datarx), 
    .clk(clk), 
	 .ra(ra),
    .r(r), 
    .g(g), 
    .c(c), 
    .u(u), 
    .p(p)
    );
	 
	 //stopwatch to transmission signal conversion
	 watchtotx watchtotx (
    .clk(clk), 	
     .r(r),	 
    .d0(d0), 
    .d1(d1), 
    .d2(d2), 
    .d3(d3), 
    .datatx(datatx),
	 .we(we),
	 .ra(ra)
    );




endmodule

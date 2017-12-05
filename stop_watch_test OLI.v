module stop_watch_test
   (
    input wire clk,
	 input wire g,c,u,p,
    output wire [3:0] an,
    output wire [7:0] sseg
   );
    wire [3:0] d3,d2,d1,d0; //output
   // instantiate 7-seg LED display module
   disp_hex_mux disp_unit
      (.clk(clk), .reset(1'b0),
       .hex3(d3), .hex2(d2), .hex1(d1), .hex0(d0),
       .dp_in(4'b0101), .an(an), .sseg(sseg));

   // instantiate stopwatch
   stop_watch_if counter_unit
      (.clk(clk),
		.d3(d3),
       .d2(d2), .d1(d1), .d0(d0),.g(g), .c(c), .u(u),.p(p) );

endmodule


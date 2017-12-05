//Listing 8.5
module uart_test
   (
    input wire clk,
	 input wire reset,
    input wire rx,
	 input wire r,
    output wire tx,
	 input wire [7:0] rec_data1, //Transmisor
    output wire [7:0] led,
	 output wire [7:0] rec_data //Recepcion
   );

   // signal declaration
   wire tx_full, rx_empty, btn_tick;
   localparam sw=1;
   // body
   // instantiate uart
   uart uart_unit
      (.clk(clk), .reset(reset), .rd_uart(btn_tick),
       .wr_uart(r), .rx(rx), .w_data(rec_data1),
       .tx_full(tx_full), .rx_empty(rx_empty),
       .r_data(rec_data), .tx(tx));
   // instantiate debounce circuit
   debounce btn_db_unit
      (.clk(clk), .reset(reset), .sw(sw),
       .db_level(), .db_tick(btn_tick));
   // incremented data loops back
 
   // LED display
   assign led = {1'b1, ~tx_full, 2'b11, ~rx_empty, 3'b111};
	


endmodule
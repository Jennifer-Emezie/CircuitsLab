module lab4task3_top(
	input logic [1:0] KEY,
	input logic 		MAX10_CLK1_50,
	output logic [6:0] HEX0, HEX1
);
							
	logic [3:0] BCD0, BCD1;
	logic [6:0] data_out;
	
	lfsr7  SHFT(
				.rst(~KEY[0]),
				.clk(~KEY[1]),				
				.data_out(data_out));

	bin2bcd_16 CONV(
					.x({9'd0, data_out}), 
					.BCD0(BCD0),
					.BCD1(BCD1));		
						
	hexto7seg SEG0 (.out(HEX0), .in(BCD0));
	hexto7seg SEG1 (.out(HEX1), .in(BCD1));
	
endmodule

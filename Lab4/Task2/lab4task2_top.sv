module lab4task2_top(
	input logic [0:1] KEY,
	input logic MAX10_CLK1_50,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4
);
	clktick #(.WIDTH(16)) click(
						.clk(MAX10_CLK1_50),
						.rst(~KEY[1]),
						.en(~KEY[0]),
						.N(49999),
						.tick(tick));
						
	logic [15:0]		count;
	counter  #(.WIDTH(16)) CTR16 (
						.clk(MAX10_CLK1_50),
						.rst(~KEY[1]),
						.en(~KEY[0]&& tick),
						.count(count));
							
	logic [3:0] BCD0, BCD1, BCD2, BCD3, BCD4;

	bin2bcd_16 (.x(count), 
					.BCD0(BCD0),
					.BCD1(BCD1),
					.BCD2(BCD2),
					.BCD3(BCD3),
					.BCD4(BCD4));			
						
	hexto7seg SEG0 (.out(HEX0), .in(BCD0));
	hexto7seg SEG1 (.out(HEX1), .in(BCD1));
	hexto7seg SEG2 (.out(HEX2), .in(BCD2));
	hexto7seg SEG3 (.out(HEX3), .in(BCD3));
	hexto7seg SEG4 (.out(HEX4), .in(BCD4));
	
endmodule
						
	
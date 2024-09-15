module lab5task3_top(
	input logic [9:0] SW,
	input logic MAX10_CLK1_50,
	output logic [6:0] HEX0, HEX1, HEX2, HEX3, HEX4
	output logic pmw_out
);

	logic tick; 
	logic [9:0] count; 
	
	ncounter #(.WIDTH(10)) COUNTN(.clk(MAX10_CLK1_50),
											.rst(~KEY[1]),
											.en(tick),
											.count(count)
											.n(SW)); 

	clktick #(.WIDTH(10)) click(
						.clk(MAX10_CLK1_50),
						.rst(~KEY[1]),
						.en(1'b1),
						.N(49999),
						.tick(tick));
						
	pwm digi_pwm ( .clk(MAX10_CLK1_50),
						.data_in(count)
						.max(10'd999),
						.pwm_out(PWM_OUT));
						
	spi2dac CHIP(.sysclk(MAX10_CLK1_50),
						.data_in(SW),
						.load(tick), 
						.dac_cs(DAC_CS),
						.dac_sck(DAC_SCK),
						.dac_sdi(DAC_SDI));
	
							
	logic [3:0] BCD0, BCD1, BCD2, BCD3, BCD4;

	bin2bcd_16 CONV (.x(SW), 
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
						
	
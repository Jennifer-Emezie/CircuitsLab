module task2_top(
	input logic [9:0] SW,
	output logic [6:0] HEX0, HEX1, HEX2
);

	hexto7seg	SEG0(.out(HEX0), .in(SW[3:0]));
	hexto7seg	SEG1(.out(HEX1), .in(SW[7:4]));
	hexto7seg	SEG2(.out(HEX2), .in({2'b00, SW[9:8]}));
	
endmodule 
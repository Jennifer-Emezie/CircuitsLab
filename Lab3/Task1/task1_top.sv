module task1_top (
	input logic [3:0] SW, 
	output logic [6:0] HEX0
);

	hexto7seg 	SEG0 (.out(HEX0), .in(SW[3:0]));
endmodule

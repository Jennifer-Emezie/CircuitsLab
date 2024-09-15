`timescale 1ns/100ps
module ncounter #(
	parameter WIDTH = 4 
)(
	input logic 					clk,
	input logic						rst,
	input logic						en,
	output logic [WIDTH-1:0]	n,
	output logic [WIDTH-1:0]	max,
	output logic [WIDTH-1:0]	count
);
	always_ff @ (posedge clk)begin
		if (en == 1'b1) begin
			if (rst | (count == max)) count <= {WIDTH{1'b0}};
			else 		count <= count + n;
		end
	end
endmodule



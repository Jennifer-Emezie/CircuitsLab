//------------------------------
// Module name: lab6task1
// Function: 	Test MCP3021 ADC by applying a 0 - 3.3V DC
//						... and display converted 10-bit results on 7-seg display in decimal
// Creator:  Peter Cheung
// Version:  2.0
// Date:     29 Nov 2022
//------------------------------
module lab6task1 (
	input  logic			MAX10_CLK1_50, 				// system clock at 50MHz
	input  logic			ADC_DOUT,					// ADC chip select - low active
	output logic			ADC_CS, ADC_CLK,			// ADC chip-select & serial symmetical clock at 1MHz 
	output logic [6:0]  	HEX0, HEX1, HEX2, HEX3		// HEX displays
);
	
	logic  			tick_10k;						// sampling signal, 1 cycle of 20ns per sampling period
	logic [9:0] 	data_in; 					// converted data from ADC
	logic			data_valid;					// high when converted data is available
	logic [3:0]		bcd0, bcd1, bcd2, bcd3, bcd4;
 	
	// Generate sampling tick once every 100us (10kHz sampling rate)
	clktick  GEN_10K (.clk(MAX10_CLK1_50), .rst(1'b0), .en(1'b1), .N(16'd4999),  .tick(tick_10k));
	
	spi2adc SPI_ADC_INTERFACE (	
			.sysclk (MAX10_CLK1_50),
			.start (tick_10k),
			.data_from_adc (data_in),
			.data_valid (data_valid),
			.adc_cs (ADC_CS),
			.adc_sck (ADC_CLK),
			.sdata_from_adc (ADC_DOUT));
			
	bin2bcd_16 BCD_CONVERTER (.x({6'b0,data_in}), 
			.BCD0(bcd0), .BCD1(bcd1), .BCD2(bcd2), .BCD3(bcd3), .BCD4(bcd4));

	hexto7seg DISP0 (.out(HEX0), .in(bcd0));
	hexto7seg DISP1 (.out(HEX1), .in(bcd1));
	hexto7seg DISP2 (.out(HEX2), .in(bcd2));
	hexto7seg DISP3 (.out(HEX3), .in(bcd3));
	
endmodule



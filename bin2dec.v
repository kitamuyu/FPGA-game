module bin2dec(BIN, DEC1, DEC0);
	input [6:0] BIN;
	output [3:0] DEC1, DEC0;

	assign DEC1 = (BIN >= 7'd90) ? 4'h9 : 
				  (BIN >= 7'd80) ? 4'h8 : 
				  (BIN >= 7'd70) ? 4'h7 : 
				  (BIN >= 7'd60) ? 4'h6 : 
				  (BIN >= 7'd50) ? 4'h5 : 
				  (BIN >= 7'd40) ? 4'h4 : 
				  (BIN >= 7'd30) ? 4'h3 : 
				  (BIN >= 7'd20) ? 4'h2 : 
				  (BIN >= 7'd10) ? 4'h1 : 4'h0;

	assign DEC0 = (BIN >= 7'd90) ? BIN - 7'd90 : 
				  (BIN >= 7'd80) ? BIN - 7'd80 : 
				  (BIN >= 7'd70) ? BIN - 7'd70 : 
				  (BIN >= 7'd60) ? BIN - 7'd60 : 
				  (BIN >= 7'd50) ? BIN - 7'd50 : 
				  (BIN >= 7'd40) ? BIN - 7'd40 : 
				  (BIN >= 7'd30) ? BIN - 7'd30 : 
				  (BIN >= 7'd20) ? BIN - 7'd20 : 
				  (BIN >= 7'd10) ? BIN - 7'd10 : BIN;
endmodule
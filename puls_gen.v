module puls_gen(CLK, RST_N, KEY, PULS);
	input CLK;
	input RST_N;
	input KEY;
	output PULS;

	reg delay_KEY;

	always @(posedge CLK) begin
		if(!RST_N) begin
			delay_KEY <= 1'b1;
		end else begin
			delay_KEY <= KEY;
		end
	end

	assign PULS = ({delay_KEY, KEY} == 2'b10) ? 1'b0 : 1'b1;
endmodule
`include "puls_gen.v"
`include "dec_7seg.v"
`include "bin2dec.v"

module game(CLK, DEBUG, CHANGE, STOP, ENTER, RESET, LEDR, LEDG, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input CLK, DEBUG;
	input CHANGE, STOP, ENTER, RESET;
	output [17:0] LEDR;
	output [8:0] LEDG;
	output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

	reg [1:0] state;
	reg [17:0] ledr;
	reg lr;
	reg [25:0] counter;
	reg [25:0] counter2;
	reg [4:0] count_sec;
	reg [6:0] count_10msec;
	reg [31:0] speed;

	wire change, enter, stop;
	wire [3:0] sec_10, sec_1, msec_10, msec_1;

	parameter cnt_speed = 5000000;
	parameter cnt_1sec = 100;
	parameter cnt_10msec = 500000;

	puls_gen puls_change(CLK, RESET, CHANGE, change);
	puls_gen puls_enter(CLK, RESET, ENTER, enter);
	puls_gen puls_stop(CLK, RESET, STOP, stop);

	always @(posedge CLK) begin
		if(!RESET) begin
			ledr <= 0;
			lr <= 0;
			state <= 2'd0;
			counter <= 0;
			counter2 <= 0;
			count_sec <= 0;
			count_10msec <= 0;
			speed <= 0;
		end else begin

			if (state == 2'd0) begin
				state <= (!enter)? 2'd1 : 2'd0; 
				ledr <= {1'b1, 7'b0, 1'b1, 8'b0, 1'b1};
				speed <= cnt_speed;
			end

			if (state == 2'd1) begin
				
				if (counter >= speed - 1) begin
					
					ledr[16:1] <= (lr)? {ledr[15:1], ledr[16]} : {ledr[1], ledr[16:2]}; //0:right 1:left
					speed <= speed - 32'd15000;
					counter <= 0;
				
				end else begin
					counter <= counter + 1;
				end

				if(counter2 >= cnt_10msec - 1'b1) begin
					count_10msec <= count_10msec + 7'd1;
					counter2 <= 0; 
					
					if (count_10msec >= cnt_1sec - 1'b1) begin
						count_sec <= count_sec + 5'd1;
						count_10msec <= 0;
					end
					
				end else begin
					counter2 <= counter2 + 1'b1;
				end


				state <= (ledr[1] == 1 || ledr[16] == 1)? 2'd3 : (!stop)? 2'd2 : 2'd1;
				
				lr <= (!change)? ~lr : lr;
				
			end

			if (state == 2'd2) begin
				state <= (!stop)? 2'd1 : 2'd2;
			end

			if (state == 2'd3) begin
				state <= (!RESET)? 2'd0 : 2'd3;
			end

		end
	end

	assign LEDR = ledr;
	assign HEX6 = 7'h7f;
	assign HEX5 = 7'h7f;
	assign HEX4 = 7'h7f;

	bin2dec sec({2'b0, count_sec}, sec_10, sec_1);
	bin2dec msec(count_10msec, msec_10, msec_1);

	dec_7seg dec_state({2'b0, state}, HEX7);
	dec_7seg HEX_sec_10(sec_10, HEX3);
	dec_7seg HEX_sec_1(sec_1, HEX2);
	dec_7seg HEX_msec_10(msec_10, HEX1);
	dec_7seg HEX_msec_1(msec_1, HEX0);

endmodule			
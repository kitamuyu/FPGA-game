`include "game.v"

module de2_board(CLK, SW, KEY, LEDR, LEDG, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
	input CLK;
	input [17:0] SW;
	input [3:0] KEY;
	output [17:0] LEDR;
	output [8:0] LEDG;
	output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0;

	// Please define the signal!
	game game1(CLK, SW[17], KEY[3], KEY[2], KEY[1], KEY[0], LEDR, LEDG, HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);


	// Please instantiate your circuit!

endmodule
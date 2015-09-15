module sumador
   (
    input wire clk, rst,
    output reg [14:0] o_signal

    // 	[14 13		12  11  10  9		8  7  6  5 		4  3  2  1 		0]
    //
    //	[0  0		0   0   0   0		0  0  0  0		0  0  0  0		0]
    // 	[cnt_alu	slc_mux_a		slc_mux_b		slc_reg			w]

   );

   //signal declaration
	reg [2:0] sState, rState;

   //states declaration
	parameter s0 = 3'b000;
	parameter s1 = 3'b001;
	parameter s2 = 3'b010;
	parameter s3 = 3'b011;
	parameter s4 = 3'b100;

	// state register
	always @ (posedge clk, posedge rst)
	if (rst) rState <= s0;
	else rState <= sState;

	// next state logic
	always @ (*)
	case (rState)
	s0: if(rst) sState = s0; else sState = s1;
	s1: if(rst) sState = s0; else sState = s2;
	s2: if(rst) sState = s0; else sState = s3;
	s3: if(rst) sState = s0; else sState = s4;
	s4: sState = s0;
	default: sState = s0;
	endcase

	// output logic
	always @ (*)
	case (rState)	
	s0:o_signal = 	15'b000000000000000;
	s1:o_signal = 	15'b000000000000000;
	s2:o_signal = 	15'b000000000100000;
	s3:o_signal =	15'b000000000100000;
	s4:o_signal = 	15'b000000000000101;
	default:o_signal = 15'b000000000000000;
	endcase
endmodule

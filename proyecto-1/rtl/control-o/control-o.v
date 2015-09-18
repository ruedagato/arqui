

module control-o
   (
    input wire clk, rst,mayor,zero,neg,
    output reg [15:0] o_signal

	  // 	15  14	13		12  11  10  9		 8  7  6  5 		4  3  2  1 		0
    //
    //	[0  0 	0     0	  0   0   0		 0  0  0  0		  0  0  0  0		0]
    // 	cnt_alu		    slc_mux_a			    slc_mux_b		  slc_reg			  w

   );

   //signal declaration
	reg [5:0] sState, rState;

   //states declaration
	parameter s0 = 		6'b000000;
	parameter s1 = 		6'b000001;
	parameter s2 = 		6'b000010;
	parameter s3 = 		6'b000011;
	parameter s4 = 		6'b000100;
	parameter s5 = 		6'b000101;
	parameter s6 = 		6'b000110;
	parameter s7 = 		6'b000111;
	parameter s8 =		6'b001000;
	parameter s9 =		6'b001001;
	parameter s10 =		6'b001010;
	parameter s11 =		6'b001011;
	parameter s12 =		6'b001100;
	parameter s13 =		6'b001101;
  parameter s14 =   6'b001110;
  parameter s15 =   6'b001111;
  parameter s16 =   6'b010000;
  parameter s17 =   6'b010001;
  parameter s18 =   6'b010010;
  parameter s19 =   6'b010011;
  parameter s20 =   6'b010100;
  parameter s21 =   6'b010101;
  parameter s22 =   6'b010110;
  parameter s23 =   6'b010111;
  parameter s24 =   6'b011000;
  parameter s25 =   6'b011001;
  parameter s26 =   6'b011010;
  parameter s27 =   6'b011011;
  parameter s28 =   6'b011100;
  parameter s29 =   6'b011101;
  parameter s30 =   6'b011110;
  parameter s31 =   6'b011111;
  parameter s32 =   6'b100000;
  parameter s33 =   6'b100001;
  parameter s34 =   6'b100010;
  parameter s35 =   6'b100011;

  reg [2:0] selector,rselector;
	// state register
	always @ (posedge clk, posedge rst)
	if (rst) begin
    rState <= s0;
    rselector = 3'b000;
  end
	else begin
    rState <= sState;
    rselector <= selector;
  end

	// next state logic
	always @ (*)
	case (rState)
	s0: if(rst) sState = s0; else sState = s1;
	s1: sState = s2;
	s2: if(neg) sState = s3; else sState = s34;
	s3: sState = s4;
	s4: sState = s5;
	s5: sState = s6;
	s6: sState = s7;
	s7: sState = s8;
	s8: sState = s34;
	s9: sState = s10;
	s10: if(neg) sState = s11; else sState = s34;
	s11: sState = s12;
	s12: sState = s13;
	s13: sState = s14;
  s14: sState = s15;
  s15: sState = s1;
  s16: sState = s17;
  s17: sState = s18;
  s18: sState = s19;
  s19: sState = s20;
  s20: sState = s21;
  s21: sState = s10;
  s22: sState = s23;
  s23: if(neg) sState = s24; else sState = s34;
  s24: sState = s25;
  s25: sState = s26;
  s27: sState = s16;
  s28: sState = s29;
  s29: if(neg) sState = s30; else sState = s34;
  s30: sState = s31;
  s31: sState = s32;
  s32: sState = s33;
  s33: sState = s22;
  s34: begin
        selector = selector + 1;
        if (rselector == 1)
        
  end

	default: sState = s0;
	endcase

	// output logic
	always @ (*)
	case (rState)
	s0:o_signal = 	   16'b0000000000000000;
	s1:o_signal =      16'b0000001001000000;
	s2:o_signal = 	   16'b0100110010000000;
	s3:o_signal =	     16'b0000001001001001;
	s4:o_signal = 	   16'b0000001001000011;
	s5:o_signal = 	   16'b0000010001100000;
	s6:o_signal = 	   16'b0000010001100000;
	s8:o_signal = 	   16'b0000010001100101;
	s7:o_signal = 	   16'b0000010001101001;
	s9:o_signal = 	   16'b0000011000100000;
	s10:o_signal = 	   16'b0000011000100000;
	s12:o_signal = 	   16'b0000011000100111;
	s11:o_signal = 	   16'b0000011000101001;
	s13:o_signal = 	   16'b0000000000000000;
  s14:o_signal =     16'b0100110010000000;
  s15:o_signal =     16'b0100110010000000;
  s16:o_signal =     16'b0100110010000000;
  s17:o_signal =     16'b1000000001001000;
  s18:o_signal =     16'b1000000001001001;
  s19:o_signal =     16'b1000000000101000;
  s20:o_signal =     16'b1000000000101001;
  s21:o_signal =     16'b0100011000101000;
  s22:o_signal =     16'b0100011000101000;
  s23:o_signal =     16'b0100011000101001;
  s24:o_signal =     16'b0100011000100111;
  s25:o_signal =     16'b0100010001101000;
  s26:o_signal =     16'b0100010001101000;
  s27:o_signal =     16'b0100010001101001;
  s28:o_signal =     16'b0100010001100101;
  s29:o_signal =     16'b0100001001001000;
  s30:o_signal =     16'b0100001001001000;
  s31:o_signal =     16'b0100001001001001;
  s32:o_signal =     16'b0100001001000011;
  s33:o_signal =     16'b0000000000000000;

	default:o_signal = 16'b0000000000000000;
	endcase


endmodule

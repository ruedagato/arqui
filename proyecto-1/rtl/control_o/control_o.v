

module control_o
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
    rselector = 3'b001;
  end
	else begin
    rState <= sState;
    rselector <= selector;
  end

	// next state logic
	always @ (*)
	case (rState)
	s0: begin
        if(rst) sState = s0; else sState = s1;
        selector = 3'b001;
      end
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
  s21: sState = s9;
  s22: sState = s23;
  s23: if(neg) sState = s24; else sState = s34;
  s24: sState = s25;
  s25: sState = s26;
  s26: sState = s27;
  s27: sState = s16;
  s28: sState = s29;
  s29: if(neg) sState = s30; else sState = s34;
  s30: sState = s31;
  s31: sState = s32;
  s32: sState = s33;
  s33: sState = s22;
  s34: begin
        selector = selector + 1;
        if (rselector == 3'd1)
          sState = s9;
        else if (rselector == 3'd2)
          sState = s16;
        else if (rselector == 3'd3)
          sState = s22;
        else if (rselector == 3'd4)
          sState = s28;
        else
          sState = s35;
  end
  s35: sState = s35;
	default: sState = s0;
	endcase

	// output logic
	always @ (*)
	case (rState)
	s0:o_signal = 	   16'b0000000000000000;
	s1:o_signal =      16'b0100001000000000;
	s2:o_signal = 	   16'b0100001000000000;
	s3:o_signal =	     16'b1000001000001100;
	s4:o_signal = 	   16'b1000001000001101;
	s5:o_signal = 	   16'b1010001000000000;
	s6:o_signal = 	   16'b1010001000000001;
	s7:o_signal = 	   16'b1010110000000010;
	s8:o_signal = 	   16'b1010110000000011;
	s9:o_signal = 	   16'b0100010000101100;
	s10:o_signal = 	   16'b0100010000101100;
	s11:o_signal = 	   16'b1000010000101100;
	s12:o_signal = 	   16'b1000010000101101;
	s13:o_signal = 	   16'b1010010011000010;
  s14:o_signal =     16'b1010010011000011;
  s15:o_signal =     16'b1000010011000101;
  s16:o_signal =     16'b0100011001001100;
  s17:o_signal =     16'b1000011001001100;
  s18:o_signal =     16'b1000011001001101;
  s19:o_signal =     16'b1010011011000100;
  s20:o_signal =     16'b1010011011000101;
  s21:o_signal =     16'b1000011011000111;
  s22:o_signal =     16'b0100100001101100;
  s23:o_signal =     16'b0100100001101100;
  s24:o_signal =     16'b1000100001101101;
  s25:o_signal =     16'b1010100011000110;
  s26:o_signal =     16'b1010100011000111;
  s27:o_signal =     16'b1000100011001001;
  s28:o_signal =     16'b0100101010001100;
  s29:o_signal =     16'b0100101010001100;
  s30:o_signal =     16'b1000101010001101;
  s31:o_signal =     16'b1010101011001000;
  s32:o_signal =     16'b1010101011001001;
  s33:o_signal =     16'b1000101011001011;
  s34:o_signal =     16'b0000000000000000;
  s35:o_signal =     16'b0000000000000000;
	default:o_signal = 16'b0000000000000000;
	endcase


endmodule



//---------------------------------------------------------------------------
// SharkBoad ExampleModule
// Josnelihurt Rodriguez - Fredy Segura Q.
// josnelihurt@gmail.com
// Top Level Design for the Xilinx Spartan 3-100E Device
//---------------------------------------------------------------------------

/*#
# SharkBoad
# Copyright (C) 2012 Bogotá, Colombia
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, version 3 of the License.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#*/
// FES Example
//

module posy
   (
    input wire clk, rst,change,
    output wire [9:0] o_signal
   );

   //signal declaration
	reg [4:0] sState, rState;
	reg [9:0] cam;
   //states declaration
	parameter s0 = 		5'b00000;
	parameter s1 = 		5'b00001;
	parameter s2 = 		5'b00010;
	parameter s3 = 		5'b00011;
	parameter s4 = 		5'b00100;
	parameter s5 = 		5'b00101;
	parameter s6 = 		5'b00110;
	parameter s7 = 		5'b00111;
	parameter s8 = 		5'b01000;
	parameter s9 = 		5'b01001;
	parameter s10 = 	5'b01010;
	parameter s11 = 	5'b01011;
	parameter s12 = 	5'b01100;
	parameter s13 = 	5'b01101;
	parameter s14 = 	5'b01110;	
	parameter s15 = 	5'b01111;
	parameter s16 = 	5'b10000;
	parameter s17 = 	5'b10001;
	parameter s18 = 	5'b10010;
	parameter s19 = 	5'b10011;
	parameter s20 = 	5'b10100;
	parameter s21 = 	5'b10101;
	parameter s22 = 	5'b10110;
	parameter s23 = 	5'b10111;
	parameter s24 = 	5'b11000;	
	parameter s25 = 	5'b11001;
	parameter s26 = 	5'b11010;
	parameter s27 = 	5'b11011;
	parameter s28 = 	5'b11100;
	parameter s29 = 	5'b11101;
	parameter s30 = 	5'b11110;
	parameter s31 = 	5'b11111;

	// state register
	always @ (posedge clk, posedge rst)
	if (rst) rState <= s0;
	else rState <= sState;

	// next state logic
	always @ (*)
	case (rState)
	s0: if(rst) sState = s0; else sState = s1;
	s1: if(change)sState = s2; else sState = s1;
  	s2: if(change)sState = s3; else sState = s2;
	s3: if(change)sState = s4; else sState = s3;
	s4: if(change)sState = s5; else sState = s4;
  	s5: if(change)sState = s6; else sState = s5;
	s6: if(change)sState = s7; else sState = s6;
	s7: if(change)sState = s8; else sState = s7;
  	s8: if(change)sState = s9; else sState = s8;
	s9: if(change)sState = s10; else sState = s9;
	s10: if(change)sState = s11; else sState = s10;
  	s11: if(change)sState = s12; else sState = s11;
	s12: if(change)sState = s13; else sState = s12;
	s13: if(change)sState = s14; else sState = s13;
  	s14: if(change)sState = s15; else sState = s14;
	s15: if(change)sState = s16; else sState = s15;
	s16: if(change)sState = s17; else sState = s16;
  	s17: if(change)sState = s18; else sState = s17;
	s18: if(change)sState = s19; else sState = s18;
	s19: if(change)sState = s20; else sState = s19;
	s20: if(change)sState = s21; else sState = s20;
	s21: if(change)sState = s22; else sState = s21;
	s22: if(change)sState = s23; else sState = s22;
	s23: if(change)sState = s24; else sState = s23;
  	s24: if(change)sState = s25; else sState = s24;
	s25: if(change)sState = s26; else sState = s25;
	s26: if(change)sState = s27; else sState = s26;
  	s27: if(change)sState = s28; else sState = s27;
	s28: if(change)sState = s29; else sState = s28;
	s29: if(change)sState = s30; else sState = s29;
	s30: if(change)sState = s31; else sState = s30;
	s31: if(change)sState = s1; else sState = s31;
	default: sState = s0;
	endcase

	// output logic
	always @ (*)
	case (rState)
	s0:cam = 	   10'd80;
	s1:cam =       10'd350;
	s2:cam = 	   10'd280;
	s3:cam =	   10'd250;
	s4:cam = 	   10'd280;
	s5:cam =       10'd230;
	s6:cam = 	   10'd250;
	s7:cam =	   10'd280;
	s8:cam = 	   10'd285;
	s9:cam =       10'd260;
	s10:cam = 	   10'd220;
	s11:cam =	   10'd280;
	s12:cam = 	   10'd295;
	s13:cam =	   10'd270;
	s14:cam = 	   10'd230;
	s15:cam =	   10'd300;
	s16:cam = 	   10'd215;
	s17:cam = 	   10'd300;
	s18:cam = 	   10'd250;
	s19:cam =	   10'd200;
	s20:cam =	   10'd250;
	s21:cam =	   10'd300;
	s22:cam = 	   10'd295;
	s23:cam =	   10'd290;
	s24:cam = 	   10'd300;
	s25:cam =	   10'd320;
	s26:cam = 	   10'd255;
	s27:cam = 	   10'd290;
	s28:cam = 	   10'd285;
	s29:cam =	   10'd200;
	s30:cam =	   10'd265;
	s31:cam =	   10'd265;
	default:cam = 10'd300;
	endcase

	assign o_signal = cam;

endmodule

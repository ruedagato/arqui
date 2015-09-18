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

module control2
   (
    input wire clk, rst,mayor,paridad,compuor,
    output reg [15:0] o_signal

	  // 	15  14	13	 12  11  10  9		 8  7  6  5 		4  3  2  1 		0
    //
    //	[0   0	0		 0	0   0    0		0  0   0  0		  0  0  0  0		0]
    // 	cnt_alu		   slc_mux_a		    slc_mux_b       slc_reg       w

   );

   //signal declaration
	reg [3:0] sState, rState;

   //states declaration
	parameter s0 = 		4'b0000;
	parameter s1 = 		4'b0001;
	parameter s2 = 		4'b0010;
	parameter s3 = 		4'b0011;
	parameter s4 = 		4'b0100;
	parameter s5 = 		4'b0101;
	parameter s6 = 		4'b0110;
	parameter s7 = 		4'b0111;
	parameter s8 = 		4'b1000;
	parameter s9 = 		4'b1001;	
	parameter s10 = 	4'b1010; 

	// state register
	always @ (posedge clk, posedge rst)
	if (rst) rState <= s0;
	else rState <= sState;

	// next state logic
	always @ (*)
	case (rState)
	s0: if(rst) sState = s0; else sState = s1;
	s1: sState = s2; 
	s2: if(paridad) sState = s3; else sState =s5;
	s3: sState = s4;
	s4: sState = s5;
	s5: sState = s6;
	s6: sState = s7;
	s7: sState = s8;
	s8: sState = s9;
	s9: if(compuor) sState = s10; else sState =s1;
	s10: sState =s10;
	endcase

	// output logic
	always @ (*)
	case (rState)
	s0:o_signal = 16'b0000000000000000; //estado inicial
	s1:o_signal = 16'b1000000000000000;//mira paridad de i_b
	s2:o_signal = 16'b1000000000000000;//
	s3:o_signal = 16'b0000001010100000;//suma los datos
	s4:o_signal = 16'b0000001010101011;//escribe los datos
	s5:o_signal = 16'b0110001000000000;//shit-d i_a
	s6:o_signal = 16'b0110001000000011; //guarda el dato
	s7:o_signal = 16'b0010000000000000; //shit-i i_b
	s8:o_signal = 16'b0010000000000001; //guarda el dato
	s9:o_signal = 16'b1000000000000000; //
	s10:o_signal = 16'b0010000000000000; //

	default:o_signal = 16'b000000000000000;
	endcase


endmodule

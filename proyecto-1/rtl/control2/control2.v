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
    input wire clk, rst,mayor,bandera,
    output reg [14:0] o_signal

	// 	14	13		12  11  10  9		8  7  6  5 		4  3  2  1 		0
    //
    //	[0	0		0	0   0   0		0  0  0  0		0  0  0  0		0]
    // 	cnt_alu		slc_mux_a			slc_mux_b		slc_reg			w

   );

   //signal declaration
	reg [3:0] sState, rState;

   //states declaration
	parameter s0 = 		3'b000;
	parameter s1 = 		3'b001;
	parameter s2 = 		3'b010;
	parameter s3 = 		3'b011;
	parameter s4 = 		3'b100;
	parameter s5 = 		3'b101;
	parameter s6 = 		3'b110;
	parameter s7 = 		3'b111;

	// state register
	always @ (posedge clk, posedge rst)
	if (rst) rState <= s0;
	else rState <= sState;

	// next state logic
	always @ (*)
	case (rState)
	s0: if(rst) sState = s0; else sState = s1;
	s1: if(bandera) sState = s2; else sState =s3;
	s2: sState = s3;
	s3: sState = s4;

	endcase

	// output logic
	always @ (*)
	case (rState)	
	s0:o_signal = 	15'b000000000000000;
	s1:o_signal = 	15'b110001000000000;
	s2:o_signal = 	15'b000001000000001;
	s3:o_signal = 	15'b100001000000011;
	s4:o_signal =	15'b000001001001001;

	default:o_signal = 15'b000000000000000;
	endcase


endmodule

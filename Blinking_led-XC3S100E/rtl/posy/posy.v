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
	reg [1:0] sState, rState;
	reg [9:0] salida;



   //states declaration
	parameter s0 = 	2'b00;
	parameter s1 = 	2'b01;
	parameter s2 = 	2'b10;
	parameter s3 = 	2'b11;


	// state register
	always @ (posedge clk, posedge rst)
	if (rst) rState <= s0;
	else rState <= sState;

	// next state logic
	always @ (*)
	case (rState)
	s0: if(rst) sState=s0;else sState=s1;
	s1: if(change)sState=s2;else sState=s1;
	s2: if(change)sState=s3;else sState=s2;
	s3: if(change)sState=s1;else sState=s3;
	endcase

	// output logic
	always @ (*)
	case (rState)
	s0:salida = 10'b0000000000; //estado inicial
	s1:salida = 10'b0011001000; //estado inicial
	s2:salida = 10'b0011100110;//mira paridad de i_b
	s3:salida = 10'b0100000000;//
	endcase

	assign o_signal = salida;

endmodule

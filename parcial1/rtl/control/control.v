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

module control
   (
    input wire clk, rst,mayor,
    output reg [8:0] o_signal

    // 	8	7		6	5		4	3 		2 	1 		0
    //
    //	[0	0		0	0		0	0		0	0		0]
    // 	cnt_alu		slc_mux_a	slc_mux_b	slc_reg		w

   );

   //signal declaration
	reg [3:0] sState, rState;

   //states declaration
	parameter reset = 		4'b0000;
	parameter selec12 = 	4'b0001;
	parameter sumar = 		4'b0010;
	parameter guardar3 = 	4'b0011;
	parameter guardar1 = 	4'b0100;
	parameter guardar2 = 	4'b0101;
	parameter selec23 = 	4'b0110;
	parameter selec13 = 	4'b0111;
	parameter comparar =	4'b1000;
	parameter fin =		 	4'b1001;

	reg next;

	// state register
	always @ (posedge clk, posedge rst)
	if (rst) rState <= reset;
	else rState <= sState;

	// next state logic
	always @ (*)
	case (rState)
	reset: if(rst) sState = reset; else sState = selec12;
	selec12:  sState = sumar;
	sumar: sState = guardar3;
	guardar3: if(next) sState = guardar2; else sState = guardar1;
	guardar2: sState = selec13; 
	guardar1: sState = selec23;
	selec13: sState = comparar;
	selec23 : sState = comparar;
	comparar: if(mayor) sState = fin; else sState=selec12;
	fin: sState=fin;
	default: sState = reset;
	endcase

	// output logic
	always @ (*)
	case (rState)	
	reset:begin
		next = 0;
		o_signal = 9'b000000000;
	end
	selec12:begin
		o_signal[6:3] = 4'b0001;
	end
	sumar:begin
		o_signal[8:7] = 2'b00;
	end
	guardar3:begin
		o_signal[2:0] = 3'b101;

	end
	guardar2:begin
		o_signal[2:0] = 3'b011;
	end
	guardar1:begin
		o_signal[2:0] = 3'b001;
	end
	selec13:begin
		o_signal[6:3] = 4'b0010;
		o_signal[0] = 1'b0;
	end
	selec23 : begin
		o_signal[6:3] = 4'b0110;
		o_signal[0] = 1'b0;
	end
	comparar:begin
		if (next) begin
			next = 1'b0;
		end
		else begin
			next = 1'b1;
		end
		o_signal = o_signal;
		
	end
	endcase


endmodule

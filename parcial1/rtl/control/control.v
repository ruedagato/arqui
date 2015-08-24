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
    output reg [1:0] cnt_alu,slc_mux_a,slc_mux_b,slc_reg,
    output reg w
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
	endcase

	// output logic
	always @ (*)
	case (rState)	
	reset: next = 0;
	selec12:begin
		slc_mux_a = 2'b00;
		slc_mux_b = 2'b01;
	end
	sumar:begin
		cnt_alu = 2'b00;
	end
	guardar3:begin
		w = 1;
		slc_reg = 2'b10;

	end
	guardar2:begin
		w = 1;
		slc_reg = 2'b01;
	end
	guardar1:begin
		w = 1;
		slc_reg = 2'b00;
	end
	selec13:begin
		w = 0;
		cnt_alu = 2'b00;
		slc_mux_a = 2'b00;
		slc_mux_b = 2'b10;
	end
	selec23 : begin
		w = 0;
		cnt_alu = 2'b00;
		slc_mux_a = 2'b01;
		slc_mux_b = 2'b10;
	end
	comparar:begin
		if (next) begin
			next = 1'b0;
		end
		else begin
			next = 1'b1;
		end
		
	end
	endcase


endmodule

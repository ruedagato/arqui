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
// Based on Pong P. Chu - FPGA Prototyping by Verilog Examples 
// Listing 4.11
module salida
   #(
    parameter N=8 // number of bits in counter
   )
   (
    input wire [1:0] i_a, // entrada proveniente del modulo control
    input wire reset,
    output wire [N-1:0] q

   );

    parameter [1:0] P_N=2'b00;
    parameter [1:0] P_0=2'b10;
    parameter [1:0] P_1=2'b01;

   //signal declaration

   reg [N-1:0] numero_salida;
   wire [N-1:0] w_o;
   wire [N-1:0] w_1;


always @(posedge reset) begin
  if (reset) begin
  numero_salida=8'd0;
    // reset
    
  end
  
end

always @(*) begin
  case(i_a)
    P_N: begin
      
    end
    P_0: begin
      numero_salida=w_0;

    end
    P_1: begin
      numero_salida=w_1;
    end
  endcase 
end

   // assign
   assign w_1 = (numero_salida<<1)+8'd1;
   assign w_0 = numero_salida<<1;
   assign q = numero_salida;

endmodule

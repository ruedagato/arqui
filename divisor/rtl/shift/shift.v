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
module shift
   #(
    parameter N=8 // number of bits in counter
   )
   (
    input wire rst,cont,equal,
    input wire [N-1:0] dividiendo,n_valor,
    output wire [N-1:0] q,
    output wire o_n
   );

   //signal declaration
   reg [N-1:0] select_bit;
   reg [N-1:0] salida;
   reg [N-1:0] r_dividiendo;
   wire [N-1:0] w_salida;

   // body
   // register
   always @(posedge cont, posedge rst, posedge equal) begin
     if (rst) begin
       // reset
       select_bit = N;
       salida = 8'b0;
       //r_dividiendo = dividiendo;
     end
     else if (cont) begin
       salida = w_salida;
       select_bit = select_bit -1;
     end
     else if (equal) begin
       salida = n_valor;
     end
   end


   // assign
   assign w_salida = (salida << 1) + dividiendo[select_bit-1];
   assign q = salida;
   assign o_n = (select_bit<1)?1'b1:1'b0;

endmodule

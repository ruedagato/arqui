//---------------------------------------------------------------------------
// SharkBoad SystemModule
//
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

module system
#(
	parameter	clk_freq	= 50000000,
	parameter	uart_baud_rate	= 57600
) (
	input		clk,
	input		rst,
	// UART
	//input             uart_rxd, 
	//output            uart_txd,
	// Debug 
	output		led
);
//---------------------------------------------------------------------------
// General Purpose IO
//---------------------------------------------------------------------------
wire counter_unit0_ovf;
wire led_out;
wire n_rst=~rst;
counter	#(    .N(32), // number of bits in counter
              .M(5000000) // mod-M
   		)
	counter_unit0 
   (
    .clk(clk), .reset(n_rst),
    .max_tick(counter_unit0_ovf),
    .q()
   );
datadegister	#(.DATAWIDTH(1)
		)
	datadegister_unit0 
	(
		.clk(clk),.rst(n_rst),.tg_tick(counter_unit0_ovf),
		.d(counter_unit0_ovf),
		.q(led_out) 
	);
//----------------------------------------------------------------------------
// Wires Assigments
//----------------------------------------------------------------------------
assign led = led_out;

endmodule

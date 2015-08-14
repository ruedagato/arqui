//----------------------------------------------------------------------------
//
//----------------------------------------------------------------------------

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

`timescale 1 ns / 100 ps

module system_tb;

//----------------------------------------------------------------------------
// Parameter (may differ for physical synthesis)
//----------------------------------------------------------------------------
parameter tck              = 20;       // clock period in ns
parameter uart_baud_rate   = 1152000;  // uart baud rate for simulation 

parameter clk_freq = 1000000000 / tck; // Frequenzy in HZ
//----------------------------------------------------------------------------
//
//----------------------------------------------------------------------------
reg        clk_tb;
reg        rst_tb;
reg			cont_tb;
reg			equal_tb;
reg			[7:0]dividiendo_tb,i_a_tb,i_b_tb;
reg			[7:0]n_valor_tb;
wire       led_tb;
//----------------------------------------------------------------------------
// UART STUFF (testbench uart, simulating a comm. partner)
//----------------------------------------------------------------------------
wire         uart_rxd_tb;
wire         uart_txd_tb;

//----------------------------------------------------------------------------
// Device Under Test 
//----------------------------------------------------------------------------
comparador #(
	.N ( 8 )
	) comp(
	.i_a ( i_a_tb),
	.i_b (i_b_tb)
	);


shift #(
	.N	(	8	)
	) dut  (
	//.clk(	clk_tb	),
	// Debug
	.rst(	rst_tb	),
	.cont( cont_tb),
	.equal( equal_tb ),
	.n_valor( n_valor_tb ),
	.dividiendo( dividiendo_tb)

	// Uart
	);


	/* Clocking device */
// Remember this is only for simulation. It never will be syntetizable //
initial         clk_tb <= 0;
always #(tck/2) clk_tb <= ~clk_tb;

/* Simulation setup */
initial begin
	//set the file for loggin simulation data
	$dumpfile("system_tb.vcd"); 
	//$monitor("%b,%b,%b",clk_tb,rst_tb,led_tb);
	//export all signals in the simulation viewer
	$dumpvars(-1, dut);
	$dumpvars(-1, comp);
	//$dumpvars(-1,clk_tb,rst_tb);
	#0 i_a_tb <= 8'b00000100;
	#0 i_b_tb <= 8'b00001010;
	
	#0 dividiendo_tb <= 8'b11001011;
	#0 n_valor_tb <= 8'd5;
	#0 equal_tb <= 0;
	#0  rst_tb <= 1;
	#0 cont_tb <= 0;
	#80 rst_tb <= 0;
	#100 cont_tb <= 1;

	#0 i_a_tb <= 8'b00000100;
	#0 i_b_tb <= 8'b00000010;

	#20 cont_tb <= 0;
	#100 cont_tb <= 1;
	#20 cont_tb <= 0;
	#100 cont_tb <= 1;
	#20 cont_tb <= 0;
	#100 cont_tb <= 1;
	#20 cont_tb <= 0;
	#50 equal_tb <= 1;
	#50 equal_tb <= 0;
	#(tck*100000) $finish;
	end
	endmodule

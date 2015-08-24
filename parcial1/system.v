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
	parameter	uart_baud_rate	= 57600,
	parameter	p_N = 16
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


// cables del sitema del divisor
wire w_registro,mayor;
wire [p_N-1:0]in_register,r1,r2,r3,r4,i_a,i_b;
wire [1:0] cnt_alu,slc_mux_a,slc_mux_b,slc_reg;



registros
	//Parametros
	#(
		.N(16)
	)
	registro
	//entradas y salidas
	(
		// entradas
		.w(w_registro),
		.rst(rst),
		.clk(clk),
		.select_register(slc_reg),
		.s(in_register),
		// salidas
		.r1(r1),
		.r2(r2),
		.r3(r3),
		.r4(r4)
	);
mux
	//Parametros
	#(
		.N(p_N)
	)
	muxa
	//entradas y salidas
	(
		.selecm(slc_mux_a),
		.R_0(r1),
		.R_1(r2),
		.R_2(r3),
		.R_3(r4),
		.q(i_a)
	);

mux
	//Parametros
	#(
		.N(p_N)
	)
	muxb
	//entradas y salidas
	(
		.selecm(slc_mux_b),
		.R_0(r1),
		.R_1(r2),
		.R_2(r3),
		.R_3(r4),
		.q(i_b)
	);
alu
	//Parametros
	#(
		.N(p_N)
	)
	alu
	//entradas y salidas
	(
		.i_a(i_a),
		.i_b(i_b),
		.i_control(cnt_alu),
		.mayor(mayor),
		.q(in_register)
	);

control
	cont
   (
   	//input
    .clk(clk), 
    .rst(rst),
    .mayor(mayor),
    //output
    .cnt_alu(cnt_alu),
    .slc_mux_a(slc_mux_a),
    .slc_mux_b(slc_mux_b),
    .slc_reg(slc_reg),
    .w(w_registro)
   );
//----------------------------------------------------------------------------
// Wires Assigments
//----------------------------------------------------------------------------
assign led = led_out;

endmodule

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
	output		led,
	output[p_N-1:0] salidas_final
);
//---------------------------------------------------------------------------
// General Purpose IO
//---------------------------------------------------------------------------
wire counter_unit0_ovf;
wire led_out;


// 	15  14	13		12  11  10  9		8  7  6  5 		4  3  2  1 		0
//
//	[0  0 	0     0	  0   0   0		0  0  0  0		0  0  0  0		0]
// 	cnt_alu				slc_mux_a			slc_mux_b		slc_reg			w

// cables del sitema del divisor
wire mayor,w_paridad,w_zero;
wire [15:0] signal_control;
wire [p_N-1:0]in_register,rr1,rr2,rr3,rr4,rr5,rr6,rr7,rr8,rr9,rr10,rr11,rr12,rr13,rr14,rr15,rr16,i_a,i_b;




memoria
	//Parametros
	#(
		.N(16)
	)
	registro
	//entradas y salidasparidad,zero
	(
		// entradas
		.w(signal_control[0]),
		.rst(rst),
		.clk(clk),
		.select_register(signal_control[4:1]),
		.s(in_register),
		// salidas
		.r1(rr1),
		.r2(rr2),
		.r3(rr3),
		.r4(rr4),
		.r5(rr5),
		.r6(rr6),
		.r7(rr7),
		.r8(rr8),
		.r9(rr9),
		.r10(rr10),
		.r11(rr11),
		.r12(rr12),
		.r13(rr13),
		.r14(rr14),
		.r15(rr15),
		.r16(rr16)
	);
mux
	//Parametros
	#(
		.N(p_N)
	)
	muxa
	//entradas y salidas
	(
		.selecm(signal_control[12:9]),
		.R_0(rr1),
		.R_1(rr2),
		.R_2(rr3),
		.R_3(rr4),
		.R_4(rr5),
		.R_5(rr6),
		.R_6(rr7),
		.R_7(rr8),
		.R_8(rr9),
		.R_9(rr10),
		.R_10(rr11),
		.R_11(rr12),
		.R_12(rr13),
		.R_13(rr14),
		.R_14(rr15),
		.R_15(rr16),
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
		.selecm(signal_control[8:5]),
		.R_0(rr1),
		.R_1(rr2),
		.R_2(rr3),
		.R_3(rr4),
		.R_4(rr5),
		.R_5(rr6),
		.R_6(rr7),
		.R_7(rr8),
		.R_8(rr9),
		.R_9(rr10),
		.R_10(rr11),
		.R_11(rr12),
		.R_12(rr13),
		.R_13(rr14),
		.R_14(rr15),
		.R_15(rr16),
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
		.i_control(signal_control[15:13]),
		.mayor(mayor),
		.paridad(w_paridad),
		.zero(w_zero),
		.q(in_register)
	);

control
	lucas
   (
   	//input
    .clk(clk),
    .rst(rst),
    .mayor(mayor),
		.zero(w_zero),
    //output
    .o_signal(signal_control)
   );

/*control2
	cont2
	(
		//input
		.clk(clk),
		.rst(rst),
	 	.mayor(mayor),
		.paridad(w_paridad),
		.compuor(w_zero),
	 	//output
		.o_signal(signal_control)
	);*/


//----------------------------------------------------------------------------
// Wires Assigments
//----------------------------------------------------------------------------
assign led = led_out;
assign salidas_final = rr3;

endmodule

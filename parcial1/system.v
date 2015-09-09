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


	// 	14	13		12  11  10  9		8  7  6  5 		4  3  2  1 		0
    //
    //	[0	0		0	0   0   0		0  0  0  0		0  0  0  0		0]
    // 	cnt_alu		slc_mux_a			slc_mux_b		slc_reg			w

// cables del sitema del divisor
wire mayor;
wire [14:0] signal_control;
wire [p_N-1:0]in_register,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,r13,r14,r15,r16,i_a,i_b;




registros
	//Parametros
	#(
		.N(16)
	)
	registro
	//entradas y salidas
	(
		// entradas
		.w(signal_control[0]),
		.rst(rst),
		.clk(clk),
		.select_register(signal_control[4:1]),
		.s(in_register),
		// salidas
		.r1(r1),
		.r2(r2),
		.r3(r3),
		.r4(r4),
		.r5(r5),
		.r6(r6),
		.r7(r7),
		.r8(r8),
		.r9(r9),
		.r10(r10),
		.r11(r11),
		.r12(r12),
		.r13(r13),
		.r14(r14),
		.r15(r15),
		.r16(r16)
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
		.R_0(r1),
		.R_1(r2),
		.R_2(r3),
		.R_3(r4),
		.R_4(r5),
		.R_5(r6),
		.R_6(r7),
		.R_7(r8),
		.R_8(r9),
		.R_9(r10),
		.R_10(r11),
		.R_11(r12),
		.R_12(r13),
		.R_13(r14),
		.R_14(r15),
		.R_15(r16),
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
		.R_0(r1),
		.R_1(r2),
		.R_2(r3),
		.R_3(r4),
		.R_4(r5),
		.R_5(r6),
		.R_6(r7),
		.R_7(r8),
		.R_8(r9),
		.R_9(r10),
		.R_10(r11),
		.R_11(r12),
		.R_12(r13),
		.R_13(r14),
		.R_14(r15),
		.R_15(r16),
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
		.i_control(signal_control[14:13]),
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
    .o_signal(signal_control)
   );
//----------------------------------------------------------------------------
// Wires Assigments
//----------------------------------------------------------------------------
assign led = led_out;
assign salidas_final = r3;

endmodule

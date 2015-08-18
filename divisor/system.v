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
	parameter	p_N = 8
) (
	input		clk,
	input		rst,
	input wire [p_N-1:0] i_a,i_b,

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
wire w_cont,w_equals,w_o_n,w_signal_comp;
wire [p_N-1:0]w_n_valor,w_salida_shift,w_salida_final;
wire [1:0] w_salida_cont;



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


// corredor 
shift#(
    .N(p_N) // number of bits in counter
   )
	corredor
   (
   	// entradas
    .rst(rst),
    .cont(w_cont),
    .equal(w_equals),
    .dividiendo(i_a),
    .n_valor(w_n_valor),
    // salidas
    .q(w_salida_shift),
    .o_n(w_o_n)
   );

comparador
	//Parametros
	#(
		.N(p_N)
	)
	comparador_1
	//entradas y salidas
	(
		// entradas
		.i_a(w_salida_shift),
		.i_b(i_b),
		// salidas
		.o_signal(w_signal_comp),
		.o_resta(w_n_valor)
	);

control
	control_1
	(
		// entradas
		.termino(w_o_n), 
		.mayor(w_signal_comp), 
		.clk(clk), 
		.rst(rst),
		// salidas
		.salida(w_salida_cont),
		.bajar(w_cont), 
		.igualar(w_equals)
	);

salida
   #(
   		.N(p_N) // number of bits in counter
   )
   salida_1
   (
   		//entradas
   		.i_a(w_salida_cont), // entrada proveniente del modulo control
   		.reset(rst),
   		.q(w_salida_final)

   );
//----------------------------------------------------------------------------
// Wires Assigments
//----------------------------------------------------------------------------
assign led = led_out;

endmodule

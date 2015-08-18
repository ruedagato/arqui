module comparador
	//Parametros
	#(
		parameter N=8
	)
	//entradas y salidas
	(
		input wire [N-1:0] i_a,
		input wire [N-1:0] i_b,
		output wire o_signal,
		output wire [N-1:0] o_resta
	);

	//registros y señales


	//cuerpo del modulo
	assign o_signal = ((i_a>=i_b))?1'b1:1'b0;
	assign o_resta = i_a-i_b;


endmodule 
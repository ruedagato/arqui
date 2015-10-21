module imagen
   	(
	input wire [3:0] muneco, nivel, 
	input wire [2:0] fondo,
	output wire [2:0] o_salida
	);

	reg [2:0] salida;

	//cuerpo del modulo
	always @(*)
		if(muneco[3]==0 && muneco!=4'b0111)
			salida=muneco[2:0];
		else if(nivel[3]==0 && nivel!=4'b0111)
			salida=nivel[2:0];
		else
			salida=fondo;

	//asiganaciones
	assign o_salida=salida;

endmodule


module  alu
	//Parametros
	#(
		parameter N=16
	)
	//entradas y salidas
	(
		input wire [N-1:0] i_a,
		input wire [N-1:0] i_b,
		input wire [2:0] i_control,
		output wire mayor, paridad,
		output wire [N-1:0] q
	);
	 parameter [1:0] suma=2'b00;
	 parameter [1:0] resta=2'b10;
	 parameter [1:0] shift_d=2'b01;
	 parameter [1:0] shift_i=2'b11;

	//registros y señales
	reg [N-1:0] salida;
	reg [N:0] salida2;
	reg es_mayor,bandera;

	//cuerpo del modulo
	always @(*) begin
			case(i_control)
				suma: begin
					salida = i_a +i_b;
					salida2 = i_a +i_b;
					if (salida2[16]==1'b1) es_mayor = 1'b1;
					else es_mayor = 1'b0;
				end
				resta: begin
					salida = i_a - i_b;
					es_mayor = 1'b0;
				end
				shift_i: begin
					salida= i_a;
					es_mayor = 1'b0;
				end
				shift_d:begin
					salida=i_a>>1;
					es_mayor = 1'b0;
				end
				defaultcase:begin
					salida= i_a;
				end
			endcase

			if (salida[0]==1) begin
				bandera=1;
			else begin
				bandera=0;
			end

	end
	//se define para mirar el bit de menor peso del dato en el bus C

	//asiganaciones
	assign paridad = bandera ;
	assign q = salida;
	assign mayor = es_mayor;

endmodulde 
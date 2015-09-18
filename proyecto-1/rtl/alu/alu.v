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
		output wire mayor,paridad,zero,
		output wire [N-1:0] q
	);
	 parameter [2:0] suma=3'b000;
	 parameter [2:0] resta=3'b010;
	 parameter [2:0] shift_d=3'b001;
	 parameter [2:0] shift_i=3'b011;
	 parameter [2:0] pasar_b=3'b100;
	 parameter [2:0] pasar_a=3'b101;

	//registros y señales
	reg [N-1:0] salida;
	reg [N:0] salida2;
	reg es_mayor,reg_paridad,reg_zero;

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
					salida= i_a<<1;
					es_mayor = 1'b0;
				end
				shift_d:begin
					salida=i_a>>1;
					es_mayor = 1'b0;
				end
				pasar_b: begin
					salida = i_b;
					es_mayor = 1'b0;
				end
				pasar_a: begin
					salida = i_a;
					es_mayor = 1'b0;
				end
				default: salida = i_a;
			endcase
	end

	always @(*) begin
		if(salida==0)
			reg_zero = 1;
		else
			reg_zero = 0;
		if(salida[15]==1)
			reg_paridad = 1;
		else
			reg_paridad = 0;
	end


	//asignaciones
	assign zero = reg_zero;
	assign paridad = reg_paridad;
	assign q = salida;
	assign mayor = es_mayor;

endmodule

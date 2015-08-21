module  alu
	//Parametros
	#(
		parameter N=16
	)
	//entradas y salidas
	(
		input wire [N-1:0] i_a,
		input wire [N-1:0] i_b,
		input wire [1:0] i_control,
		output wire [N-1:0] q
	);
	 parameter [1:0] suma=2'b00;
	 parameter [1:0] resta=2'b10;
	 parameter [1:0] shift_d=2'b01;
	 parameter [1:0] shift_i=2'b11;

	//registros y señales
	reg [N-1:0] salida;

	//cuerpo del modulo
	always @(*) begin
			case(i_control)
				suma: begin
					salida = i_a +i_b;
				end
				resta: begin
					salida = i_a - i_b;
				end
				shift_i: begin
					salida= i_a<<1;
				end
				shift_d:begin
					salida=i_a>>1;
				end
			endcase
		end
	end

	//asiganaciones
	assign q = salida;


endmodule 
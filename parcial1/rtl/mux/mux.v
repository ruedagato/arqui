module  mux
	//Parametros
	#(
		parameter N=16
	)
	//entradas y salidas
	(
		input wire [1:0] selecM,
		input wire [N-1:0] R_0,
		input wire [N-1:0] R_1,
		input wire [N-1:0] R_2,
		input wire [N-1:0] R_3,
		output wire [N-1:0] Q,
	);
	 parameter [1:0] P_N=2'b00;
	 parameter [1:0] P_0=2'b10;
	 parameter [1:0] P_1=2'b01;
	 parameter [1:0] P_2=2'b11;

	//registros y señales
	reg [N-1:0] salida;

	//cuerpo del modulo
	always @(*) begin
		case(selecM) begin
			P_N: begin
				salida= R_0;
			end
			P_0:begin
				salida = R_1;
			end
			P_1:begin
				salida = R_2;
			end
			P_2:begin
				salida = R_3;
			end
			default:begin
				
			end

			
		endcase
			
		end
	end

	//asiganaciones
	assign q=salida;

endmodule 
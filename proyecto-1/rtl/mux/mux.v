module  mux
	//Parametros
	#(
		parameter N=16
	)
	//entradas y salidas
	(
		input wire [3:0] selecm,
		input wire [N-1:0] R_0,
		input wire [N-1:0] R_1,
		input wire [N-1:0] R_2,
		input wire [N-1:0] R_3,
		input wire [N-1:0] R_4,
		input wire [N-1:0] R_5,
		input wire [N-1:0] R_6,
		input wire [N-1:0] R_7,
		input wire [N-1:0] R_8,
		input wire [N-1:0] R_9,
		input wire [N-1:0] R_10,
		input wire [N-1:0] R_11,
		input wire [N-1:0] R_12,
		input wire [N-1:0] R_13,
		input wire [N-1:0] R_14,
		input wire [N-1:0] R_15,
		output wire [N-1:0] q
	);
	 parameter [3:0] P_0 =4'b0000;
	 parameter [3:0] P_1 =4'b0001;
	 parameter [3:0] P_2 =4'b0010;
	 parameter [3:0] P_3 =4'b0011;
	 parameter [3:0] P_4 =4'b0100;
	 parameter [3:0] P_5 =4'b0101;
	 parameter [3:0] P_6 =4'b0110;
	 parameter [3:0] P_7 =4'b0111;
	 parameter [3:0] P_8 =4'b1000;
	 parameter [3:0] P_9 =4'b1001;
	 parameter [3:0] P_10=4'b1010;
	 parameter [3:0] P_11=4'b1011;
	 parameter [3:0] P_12=4'b1100;
	 parameter [3:0] P_13=4'b1101;
	 parameter [3:0] P_14=4'b1110;
	 parameter [3:0] P_15=4'b1111;

	//registros y señales
	reg [N-1:0] salida;

	//cuerpo del modulo
	always @(*) begin
		case(selecm) 
			P_0: begin
				salida= R_0;
			end
			P_1:begin
				salida = R_1;
			end
			P_2:begin
				salida = R_2;
			end
			P_3:begin
				salida = R_3;
			end
			P_4:begin
				salida = R_4;
			end
			P_5:begin
				salida = R_5;
			end
			P_6:begin
				salida = R_6;
			end
			P_7:begin
				salida = R_7;
			end
			P_8:begin
				salida = R_8;
			end
			P_9:begin
				salida = R_9;
			end
			P_10:begin
				salida = R_10;
			end
			P_11:begin
				salida = R_11;
			end
			P_12:begin
				salida = R_12;
			end
			P_13:begin
				salida = R_13;
			end
			P_14:begin
				salida = R_14;
			end
			P_15:begin
				salida = R_15;
			end
			default:begin
				salida = R_0;
			end
		endcase
			
	end

	//asiganaciones
	assign q=salida;

endmodule 
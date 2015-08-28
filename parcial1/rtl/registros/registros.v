module registros
	//Parametros
	#(
		parameter N=16
	)
	//entradas y salidas
	(
		// entradas
		input wire w,rst,clk,
		input wire [1:0] select_register,
		input wire [N-1:0] s,
		// salidas
		output wire [N-1:0]r1,
		output wire [N-1:0]r2,
		output wire [N-1:0]r3,
		output wire [N-1:0]r4
	);

	//registros y señales
	reg [N-1:0]register[0:3]; 

	//cuerpo del modulo
	always @(posedge clk, posedge rst) begin
		if (rst) begin
			// reset
			register[2'b00] = 16'D2;
			register[2'b01] = 16'D1;
			register[2'b10] = 16'D0;
			register[2'b11] = 16'D0;

		end
		else 
		if (w) begin
			register[select_register] = s;
		end

	end

	// asignaciónes
	assign r1 = register[2'b00];
	assign r2 = register[2'b01];
	assign r3 = register[2'b10];
	assign r4 = register[2'b11];

endmodule 
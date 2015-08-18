module control(
	input wire termino, mayor, clk, rst,
	output reg [1:0] salida,
	output reg bajar, igualar
	);
	// codificación de estados
	parameter [2:0] reset = 3'b000;
	parameter [2:0] bit_bajar = 3'b001;
	parameter [2:0] comprar = 3'b010;
	parameter [2:0] add_cero = 3'b011;
	parameter [2:0] add_one = 3'b100;
	parameter [2:0] fin = 3'b101;

	// estado actual y siguiente
	reg [2:0]sState,rState;
	initial
	begin
		rState = reset;
		sState = reset;
	end

	// cambio de estado
	always @(posedge clk or posedge rst) begin
		if (rst) begin
			// reset
			rState <= reset;
		end
		else begin
			rState <= sState;
		end
	end

	// señales de cambio
	always @(posedge clk) begin
		case(rState)
		reset: begin
			sState = (rst)?reset:bit_bajar;
		end
		bit_bajar:begin
			sState = comprar; 
		end
		comprar: begin
			sState = (mayor)?add_one:add_cero;
		end
		add_one: begin
			sState = (termino)?fin:bit_bajar;
		end
		add_cero: begin
			sState = (termino)?fin:bit_bajar;
		end
		endcase
	end

	// salida de cada estado
	always @(*) begin
		case(rState)
			reset:begin
				salida = 2'b00;
				bajar = 1'b0;
				igualar = 1'b0;
			end
			bit_bajar:begin
				salida = 2'b00;
				bajar = 1'b1;
				igualar = 1'b0;
			end
			comprar:begin
				salida = 2'b00;
				bajar = 1'b0;
				igualar = 1'b0;
			end
			add_one:begin
				salida = 2'b01;
				bajar = 1'b0;
				igualar = 1'b1;
			end
			add_cero:begin
				salida = 2'b10;
				bajar = 1'b0;
				igualar = 1'b0;
			end
		endcase
	end

endmodule
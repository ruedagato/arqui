module memoria
	//Parametros
	#(
		parameter N=16
	)
	//entradas y salidas
	(
		// entradas
		input wire w,rst,clk,
		input wire [3:0] select_register,
		input wire [N-1:0] s,
		// salidas
		output wire [N-1:0]r1,
		output wire [N-1:0]r2,
		output wire [N-1:0]r3,
		output wire [N-1:0]r4,
		output wire [N-1:0]r5,
		output wire [N-1:0]r6,
		output wire [N-1:0]r7,
		output wire [N-1:0]r8,
		output wire [N-1:0]r9,
		output wire [N-1:0]r10,
		output wire [N-1:0]r11,
		output wire [N-1:0]r12,
		output wire [N-1:0]r13,
		output wire [N-1:0]r14,
		output wire [N-1:0]r15,
		output wire [N-1:0]r16
	);

	//registros y señales
	reg [15:0]reg1;
	reg [15:0]reg2;
	reg [15:0]reg3;
	reg [15:0]reg4;
	reg [15:0]reg5;
	reg [15:0]reg6;
	reg [15:0]reg7;
	reg [15:0]reg8;
	reg [15:0]reg9;
	reg [15:0]reg10;
	reg [15:0]reg11;
	reg [15:0]reg12;
	reg [15:0]reg13;
	reg [15:0]reg14;
	reg [15:0]reg15;
	reg [15:0]reg16;

	//cuerpo del modulo
	always @(posedge rst, posedge clk)
	begin
		if (rst) begin
			// reset
			reg1 = 16'b0000000000000001;
			reg2 = 16'b0000000000000001;
			reg3 = 16'b0000000000000001;
			reg4 = 16'b0000000000000001;
			reg5 = 16'b0000000000000000;
			reg6 = 16'b0000000000000000;
			reg7 = 16'b0000000000100101;
			reg8 = 16'b0000000000000000;
			reg9 = 16'b0000000000000000;
			reg10 = 16'b0000010000000100;
			reg11 = 16'b0000000000000100;
			reg12 = 16'b0000000000000100;
			reg13 = 16'b0000000000000100;
			reg14 = 16'b1000000000000100;
			reg15 = 16'b1010001000000100;
			reg16 = 16'b1000000000000100;
		end
		else if (w) begin
			case(select_register)
				4'b0000:reg1 = s;
				4'b0001:reg2 = s;
				4'b0010:reg3 = s;
				4'b0011:reg4 = s;
				4'b0100:reg5 = s;
				4'b0101:reg6 = s;
				4'b0110:reg7 = s;
				4'b0111:reg8 = s;
				4'b1000:reg9 = s;
				4'b1001:reg10 = s;
				4'b1010:reg11 = s;
				4'b1011:reg12 = s;
				4'b1100:reg13 = s;
				4'b1101:reg14 = s;
				4'b1110:reg15 = s;
				4'b1111:reg16 = s;
			endcase
		end
	end

	// asignaciónes
	assign r1 =		reg1;
	assign r2 =		reg2;
	assign r3 =		reg3;
	assign r4 =		reg4;
	assign r5 =		reg5;
	assign r6 =		reg6;
	assign r7 =		reg7;
	assign r8 =		reg8;
	assign r9 =		reg9;
	assign r10 =	reg10;
	assign r11 =	reg11;
	assign r12 =	reg12;
	assign r13 =	reg13;
	assign r14 =	reg14;
	assign r15 =	reg15;
	assign r16 =	reg16;

endmodule

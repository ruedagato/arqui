module movx

   	//entradas y salidas
   	(
	input wire clk, rst,s, MN,MX,perdio,cont,sta,
	output wire [1:0] o_signal
	);

	reg [3:0] sState, rState;
	reg [1:0] w_salida;

	//registros
	parameter s0 = 		3'b000;
	parameter s1 = 		3'b001;
	parameter s2 = 		3'b010;
	parameter s3 = 		3'b011;
	parameter s4 = 		3'b100;
	parameter s5 = 		3'b101;
	parameter s6 = 		3'b110;
	parameter s7 = 		3'b111;


	//state register
	 always @(posedge clk, posedge rst)
      if (rst) rState <= s0;
      else rState <= sState;


	//next state logic
	always @(*)
	case(rState)
	s0: if(rst) sState = s0; else sState = s7;
	s1: if(perdio) sState=s5; else if(MX) sState = s6; else if(s) sState= s3; else sState=s1;
	s2: if(perdio) sState=s5; else if(MN) sState = s1; else if(s) sState= s4; else sState=s2;
	s3: sState = s1;
	s4: sState = s2;
	s5: if(rst) sState = s0; else sState = s5;
	s6: if(cont) sState = s2; else sState = s6;
	s7: if(sta) sState = s1; else sState = s7;
	endcase


	//output logic
	always @(*)
	case (rState)
	s0: w_salida = 2'b00;
	s1: w_salida = 2'b00;
	s2: w_salida = 2'b00;
	s3: w_salida = 2'b10;
	s4: w_salida = 2'b01;
	s5: w_salida = 2'b00;
	s6: w_salida = 2'b00;
	s7: w_salida = 2'b00;
 	endcase

 	assign o_signal =w_salida ;

endmodule


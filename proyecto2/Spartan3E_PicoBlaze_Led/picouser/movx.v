module movx

   	//entradas y salidas
   	(
	input wire clk, reset,s, MN,MX,
	output wire [1:0] o_signal
	);

	reg [3:0] sState, rState;

	//registros
	parameter s0 = 		3'b000;
	parameter s1 = 		3'b001;
	parameter s2 = 		3'b010;
	parameter s3 = 		3'b011;
	parameter s4 = 		3'b100;


	//state register
	 always @(posedge clk, posedge rst)
      if (rst) rState <= s0;
      else rState <= sState;


	//next state logic
	always @(*)
	case(rstate)
	s0: if(rst) sState = s0; else sState = s1;
	s1: if(MN) sState = s2; else if(s) sState= s3; else sState=s1;
	s2: if(MX) sState = s1; else if(s) sState= s4; else sState=s2;
	s3: sState = s1;
	s4: sState = s2;
	endcase


	//output logic
	always @(*)
	case (rstate)
	s0: o_signal = 2'b00;
	s1: o_signal = 2'b00;
	s2: o_signal = 2'b00;
	s3: o_signal = 2'b10;
	s4: o_signal = 2'b01;
 	endcase


endmodule


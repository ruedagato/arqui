module bit
(
	input wire clk,s,rst,
	output wire out
);

reg [1:0] sState, rState;
reg w_salida;

//registros
parameter s0 = 		2'b00;
parameter s1 = 		2'b01;
parameter s2 = 		2'b10;

//state register
always @(posedge clk, posedge rst)
    if (rst) rState <= s0;
    else rState <= sState;

//next state logic
always @(*)
case(rState)
s0: if(s) sState = s1; else sState = s0;
s1: sState = s2;
s2: if(s) sState = s2; else sState = s0;
endcase

//output logic
always @(*)
case (rState)
s0: w_salida = 1'b0;
s1: w_salida = 1'b1;
s2: w_salida = 1'b0;
endcase

assign out = w_salida;

endmodule

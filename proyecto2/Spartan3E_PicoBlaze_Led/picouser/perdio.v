module perdio

   	//entradas y salidas
   	(
	input wire [9:0] posx1,posx2,posy1,posy2,
	output wire o_signal
	);
	
	//registro
	reg r_out;
	parameter dis = 10;

	always@(*)

	if(posx2<posx1+30 && posx2+30>posx1 &&posy2+70>posy1 && posy2<posy1+64)
		r_out=1;
	else 
	 	r_out=0;

	assign o_signal=r_out;

endmodule


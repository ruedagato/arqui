module cmove
   (
    input wire clk, reset,
    input wire [9:0] N,M,X,
    input [1:0] oper,
    output wire x_min, x_max,
    output wire [9:0] salida
   );

   reg [9:0] posx;
   wire [9:0] next_posx;
   reg r_xmin, r_xmax;


always @(*) begin
		if(posx<=N) begin
			r_xmin = 1;
			r_xmax = 0;
    end
		else if(posx>=M)
    begin
			r_xmin = 0;
			r_xmax = 1;
    end
		else
    begin
		    r_xmin = 0;
		    r_xmax = 0;
    end
		end

   // output logic
   assign x_min = r_xmin;
   assign x_max = r_xmax;


      always @(posedge clk, posedge reset)
      if (reset)
         posx <= X;
      else
         posx <= next_posx;

   // next-posx logic
   assign next_posx = (oper==2'b10)? posx + 1:(oper==2'b01)? posx-1 : posx;
   assign salida = next_posx;
  

endmodule


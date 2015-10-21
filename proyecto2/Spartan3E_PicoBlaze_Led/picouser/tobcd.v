

module tobcd
   (
    input wire [7:0] binary,
    output reg [3:0] cen,
    output reg [3:0] dec,
    output reg [3:0] uni
   );

   //signal declaration
   reg [6:0] seg;

   integer i;
   always @(binary)
   begin
   		//set 100's,10's, and 1's to 0
   		cen = 4'd0;
   		dec = 4'd0;
   		   		uni = 4'd0;
   		
   		   		for (i=7; i>=0; i=i-1)
   		   		begin
   		
   		   		if(cen >= 5)
   		   		cen = cen + 3;
   		   		if(dec >= 5)
   		   		dec = dec + 3;
   		   		if(uni >= 5)
   		   		uni = uni + 3;

   		   		cen = cen << 1;
   		   		cen[0] = dec[3];
   		   		dec = dec << 1;
   		   		dec[0] = uni[3];
   		   		uni = uni <<1;
   		   		uni[0] = binary [i];
   		   	end
   		end

endmodule

module bcd7
   (
    input wire [3:0] bcd,
    output wire [6:0] w_seg
   );

   //signal declaration
   reg [6:0] seg;


   //states declaration
	parameter s0 = 		4'b0000;
	parameter s1 = 		4'b0001;
	parameter s2 = 		4'b0010;
	parameter s3 = 		4'b0011;
	parameter s4 = 		4'b0100;
	parameter s5 = 		4'b0101;
	parameter s6 = 		4'b0110;
	parameter s7 = 		4'b0111;
	parameter s8 = 		4'b1000;
	parameter s9 = 		4'b1001;	
	parameter s10 = 	4'b1010;
	parameter s11 = 	4'd11;
	parameter s12 = 	4'd12;
	parameter s13 = 	4'd13;	
	parameter s14 = 	4'd14;  
	parameter s15 = 	4'd15;

    // output

	always @ (*)
	case (bcd)
	s0: seg = 7'b1111110;
	s1: seg = 7'b0110000;
	s2: seg = 7'b1101101;
	s3: seg = 7'b1111001;
	s4: seg = 7'b0110011;
	s5: seg = 7'b1011011;
	s6: seg = 7'b0011111;
	s7: seg = 7'b1110000;
	s8: seg = 7'b1111111;
	s9: seg = 7'b1110011;

	s10: seg = 7'b0001101;
	s11: seg = 7'b0011001;
	s12: seg = 7'b0100011;
	s13: seg = 7'b1001011;
	s14: seg = 7'b0001111;
	s15: seg = 7'b0000000;


	default: seg = 7'b1111110;
	endcase

	assign w_seg= seg;


endmodule
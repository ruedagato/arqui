/*
Universidad de los Andes
Departamento Ingenieria Electrica y Electronica
Arquitectura y Diseño de Sistemas Digitales

Modulo controlador VGA FPGA

Autor:Jose Francisco Molano Pulido (jf.molano1587@uniandes.edu.co)
*/
             
module display
   (
    input wire [9:0] hcount, vcount,
    output wire [2:0] rgb_out
   ); 
//Registro de salida
reg [2:0] rgb_outT;

always @(*) 
//Inicio bloque always
begin
          if(vcount<=10'b0100000000)
          begin
		  if(hcount<=10'b0100110000)
		  begin
		  rgb_outT[2]=1'b1;// Azul
		  rgb_outT[1]=1'b0;
		  rgb_outT[0]=1'b0;
		  end
		  else
		  begin
		  rgb_outT[2]=1'b1;// Azul
		  rgb_outT[1]=1'b1;// Verde
		  rgb_outT[0]=1'b0;
		  end
          end
          else
          begin
		  if(hcount<=10'b0100110000)
		  begin
		  rgb_outT[2]=1'b0;
		  rgb_outT[1]=1'b1;//Verde
		  rgb_outT[0]=1'b0;
		  end
		  else
		  begin
		  rgb_outT[2]=1'b0;
		  rgb_outT[1]=1'b1;//Verde
		  rgb_outT[0]=1'b1;//Rojo
		  end
          end
//Fin bloque always
end      
assign rgb_out=rgb_outT;
endmodule

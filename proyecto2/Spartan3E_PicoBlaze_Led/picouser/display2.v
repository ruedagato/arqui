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
if(vcount<=10'd100) 
begin 
rgb_outT[2]=1'b0;// Negro 
rgb_outT[1]=1'b0; 
rgb_outT[0]=1'b0; 
end
 
else if(vcount>=10'd370)
begin
rgb_outT[2]=1'b0; 
rgb_outT[1]=1'b0;//Negro
rgb_outT[0]=1'b0; 
end 

else
begin
if(hcount<=10'd190) 
begin 
rgb_outT[2]=1'b0;// Negro 
rgb_outT[1]=1'b0; 
rgb_outT[0]=1'b0; 
end
else if(hcount>=10'd550)
begin 
rgb_outT[2]=1'b0;// Negro 
rgb_outT[1]=1'b0; 
rgb_outT[0]=1'b0; 
end
else 
begin
begin 
rgb_outT[2]=1'b1;// Blanco 
rgb_outT[1]=1'b1; 
rgb_outT[0]=1'b1; 
end
end
end

//Fin bloque always 
end  
assign rgb_out=rgb_outT; 
endmodule


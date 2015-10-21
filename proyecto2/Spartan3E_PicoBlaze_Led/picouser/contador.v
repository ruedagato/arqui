module contador
(
	input wire clk,rst,max,
	output wire [7:0] out
);

reg  [7:0] salida;
wire [7:0] wsalida;

always @(posedge clk or posedge rst) begin
	if (rst) 
		salida = 8'd0;
	else 
		salida = wsalida;
end

assign wsalida = (max)?salida +1:salida;
assign out = salida;
endmodule
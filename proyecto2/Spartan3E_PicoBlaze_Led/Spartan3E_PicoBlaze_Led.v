`timescale 1ns / 1ps
/*
 * Spartan3AN_PicoBlaze_Leds.v
 *
 *  ___       _         _   _       _ ___ _ _ ___
 *	| __._ _ _| |_ ___ _| |_| |___ _| | . | \ |_ _|
 *	| _>| ' ' | . / ._/ . / . / ._/ . |   |   || |
 *	|___|_|_|_|___\___\___\___\___\___|_|_|_\_||_|
 *
 *
 *  Created on	: 20/07/2015
 *      Author	: Ernesto Andres Rincon Cruz
 *      Web		: www.embeddedant.org
 *		  Device : XC3S700AN - 4FGG484
 *		  Board  : Spartan-3AN Starter Kit.
 *
 *      Revision History:
 *			Rev 1.0.0 - (ErnestoARC) First release 19/06/2015.
 */
//////////////////////////////////////////////////////////////////////////////////

module Spartan3E_PicoBlaze_Led(
	//////////// CLOCK //////////
	CLK_50M,rst_n,sal,
  r,g,b,w_hsync,w_vsync,LED2,a1,b1,c1,e1,f1,g1,a2,b2,c2,d2,e2,f2,g2,
	//////////// LED //////////
	LED
);

//=======================================================
//  PARAMETER declarations
//=======================================================
parameter  PORTA_ID = 8'h00;

//=======================================================
//  PORT declarations
//=======================================================

input  wire        CLK_50M;
input  wire      rst_n,sal;
output wire  		 LED;
output wire      LED2;
output wire a1,b1,c1,e1,f1,g1,a2,b2,c2,d2,e2,f2,g2;

output wire      r;
output wire      g;
output wire      b;
output wire      w_hsync,w_vsync;

//=======================================================
//  REG/WIRE declarations
//=======================================================
wire [7:0] portA;

//=======================================================
//  Structural coding
//=======================================================


//******************************************************************//
// Instantiate PicoBlaze and the Program ROM.                       // 
//******************************************************************//

  wire    [9:0] address;
  wire    [17:0] instruction;
  wire    [7:0] port_id;
  wire    [7:0] out_port;
  wire    [7:0] in_port;
  wire          write_strobe;
  wire          read_strobe;
  wire          interrupt;
  wire          reset;		

  // conexiones user
  wire w_video_on,minimo,maximo,w_bit,w_bit_3,minimo_2,maximo_2,w_bit_2,w_led,temmm;
  wire [9:0] w_pixel_x, w_pixel_y,x_posicion_salida,x_posicion_salida_2,wys;
  wire [2:0] rgb_outS,rgb_fondo;
  wire [3:0] s_muneco,s_nivel,unidades,decenas;
  wire [1:0] w_oper,w_oper_2,w_cont;
  wire [6:0] seg1,seg2;
  wire [7:0] con_sal;


  kcpsm3 kcpsm3_inst (
    .address(address),
    .instruction(instruction),
    .port_id(port_id),
    .write_strobe(write_strobe),
    .out_port(out_port),
    .read_strobe(read_strobe),
    .in_port(in_port),
    .interrupt(interrupt),
    .interrupt_ack(),
    .reset(reset),
    .clk(CLK_50M));

  picocode picocode_inst (
    .address(address),
    .instruction(instruction),
    .clk(CLK_50M)); 
	 
	PicoBlaze_OutReg	#(.LOCAL_PORT_ID(PORTA_ID)) portA_inst(
	 .clk(CLK_50M),
	 .reset(reset),
	 .port_id(port_id),
	 .write_strobe(write_strobe),
	 .out_port(out_port),
	 .new_out_port(portA));


  vga_sync vga
   (
    //input
    .clk(CLK_50M), 
    .reset(reset),
    //output
    .hsync(w_hsync), 
    .vsync(w_vsync), 
    .video_on(w_video_on), 
    .p_tick(),
    .pixel_x(w_pixel_x), 
    .pixel_y(w_pixel_y)
   );

  display display_u 
   (
    .hcount(w_pixel_x),
    .vcount(w_pixel_y),
    .rgb_out()
   );

   ficha ficha
(
  .clk(CLK_50M),
  .hcount(w_pixel_x),
  .vcount(w_pixel_y),
  .origen_y(x_posicion_salida),
  .rgb_out(s_muneco)
);

  nivel nivel1
(
  .clk(CLK_50M),
  .hcount(w_pixel_x),
  .vcount(w_pixel_y),
  .origen_x(x_posicion_salida_2),
  .origen_y(wys),
  .rgb_out(s_nivel)
);

display fondo
( 
  .hcount(w_pixel_x), 
  .vcount(w_pixel_y),
  .rgb_out(rgb_fondo) 
);


imagen multi
  (
  //entradas
  .muneco(s_muneco), 
  .nivel(s_nivel), 
  .fondo(rgb_fondo),
  //salidas
  .o_salida(rgb_outS)
  );

// bloques de movimiento 1

cmove mover1
  (
   // entradas
   .clk(CLK_50M), 
   .reset(reset),
   .oper(w_oper),
   .N(10'd100),
   .M(10'd300),
   .X(10'd290),
   // salidas
   .x_min(minimo), 
   .x_max(maximo),
   .salida(x_posicion_salida)
  );

movx control1
  (
    //entradas
    .clk(CLK_50M), 
    .rst(reset),
    .s( w_bit),
    .perdio(w_led),
    .MN(minimo),
    .MX(maximo),
    .sta(sal),
    .cont(sal),
    //salidas
    .o_signal(w_oper)
  );

bit bit
(
  //entrada
  .clk(CLK_50M),
  .s( portA[0]),
  .rst(reset),
  //salida
  .out(w_bit)
);

bit bit2
(
  //entrada
  .clk(CLK_50M),
  .s( portA[1]),
  .rst(reset),
  //salida
  .out(w_bit_2)
);

// bloque de movimiento 2

volver mover2
  (
   // entradas
   .clk(CLK_50M), 
   .reset(reset),
   .oper(w_oper_2),
   .N(10'd100),
   .M(10'd560),
   .X(10'd555),
   // salidas
   .x_min(minimo_2), 
   .x_max(maximo_2),
   .salida(x_posicion_salida_2)
  );

movx control2
  (
    //entradas
    .clk(CLK_50M), 
    .rst(reset),
    .s( w_bit_2),
    .perdio(w_led),
    .MN(minimo_2),
    .MX(maximo_2),
    .sta(minimo),
    .cont(1'b1),
    //salidas
    .o_signal(w_oper_2)
  );

// control de juego
perdio perdio
  (
  .posx1(10'd200),
  .posx2(x_posicion_salida_2),
  .posy1(x_posicion_salida),
  .posy2(wys),
  .o_signal(w_led)
  );

posy poss
   (
    .clk(CLK_50M), 
    .rst(rst),
    .change(minimo_2),
    .o_signal(wys)
   );


// puntuacion del juego
tobcd conv
   (
    .binary(con_sal),
    .cen(),
    .dec(decenas),
    .uni(unidades)
   );

bcd7 unid
   (
    .bcd(unidades),
    .w_seg(seg1)
   );

bcd7 dece
   (
    .bcd(decenas),
    .w_seg(seg2)
   );


contador contad
(
  .clk(CLK_50M),
  .rst(reset),
  .max(minimo_2),
  .out(con_sal)
);
//=======================================================
// 			Connections & assigns
//======================================================= 

//******************************************************************//
// Input PicoBlaze Interface.                       					  // 
//******************************************************************//
assign in_port = 8'h00;
assign interrupt = 1'b0;
assign reset = ~rst_n;
assign a2 = 1'b1;
assign b2 = ~seg1[5];
assign c2 = ~seg1[4];
assign d2 = ~seg2[3];
assign e2 = ~seg1[2];
assign f2 = ~seg1[1];
assign g2 = ~seg1[0];

assign a1 = ~seg2[6];
assign b1 = ~seg2[5];
assign c1 = ~seg2[4];
assign e1 = ~seg2[2];
assign f1 = ~seg2[1];
assign g1 = ~seg2[0];
//******************************************************************//
// Output PicoBlaze Interface.                       					  // 
//******************************************************************//
assign LED = portA[0];
assign LED2 = temmm;

// asignaciones usuario
assign r = rgb_outS[2]&w_video_on;
assign g = rgb_outS[1]&w_video_on;
assign b = rgb_outS[0]&w_video_on;


endmodule

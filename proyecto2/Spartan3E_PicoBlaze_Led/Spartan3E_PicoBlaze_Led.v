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
	CLK_50M,
  r,g,b,w_hsync,w_vsync,
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
output wire  		 LED;

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
  wire w_video_on;
  wire [9:0] w_pixel_x, w_pixel_y;
  wire [2:0] rgb_outS;
  wire [3:0] s_muneco,s_nivel;


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
  .origen_y(10'd200),
  .rgb_out(s_muneco)
);

  nivel nivel1
(
  .clk(CLK_50M),
  .hcount(w_pixel_x),
  .vcount(w_pixel_y),
  .origen_x(10'd400),
  .rgb_out(s_nivel)
);


imagen multi
  (
  //entradas
  .muneco(s_muneco), 
  .nivel(s_nivel), 
  .fondo(4'b0011),
  //salidas
  .o_salida(rgb_outS)
  );

//=======================================================
// 			Connections & assigns
//======================================================= 

//******************************************************************//
// Input PicoBlaze Interface.                       					  // 
//******************************************************************//
assign in_port = 8'h00;
assign interrupt = 1'b0;
assign reset = 1'b0;
//******************************************************************//
// Output PicoBlaze Interface.                       					  // 
//******************************************************************//
assign LED = portA[0];

// asignaciones usuario
assign r = rgb_outS[2]&w_video_on;
assign g = rgb_outS[1]&w_video_on;
assign b = rgb_outS[0]&w_video_on;


endmodule

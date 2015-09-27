`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:13:25 09/06/2015 
// Design Name: 
// Module Name:    Proyecto2_Top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Proyecto2_Top(

input clk, reset,
input wire kbclck, kbdata, en,
output wire alarm,
output wire warning,
output  [3:0] statuse,
output H,  //Declaramos la salida tipo bus de 4 bits outp
output T,
output a, b, c, d, e, f, g, dp, //the individual LED output for the seven segment along with the digital point
output[3:0] an
    );

wire [7:0] datain_1;
wire [6:0] datain_2;
wire hum_1;

RecepcionDato Teclado (
    .clk(clk), 
    .reset(reset), 
    .ps2d(kbdata), 
    .ps2c(kbclck), 
    .rx_en(en), 
    .dataout(datain_1)
    );
	 
// Instantiate the module
Deco Filtrado (
    .datain(datain_1), 
    .dataout(datain_2)
    );
	 

Filtro_h Filtro_Humo (
    .dato(datain_2), 
    .reset(reset), 
    .clock(clk), 
    .Htec(hum_1)
    ); 



Proyecto_1 Maquina_incendio (
    .inp(datain_2), 
    .clock(clk), 
    .clr(reset), 
    .hu(hum_1), 
    .H(H), 
    .T(T), 
    .alarm(alarm), 
    .warning(warning), 
    .statuse(statuse), 
    .a(a), 
    .b(b), 
    .c(c), 
    .d(d), 
    .e(e), 
    .f(f), 
    .g(g), 
    .dp(dp), 
    .an(an)
    );

endmodule

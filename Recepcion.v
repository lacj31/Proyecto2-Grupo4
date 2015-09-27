`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: Instituto Tecnologico de Costa Rica
// Engineer: 
// 
// Create Date:    09:57:21 09/14/2015 
// Design Name: 
// Module Name:    RecepcionDato 
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
module RecepcionDato(input wire clk, reset,
input wire ps2d, ps2c, rx_en,
output wire [7:0] dataout

    ); 
	  
wire s,s1; 
wire [7:0] data;
  


PS2_Controller ps2receiver(
.clk(clk),
.reset(reset),
.PS2_DAT(ps2d),
 .PS2_CLK(ps2c),
 .send_command(rx_en),
 .received_data_en(s),
 .received_data(data));
 
 
Dato obtenciondato( 
.ready(s),
 .clk(clk),
 .reset(reset),
 .datain(data),
 .dataout(dataout));


endmodule

`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luis Adriàn Castillo J
// 			 Carlos Carranza
// Create Date:    09:00:10 09/06/2015 
// Design Name: 
// Module Name:    Filtro_h 
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
module Filtro_h(
input [6:0] dato,
input reset,
input clock,          //Declaramos la entrada clk
output reg Htec          //Declaramos la entrada clr
	
    );
localparam bn1 = 7'b0111100;
reg d1;
//reg d3;


always @ (dato)
	if (dato==bn1)
		d1 = 1'b1;
	else
		d1 = 1'b0;
    
always @(posedge clock)
      if (reset) begin
         Htec <= 1'b0;
      end else if (d1) begin
         Htec <= d1;
      end		

		


endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: Luis Adriàn Castillo J
//           Carlos Carranza
// Create Date:    00:51:55 09/06/2015 
// Design Name: 
// Module Name:    Deco 
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
module Deco(
   input wire [7:0] datain, 
	output reg [6:0] dataout
	);
	 
always@(datain)
	begin
		
		
				case(datain)
			    8'h16: begin
				 dataout<=7'b0001010; //Temperatura de 10 grados
				
				 end
				 8'h1E: begin
				 dataout<=7'b0001111; //Temperatura de 15 grados
				
				 end 
				 8'h26: begin
				 dataout<=7'b0010100; //Temperatura de 20 grados
				 
				 end
				 8'h25: begin
				 dataout<=7'b0011001; //Temperatura de 25 grados
				
				 end
				 8'h2E: begin
				 dataout<=7'b0011011; // Temperatura de 27 grados
				 
				 end
				 8'h36: begin
				 dataout<=7'b0011110; // Temperatura de 30 grados
				
				 end
				 8'h3D: begin
				 dataout<=7'b0100000; //Temperatura de 32 grados
				
				 end
				 8'h3E: begin
				 dataout<=7'b0100011; //Temperatura de 35 grados
				
				 end
				 8'h46: begin
				 dataout<=7'b0100111; //Temperatura de 39 grados
				
				 end
				 8'h45: begin
				 dataout<=7'b0101001; //Temperatura de 41 grados
				
				 end
				 8'h33: begin
				 dataout<=7'b0111100; //Presencia de humo
				
				 end
				
				default: begin 
				dataout<=7'b0000000;	// La salida seria 0, en todos los demás
				
				end
				endcase
		
	
	end

	 

endmodule

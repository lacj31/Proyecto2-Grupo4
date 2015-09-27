`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Instituto Tecnologico de Costa Rica
//
// Estudiantes: Luis Adrián Castillo J
//				    Carlos Carranza
//
//	
// Module:  PS2_CONTROLER 
// Create Date:    00:18:55 09/06/2015 
// Design Name: 
// Module Name:    Dato 
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
module Dato(
 input wire ready, clk,reset, input wire [7:0] datain, output reg [7:0] dataout);

//declaración de señales 	 
reg [1:0] estado, est_sig;
reg [7:0] data_sig;


//inicialización
 
 
always @(posedge clk,posedge reset) 
	begin
	if(reset) begin
		estado=2'b00;
	   dataout=8'd0;
		
		end
	else 
		begin
		dataout=data_sig;
		estado=est_sig;
	
		
		end
	end
	



always@*
	begin 
		 
		est_sig=estado; 
		
		data_sig=dataout;
		

	case(estado)
	2'b00: 
	begin
		if (ready) begin
			
			est_sig=2'b01; end 
		else begin
			est_sig=estado;end 
	end
	
	2'b01: 
	begin
		if ((datain)==(8'hf0))begin
			est_sig=2'b10;end
		else begin
			est_sig=2'b00;end		
	end
	
	2'b10: 
	begin
	
		if (ready) 
			begin
			data_sig=datain;
		
			est_sig=2'b00;
			
			end
		else begin
			est_sig=2'b10; end		
	end 
	
	2'b11:begin 
	 est_sig=2'b00; end
	
		



endcase

end
	
endmodule

`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   10:35:32 09/06/2015
// Design Name:   Proyecto2_Top
// Module Name:   C:/Xilinx/Trabajos/Proyecto2/proyever2/p2simu.v
// Project Name:  proyever2
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: Proyecto2_Top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module p2simu;

	// Inputs
	reg clk;
	reg reset;
	reg kbclck;
	reg kbdata;
	reg en;

	// Outputs
	wire alarm;
	wire warning;
	wire [3:0] statuse;
	wire H;
	wire T;
	wire a;
	wire b;
	wire c;
	wire d;
	wire e;
	wire f;
	wire g;
	wire dp;
	wire [3:0] an;
	

	// Instantiate the Unit Under Test (UUT)
	Proyecto2_Top uut (
		.clk(clk), 
		.reset(reset), 
		.kbclck(kbclck), 
		.kbdata(kbdata), 
		.en(en), 
		.alarm(alarm), 
		.warning(warning), 
		.statuse(statuse), 
		.H(H), 
		.T(T), 
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
	
	
	initial forever #50000 kbclck=~kbclck;
initial forever #10 clk=~clk;
//initial forever #50000 kbclck=~kbclck;
	initial begin
		// Initialize Inputs
		clk = 1;
		reset = 0;
		kbdata = 1;
		kbclck = 1;
		en=1;
/*		repeat(10) @(posedge clk)
		reset=1;
	
	#100000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;
	#1100000 en=0;
	#1000000 en=1;*/

			reset = 1;
		   // se manda el primer dato en hexa en este caso 2a
			kbdata = 1;
			#40000; // bit de parada 
			@(posedge kbclck); // se cambian los valores de ps2c en cambios de 0 a 1 ya que este modulo funciona con cambios negativos 
			en = 1; // se  indica que ya se puede leer 
			#40000;
			kbdata = 0; // bit de incio
			@(posedge kbclck);
			kbdata = 1; // bit Lsb [0]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit [1]
			#40000;
			@(posedge kbclck);
			kbdata = 0; // bit [2]
			#40000;
			@(posedge kbclck);
			kbdata = 0; // bit [3]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit [4]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit [5]
			#40000;
			@(posedge kbclck);
			kbdata = 0; // bit [6]
			#40000;
			@(posedge kbclck);
			kbdata = 0; // bit MSB [7]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit paridad
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit de parada 
			en = 0;
			#40000;
			// se termina de mandar la  primer letra 2a
			// se prosede a mandar el f0 del protocolo ps2 
			en = 1;
			#40000;
			kbdata = 0; // bit de incio
			@(posedge kbclck);
			kbdata = 0; // bit Lsb [0]
			#40000;
			@(posedge kbclck);
			kbdata = 0; // bit [1]
			#40000;
			@(posedge kbclck);
			kbdata = 0; // bit [2]
			#40000;
			@(posedge kbclck);
			kbdata = 0; // bit [3]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit [4]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit [5]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit [6]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit MSB [7]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit paridad
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit de parada 
			en = 0;
			#40000;
			// se termina de mandar el codigo de  F0
			// se procede a mandar una vez mas 2a
			en = 1;
			#40000;
			kbdata = 0; // bit de incio
			@(posedge kbclck);
			kbdata = 1; // bit Lsb [0]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit [1]
			#40000;
			@(posedge kbclck);
			kbdata = 0; // bit [2]
			#40000;
			@(posedge kbclck);
			kbdata = 0; // bit [3]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit [4]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit [5]
			#40000;
			@(posedge kbclck);
			kbdata = 0; // bit [6]
			#40000;
			@(posedge kbclck);
			kbdata = 0; // bit MSB [7]
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit paridad
			#40000;
			@(posedge kbclck);
			kbdata = 1; // bit de parada 
			en = 0;
			#40000;
			// se termina la simulacion 
//		$stop;
		end
        
		// Add stimulus here

      
endmodule


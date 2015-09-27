`timescale 1ns / 1ps
/***************************************************************************** 
Instituto Tecnologico de Costa Rica

Estudiantes: Luis Adri�n Castillo J
				 Carlos Carranza

	
 * Module:  PS2_CONTROLER                                                    * 
 * Description:                                                              * 
 *      This module communicates with the PS2 core.                          * 
 *                                                                           * 
 *****************************************************************************/ 
 
module PS2_Controller ( 
	// Inputs 
	clk, 
	reset, 
 
//	the_command1, 
	send_command, 
 
	// Bidirectionals 
	PS2_CLK,					// PS2 Clock 
 	PS2_DAT,					// PS2 Data 
 
	// Outputs 
//	command_was_sent, 
//	error_communication_timed_out, 
 
	received_data, 
	received_data_en			// If 1 - new data has been received 
); 
 
// Inputs 
input			clk; 
input			reset; 
 

input			send_command;  
input			PS2_CLK; 
input		 	PS2_DAT; 
 
 
output	[7:0]	received_data; 
output		 	received_data_en; 
 

// states 
localparam	PS2_STATE_0_IDLE			= 3'h0, 
			PS2_STATE_1_DATA_IN			= 3'h1, 
			PS2_STATE_2_COMMAND_OUT		= 3'h2, 
			PS2_STATE_3_END_TRANSFER	= 3'h3, 
			PS2_STATE_4_END_DELAYED		= 3'h4; 

// Internal Wires 
wire			ps2_clk_posedge; 
wire			ps2_clk_negedge; 
 
wire			start_receiving_data; 
wire			wait_for_incoming_data; 
 
// Internal Registers 
reg		[7:0]	idle_counter; 
 
reg				ps2_clk_reg; 
reg				ps2_data_reg; 
reg				last_ps2_clk; 
 
// State Machine Registers 
reg		[2:0]	ns_ps2_transceiver; 
reg		[2:0]	s_ps2_transceiver; 
 
//FSM
always @(posedge clk) 
begin 
	if (reset == 1'b1) 
		s_ps2_transceiver <= PS2_STATE_0_IDLE; 
	else 
		s_ps2_transceiver <= ns_ps2_transceiver; 
end 
 
always @(*) 
begin 
	
	ns_ps2_transceiver = PS2_STATE_0_IDLE; 
 
    case (s_ps2_transceiver) 
	PS2_STATE_0_IDLE: 
		begin 
			if ((idle_counter == 8'hFF) &&  
					(send_command == 1'b1)) 
				ns_ps2_transceiver = PS2_STATE_2_COMMAND_OUT; 
			else if ((ps2_data_reg == 1'b0) && (ps2_clk_posedge == 1'b1)) 
				ns_ps2_transceiver = PS2_STATE_1_DATA_IN; 
			else 
				ns_ps2_transceiver = PS2_STATE_0_IDLE; 
		end 
	PS2_STATE_1_DATA_IN: 
		begin 
			if ((received_data_en == 1'b1)) 
				ns_ps2_transceiver = PS2_STATE_0_IDLE; 
			else 
				ns_ps2_transceiver = PS2_STATE_1_DATA_IN; 
		end 
	
	PS2_STATE_3_END_TRANSFER: 
		begin 
			if (send_command == 1'b0) 
				ns_ps2_transceiver = PS2_STATE_0_IDLE; 
			else if ((ps2_data_reg == 1'b0) && (ps2_clk_posedge == 1'b1)) 
				ns_ps2_transceiver = PS2_STATE_4_END_DELAYED; 
			else 
				ns_ps2_transceiver = PS2_STATE_3_END_TRANSFER; 
		end 
	PS2_STATE_4_END_DELAYED:	 
		begin 
			if (received_data_en == 1'b1) 
			begin 
				if (send_command == 1'b0) 
					ns_ps2_transceiver = PS2_STATE_0_IDLE; 
				else 
					ns_ps2_transceiver = PS2_STATE_3_END_TRANSFER; 
			end 
			else 
				ns_ps2_transceiver = PS2_STATE_4_END_DELAYED; 
		end	 
	default: 
			ns_ps2_transceiver = PS2_STATE_0_IDLE; 
	endcase 
end  
 
always @(posedge clk) 
begin 
	if (reset == 1'b1) 
	begin 
		last_ps2_clk	<= 1'b1; 
		ps2_clk_reg		<= 1'b1; 
 
		ps2_data_reg	<= 1'b1; 
	end 
	else 
	begin 
		last_ps2_clk	<= ps2_clk_reg; 
		ps2_clk_reg		<= PS2_CLK; 
 
		ps2_data_reg	<= PS2_DAT; 
	end 
end 
 
always @(posedge clk) 
begin 
	if (reset == 1'b1) 
		idle_counter <= 6'h00; 
	else if ((s_ps2_transceiver == PS2_STATE_0_IDLE) && 
			(idle_counter != 8'hFF)) 
		idle_counter <= idle_counter + 6'h01; 
	else if (s_ps2_transceiver != PS2_STATE_0_IDLE) 
		idle_counter <= 6'h00; 
end 
 

assign ps2_clk_posedge =  
			((ps2_clk_reg == 1'b1) && (last_ps2_clk == 1'b0)) ? 1'b1 : 1'b0; 

 
assign start_receiving_data		= (s_ps2_transceiver == PS2_STATE_1_DATA_IN); 
assign wait_for_incoming_data	=  
			(s_ps2_transceiver == PS2_STATE_3_END_TRANSFER); 
 
 
Altera_UP_PS2_Data_In PS2_Data_In ( 
	// Inputs 
	.clk							(clk), 
	.reset							(reset), 
 
	.wait_for_incoming_data			(wait_for_incoming_data), 
	.start_receiving_data			(start_receiving_data), 
 
	.ps2_clk_posedge				(ps2_clk_posedge), 

	.ps2_data						(ps2_data_reg), 
 
 
	// Outputs 
	.received_data					(received_data), 
	.received_data_en				(received_data_en) 
); 
 

endmodule

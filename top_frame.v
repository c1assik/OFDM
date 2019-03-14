    
// -----------------------------------------------------------------------------
// Copyright (c) 2018 All rights reserved
// -----------------------------------------------------------------------------
// Author : Miyutin & Petrovsky 
// File   : toptop_frame.v
// Create : 2018-12-21 14:59:25
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module top_frame(
	input clock, enable, reset, ready_in, mod_switch,
	output reg signed [15:0] I, Q,
	output sop

);
   wire controlkkkk;
   wire ready_in1;
   wire sop_preamb, sop_ofdm;
   wire signed [15:0] I_O,Q_O,I_P,Q_P;
 

   	
	toptop_OFDM toptop_OFDM1					       	(.clock(clock),
														 .enable(enable),
														 .reset(reset),
													     .ready_in(ready_in1),
													     .control(~control),
													     .I_OFDM(I_O),
													     .Q_OFDM(Q_O),
													     .sop(sop_ofdm),
													     .mod_switch(mod_switch)
		                 								 );
	
	toptop_preambule toptop_preambule1    				(.clock(clock),
														 .enable(enable),
														 .reset(reset),
														 .control(control),
													     .ready_in(ready_in1),
													     .I_preamb(I_P),
													     .Q_preamb(Q_P),
													     .sop(sop_preamb),
													     .mod_switch(mod_switch)
		                 								 );


	counter_frame counter_frame1                        (.clock(clock),
														 .enable(enable),
														 .reset(reset),
													     .ready_in(ready_in),
													     .ready_out(ready_in1),
													     .control_signal(control)
		                 								 );
	

	
	always @(posedge clock or posedge reset) begin
		if (reset) begin
			I<=0;
			Q<=0;
		end
		else  begin
			I <= (control) ? I_P : I_O;
			Q <= (control) ? Q_P : Q_O;
		end
	end

assign sop = sop_ofdm || sop_preamb;

endmodule
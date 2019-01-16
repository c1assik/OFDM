    
// -----------------------------------------------------------------------------
// Copyright (c) 2018 All rights reserved
// -----------------------------------------------------------------------------
// Author : Miyutin & Petrovsky 
// File   : toptop.v
// Create : 2018-12-21 14:59:25
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module toptop_OFDM(
	input clock, enable, reset, ready_in, mod_switch,control,
	output signed [15:0] I_OFDM, Q_OFDM,
	output sop,
	output signed [15:0] out_q,out_i
);
   wire signed [15:0] s1, s2;
   wire ready_in2, ready_in3,ready_in4, valid_rom, valid_qam, valid_pilot;
   wire index_pilot, sign_pilot, ready_out_pilots;
   wire  [10:0] count_index;
   wire [3:0]	Bit_wire;
   assign ready_in1 = ready_in3 && ready_in2;
   assign out_i = s1;
   assign out_q = s2;

   	
	build_rom_OFDM build_rom_OFDM1        				(.clock(clock),
														 .enable(enable),
														 .reset(reset),
													     .Bit_ROM(Bit_wire),
													     .ready_in(ready_in1),
													     .valid_rom(valid_rom),
													     .sop(sop),
													     .mod_switch(mod_switch)
		                 								 );
	
	
	
	qam qam2 					                        (.clk(clock),
													    .idata(Bit_wire),
														 .en(enable),
														 .res(reset),
														 .i(s1),
														 .q(s2),
														 .ready_in(ready_in4),
														 .ready_out(ready_in2),
														 .valid_rom(valid_rom),
														 .valid_qam(valid_qam)
													     );
	
	OFDM_subcarrier_mux	OFDM_subcarrier_mux1		    (.clk(clock),
									 					 .en(enable),
														 .res(reset),
														 .control(control),
														 .ready_in(ready_in),
														 .ready_out_ROM(ready_in3),
														 .ready_out_QAM(ready_in4),
														 .i(s1),
														 .q(s2),
														 .i_OFDM(I_OFDM),
														 .q_OFDM(Q_OFDM),
														 .valid_qam(valid_qam),
														 .valid_pilot(valid_pilot),
														 .index_pilot(index_pilot),
														 .sign_pilot(sign_pilot),
														 .ready_out_pilots(ready_out_pilots),
														 .count(count_index),
														 .sop(sop)
														 );

	pilots pilots2					                 (	 .clk(clock),
													    
														 .en(enable),
														 .res(reset),
														 .ready_in(ready_out_pilots),
														 .index_pilot(index_pilot),
														 .sign_pilot(sign_pilot),
														 .valid_pilot(valid_pilot),
														 .count_index(count_index)
													     );
	
	
	
endmodule

    
// -----------------------------------------------------------------------------
// Copyright (c) 2018 All rights reserved
// -----------------------------------------------------------------------------
// Author : Milyutin & Petrovsky 
// File   : build_rom.v
// Create : 2018-12-21 17:19:19
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------


module build_rom
#(parameter ADDR_WIDTH=11)
(
	input clock, enable,reset, ready_in, mod_switch,sop,
	output [3:0] Bit_ROM,
	output valid_rom, valid_count
);
   wire [ADDR_WIDTH-1:0] addr1;
   wire ready;
	
	counter_rom_preambule counter_rom_preambule1		(.clk(clock),
									 					.en(enable),
														 .sop(sop),
														 .reset(reset),
														 .addr(addr1),
														 .ready_in(ready),
														 .valid_count(valid_count),
														 .mod_switch(mod_switch)
								  					 	);
	
	ROM_preambule ROM1										    (.clk(clock),
														 .en(enable),
														 .reset(reset),
														 .addr(addr1),
														 .idata(Bit_ROM),
														 .ready_out(ready),
														 .ready_in(ready_in),
														 .valid_count(valid_count),
														 .valid_rom(valid_rom),
														 .mod_switch(mod_switch)
														 );
	

endmodule
    
// -----------------------------------------------------------------------------
// Copyright (c) 2018 All rights reserved
// -----------------------------------------------------------------------------
// Author : Miyutin & Petrovsky 
// File   : counter_rom_preambule.v
// Create : 2018-12-21 14:59:07
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module counter_rom_preambule
#(parameter ADDR_WIDTH=11)
(   
	input clk, en, reset,ready_in,mod_switch,sop,
	output reg  [ADDR_WIDTH-1:0] addr,
	output reg valid_count
);
   reg switch;
initial
begin
	switch =0;
	addr =0;
	valid_count = 0;
end

        always @(posedge reset) 
        begin
          switch <= mod_switch; 
        end
        
        always @(posedge clk or posedge reset ) begin
         if(reset) valid_count <=0;
           else valid_count <=(en && ready_in)?1'b1: 1'b0;
        	end


		always @(posedge clk or posedge reset) begin
		if (reset || sop) begin
			addr <=0;
			end
		else begin if(en && ready_in) begin
				case(switch) 
					0:
				       if(addr == 11'b11001101111) addr <= 0;
					   else addr <= addr + 1;

					1:
					   if(addr == 11'b11001101110) addr <= 0;
					   else addr <= addr + 2;

					 default: if(addr == 11'b11001101111) addr <= 0;
					   else addr <= addr + 1;
				endcase      	 
		end
	end
		end

endmodule
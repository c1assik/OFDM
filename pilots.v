    
// -----------------------------------------------------------------------------
// Copyright (c) 2018 All rights reserved
// -----------------------------------------------------------------------------
// Author : Miyutin & Petrovsky 
// File   : pilots.v
// Create : 2018-12-21 14:59:33
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module pilots
#(parameter DATA_WIDTH=1, parameter ADDR_WIDTH_INDEX=10, parameter ADDR_WIDTH_VALUE=80
)
(

	input clk, en, res, ready_in,
	input [10:0] count_index,

	output reg valid_pilot,
	output reg  index_pilot, sign_pilot
);

    reg  [6:0] count_value;
	reg  index[2**ADDR_WIDTH_INDEX:0];
	reg  value[ADDR_WIDTH_VALUE:0];
	//reg [(DATA_WIDTH-1):0] idata;// idata register

	initial
	begin
		$readmemb("index.txt", index);
		$readmemb("value.txt", value);
        count_value = 0;
		
	
	end

  always @(posedge clk or posedge res) 
begin 												                	
	if (res) 														   
	begin                                       			   	      
		count_value <=0;                                           		                                      		
	end                                                      
	else 
	begin 
		if(en && ready_in) 
		begin     								                   
			if(count_value == 7'd80 || count_index  == 10'b1111111111) count_value <= 0;                         
			else if(index_pilot) count_value <= count_value + 1;						    
		end                                                       						    
	end
end

		always @(posedge clk or posedge res) 
		begin
			if (res) 
			begin
				index_pilot <=0;
				sign_pilot <=0;
				valid_pilot <=0;
			end 
		else if (en && ready_in)		
			begin  
			 valid_pilot <= 1'b1;
			 index_pilot <= index[count_index];
			 sign_pilot <= value[count_value];
	        end else valid_pilot <=0;
		end


endmodule

    
// -----------------------------------------------------------------------------
// Copyright (c) 2018 All rights reserved
// -----------------------------------------------------------------------------
// Author : Miyutin & Petrovsky 
// File   : OFDM_preambule.v
// Create : 2018-12-21 14:58:43
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
module OFDM_preambule
#(parameter OFDM_SIZE   = 512*2,
  parameter Num_Carrier = 412*2)
(

input clk,en,res,valid_qam, ready_in, valid_pilot,
input signed [15:0] i,q,
input index_pilot, sign_pilot,control,
//input signed [15:0] pilots,
output reg  [10:0] count,
output reg ready_out_ROM,ready_out_QAM,ready_out_pilots,
output reg valid_OFDM,
output reg signed [15:0] i_preambule, q_preambule,
output reg sop
);

reg indexCarrier;
reg signed [15:0] pilot_value;
reg pilot1, pilot2, pilot3;   // delay for pilots, 2 ticks


initial
 begin
  pilot_value           = 16'd32_767;
 end



//wire indexCarrier;
reg [10:0] mid_ofdm;
reg [10:0] Left_index;
reg [10:0] Right_index;



initial
begin
valid_OFDM              = 0;
sop                     = 0;
indexCarrier            = 0;
ready_out_ROM           = 0;
ready_out_QAM           = 0;
 i_preambule                 = 0;
 q_preambule                 = 0;
 mid_ofdm               = (OFDM_SIZE >> 1) - 1;                     
 Left_index             = mid_ofdm - (Num_Carrier >> 1);   
 Right_index            = mid_ofdm + (Num_Carrier >> 1);  
 count                  = 0;
end


always@(posedge clk or posedge res)
begin 												                	
	if (res) 														   
	begin                                       			   	      
		pilot1          <= 0;
		pilot2          <= 0;        
	end                                                      
	else 
	begin 
	pilot1              <= index_pilot;
	pilot2              <= pilot1;   
	pilot3              <= pilot2;       
	end                                                       						    
end



always @(posedge clk or posedge res) 
begin 												                	
	if (res) 														   
	begin                                       			   	      
		count           <=0;                                                                                              
	end                                                      
	else 
	begin 
		if(en && ready_in && control) 
		begin     								                   
			if(count == 10'b1111111111) count <= 0;                         
			else count  <= count + 1;    
			sop         <= (count == 0) ? 1 : 0;                        
		end                                                       						    
	end
end


always @(posedge clk or posedge res) begin
	if (res) begin
	 i_preambule             <= 0;
     q_preambule             <= 0;
     valid_OFDM         <= 0;
	end
	else if (en && ready_in && valid_pilot && control) begin
	valid_OFDM          <= 1;
	 i_preambule             <= (pilot3) ? (sign_pilot ? (~pilot_value + 1) : pilot_value) : ((indexCarrier && valid_qam) ?  i : 0);
     q_preambule             <= (pilot3) ? 0 : ((indexCarrier && valid_qam) ?  q : 0);
	end else valid_OFDM <= 0;
end





always @(posedge clk or posedge res) begin
	if (res) begin
     ready_out_ROM      <= 0;
     ready_out_QAM      <= 0;
     ready_out_pilots   <= 0;
     indexCarrier       <= 0;
	end
	else if (en && ready_in && control) begin
	 ready_out_pilots   <= 1'b1;
   ready_out_ROM        <= index_pilot ? 1'b0 : (((count < Left_index -2'b10) || (count == mid_ofdm-2'b11) || (count > Right_index-2'b10)) ? 0 : 1'b1);
	 ready_out_QAM      <= ((count < Left_index -2'b01) || (count == mid_ofdm-2'b01) || (count > Right_index-2'b01)) ? 0 : 1'b1;
      indexCarrier      <= ((count < Left_index ) || (count == mid_ofdm) || (count > Right_index)) ? 0 : 1'b1;   
	end
end



endmodule
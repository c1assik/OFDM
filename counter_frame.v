module counter_frame #(parameter COUNT_SIZE = 12)
(
input clock,enable,reset,ready_in,
output reg control_signal, 
output reg ready_out
);
reg delay_ready_in;
reg [COUNT_SIZE-1:0] count_frame;
always @(posedge clock or posedge reset) 
begin 												                	
	if (reset) 														   
	begin                                       			   	      
		count_frame    <=0;     
		control_signal <=0;                                                                                         
	end                                                      
	else 
	begin 
	 	ready_out <= ready_in;
		if(enable && ready_in) 
		begin     								                   
			if(count_frame == 12'b111111111111) count_frame <= 0;                         
			else count_frame  <= count_frame + 1;    
			    
		end                                                       						    
	end
end

always @(clock)
begin
control_signal         <= (count_frame < 1024) ? 1'b1 : 1'b0; 
end
endmodule
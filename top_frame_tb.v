    
// -----------------------------------------------------------------------------
// Copyright (c) 2018 All rights reserved
// -----------------------------------------------------------------------------
// Author : Miyutin & Petrovsky 
// File   : toptop_tb.v
// Create : 2018-12-21 14:59:11
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------



/** The rom testbenablech */
module top_frame_tb;

parameter tck = 10; ///< clock tick

reg clock,enable, reset,ready_in,mod_switch; 
wire signed [15:0] I, Q;
wire sop;

/** The LFSR DUT instance */
top_frame top_inst(clock,enable, reset,ready_in,mod_switch,I,Q,sop);
integer outfile;

initial 
begin
	outfile =$fopen("OFDM_FRAME.txt");	

	$dumpfile("top_frame.vcd");
	$dumpvars(0, top_frame_tb);
	$monitor("%b", clock,enable, reset,ready_in,mod_switch,I, Q,sop);
end

// testbenablech actions
initial
begin
	clock = 0;enable =0; reset = 0; ready_in = 0; mod_switch = 1;
	#50 enable =1;
	#10 reset =1;
	#10 reset =0;
	#100 ready_in = 1;
	#6000 reset = 1;
	#10 reset = 0;
	

	

end 

initial 
begin

	#80000$fclose(outfile);
	#1 $finish;	
end
integer i=0;
initial
begin
#2;
 while(i < 7000) begin
 	$fdisplay(outfile, "%d", I,"\t", Q,"\t", sop);		
 	#10;
 	i = i + 1;
 end
end


always #(tck/2) clock <= ~clock; // clocking device


endmodule

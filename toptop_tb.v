    
// -----------------------------------------------------------------------------
// Copyright (c) 2018 All rights reserved
// -----------------------------------------------------------------------------
// Author : Miyutin & Petrovsky 
// File   : toptop_tb.v
// Create : 2018-12-21 14:59:11
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------



/** The rom testbenablech */
module toptop_tb;

parameter tck = 10; ///< clock tick

reg clock,enable, reset,ready_in,mod_switch; 
wire signed [15:0] i_OFDM, q_OFDM;
wire sop;
wire signed [15:0] out_q, out_i;
wire signed [15:0] s1,s2;
   wire ready_in2, ready_in3,ready_in4, valid_rom, valid_qam;
   wire [1:0]	Bit_wire;
   
   reg i_pilot;
  integer outfile, outfile1;
/** The LFSR DUT instance */
toptop top_inst(clock, enable, reset,ready_in,mod_switch,i_OFDM, q_OFDM,sop,out_q, out_i);
 

initial 
begin
	outfile =$fopen("OFDM_Symbol.txt");
	outfile1 =$fopen("data_Symbol.txt");

	

	$dumpfile("toptop.vcd");
	$dumpvars(0, toptop_tb);
	$monitor("%b", clock, enable, reset,ready_in,mod_switch,i_OFDM, q_OFDM,sop,out_q, out_i);
end

// testbenablech actions
initial
begin
	clock = 0;enable =0; reset = 0; ready_in = 0; mod_switch = 1;
	#50 enable =1;
	#10 reset =1;
	#10 reset =0;
	#100 ready_in = 1;
	

	

end 

initial 
begin
	#22000$fclose(outfile);
	$fclose(outfile1);
	#1 $finish;	
end

always #(tck/2) clock <= ~clock; // clocking device

integer i = 0;

initial
begin
#2;
 while(i < 2000) begin
 	$fdisplay(outfile, "%d", i_OFDM,"\t", q_OFDM,"\t", sop);
 	$fdisplay(outfile1, "%d", out_i,"\t", out_q,"\t");
 	#10;
 	i = i + 1;
 end
  
end
endmodule

module fft_4_tb;
`include 'fft_4.v' 

parameter tck = 10; 

reg  clk, en, rst;
reg signed [2:0] i_re0, i_re1, i_re2, i_re3,i_im0, i_im1, i_im2, i_im3;
wire signed [4:0] o_re0, o_re1, o_re2, o_re3,o_im0, o_im1, o_im2, o_im3;

fft_4 top_inst(clk, en, rst,i_re0, i_re1, i_re2, i_re3,i_im0, i_im1, i_im2, i_im3,o_re0, o_re1, o_re2, o_re3,o_im0, o_im1, o_im2, o_im3);
 

initial 
begin
	$dumpfile("fft_4.vcd");
	$dumpvars(0, fft_4_tb);
	$monitor("%b",clk, en, rst,"%d",i_re0, i_re1, i_re2, i_re3,i_im0, i_im1, i_im2, i_im3,o_re0, o_re1, o_re2, o_re3,o_im0, o_im1, o_im2, o_im3);
end

initial
begin
	clk = 0;
	en = 1;
	rst = 0;
	i_re0 = 0;
	i_re1 = 0;
	i_re2 = 0;
	i_re3 = 0;
	i_im0 = 0;
	i_im1 = 0;
	i_im2 = 0;
	i_im3 = 0;
	#100 i_re0 = 3'd3;
	i_re1 = 3'd2;
	i_re2 = 3'd0;
	i_re3 = 3'd3;
	#10 i_re0 = 3'b110;
	i_re1 = 3'd2;
	i_re2 = 3'd1;
	i_re3 = 3'd3;
	#10 i_re0 = 3'd1;
	i_re1 = 3'd0;
	i_re2 = 3'b111;
	i_re3 = 3'd0;
	#10 i_re0 = 3'd0;
	i_re1 = 3'd0;
	i_re2 = 3'd0;
	i_re3 = 3'd0;
	#2000 $finish;	
end

always #(tck/2) clk <= ~clk; // clocking device

endmodule

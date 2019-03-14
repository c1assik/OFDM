module fft_4
(
	input clk, en, rst,
	input signed [2:0]  i_re0, i_re1, i_re2, i_re3,i_im0, i_im1, i_im2, i_im3,

	output reg signed [4:0] o_re0, o_re1, o_re2, o_re3,o_im0, o_im1, o_im2, o_im3
);

reg signed [3:0] sum_im1, sum_im2, diff_im1, diff_im2, sum_re1, sum_re2, diff_re1, diff_re2;

initial
begin
	o_re0 = 0;
	o_re1 = 0;
	o_re2 = 0;
	o_re3 = 0;
	o_im0 = 0;
	o_im1 = 0;
	o_im2 = 0;
	o_im3 = 0;
	sum_im1 = 0;
	sum_im2 = 0;
	diff_im1 = 0;
	diff_im2 = 0;
	sum_re1 = 0;
	sum_re2 = 0;
	diff_re1 = 0;
	diff_re2 = 0;
end

always @(posedge clk or posedge rst) begin
	if (rst) 
	begin
		o_re0 = 0;
		o_re1 = 0;
		o_re2 = 0;
		o_re3 = 0;
		o_im0 = 0;
		o_im1 = 0;
		o_im2 = 0;
		o_im3 = 0;
		sum_im1 = 0;
		sum_im2 = 0;
		diff_im1 = 0;
		diff_im2 = 0;
		sum_re1 = 0;
		sum_re2 = 0;
		diff_re1 = 0;
		diff_re2 = 0;
	end
	else if (en) 
	begin
		o_re0 = sum_re1 + sum_re2;
		o_re1 = diff_re1 + diff_im2;
		o_re2 = sum_re1 - sum_re2;
		o_re3 = diff_re1 - diff_im2;

		o_im0 = sum_im1 + sum_im2;
		o_im1 = diff_im1 - diff_re2;
		o_im2 = sum_im1 - sum_im2;
		o_im3 = diff_im1 + diff_re2;

		sum_im1 = i_im0 + i_im2;
		sum_im2 = i_im1 + i_im3;
		diff_im1 = i_im0 - i_im2;
		diff_im2 = i_im1 - i_im3;
		sum_re1 = i_re0 + i_re2;
		sum_re2 = i_re1 + i_re3;
		diff_re1 = i_re0 - i_re2;
		diff_re2 = i_re1 - i_re3;
	end
end

endmodule
    
// -----------------------------------------------------------------------------
// Copyright (c) 2018 All rights reserved
// -----------------------------------------------------------------------------
// Author : Miyutin & Petrovsky 
// File   : qam.v
// Create : 2018-12-21 15:51:45
// Editor : sublime text3, tab size (4)
// -----------------------------------------------------------------------------
    

module qam(

	input clk, res, en, ready_in,
	input valid_rom,
	input [3:0] idata,
	output reg ready_out, 
	output reg valid_qam,
	output reg signed [15:0] i,q
	);

	

	reg [14:0] grid;
	reg [14:0] grid_value1;
	reg [14:0] grid_value2;
	reg error;

	initial
	 begin
	 error = 0;
	 i = 0;
	 q = 0;
	grid = 0;
	grid = ~grid;
	grid = grid >> 2;
	grid_value1 = grid;
	grid_value2 = grid_value1 + (grid << 1);
	end
	
 always@(posedge clk or posedge res)
  begin
  if(res) begin
  	valid_qam<=0;
  	i<=0;
  	q<=0;
  end
  else if(en && ready_in && valid_rom) begin
     //I <= {idata[3],(idata[1] ? grid_value1 : grid_value2)};
	// Q <= {idata[2],(idata[0] ? grid_value1 : grid_value2)};  
		valid_qam <=1'b1;
  		i <= idata[3] ? {idata[3], (~(idata[1] ? grid_value1 : grid_value2) + 1'b1)} : {idata[3], (idata[1] ? grid_value1 : grid_value2)};
  		q <= idata[2] ? {idata[2], (~(idata[0] ? grid_value1 : grid_value2) + 1'b1)} : {idata[2], (idata[0] ? grid_value1 : grid_value2)};
  end
  else valid_qam <=1'b0;
  end

  always @(posedge clk or posedge res) begin
  	if (res) begin
  		error <= 0;
  		ready_out <= 0;
  	end
  	else begin
  		ready_out <= (error) ? 0 : 1;
  	end
  end
	
 endmodule  
`timescale 1 ns/1 ps
/**********************************************************
*	Name:  				DPSRAM_fpga
*
*	Author: 			Hanssel Norato-Sep 17, 2019.
*
*	Modified by: 	Hanssel Norato-May 20, 2020.											
*																													
* Abstract:			True dual port memory model for fpga
*								synthesis inference
***********************************************************/

module	DPSRAM_fpga #(parameter nbits=32,
	parameter length=2048*4,parameter memory = "boot.mem")
(
	//PORT A
	input [$clog2(length/4)-1:0] addr_A,
	output[nbits-1:0] out_data_A,
	input [nbits-1:0] data_A,
	input [3:0]WE_A ,

  //PORT B
	input [$clog2(length/4)-1:0] addr_B,
	output[nbits-1:0] out_data_B,
	input [nbits-1:0] data_B,
	input [3:0]WE_B,
	
	//clock
	input clock
);
	reg [nbits-1:0] mem [0:length/4 - 1];
	reg [nbits-1:0] out_data_A_R = 0;
	reg [nbits-1:0] out_data_B_R = 0;
    initial begin
            $readmemh(memory,mem);
    end
	genvar i;
	generate
		for(i=0;i<=3;i=i+1)begin : genmem
			
			always @(posedge clock)
				  if (WE_A[i])
				    mem[addr_A][7+8*i:8*i] <= data_A[7+8*i:8*i];

			always @(posedge clock)
				  if (WE_B[i])
				    mem[addr_B][7+8*i:8*i] <= data_B[7+8*i:8*i];
		end
	endgenerate
				  	
 always @(posedge clock)begin
				    out_data_B_R <= mem[addr_B];
				    out_data_A_R <= mem[addr_A];
  end     
  // The following is a 1 clock cycle read latency at the cost of a longer clock-to-out timing
   assign out_data_A = out_data_A_R;
   assign out_data_B = out_data_B_R;

endmodule						

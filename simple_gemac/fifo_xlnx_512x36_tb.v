`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:15:57 02/18/2011
// Design Name:   fifo_xlnx_512x36_2clk
// Module Name:   C:/Users/Administrator/Desktop/Xilinx/atlys_ethernet_test/simple_gemac/fifo_xlnx_512x36_tb.v
// Project Name:  atlys_ethernet_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: fifo_xlnx_512x36_2clk
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module fifo_xlnx_512x36_tb;

	// Inputs
	reg rst;
	reg wr_clk;
	reg rd_clk;
	reg [35:0] din;
	reg wr_en;
	reg rd_en;

	// Outputs
	wire [35:0] dout;
	wire full;
	wire empty;
	wire [9:0] rd_data_count;
	wire [9:0] wr_data_count;

	// Instantiate the Unit Under Test (UUT)
	fifo_xlnx_512x36_2clk uut (
		.rst(rst), 
		.wr_clk(wr_clk), 
		.rd_clk(rd_clk), 
		.din(din), 
		.wr_en(wr_en), 
		.rd_en(rd_en), 
		.dout(dout), 
		.full(full), 
		.empty(empty), 
		.rd_data_count(rd_data_count), 
		.wr_data_count(wr_data_count)
	);

	initial begin
		// Initialize Inputs
		rst = 1;
		wr_clk = 0;
		rd_clk = 0;
		din = 0;
		wr_en = 0;
		rd_en = 0;

		// Wait 100 ns for global reset to finish
		#100;
      rst = 0;
		
		#100;
		// Add stimulus here
		wr_en = 1;
		din = 123;
		
		#200;
		wr_en = 0;
		din = 0;
		
		#200;
		rd_en = 1;
	end

	always begin
		#10;
		rd_clk = ~rd_clk;
	end
	
	always begin
		#20;
		wr_clk = ~wr_clk;
	end
	
endmodule


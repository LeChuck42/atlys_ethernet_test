`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   14:05:00 02/28/2011
// Design Name:   ethernet_test_top
// Module Name:   C:/Users/Administrator/Desktop/Xilinx/atlys_ethernet_test/ethernet_test_top_tb.v
// Project Name:  atlys_ethernet_test
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: ethernet_test_top
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module ethernet_test_top_tb;

	// Inputs
	reg clk_100_pin;
	reg MII_TX_CLK_pin;
	wire [7:0] GMII_RXD_pin;
	wire GMII_RX_DV_pin;
	reg GMII_RX_ER_pin;
	reg GMII_RX_CLK_pin;
	reg [7:0] sw;
	reg [5:0] btn;

	// Outputs
	wire PhyResetOut_pin;
	wire [7:0] GMII_TXD_pin;
	wire GMII_TX_EN_pin;
	wire GMII_TX_ER_pin;
	wire GMII_TX_CLK_pin;
	wire MDC_pin;
	wire [7:0] leds;

	// Bidirs
	wire MDIO_pin;
	
	//rs232
	wire rs232_tx;
	reg rs232_rx;

	// Instantiate the Unit Under Test (UUT)
	ethernet_test_top uut (
		.clk_100_pin(clk_100_pin), 
		.PhyResetOut_pin(PhyResetOut_pin), 
		.MII_TX_CLK_pin(MII_TX_CLK_pin), 
		.GMII_TXD_pin(GMII_TXD_pin), 
		.GMII_TX_EN_pin(GMII_TX_EN_pin), 
		.GMII_TX_ER_pin(GMII_TX_ER_pin), 
		.GMII_TX_CLK_pin(GMII_TX_CLK_pin), 
		.GMII_RXD_pin(GMII_RXD_pin), 
		.GMII_RX_DV_pin(GMII_RX_DV_pin), 
		.GMII_RX_ER_pin(GMII_RX_ER_pin), 
		.GMII_RX_CLK_pin(GMII_RX_CLK_pin), 
		.MDC_pin(MDC_pin), 
		.MDIO_pin(MDIO_pin), 
		.leds(leds), 
		.sw(sw),
		.btn(btn),
		.rs232_rx(rs232_rx),
		.rs232_tx(rs232_tx)
	);



   // Loopback
   assign GMII_RX_DV_pin  = GMII_TX_EN_pin;
   assign GMII_RXD_pin    = GMII_TXD_pin;
   wire GMII_RX_CLK   = GMII_TX_CLK_pin;
	
	
	initial begin
		// Initialize Inputs
		clk_100_pin = 0;
		MII_TX_CLK_pin = 0;
		GMII_RX_CLK_pin = 0;
		sw = 0;
		rs232_rx = 1;
		btn = 6'h3F;
		// Wait 100 ns for global reset to finish
		#1442;
      /*
		rs232_send(8'h52); // set rising trigger
		#234;
		rs232_send(8'h00);
		rs232_send(8'h00);
		rs232_send(8'h00);
		rs232_send(8'h00);
		rs232_send(8'h00);
		
		rs232_send(8'h00);
		rs232_send(8'h00);
		rs232_send(8'h00);
		rs232_send(8'h40);
		rs232_send(8'h00);
		
		#100;*/
		rs232_send(8'h41); // arm scope
		
		#100;
		btn = 6'h3E;
		#5000;
		btn = 6'h3F;
	end
	
	task rs232_send;
		input [7:0] data;
		reg[4:0] i;
		begin
			rs232_rx = 0;
			#1000;
			for (i=0; i<8; i=i+1) begin
				rs232_rx = data[i];
				#1000;
			end
			rs232_rx = 1;
			#1000;
		end
	endtask
      
	always begin
		#4;
		GMII_RX_CLK_pin = ~GMII_RX_CLK_pin;
	end
	
	always begin
		#5;
		clk_100_pin = ~clk_100_pin;
	end
endmodule


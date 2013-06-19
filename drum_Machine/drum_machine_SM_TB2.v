`timescale 1ns / 1ps

////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer:
//
// Create Date:   17:10:23 04/18/2013
// Design Name:   drum_machine_SM
// Module Name:   C:/Users/user/Dropbox/School/EE-201L intro to digital circuits/Drum_Machine/drum_Machine/drum_machine_SM_TB2.v
// Project Name:  drum_Machine
// Target Device:  
// Tool versions:  
// Description: 
//
// Verilog Test Fixture created by ISE for module: drum_machine_SM
//
// Dependencies:
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
////////////////////////////////////////////////////////////////////////////////

module drum_machine_SM_TB2;

	// Inputs
	reg Clk;
	reg Reset;
	reg Start;
	reg Stop;
	reg Ain;
	reg Bin;
	reg Cin;
	reg Din;
	reg Ein;
	reg Fourths;
	reg Eighths;

	// Outputs
	wire playing;
	wire Aout;
	wire Bout;
	wire Cout;
	wire Dout;
	wire Eout;
	wire [15:0] A;
	wire [15:0] B;
	wire [15:0] C;
	wire [15:0] D;
	wire [15:0] E;
	wire [16:0] state;

	// Instantiate the Unit Under Test (UUT)
	drum_machine_SM uut (
		.Clk(Clk), 
		.Reset(Reset), 
		.Start(Start), 
		.Stop(Stop), 
		.Ain(Ain), 
		.Bin(Bin), 
		.Cin(Cin), 
		.Din(Din), 
		.Ein(Ein), 
		.playing(playing), 
		.Aout(Aout), 
		.Bout(Bout), 
		.Cout(Cout), 
		.Dout(Dout), 
		.Eout(Eout), 
		.A(A), 
		.B(B), 
		.C(C), 
		.D(D), 
		.E(E), 
		.state(state), 
		.Fourths(Fourths), 
		.Eighths(Eighths)
	);

localparam CLK_PERIOD = 20;
integer ii, jj;

initial
  begin  : CLK_GENERATOR
    Clk = 0;
    forever
       begin
	      #(CLK_PERIOD/2) Clk = ~Clk;
       end 
  end
  
	initial begin
		// Initialize Inputs
		Clk = 0;
		Reset = 0;
		Start = 0;
		Stop = 0;
		Ain = 0;
		Bin = 0;
		Cin = 0;
		Din = 0;
		Ein = 0;
		Fourths = 0;
		Eighths = 0;

		// Wait 100 ns for global reset to finish
		#100;
        
		// Add stimulus here
		@(posedge Clk);
		#2
		Reset = 1;
		@(posedge Clk);
		#2
		Reset = 0;
		@(posedge Clk);
		#2
		Start = 1;
		@(posedge Clk);
		#2
		Start = 0;
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		@(posedge Clk);
		#2
		Ain = 1;
		@(posedge Clk);
		#2
		Ain = 0;
		
		
   	
		
		for(ii = 0; ii <= 5; ii = ii+1)
		  for(jj=0; jj<=15; jj = jj+1)
      		@(posedge Clk);
		#2
		Eighths = 1;
		
		for(ii = 0; ii <= 2; ii = ii+1)
		  for(jj=0; jj<=15; jj = jj+1)
      		@(posedge Clk);
		#2
		Eighths = 0;
		
		for(ii = 0; ii <= 2; ii = ii+1)
		  for(jj=0; jj<=15; jj = jj+1)
      		@(posedge Clk);

		#2
		Fourths = 1;
		
		for(ii = 0; ii <= 2; ii = ii+1)
		  for(jj=0; jj<=15; jj = jj+1)
      		@(posedge Clk);
		#2
		Fourths = 0;				
		@(posedge Clk);
		#2
		Stop = 1;
		
		@(posedge Clk);
		#2
		Stop = 0;

	end
      
endmodule


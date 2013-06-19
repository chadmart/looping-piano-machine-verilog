`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// VGA verilog template
// Author:  Da Cheng
//////////////////////////////////////////////////////////////////////////////////
module vga_demo(ClkPort, reset, vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b, 	//Sw0, Sw1, btnU, btnD, Sw7, Sw6,
	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar,
	Ain, Bin, Cin, Din, Ein, State, DIV_CLK_1
	//An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	//LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7
	);
	
	input ClkPort, reset, Ain, Bin, Cin, Din, Ein, State, DIV_CLK_1; //Sw0, btnU, btnD, Sw0, Sw1, Sw7, Sw6;
	
	output St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b;
	
	//output An0, An1, An2, An3, Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp;
	//output LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	
	reg vga_r, vga_g, vga_b;
	
	//////////////////////////////////////////////////////////////////////////////////////////
	
	/*  LOCAL SIGNALS */
	wire	reset, start, ClkPort, board_clk, clk;//, button_clk;
	wire [15:0] Ain;
	wire [15:0] Bin;
	wire [15:0] Cin;
	wire [15:0] Din;
	wire [15:0] Ein;
	wire [16:0] State;
	wire q_Play15, q_Play14, q_Play13, q_Play12, q_Play11, q_Play10, q_Play9, q_Play8, q_Play7, q_Play6, q_Play5, q_Play4, q_Play3, q_Play2, q_Play1, q_Play0, q_I;
	assign {q_Play15, q_Play14, q_Play13, q_Play12, q_Play11, q_Play10, q_Play9, q_Play8, q_Play7, q_Play6, q_Play5, q_Play4, q_Play3, q_Play2, q_Play1, q_Play0, q_I} = State;
			
	//BUF BUF1 (board_clk, ClkPort); 	
	//BUF BUF2 (reset, Sw0);
	//BUF BUF3 (start, Sw1);
	
	/*reg [27:0]	DIV_CLK;
	always @ (posedge board_clk, posedge reset)  
	begin : CLOCK_DIVIDER
      if (reset)
			DIV_CLK <= 0;
      else
			DIV_CLK <= DIV_CLK + 1'b1;
	end	

	assign	button_clk = DIV_CLK[18];*/
	assign	clk = DIV_CLK_1;
	
	assign 	{St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar} = {5'b11111};
	
	//wire q_Play0, Ain;
	//assign q_Play0= Sw7;
	//ssign Ain = Sw6;
	
	wire inDisplayArea;
	wire [9:0] CounterX;
	wire [9:0] CounterY;

	hvsync_generator syncgen(.clk(clk), .reset(reset),.vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .inDisplayArea(inDisplayArea), .CounterX(CounterX), .CounterY(CounterY));
	
	/////////////////////////////////////////////////////////////////
	///////////////		VGA control starts here		/////////////////
	/////////////////////////////////////////////////////////////////
	/*reg [9:0] position;
	
	always @(posedge DIV_CLK[21])
		begin
			if(reset)
				position<=240;
			else if(btnD && ~btnU)
				position<=position+2;
			else if(btnU && ~btnD)
				position<=position-2;	
		end*/
		
	reg [9:0] temp_r;
	reg [9:0] temp_b;
	reg [9:0] temp_g;
	reg [9:0] temp_y;
	
	always @(*)
	begin
		temp_y <= 
		//first line
		(q_Play0 && !Ain[0] && CounterX>20 && CounterX<50 && CounterY>20 && CounterY<50) || 
		(q_Play1 && !Ain[1] && CounterX>57 && CounterX<87 && CounterY>20 && CounterY<50) || 
		(q_Play2 && !Ain[2] && CounterX>94 && CounterX<124 && CounterY>20 && CounterY<50)||
		(q_Play3 && !Ain[3] && CounterX>131 && CounterX<161 && CounterY>20 && CounterY<50)||
		(q_Play4 && !Ain[4] && CounterX>168 && CounterX<198 && CounterY>20 && CounterY<50)||
		(q_Play5 && !Ain[5] && CounterX>205 && CounterX<235 && CounterY>20 && CounterY<50)||
		(q_Play6 && !Ain[6] && CounterX>242 && CounterX<272 && CounterY>20 && CounterY<50)||
		(q_Play7 && !Ain[7] && CounterX>279 && CounterX<309 && CounterY>20 && CounterY<50)||
		(q_Play8 && !Ain[8] && CounterX>316 && CounterX<346 && CounterY>20 && CounterY<50)||
		(q_Play9 && !Ain[9] && CounterX>353 && CounterX<383 && CounterY>20 && CounterY<50)||
		(q_Play10 && !Ain[10] && CounterX>390 && CounterX<420 && CounterY>20 && CounterY<50)||
		(q_Play11 && !Ain[11] && CounterX>427 && CounterX<457 && CounterY>20 && CounterY<50)||
		(q_Play12 && !Ain[12] && CounterX>464 && CounterX<494 && CounterY>20 && CounterY<50)||
		(q_Play13 && !Ain[13] && CounterX>501 && CounterX<531 && CounterY>20 && CounterY<50)||		
		(q_Play14 && !Ain[14] && CounterX>538 && CounterX<568 && CounterY>20 && CounterY<50)||
		(q_Play15 && !Ain[15] && CounterX>575 && CounterX<605 && CounterY>20 && CounterY<50) ||
		
		// second line
		(q_Play0 && !Bin[0] && CounterX>20 && CounterX<50 && CounterY>57 && CounterY<87) || 
		(q_Play1 && !Bin[1] && CounterX>57 && CounterX<87 && CounterY>57 && CounterY<87) || 
		(q_Play2 && !Bin[2] && CounterX>94 && CounterX<124 && CounterY>57 && CounterY<87)||
		(q_Play3 && !Bin[3] && CounterX>131 && CounterX<161 && CounterY>57 && CounterY<87)||
		(q_Play4 && !Bin[4] && CounterX>168 && CounterX<198 && CounterY>57 && CounterY<87)||
		(q_Play5 && !Bin[5] && CounterX>205 && CounterX<235 && CounterY>57 && CounterY<87)||
		(q_Play6 && !Bin[6] && CounterX>242 && CounterX<272 && CounterY>57 && CounterY<87)||
		(q_Play7 && !Bin[7] && CounterX>279 && CounterX<309 && CounterY>57 && CounterY<87)||
		(q_Play8 && !Bin[8] && CounterX>316 && CounterX<346 && CounterY>57 && CounterY<87)||
		(q_Play9 && !Bin[9] && CounterX>353 && CounterX<383 && CounterY>57 && CounterY<87)||
		(q_Play10 && !Bin[10] && CounterX>390 && CounterX<420 && CounterY>57 && CounterY<87)||
		(q_Play11 && !Bin[11] && CounterX>427 && CounterX<457 && CounterY>57 && CounterY<87)||
		(q_Play12 && !Bin[12] && CounterX>464 && CounterX<494 && CounterY>57 && CounterY<87)||
		(q_Play13 && !Bin[13] && CounterX>501 && CounterX<531 && CounterY>57 && CounterY<87)||		
		(q_Play14 && !Bin[14] && CounterX>538 && CounterX<568 && CounterY>57 && CounterY<87)||
		(q_Play15 && !Bin[15] && CounterX>575 && CounterX<605 && CounterY>57 && CounterY<87) ||
				
		//third line
		(q_Play0 && !Cin[0] && CounterX>20 && CounterX<50 && CounterY>94 && CounterY<124) || 
		(q_Play1 && !Cin[1] && CounterX>57 && CounterX<87 && CounterY>94 && CounterY<124) || 
		(q_Play2 && !Cin[2] && CounterX>94 && CounterX<124 && CounterY>94 && CounterY<124)||
		(q_Play3 && !Cin[3] && CounterX>131 && CounterX<161 && CounterY>94 && CounterY<124)||
		(q_Play4 && !Cin[4] && CounterX>168 && CounterX<198 && CounterY>94 && CounterY<124)||
		(q_Play5 && !Cin[5] && CounterX>205 && CounterX<235 && CounterY>94 && CounterY<124)||
		(q_Play6 && !Cin[6] && CounterX>242 && CounterX<272 && CounterY>94 && CounterY<124)||
		(q_Play7 && !Cin[7] && CounterX>279 && CounterX<309 && CounterY>94 && CounterY<124)||
		(q_Play8 && !Cin[8] && CounterX>316 && CounterX<346 && CounterY>94 && CounterY<124)||
		(q_Play9 && !Cin[9] && CounterX>353 && CounterX<383 && CounterY>94 && CounterY<124)||
		(q_Play10 && !Cin[10] && CounterX>390 && CounterX<420 && CounterY>94 && CounterY<124)||
		(q_Play11 && !Cin[11] && CounterX>427 && CounterX<457 && CounterY>94 && CounterY<124)||
		(q_Play12 && !Cin[12] && CounterX>464 && CounterX<494 && CounterY>94 && CounterY<124)||
		(q_Play13 && !Cin[13] && CounterX>501 && CounterX<531 && CounterY>94 && CounterY<124)||		
		(q_Play14 && !Cin[14] && CounterX>538 && CounterX<568 && CounterY>94 && CounterY<124)||
		(q_Play15 && !Cin[15] && CounterX>575 && CounterX<605 && CounterY>94 && CounterY<124)||

		//fourth line
		(q_Play0 && !Din[0] && CounterX>20 && CounterX<50 && CounterY>131 && CounterY<161) || 
		(q_Play1 && !Din[1] && CounterX>57 && CounterX<87 && CounterY>131 && CounterY<161) || 
		(q_Play2 && !Din[2] && CounterX>94 && CounterX<124 && CounterY>131 && CounterY<161)||
		(q_Play3 && !Din[3] && CounterX>131 && CounterX<161 && CounterY>131 && CounterY<161)||
		(q_Play4 && !Din[4] && CounterX>168 && CounterX<198 && CounterY>131 && CounterY<161)||
		(q_Play5 && !Din[5] && CounterX>205 && CounterX<235 && CounterY>131 && CounterY<161)||
		(q_Play6 && !Din[6] && CounterX>242 && CounterX<272 && CounterY>131 && CounterY<161)||
		(q_Play7 && !Din[7] && CounterX>279 && CounterX<309 && CounterY>131 && CounterY<161)||
		(q_Play8 && !Din[8] && CounterX>316 && CounterX<346 && CounterY>131 && CounterY<161)||
		(q_Play9 && !Din[9] && CounterX>353 && CounterX<383 && CounterY>131 && CounterY<161)||
		(q_Play10 && !Din[10] && CounterX>390 && CounterX<420 && CounterY>131 && CounterY<161)||
		(q_Play11 && !Din[11] && CounterX>427 && CounterX<457 && CounterY>131 && CounterY<161)||
		(q_Play12 && !Din[12] && CounterX>464 && CounterX<494 && CounterY>131 && CounterY<161)||
		(q_Play13 && !Din[13] && CounterX>501 && CounterX<531 && CounterY>131 && CounterY<161)||		
		(q_Play14 && !Din[14] && CounterX>538 && CounterX<568 && CounterY>131 && CounterY<161)||
		(q_Play15 && !Din[15] && CounterX>575 && CounterX<605 && CounterY>131 && CounterY<161) ||
		
		//fifth line
		(q_Play0 && !Ein[0] && CounterX>20 && CounterX<50 && CounterY>168 && CounterY<198) || 
		(q_Play1 && !Ein[1] && CounterX>57 && CounterX<87 && CounterY>168 && CounterY<198) || 
		(q_Play2 && !Ein[2] && CounterX>94 && CounterX<124 && CounterY>168 && CounterY<198)||
		(q_Play3 && !Ein[3] && CounterX>131 && CounterX<161 && CounterY>168 && CounterY<198)||
		(q_Play4 && !Ein[4] && CounterX>168 && CounterX<198 && CounterY>168 && CounterY<198)||
		(q_Play5 && !Ein[5] && CounterX>205 && CounterX<235 && CounterY>168 && CounterY<198)||
		(q_Play6 && !Ein[6] && CounterX>242 && CounterX<272 && CounterY>168 && CounterY<198)||
		(q_Play7 && !Ein[7] && CounterX>279 && CounterX<309 && CounterY>168 && CounterY<198)||
		(q_Play8 && !Ein[8] && CounterX>316 && CounterX<346 && CounterY>168 && CounterY<198)||
		(q_Play9 && !Ein[9] && CounterX>353 && CounterX<383 && CounterY>168 && CounterY<198)||
		(q_Play10 && !Ein[10] && CounterX>390 && CounterX<420 && CounterY>168 && CounterY<198)||
		(q_Play11 && !Ein[11] && CounterX>427 && CounterX<457 && CounterY>168 && CounterY<198)||
		(q_Play12 && !Ein[12] && CounterX>464 && CounterX<494 && CounterY>168 && CounterY<198)||
		(q_Play13 && !Ein[13] && CounterX>501 && CounterX<531 && CounterY>168 && CounterY<198)||		
		(q_Play14 && !Ein[14] && CounterX>538 && CounterX<568 && CounterY>168 && CounterY<198)||
		(q_Play15 && !Ein[15] && CounterX>575 && CounterX<605 && CounterY>168 && CounterY<198);

		
		temp_b <= 
		//first line		
		(!q_Play0 && Ain[0] && CounterX>20 && CounterX<50 && CounterY>20 && CounterY<50) || 
		(!q_Play1 && Ain[1] && CounterX>57 && CounterX<87 && CounterY>20 && CounterY<50) || 
		(!q_Play2 && Ain[2] && CounterX>94 && CounterX<124 && CounterY>20 && CounterY<50)||
		(!q_Play3 && Ain[3] && CounterX>131 && CounterX<161 && CounterY>20 && CounterY<50)||
		(!q_Play4 && Ain[4] && CounterX>168 && CounterX<198 && CounterY>20 && CounterY<50)||
		(!q_Play5 && Ain[5] && CounterX>205 && CounterX<235 && CounterY>20 && CounterY<50)||
		(!q_Play6 && Ain[6] && CounterX>242 && CounterX<272 && CounterY>20 && CounterY<50)||
		(!q_Play7 && Ain[7] && CounterX>279 && CounterX<309 && CounterY>20 && CounterY<50)||
		(!q_Play8 && Ain[8] && CounterX>316 && CounterX<346 && CounterY>20 && CounterY<50)||
		(!q_Play9 && Ain[9] && CounterX>353 && CounterX<383 && CounterY>20 && CounterY<50)||
		(!q_Play10 && Ain[10] && CounterX>390 && CounterX<420 && CounterY>20 && CounterY<50)||
		(!q_Play11 && Ain[11] && CounterX>427 && CounterX<457 && CounterY>20 && CounterY<50)||
		(!q_Play12 && Ain[12] && CounterX>464 && CounterX<494 && CounterY>20 && CounterY<50)||
		(!q_Play13 && Ain[13] && CounterX>501 && CounterX<531 && CounterY>20 && CounterY<50)||		
		(!q_Play14 && Ain[14] && CounterX>538 && CounterX<568 && CounterY>20 && CounterY<50)||
		(!q_Play15 && Ain[15] && CounterX>575 && CounterX<605 && CounterY>20 && CounterY<50) ||
		
		// second line
		(!q_Play0 && Bin[0] && CounterX>20 && CounterX<50 && CounterY>57 && CounterY<87) || 
		(!q_Play1 && Bin[1] && CounterX>57 && CounterX<87 && CounterY>57 && CounterY<87) || 
		(!q_Play2 && Bin[2] && CounterX>94 && CounterX<124 && CounterY>57 && CounterY<87)||
		(!q_Play3 && Bin[3] && CounterX>131 && CounterX<161 && CounterY>57 && CounterY<87)||
		(!q_Play4 && Bin[4] && CounterX>168 && CounterX<198 && CounterY>57 && CounterY<87)||
		(!q_Play5 && Bin[5] && CounterX>205 && CounterX<235 && CounterY>57 && CounterY<87)||
		(!q_Play6 && Bin[6] && CounterX>242 && CounterX<272 && CounterY>57 && CounterY<87)||
		(!q_Play7 && Bin[7] && CounterX>279 && CounterX<309 && CounterY>57 && CounterY<87)||
		(!q_Play8 && Bin[8] && CounterX>316 && CounterX<346 && CounterY>57 && CounterY<87)||
		(!q_Play9 && Bin[9] && CounterX>353 && CounterX<383 && CounterY>57 && CounterY<87)||
		(!q_Play10 && Bin[10] && CounterX>390 && CounterX<420 && CounterY>57 && CounterY<87)||
		(!q_Play11 && Bin[11] && CounterX>427 && CounterX<457 && CounterY>57 && CounterY<87)||
		(!q_Play12 && Bin[12] && CounterX>464 && CounterX<494 && CounterY>57 && CounterY<87)||
		(!q_Play13 && Bin[13] && CounterX>501 && CounterX<531 && CounterY>57 && CounterY<87)||		
		(!q_Play14 && Bin[14] && CounterX>538 && CounterX<568 && CounterY>57 && CounterY<87)||
		(!q_Play15 && Bin[15] && CounterX>575 && CounterX<605 && CounterY>57 && CounterY<87) ||
				
		//third line
		(!q_Play0 && Cin[0] && CounterX>20 && CounterX<50 && CounterY>94 && CounterY<124) || 
		(!q_Play1 && Cin[1] && CounterX>57 && CounterX<87 && CounterY>94 && CounterY<124) || 
		(!q_Play2 && Cin[2] && CounterX>94 && CounterX<124 && CounterY>94 && CounterY<124)||
		(!q_Play3 && Cin[3] && CounterX>131 && CounterX<161 && CounterY>94 && CounterY<124)||
		(!q_Play4 && Cin[4] && CounterX>168 && CounterX<198 && CounterY>94 && CounterY<124)||
		(!q_Play5 && Cin[5] && CounterX>205 && CounterX<235 && CounterY>94 && CounterY<124)||
		(!q_Play6 && Cin[6] && CounterX>242 && CounterX<272 && CounterY>94 && CounterY<124)||
		(!q_Play7 && Cin[7] && CounterX>279 && CounterX<309 && CounterY>94 && CounterY<124)||
		(!q_Play8 && Cin[8] && CounterX>316 && CounterX<346 && CounterY>94 && CounterY<124)||
		(!q_Play9 && Cin[9] && CounterX>353 && CounterX<383 && CounterY>94 && CounterY<124)||
		(!q_Play10 && Cin[10] && CounterX>390 && CounterX<420 && CounterY>94 && CounterY<124)||
		(!q_Play11 && Cin[11] && CounterX>427 && CounterX<457 && CounterY>94 && CounterY<124)||
		(!q_Play12 && Cin[12] && CounterX>464 && CounterX<494 && CounterY>94 && CounterY<124)||
		(!q_Play13 && Cin[13] && CounterX>501 && CounterX<531 && CounterY>94 && CounterY<124)||		
		(!q_Play14 && Cin[14] && CounterX>538 && CounterX<568 && CounterY>94 && CounterY<124)||
		(!q_Play15 && Cin[15] && CounterX>575 && CounterX<605 && CounterY>94 && CounterY<124)||

		//fourth line
		(!q_Play0 && Din[0] && CounterX>20 && CounterX<50 && CounterY>131 && CounterY<161) || 
		(!q_Play1 && Din[1] && CounterX>57 && CounterX<87 && CounterY>131 && CounterY<161) || 
		(!q_Play2 && Din[2] && CounterX>94 && CounterX<124 && CounterY>131 && CounterY<161)||
		(!q_Play3 && Din[3] && CounterX>131 && CounterX<161 && CounterY>131 && CounterY<161)||
		(!q_Play4 && Din[4] && CounterX>168 && CounterX<198 && CounterY>131 && CounterY<161)||
		(!q_Play5 && Din[5] && CounterX>205 && CounterX<235 && CounterY>131 && CounterY<161)||
		(!q_Play6 && Din[6] && CounterX>242 && CounterX<272 && CounterY>131 && CounterY<161)||
		(!q_Play7 && Din[7] && CounterX>279 && CounterX<309 && CounterY>131 && CounterY<161)||
		(!q_Play8 && Din[8] && CounterX>316 && CounterX<346 && CounterY>131 && CounterY<161)||
		(!q_Play9 && Din[9] && CounterX>353 && CounterX<383 && CounterY>131 && CounterY<161)||
		(!q_Play10 && Din[10] && CounterX>390 && CounterX<420 && CounterY>131 && CounterY<161)||
		(!q_Play11 && Din[11] && CounterX>427 && CounterX<457 && CounterY>131 && CounterY<161)||
		(!q_Play12 && Din[12] && CounterX>464 && CounterX<494 && CounterY>131 && CounterY<161)||
		(!q_Play13 && Din[13] && CounterX>501 && CounterX<531 && CounterY>131 && CounterY<161)||		
		(!q_Play14 && Din[14] && CounterX>538 && CounterX<568 && CounterY>131 && CounterY<161)||
		(!q_Play15 && Din[15] && CounterX>575 && CounterX<605 && CounterY>131 && CounterY<161) ||
		
		//fifth line
		(!q_Play0 && Ein[0] && CounterX>20 && CounterX<50 && CounterY>168 && CounterY<198) || 
		(!q_Play1 && Ein[1] && CounterX>57 && CounterX<87 && CounterY>168 && CounterY<198) || 
		(!q_Play2 && Ein[2] && CounterX>94 && CounterX<124 && CounterY>168 && CounterY<198)||
		(!q_Play3 && Ein[3] && CounterX>131 && CounterX<161 && CounterY>168 && CounterY<198)||
		(!q_Play4 && Ein[4] && CounterX>168 && CounterX<198 && CounterY>168 && CounterY<198)||
		(!q_Play5 && Ein[5] && CounterX>205 && CounterX<235 && CounterY>168 && CounterY<198)||
		(!q_Play6 && Ein[6] && CounterX>242 && CounterX<272 && CounterY>168 && CounterY<198)||
		(!q_Play7 && Ein[7] && CounterX>279 && CounterX<309 && CounterY>168 && CounterY<198)||
		(!q_Play8 && Ein[8] && CounterX>316 && CounterX<346 && CounterY>168 && CounterY<198)||
		(!q_Play9 && Ein[9] && CounterX>353 && CounterX<383 && CounterY>168 && CounterY<198)||
		(!q_Play10 && Ein[10] && CounterX>390 && CounterX<420 && CounterY>168 && CounterY<198)||
		(!q_Play11 && Ein[11] && CounterX>427 && CounterX<457 && CounterY>168 && CounterY<198)||
		(!q_Play12 && Ein[12] && CounterX>464 && CounterX<494 && CounterY>168 && CounterY<198)||
		(!q_Play13 && Ein[13] && CounterX>501 && CounterX<531 && CounterY>168 && CounterY<198)||		
		(!q_Play14 && Ein[14] && CounterX>538 && CounterX<568 && CounterY>168 && CounterY<198)||
		(!q_Play15 && Ein[15] && CounterX>575 && CounterX<605 && CounterY>168 && CounterY<198);
		
		
		
		temp_g <= 
		//first line
		(!q_Play0 && !Ain[0] && CounterX>20 && CounterX<50 && CounterY>20 && CounterY<50) || 
		(!q_Play1 && !Ain[1] && CounterX>57 && CounterX<87 && CounterY>20 && CounterY<50) || 
		(!q_Play2 && !Ain[2] && CounterX>94 && CounterX<124 && CounterY>20 && CounterY<50)||
		(!q_Play3 && !Ain[3] && CounterX>131 && CounterX<161 && CounterY>20 && CounterY<50)||
		(!q_Play4 && !Ain[4] && CounterX>168 && CounterX<198 && CounterY>20 && CounterY<50)||
		(!q_Play5 && !Ain[5] && CounterX>205 && CounterX<235 && CounterY>20 && CounterY<50)||
		(!q_Play6 && !Ain[6] && CounterX>242 && CounterX<272 && CounterY>20 && CounterY<50)||
		(!q_Play7 && !Ain[7] && CounterX>279 && CounterX<309 && CounterY>20 && CounterY<50)||
		(!q_Play8 && !Ain[8] && CounterX>316 && CounterX<346 && CounterY>20 && CounterY<50)||
		(!q_Play9 && !Ain[9] && CounterX>353 && CounterX<383 && CounterY>20 && CounterY<50)||
		(!q_Play10 && !Ain[10] && CounterX>390 && CounterX<420 && CounterY>20 && CounterY<50)||
		(!q_Play11 && !Ain[11] && CounterX>427 && CounterX<457 && CounterY>20 && CounterY<50)||
		(!q_Play12 && !Ain[12] && CounterX>464 && CounterX<494 && CounterY>20 && CounterY<50)||
		(!q_Play13 && !Ain[13] && CounterX>501 && CounterX<531 && CounterY>20 && CounterY<50)||		
		(!q_Play14 && !Ain[14] && CounterX>538 && CounterX<568 && CounterY>20 && CounterY<50)||
		(!q_Play15 && !Ain[15] && CounterX>575 && CounterX<605 && CounterY>20 && CounterY<50) ||
		
		// second line
		(!q_Play0 && !Bin[0] && CounterX>20 && CounterX<50 && CounterY>57 && CounterY<87) || 
		(!q_Play1 && !Bin[1] && CounterX>57 && CounterX<87 && CounterY>57 && CounterY<87) || 
		(!q_Play2 && !Bin[2] && CounterX>94 && CounterX<124 && CounterY>57 && CounterY<87)||
		(!q_Play3 && !Bin[3] && CounterX>131 && CounterX<161 && CounterY>57 && CounterY<87)||
		(!q_Play4 && !Bin[4] && CounterX>168 && CounterX<198 && CounterY>57 && CounterY<87)||
		(!q_Play5 && !Bin[5] && CounterX>205 && CounterX<235 && CounterY>57 && CounterY<87)||
		(!q_Play6 && !Bin[6] && CounterX>242 && CounterX<272 && CounterY>57 && CounterY<87)||
		(!q_Play7 && !Bin[7] && CounterX>279 && CounterX<309 && CounterY>57 && CounterY<87)||
		(!q_Play8 && !Bin[8] && CounterX>316 && CounterX<346 && CounterY>57 && CounterY<87)||
		(!q_Play9 && !Bin[9] && CounterX>353 && CounterX<383 && CounterY>57 && CounterY<87)||
		(!q_Play10 && !Bin[10] && CounterX>390 && CounterX<420 && CounterY>57 && CounterY<87)||
		(!q_Play11 && !Bin[11] && CounterX>427 && CounterX<457 && CounterY>57 && CounterY<87)||
		(!q_Play12 && !Bin[12] && CounterX>464 && CounterX<494 && CounterY>57 && CounterY<87)||
		(!q_Play13 && !Bin[13] && CounterX>501 && CounterX<531 && CounterY>57 && CounterY<87)||		
		(!q_Play14 && !Bin[14] && CounterX>538 && CounterX<568 && CounterY>57 && CounterY<87)||
		(!q_Play15 && !Bin[15] && CounterX>575 && CounterX<605 && CounterY>57 && CounterY<87) ||
				
		//third line
		(!q_Play0 && !Cin[0] && CounterX>20 && CounterX<50 && CounterY>94 && CounterY<124) || 
		(!q_Play1 && !Cin[1] && CounterX>57 && CounterX<87 && CounterY>94 && CounterY<124) || 
		(!q_Play2 && !Cin[2] && CounterX>94 && CounterX<124 && CounterY>94 && CounterY<124)||
		(!q_Play3 && !Cin[3] && CounterX>131 && CounterX<161 && CounterY>94 && CounterY<124)||
		(!q_Play4 && !Cin[4] && CounterX>168 && CounterX<198 && CounterY>94 && CounterY<124)||
		(!q_Play5 && !Cin[5] && CounterX>205 && CounterX<235 && CounterY>94 && CounterY<124)||
		(!q_Play6 && !Cin[6] && CounterX>242 && CounterX<272 && CounterY>94 && CounterY<124)||
		(!q_Play7 && !Cin[7] && CounterX>279 && CounterX<309 && CounterY>94 && CounterY<124)||
		(!q_Play8 && !Cin[8] && CounterX>316 && CounterX<346 && CounterY>94 && CounterY<124)||
		(!q_Play9 && !Cin[9] && CounterX>353 && CounterX<383 && CounterY>94 && CounterY<124)||
		(!q_Play10 && !Cin[10] && CounterX>390 && CounterX<420 && CounterY>94 && CounterY<124)||
		(!q_Play11 && !Cin[11] && CounterX>427 && CounterX<457 && CounterY>94 && CounterY<124)||
		(!q_Play12 && !Cin[12] && CounterX>464 && CounterX<494 && CounterY>94 && CounterY<124)||
		(!q_Play13 && !Cin[13] && CounterX>501 && CounterX<531 && CounterY>94 && CounterY<124)||		
		(!q_Play14 && !Cin[14] && CounterX>538 && CounterX<568 && CounterY>94 && CounterY<124)||
		(!q_Play15 && !Cin[15] && CounterX>575 && CounterX<605 && CounterY>94 && CounterY<124)||

		//fourth line
		(!q_Play0 && !Din[0] && CounterX>20 && CounterX<50 && CounterY>131 && CounterY<161) || 
		(!q_Play1 && !Din[1] && CounterX>57 && CounterX<87 && CounterY>131 && CounterY<161) || 
		(!q_Play2 && !Din[2] && CounterX>94 && CounterX<124 && CounterY>131 && CounterY<161)||
		(!q_Play3 && !Din[3] && CounterX>131 && CounterX<161 && CounterY>131 && CounterY<161)||
		(!q_Play4 && !Din[4] && CounterX>168 && CounterX<198 && CounterY>131 && CounterY<161)||
		(!q_Play5 && !Din[5] && CounterX>205 && CounterX<235 && CounterY>131 && CounterY<161)||
		(!q_Play6 && !Din[6] && CounterX>242 && CounterX<272 && CounterY>131 && CounterY<161)||
		(!q_Play7 && !Din[7] && CounterX>279 && CounterX<309 && CounterY>131 && CounterY<161)||
		(!q_Play8 && !Din[8] && CounterX>316 && CounterX<346 && CounterY>131 && CounterY<161)||
		(!q_Play9 && !Din[9] && CounterX>353 && CounterX<383 && CounterY>131 && CounterY<161)||
		(!q_Play10 && !Din[10] && CounterX>390 && CounterX<420 && CounterY>131 && CounterY<161)||
		(!q_Play11 && !Din[11] && CounterX>427 && CounterX<457 && CounterY>131 && CounterY<161)||
		(!q_Play12 && !Din[12] && CounterX>464 && CounterX<494 && CounterY>131 && CounterY<161)||
		(!q_Play13 && !Din[13] && CounterX>501 && CounterX<531 && CounterY>131 && CounterY<161)||		
		(!q_Play14 && !Din[14] && CounterX>538 && CounterX<568 && CounterY>131 && CounterY<161)||
		(!q_Play15 && !Din[15] && CounterX>575 && CounterX<605 && CounterY>131 && CounterY<161) ||
		
		//fifth line
		(!q_Play0 && !Ein[0] && CounterX>20 && CounterX<50 && CounterY>168 && CounterY<198) || 
		(!q_Play1 && !Ein[1] && CounterX>57 && CounterX<87 && CounterY>168 && CounterY<198) || 
		(!q_Play2 && !Ein[2] && CounterX>94 && CounterX<124 && CounterY>168 && CounterY<198)||
		(!q_Play3 && !Ein[3] && CounterX>131 && CounterX<161 && CounterY>168 && CounterY<198)||
		(!q_Play4 && !Ein[4] && CounterX>168 && CounterX<198 && CounterY>168 && CounterY<198)||
		(!q_Play5 && !Ein[5] && CounterX>205 && CounterX<235 && CounterY>168 && CounterY<198)||
		(!q_Play6 && !Ein[6] && CounterX>242 && CounterX<272 && CounterY>168 && CounterY<198)||
		(!q_Play7 && !Ein[7] && CounterX>279 && CounterX<309 && CounterY>168 && CounterY<198)||
		(!q_Play8 && !Ein[8] && CounterX>316 && CounterX<346 && CounterY>168 && CounterY<198)||
		(!q_Play9 && !Ein[9] && CounterX>353 && CounterX<383 && CounterY>168 && CounterY<198)||
		(!q_Play10 && !Ein[10] && CounterX>390 && CounterX<420 && CounterY>168 && CounterY<198)||
		(!q_Play11 && !Ein[11] && CounterX>427 && CounterX<457 && CounterY>168 && CounterY<198)||
		(!q_Play12 && !Ein[12] && CounterX>464 && CounterX<494 && CounterY>168 && CounterY<198)||
		(!q_Play13 && !Ein[13] && CounterX>501 && CounterX<531 && CounterY>168 && CounterY<198)||		
		(!q_Play14 && !Ein[14] && CounterX>538 && CounterX<568 && CounterY>168 && CounterY<198)||
		(!q_Play15 && !Ein[15] && CounterX>575 && CounterX<605 && CounterY>168 && CounterY<198);
		

		//first line
		temp_r <= (q_Play0 && Ain[0] && CounterX>20 && CounterX<50 && CounterY>20 && CounterY<50) || 
		(q_Play1 && Ain[1] && CounterX>57 && CounterX<87 && CounterY>20 && CounterY<50) || 
		(q_Play2 && Ain[2] && CounterX>94 && CounterX<124 && CounterY>20 && CounterY<50)||
		(q_Play3 && Ain[3] && CounterX>131 && CounterX<161 && CounterY>20 && CounterY<50)||
		(q_Play4 && Ain[4] && CounterX>168 && CounterX<198 && CounterY>20 && CounterY<50)||
		(q_Play5 && Ain[5] && CounterX>205 && CounterX<235 && CounterY>20 && CounterY<50)||
		(q_Play6 && Ain[6] && CounterX>242 && CounterX<272 && CounterY>20 && CounterY<50)||
		(q_Play7 && Ain[7] && CounterX>279 && CounterX<309 && CounterY>20 && CounterY<50)||
		(q_Play8 && Ain[8] && CounterX>316 && CounterX<346 && CounterY>20 && CounterY<50)||
		(q_Play9 && Ain[9] && CounterX>353 && CounterX<383 && CounterY>20 && CounterY<50)||
		(q_Play10 && Ain[10] && CounterX>390 && CounterX<420 && CounterY>20 && CounterY<50)||
		(q_Play11 && Ain[11] && CounterX>427 && CounterX<457 && CounterY>20 && CounterY<50)||
		(q_Play12 && Ain[12] && CounterX>464 && CounterX<494 && CounterY>20 && CounterY<50)||
		(q_Play13 && Ain[13] && CounterX>501 && CounterX<531 && CounterY>20 && CounterY<50)||		
		(q_Play14 && Ain[14] && CounterX>538 && CounterX<568 && CounterY>20 && CounterY<50)||
		(q_Play15 && Ain[15] && CounterX>575 && CounterX<605 && CounterY>20 && CounterY<50) ||
		
		// second line
		(q_Play0 && Bin[0] && CounterX>20 && CounterX<50 && CounterY>57 && CounterY<87) || 
		(q_Play1 && Bin[1] && CounterX>57 && CounterX<87 && CounterY>57 && CounterY<87) || 
		(q_Play2 && Bin[2] && CounterX>94 && CounterX<124 && CounterY>57 && CounterY<87)||
		(q_Play3 && Bin[3] && CounterX>131 && CounterX<161 && CounterY>57 && CounterY<87)||
		(q_Play4 && Bin[4] && CounterX>168 && CounterX<198 && CounterY>57 && CounterY<87)||
		(q_Play5 && Bin[5] && CounterX>205 && CounterX<235 && CounterY>57 && CounterY<87)||
		(q_Play6 && Bin[6] && CounterX>242 && CounterX<272 && CounterY>57 && CounterY<87)||
		(q_Play7 && Bin[7] && CounterX>279 && CounterX<309 && CounterY>57 && CounterY<87)||
		(q_Play8 && Bin[8] && CounterX>316 && CounterX<346 && CounterY>57 && CounterY<87)||
		(q_Play9 && Bin[9] && CounterX>353 && CounterX<383 && CounterY>57 && CounterY<87)||
		(q_Play10 && Bin[10] && CounterX>390 && CounterX<420 && CounterY>57 && CounterY<87)||
		(q_Play11 && Bin[11] && CounterX>427 && CounterX<457 && CounterY>57 && CounterY<87)||
		(q_Play12 && Bin[12] && CounterX>464 && CounterX<494 && CounterY>57 && CounterY<87)||
		(q_Play13 && Bin[13] && CounterX>501 && CounterX<531 && CounterY>57 && CounterY<87)||		
		(q_Play14 && Bin[14] && CounterX>538 && CounterX<568 && CounterY>57 && CounterY<87)||
		(q_Play15 && Bin[15] && CounterX>575 && CounterX<605 && CounterY>57 && CounterY<87) ||
		
		//third line
		(q_Play0 && Cin[0] && CounterX>20 && CounterX<50 && CounterY>94 && CounterY<124) || 
		(q_Play1 && Cin[1] && CounterX>57 && CounterX<87 && CounterY>94 && CounterY<124) || 
		(q_Play2 && Cin[2] && CounterX>94 && CounterX<124 && CounterY>94 && CounterY<124)||
		(q_Play3 && Cin[3] && CounterX>131 && CounterX<161 && CounterY>94 && CounterY<124)||
		(q_Play4 && Cin[4] && CounterX>168 && CounterX<198 && CounterY>94 && CounterY<124)||
		(q_Play5 && Cin[5] && CounterX>205 && CounterX<235 && CounterY>94 && CounterY<124)||
		(q_Play6 && Cin[6] && CounterX>242 && CounterX<272 && CounterY>94 && CounterY<124)||
		(q_Play7 && Cin[7] && CounterX>279 && CounterX<309 && CounterY>94 && CounterY<124)||
		(q_Play8 && Cin[8] && CounterX>316 && CounterX<346 && CounterY>94 && CounterY<124)||
		(q_Play9 && Cin[9] && CounterX>353 && CounterX<383 && CounterY>94 && CounterY<124)||
		(q_Play10 && Cin[10] && CounterX>390 && CounterX<420 && CounterY>94 && CounterY<124)||
		(q_Play11 && Cin[11] && CounterX>427 && CounterX<457 && CounterY>94 && CounterY<124)||
		(q_Play12 && Cin[12] && CounterX>464 && CounterX<494 && CounterY>94 && CounterY<124)||
		(q_Play13 && Cin[13] && CounterX>501 && CounterX<531 && CounterY>94 && CounterY<124)||		
		(q_Play14 && Cin[14] && CounterX>538 && CounterX<568 && CounterY>94 && CounterY<124)||
		(q_Play15 && Cin[15] && CounterX>575 && CounterX<605 && CounterY>94 && CounterY<124) ||
		
		//fourth line
		(q_Play0 && Din[0] && CounterX>20 && CounterX<50 && CounterY>131 && CounterY<161) || 
		(q_Play1 && Din[1] && CounterX>57 && CounterX<87 && CounterY>131 && CounterY<161) || 
		(q_Play2 && Din[2] && CounterX>94 && CounterX<124 && CounterY>131 && CounterY<161)||
		(q_Play3 && Din[3] && CounterX>131 && CounterX<161 && CounterY>131 && CounterY<161)||
		(q_Play4 && Din[4] && CounterX>168 && CounterX<198 && CounterY>131 && CounterY<161)||
		(q_Play5 && Din[5] && CounterX>205 && CounterX<235 && CounterY>131 && CounterY<161)||
		(q_Play6 && Din[6] && CounterX>242 && CounterX<272 && CounterY>131 && CounterY<161)||
		(q_Play7 && Din[7] && CounterX>279 && CounterX<309 && CounterY>131 && CounterY<161)||
		(q_Play8 && Din[8] && CounterX>316 && CounterX<346 && CounterY>131 && CounterY<161)||
		(q_Play9 && Din[9] && CounterX>353 && CounterX<383 && CounterY>131 && CounterY<161)||
		(q_Play10 && Din[10] && CounterX>390 && CounterX<420 && CounterY>131 && CounterY<161)||
		(q_Play11 && Din[11] && CounterX>427 && CounterX<457 && CounterY>131 && CounterY<161)||
		(q_Play12 && Din[12] && CounterX>464 && CounterX<494 && CounterY>131 && CounterY<161)||
		(q_Play13 && Din[13] && CounterX>501 && CounterX<531 && CounterY>131 && CounterY<161)||		
		(q_Play14 && Din[14] && CounterX>538 && CounterX<568 && CounterY>131 && CounterY<161)||
		(q_Play15 && Din[15] && CounterX>575 && CounterX<605 && CounterY>131 && CounterY<161) ||
		
		//fifth line
		(q_Play0 && Ein[0] && CounterX>20 && CounterX<50 && CounterY>168 && CounterY<198) || 
		(q_Play1 && Ein[1] && CounterX>57 && CounterX<87 && CounterY>168 && CounterY<198) || 
		(q_Play2 && Ein[2] && CounterX>94 && CounterX<124 && CounterY>168 && CounterY<198)||
		(q_Play3 && Ein[3] && CounterX>131 && CounterX<161 && CounterY>168 && CounterY<198)||
		(q_Play4 && Ein[4] && CounterX>168 && CounterX<198 && CounterY>168 && CounterY<198)||
		(q_Play5 && Ein[5] && CounterX>205 && CounterX<235 && CounterY>168 && CounterY<198)||
		(q_Play6 && Ein[6] && CounterX>242 && CounterX<272 && CounterY>168 && CounterY<198)||
		(q_Play7 && Ein[7] && CounterX>279 && CounterX<309 && CounterY>168 && CounterY<198)||
		(q_Play8 && Ein[8] && CounterX>316 && CounterX<346 && CounterY>168 && CounterY<198)||
		(q_Play9 && Ein[9] && CounterX>353 && CounterX<383 && CounterY>168 && CounterY<198)||
		(q_Play10 && Ein[10] && CounterX>390 && CounterX<420 && CounterY>168 && CounterY<198)||
		(q_Play11 && Ein[11] && CounterX>427 && CounterX<457 && CounterY>168 && CounterY<198)||
		(q_Play12 && Ein[12] && CounterX>464 && CounterX<494 && CounterY>168 && CounterY<198)||
		(q_Play13 && Ein[13] && CounterX>501 && CounterX<531 && CounterY>168 && CounterY<198)||		
		(q_Play14 && Ein[14] && CounterX>538 && CounterX<568 && CounterY>168 && CounterY<198)||
		(q_Play15 && Ein[15] && CounterX>575 && CounterX<605 && CounterY>168 && CounterY<198);
		
	end
	
	
	wire R = temp_y || temp_r;
	wire G = temp_y || temp_g;
	wire B = temp_b;
	
	
	always @(posedge clk)
	begin
		vga_r <= R & inDisplayArea;
		vga_g <= G & inDisplayArea;
		vga_b <= B & inDisplayArea;
	end
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  VGA control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
/*	`define QI 			2'b00
	`define QGAME_1 	2'b01
	`define QGAME_2 	2'b10
	`define QDONE 		2'b11
	
	reg [3:0] p2_score;
	reg [3:0] p1_score;
	reg [1:0] state;
	wire LD0, LD1, LD2, LD3, LD4, LD5, LD6, LD7;
	
	assign LD0 = (p1_score == 4'b1010);
	assign LD1 = (p2_score == 4'b1010);
	
	assign LD2 = start;
	assign LD4 = reset;
	
	assign LD3 = (state == `QI);
	assign LD5 = (state == `QGAME_1);	
	assign LD6 = (state == `QGAME_2);
	assign LD7 = (state == `QDONE);*/
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  LD control ends here 	 	////////////////////
	/////////////////////////////////////////////////////////////////
	
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control starts here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
	/*reg 	[3:0]	SSD;
	wire 	[3:0]	SSD0, SSD1, SSD2, SSD3;
	wire 	[1:0] ssdscan_clk;
	
	assign SSD3 = 4'b1111;
	assign SSD2 = 4'b1111;
	assign SSD1 = 4'b1111;
	assign SSD0 = position[3:0];
	
	// need a scan clk for the seven segment display 
	// 191Hz (50MHz / 2^18) works well
	assign ssdscan_clk = DIV_CLK[19:18];	
	assign An0	= !(~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 00
	assign An1	= !(~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 01
	assign An2	= !( (ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 10
	assign An3	= !( (ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 11
	
	always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3)
	begin : SSD_SCAN_OUT
		case (ssdscan_clk) 
			2'b00:
					SSD = SSD0;
			2'b01:
					SSD = SSD1;
			2'b10:
					SSD = SSD2;
			2'b11:
					SSD = SSD3;
		endcase 
	end	

	// and finally convert SSD_num to ssd
	reg [6:0]  SSD_CATHODES;
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = {SSD_CATHODES, 1'b1};
	// Following is Hex-to-SSD conversion
	always @ (SSD) 
	begin : HEX_TO_SSD
		case (SSD)		
			4'b1111: SSD_CATHODES = 7'b1111111 ; //Nothing 
			4'b0000: SSD_CATHODES = 7'b0000001 ; //0
			4'b0001: SSD_CATHODES = 7'b1001111 ; //1
			4'b0010: SSD_CATHODES = 7'b0010010 ; //2
			4'b0011: SSD_CATHODES = 7'b0000110 ; //3
			4'b0100: SSD_CATHODES = 7'b1001100 ; //4
			4'b0101: SSD_CATHODES = 7'b0100100 ; //5
			4'b0110: SSD_CATHODES = 7'b0100000 ; //6
			4'b0111: SSD_CATHODES = 7'b0001111 ; //7
			4'b1000: SSD_CATHODES = 7'b0000000 ; //8
			4'b1001: SSD_CATHODES = 7'b0000100 ; //9
			4'b1010: SSD_CATHODES = 7'b0001000 ; //10 or A
			default: SSD_CATHODES = 7'bXXXXXXX ; // default is not needed as we covered all cases
		endcase
	end
	*/
	/////////////////////////////////////////////////////////////////
	//////////////  	  SSD control ends here 	 ///////////////////
	/////////////////////////////////////////////////////////////////
endmodule

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:59:43 04/10/2013 
// Design Name: 
// Module Name:    drum_machine_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
`timescale 1ns / 1ps

module drum_machine_top(
		MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS, // Disable the three memory chips

      ClkPort,                           // the 100 MHz incoming clock signal
		Btn1,Btn0,
		BtnL, BtnU, BtnD, BtnR,            // the Left, Up, Down, and the Right buttons BtnL, BtnR,
		BtnC,                              // the center button 
		Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0, // 8 switches
		Ld7, Ld6, Ld5, Ld4, Ld3, Ld2, Ld1, Ld0, // 8 LEDs
		An3, An2, An1, An0,			       // 4 anodes
		Ca, Cb, Cc, Cd, Ce, Cf, Cg,        // 7 cathodes
		Dp,                                // Dot Point Cathode on SSDs
		vga_h_sync, vga_v_sync, vga_r, vga_g, vga_b, 	
	St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar,
	SOUND_data, SOUND_gain, SOUND_shutdown
    );
	
	/*  INPUTS */
	// Clock & Reset I/O
	input		ClkPort;	
	// Project Specific Inputs
	input		BtnL, BtnU, BtnD, BtnR, BtnC;	
	input		Sw7, Sw6, Sw5, Sw4, Sw3, Sw2, Sw1, Sw0;
	input		Btn1,Btn0;
	
	
	/*  OUTPUTS */
	// Control signals on Memory chips 	(to disable them)
	output 	MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS;
	// Project Specific Outputs
	// LEDs
	output 	Ld0, Ld1, Ld2, Ld3, Ld4, Ld5, Ld6, Ld7;
	// SSD Outputs
	output 	Cg, Cf, Ce, Cd, Cc, Cb, Ca, Dp;
	output 	An0, An1, An2, An3;	

	output vga_h_sync, vga_v_sync, vga_r,vga_g, vga_b, St_ce_bar, St_rp_bar, Mt_ce_bar, Mt_St_oe_bar, Mt_St_we_bar;
	output SOUND_data, SOUND_gain, SOUND_shutdown;
	wire SOUND_data;
	wire SOUND_gain;
	wire SOUND_shutdown;
	assign SOUND_data = (NOTE_CLK && (Aout || Bout || Cout || Dout || Eout));
	assign SOUND_gain = 0;
	assign SOUND_shutdown = (!state[0]) && (Aout || Bout || Cout || Dout || Eout);
	//output NOTE_CLK;
	
	/*  LOCAL SIGNALS */
	wire		Reset, ClkPort;
	wire		board_clk, sys_clk, sys_clk2;
	wire [1:0] 	ssdscan_clk;
	reg [26:0]	DIV_CLK;
	
	wire Ain,Bin,Cin,Din,Ein;
	wire BtnU_Pulse; 
	wire note_toggle_pulse;	//BtnC_Pulse
	wire Btn1_pulse, Btn0_pulse; //Tempo up/down
	//wire q_I, q_Play0, q_Play1, q_Play2, q_Play3; 
	wire playing;
	//wire q_Play4, q_Play5, q_Play6, q_Play7;
	//wire q_Play8, q_Play9, q_Play10, q_Play11;
	//wire q_Play12, q_Play13, q_Play14, q_Play15;
	wire Aout, Bout, Cout, Dout, Eout;
	wire [15:0] A;
	wire [15:0] B;
	wire [15:0] C;
	wire [15:0] D;
	wire [15:0] E;
	reg Note_Toggle_Flag;
	wire [16:0] state;
	wire Fourths_in, Eighths_in;
				
	wire [5:0] ADDR_in;
	wire NOTE_CLK;
	assign ADDR_in = {Note_Toggle_Flag, Aout, Bout, Cout, Dout, Eout};
	
	reg [3:0]	SSD;
	wire [3:0]	SSD3, SSD2, SSD1, SSD0; 
	reg [7:0]  SSD_CATHODES; 
	
	reg [1:0] tempo;
	
//------------	
// Disable the three memories so that they do not interfere with the rest of the design.
	assign {MemOE, MemWR, RamCS, FlashCS, QuadSpiFlashCS} = 5'b11111;

	
	
//------------
// CLOCK DIVISION

	// The clock division circuitary works like this:
	//
	// ClkPort ---> [BUFGP2] ---> board_clk
	// board_clk ---> [clock dividing counter] ---> DIV_CLK
	// DIV_CLK ---> [constant assignment] ---> sys_clk;
	
	BUFGP BUFGP1 (board_clk, ClkPort); 

// As the ClkPort signal travels throughout our design,
// it is necessary to provide global routing to this signal. 
// The BUFGPs buffer these input ports and connect them to the global 
// routing resources in the FPGA.


	// BUFGP BUFGP2 (Reset, BtnC); In the case of Spartan 3E (on Nexys-2 board), we were using BUFGP to provide global routing for the reset signal. But Spartan 6 (on Nexys-3) does not allow this.
	assign Reset = BtnL;
	
//------------
	// Our clock is too fast (100MHz) for SSD scanning
	// create a series of slower "divided" clocks
	// each successive bit is 1/2 frequency
  always @(posedge board_clk, posedge Reset) 	
    begin							
        if (Reset)
		DIV_CLK <= 0;
        else
		DIV_CLK <= DIV_CLK + 1'b1;
    end
//-------------------	
	// In this design, we run the core design at a slow speed
	 assign	sys_clk = (tempo[0] && tempo[1]) ? DIV_CLK[25] : ((!tempo[0] && tempo[1]) ? DIV_CLK[24] : ((tempo[0] && !tempo[1])? DIV_CLK[23] : DIV_CLK[22]));
	 assign	sys_clk2 = (tempo[0] && tempo[1]) ? DIV_CLK[26] : ((!tempo[0] && tempo[1]) ? DIV_CLK[25] : ((tempo[0] && !tempo[1])? DIV_CLK[24] : DIV_CLK[23]));
	 
//------------
// INPUT: SWITCHES & BUTTONS
	// BtnL is used as both Start and Stop. 
	// To make this possible, we need a single clock producing  circuit.
		 		 
		 // BtnR is used to generate in_AB_Pulse to record the values of 
		 // the inputs A and B as set on the switches.
		 // BtnU is used as CEN_Pulse to allow single-stepping
	assign {Ain, Bin, Cin, Din, Ein} = {Sw7, Sw6, Sw5, Sw4, Sw3};
	assign {Fourths_in, Eighths_in} = {Sw1, Sw0};
	

ee201_debouncer #(.N_dc(28)) ee201_debouncer_BtnC 
        (  .CLK(board_clk), .RESET(Reset), .PB(BtnC), .DPB( ), 
		.SCEN(note_toggle_pulse), .MCEN( ), .CCEN( )); 
		
ee201_debouncer #(.N_dc(28)) ee201_debouncer_Btn0 
        (  .CLK(board_clk), .RESET(Reset), .PB(Btn0), .DPB( ), 
		.SCEN(Btn0_pulse), .MCEN( ), .CCEN( )); 
		
ee201_debouncer #(.N_dc(28)) ee201_debouncer_Btn1
        (  .CLK(board_clk), .RESET(Reset), .PB(Btn1), .DPB( ), 
		.SCEN(Btn1_pulse), .MCEN( ), .CCEN( )); 	
		
ee201_debouncer #(.N_dc(28)) ee201_debouncer_BtnU
        (  .CLK(board_clk), .RESET(Reset), .PB(BtnU), .DPB( ), 
		.SCEN(BtnU_pulse), .MCEN( ), .CCEN( )); 

	// the state machine module
	drum_machine_SM drum_machine_SM_1(
							.Clk(sys_clk), .Reset(Reset), .Start(BtnR), .Stop(BtnD), 
							.Ain(Ain), .Bin(Bin), .Cin(Cin), .Din(Din), .Ein(Ein),
							.A(A),.B(B),.C(C),.D(D),.E(E),
							.playing(playing), 
							.Aout(Aout), .Bout(Bout), .Cout(Cout), .Dout(Dout), .Eout(Eout),
							//.q_I(q_I), .q_Play0(q_Play0), .q_Play1(q_Play1), .q_Play2(q_Play2), .q_Play3(q_Play3),
							//.q_Play4(q_Play4), .q_Play5(q_Play5), .q_Play6(q_Play6), .q_Play7(q_Play7),
							//.q_Play8(q_Play8), .q_Play9(q_Play9), .q_Play10(q_Play10), .q_Play11(q_Play11),
							//.q_Play12(q_Play12), .q_Play13(q_Play13), .q_Play14(q_Play14), .q_Play15(q_Play15),
							.state(state), .Fourths(Fourths_in), .Eighths(Eighths_in),.CCEN(Sw2)
			);
			
	// VGA module
	vga_demo vga_demo1(
	.ClkPort(board_clk), .reset(Reset), .vga_h_sync(vga_h_sync), .vga_v_sync(vga_v_sync), .vga_r(vga_r), .vga_g(vga_g), .vga_b(vga_b),
	.St_ce_bar(St_ce_bar), .St_rp_bar(St_rp_bar), .Mt_ce_bar(Mt_ce_bar), .Mt_St_oe_bar(Mt_St_oe_bar), .Mt_St_we_bar(Mt_St_we_bar),
	.Ain(A), .Bin(B), .Cin(C), .Din(D), .Ein(E), .State(state), .DIV_CLK_1(DIV_CLK[1])
	);
	
	// the clk generator module
	// Instantiate the UUT
		Note_CLK_GEN2 UUT (
			.ADDR(ADDR_in), 
			.RESET(Reset), 
			.NOTE_CLK(NOTE_CLK), 
			.CLK_50MHZ(DIV_CLK[0]) 
			,.sys_clk(sys_clk)
		);
	
//Set Note_Toggle_Flag
  always @(posedge board_clk) 
  begin
	if(note_toggle_pulse && Note_Toggle_Flag == 1)
		Note_Toggle_Flag <= 0;
	else if(note_toggle_pulse && Note_Toggle_Flag == 0)
		Note_Toggle_Flag <= 1;
  end
  
//------------
// OUTPUT: LEDS
	assign {Ld7, Ld6, Ld5, Ld4} = { playing, (playing && Sw2), (playing && Sw2), (playing && Sw2)};
	assign {Ld3, Ld2, Ld1, Ld0} = { (playing && Sw2), !Sw2, Sw1, (Sw0 && !Sw1)}; // Reset is driven by BtnL
	// Here
	// BtnL = Start/Ack
	// BtnU = Single-Step
	// BtnR = in_A_in_B
	// BtnD = not used here
	
//------------
// SSD (Seven Segment Display)
	
	//SSDs show Ain and Bin in initial state, A and B in subtract state, and GCD and i_count in multiply and done states.
	// ****** TODO  in Part 2 ******
	// assign y = s ? i1 : i0;  // an example of a 2-to-1 mux coding
	// assign y = s1 ? (s0 ? i3: i2): (s0 ? i1: i0); // an example of a 4-to-1 mux coding
	assign SSD3 = (state[0]) ? 1'b0000  : 1'b1111;
	assign SSD2 = (state[0]) ? 1'b0000  : 1'b1111;
	assign SSD1 = (state[0]) ? 1'b0000  : {1'b0, 1'b0, Note_Toggle_Flag, Aout}; 
	assign SSD0 = (state[0]) ? 1'b0000  : {Bout, Cout, Dout, Eout};


	// need a scan clk for the seven segment display 
	
	// 100 MHz / 2^18 = 381.5 cycles/sec ==> frequency of DIV_CLK[17]
	// 100 MHz / 2^19 = 190.7 cycles/sec ==> frequency of DIV_CLK[18]
	// 100 MHz / 2^20 =  95.4 cycles/sec ==> frequency of DIV_CLK[19]
	
	// 381.5 cycles/sec (2.62 ms per digit) [which means all 4 digits are lit once every 10.5 ms (reciprocal of 95.4 cycles/sec)] works well.
	
	//                  --|  |--|  |--|  |--|  |--|  |--|  |--|  |--|  |   
    //                    |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  | 
	//  DIV_CLK[17]       |__|  |__|  |__|  |__|  |__|  |__|  |__|  |__|
	//
	//               -----|     |-----|     |-----|     |-----|     |
    //                    |  0  |  1  |  0  |  1  |     |     |     |     
	//  DIV_CLK[18]       |_____|     |_____|     |_____|     |_____|
	//
	//         -----------|           |-----------|           |
    //                    |  0     0  |  1     1  |           |           
	//  DIV_CLK[19]       |___________|           |___________|
	//
	
	assign ssdscan_clk = DIV_CLK[19:18];
	
	assign An3	= !(~(ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 00
	assign An2	= !(~(ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 01
	assign An1	=  !((ssdscan_clk[1]) && ~(ssdscan_clk[0]));  // when ssdscan_clk = 10
	assign An0	=  !((ssdscan_clk[1]) &&  (ssdscan_clk[0]));  // when ssdscan_clk = 11
	
	
	always @ (ssdscan_clk, SSD0, SSD1, SSD2, SSD3)
	begin : SSD_SCAN_OUT
		case (ssdscan_clk) 
				  2'b00: SSD = SSD3;	
				  2'b01: SSD = SSD2;  
				  2'b10: SSD = SSD1;
				  2'b11: SSD = SSD0;
		endcase 
	end
	
	// and finally convert SSD_num to ssd
	// We convert the output of our 4-bit 4x1 mux

	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = (state[0] == 0 && ssdscan_clk[1] == 0) ?  8'b11111111 : {SSD_CATHODES};

	// Following is Hex-to-SSD conversion
	always @ (SSD) 
	begin : HEX_TO_SSD
		case (SSD) // in this solution file the dot points are made to glow by making Dp = 0
		    //                                                                abcdefg,Dp
			// ****** TODO  in Part 2 ******
			// Revise the code below so that the dot points do not glow for your design.
			4'b0000: SSD_CATHODES = 8'b00000011; // 0
			4'b0001: SSD_CATHODES = 8'b10011111; // 1
			4'b0010: SSD_CATHODES = 8'b00100101; // 2
			4'b0011: SSD_CATHODES = 8'b00001101; // 3
			4'b0100: SSD_CATHODES = 8'b10011001; // 4
			4'b0101: SSD_CATHODES = 8'b01001001; // 5
			4'b0110: SSD_CATHODES = 8'b01000001; // 6
			4'b0111: SSD_CATHODES = 8'b00011111; // 7
			4'b1000: SSD_CATHODES = 8'b00000001; // 8
			4'b1001: SSD_CATHODES = 8'b00001001; // 9
			4'b1010: SSD_CATHODES = 8'b00010001; // A
			4'b1011: SSD_CATHODES = 8'b11000001; // B
			4'b1100: SSD_CATHODES = 8'b01100011; // C
			4'b1101: SSD_CATHODES = 8'b10000101; // D
			4'b1110: SSD_CATHODES = 8'b01100001; // E
			4'b1111: SSD_CATHODES = 8'b01110001; // F    
			default: SSD_CATHODES = 8'bXXXXXXXX; // default is not needed as we covered all cases
		endcase
	end	
		
	/**Tempo Logic**/
	always @(posedge board_clk, posedge Reset)
		begin
			if(Reset)
			 begin
				tempo <= 2'b01;
			 end
			else
				begin
					if(Btn1_pulse)
						tempo <= tempo - 1;
					if(Btn0_pulse)
						tempo <= tempo + 1;
					if(BtnU_pulse)
						tempo <= 2'b01;
				end
		end
endmodule

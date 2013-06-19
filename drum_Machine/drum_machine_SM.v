//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:09:35 04/10/2013 
// Design Name: 
// Module Name:    drum_machine_SM 
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
module drum_machine_SM( Clk, Reset, Start, Stop, Ain, Bin, Cin, Din, Ein,
								playing, 
								Aout, Bout, Cout, Dout, Eout, A,B,C,D,E,
								//q_I, q_Play0, q_Play1, q_Play2, q_Play3,
								//q_Play4, q_Play5, q_Play6, q_Play7,
								//q_Play8, q_Play9, q_Play10, q_Play11,
								//q_Play12, q_Play13, q_Play14, q_Play15,
								state, Fourths, Eighths, CCEN
    );

	localparam 
			I 			= 17'b00000000000000001, 
			PLAY0 	= 17'b00000000000000010,  
			PLAY1 	= 17'b00000000000000100,  
			PLAY2 	= 17'b00000000000001000, 
			PLAY3 	= 17'b00000000000010000, 
			PLAY4 	= 17'b00000000000100000, 
			PLAY5 	= 17'b00000000001000000, 
			PLAY6 	= 17'b00000000010000000,  
			PLAY7 	= 17'b00000000100000000, 
			PLAY8 	= 17'b00000001000000000, 
			PLAY9 	= 17'b00000010000000000, 
			PLAY10 	= 17'b00000100000000000, 
			PLAY11 	= 17'b00001000000000000, 
			PLAY12 	= 17'b00010000000000000, 
			PLAY13 	= 17'b00100000000000000,  
			PLAY14 	= 17'b01000000000000000,  
			PLAY15 	= 17'b10000000000000000, 
			UNK 		= 17'bXXXXXXXXXXXXXXXXX;
	
	/*  INPUTS */
	input	Clk, Reset, Start, Stop;
	input Ain;
	input Bin;
	input Cin;
	input Din;
	input Ein;
	input Fourths, Eighths;
	input CCEN;
	
	/* Outputs */
	output reg [15:0] A;
	output reg [15:0] B;
	output reg [15:0] C;
	output reg [15:0] D;
	output reg [15:0] E;
	output reg Aout,Bout,Cout,Dout,Eout;
	output playing;
	output reg [16:0] state;
	//output q_I, q_Play0, q_Play1, q_Play2, q_Play3, q_Play4, q_Play5, q_Play6, q_Play7;
	//output q_Play8, q_Play9, q_Play10, q_Play11, q_Play12, q_Play13, q_Play14, q_Play15;
	assign {q_Play15, q_Play14, q_Play13, q_Play12, q_Play11, q_Play10, q_Play9, q_Play8, q_Play7, q_Play6, q_Play5, q_Play4, q_Play3, q_Play2, q_Play1, q_Play0, q_I} = state;
	assign playing = q_Play15 || q_Play14 || q_Play13 || q_Play12 || q_Play11 || q_Play10 || q_Play9 || q_Play8 || q_Play7 || q_Play6 || q_Play5 || q_Play4 || q_Play3 || q_Play2 || q_Play1 || q_Play0;
	
	/*reg four,eight;
	always @ (*)
	begin 	
	
		if(Reset)
		 begin
		 four <= 0;
		 eight <= 0;
		 end
		 
		else if (Fourths)
		 begin
			if(four)
				four <= 1;
			else
				four <= 0;
		 end
		 
		else if (Eighths)
		 begin
			if(eight)
				eight <= 1;
			else
				eight <= 0;
		 end
		 
	end*/
	
	// NSL AND SM
	always @ (posedge Clk, posedge Reset)
	begin 
		if(Reset) 
		  begin
			state <= I;
			A <= 16'bx;		  
			B <= 16'bx;  
			C <= 16'bx;		  
			D <= 16'bx;  
			E <= 16'bx;		  
		  end
		else
			begin
			if(CCEN)
			case(state)	
					I:
					begin
						// state transfers
						if (Start)
							state <= PLAY0;
						// data transfers
						A <= 0;
						B <= 0;
						C <= 0;
						D <= 0;
						E <= 0;
					end		
					PLAY0:
					begin
						// state transfers
						state <= PLAY1;
						// data transfers
						if(Ain && A[0])
							A[0] <= 1'b0;
						else if(Ain)
							A[0] <= 1'b1;
							
						if(Bin && B[0])
							B[0] <= 1'b0;
						else if(Bin)
							B[0] <= 1'b1;
							
						if(Cin && C[0])
							C[0] <= 1'b0;
						else if(Cin)
							C[0] <= 1'b1;
							
						if(Din && D[0])
							D[0] <= 1'b0;
						else if(Din)
							D[0] <= 1'b1;
							
						if(Ein && E[0])
							E[0] <= 1'b0;
						else if(Ein)
							E[0] <= 1'b1;
					end		
					PLAY1:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY2;
						// data transfers
						if(Ain && A[1])
							A[1] <= 1'b0;
						else if(Ain)
							A[1] <= 1'b1;
							
						if(Bin && B[1])
							B[1] <= 1'b0;
						else if(Bin)
							B[1] <= 1'b1;
							
						if(Cin && C[1])
							C[1] <= 1'b0;
						else if(Cin)
							C[1] <= 1'b1;
						
						if(Din && D[1])
							D[1] <= 1'b0;
						else if(Din)
							D[1] <= 1'b1;
						
						if(Ein && E[1])
							E[1] <= 1'b0;
						else if(Ein)
							E[1] <= 1'b1;
					end		
					PLAY2:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY3;
						// data transfers
						if(Ain && A[2])
							A[2] <= 1'b0;
						else if(Ain)
							A[2] <= 1'b1;
							
						if(Bin && B[2])
							B[2] <= 1'b0;
						else if(Bin)
							B[2] <= 1'b1;
							
						if(Cin && C[2])
							C[2] <= 1'b0;
						else if(Cin)
							C[2] <= 1'b1;
							
						if(Din && D[2])
							D[2] <= 1'b0;
						else if(Din)
							D[2] <= 1'b1;
							
						if(Ein && E[2])
							E[2] <= 1'b0;
						else if(Ein)
							E[2] <= 1'b1;
					end		
					PLAY3:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else if(Fourths)
							state <= PLAY0;
						else
							state <= PLAY4;
						// data transfers
						if(Ain && A[3])
							A[3] <= 1'b0;
						else if(Ain)
							A[3] <= 1'b1;
							
						if(Bin && B[3])
							B[3] <= 1'b0;
						else if(Bin)
							B[3] <= 1'b1;
							
						if(Cin && C[3])
							C[3] <= 1'b0;
						else if(Cin)
							C[3] <= 1'b1;
							
						if(Din && D[3])
							D[3] <= 1'b0;
						else if(Din)
							D[3] <= 1'b1;
							
						if(Ein && E[3])
							E[3] <= 1'b0;
						else if(Ein)
							E[3] <= 1'b1;
					end		
					PLAY4:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY5;
						// data transfers
						if(Ain && A[4])
							A[4] <= 1'b0;
						else if(Ain)
							A[4] <= 1'b1;
						
						if(Bin && B[4])
							B[4] <= 1'b0;
						else if(Bin)
							B[4] <= 1'b1;
							
						if(Cin && C[4])
							C[4] <= 1'b0;
						else if(Cin)
							C[4] <= 1'b1;
							
						if(Din && D[4])
							D[4] <= 1'b0;
						else if(Din)
							D[4] <= 1'b1;
							
						if(Ein && E[4])
							E[4] <= 1'b0;
						else if(Ein)
							E[4] <= 1'b1;
					end		
					PLAY5:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY6;
						// data transfers
						if(Ain && A[5])
							A[5] <= 1'b0;
						else if(Ain)
							A[5] <= 1'b1;
							
						if(Bin && B[5])
							B[5] <= 1'b0;
						else if(Bin)
							B[5] <= 1'b1;
							
						if(Cin && C[5])
							C[5] <= 1'b0;
						else if(Cin)
							C[5] <= 1'b1;
							
						if(Din && D[5])
							D[5] <= 1'b0;
						else if(Din)
							D[5] <= 1'b1;
							
						if(Ein && E[5])
							E[5] <= 1'b0;
						else if(Ein)
							E[5] <= 1'b1;
					end		
					PLAY6:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY7;
						// data transfers
						if(Ain && A[6])
							A[6] <= 1'b0;
						else if(Ain)
							A[6] <= 1'b1;
							
						if(Bin && B[6])
							B[6] <= 1'b0;
						else if(Bin)
							B[6] <= 1'b1;
							
						if(Cin && C[6])
							C[6] <= 1'b0;
						else if(Cin)
							C[6] <= 1'b1;
							
						if(Din && D[6])
							D[6] <= 1'b0;
						else if(Din)
							D[6] <= 1'b1;
							
						if(Ein && E[6])
							E[6] <= 1'b0;
						else if(Ein)
							E[6] <= 1'b1;
					end		
					PLAY7:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else if(Eighths)
							state <= PLAY0;
						else
							state <= PLAY8;
						// data transfers
						if(Ain && A[7])
							A[7] <= 1'b0;
						else if(Ain)
							A[7] <= 1'b1;
							
						if(Bin && B[7])
							B[7] <= 1'b0;
						else if(Bin)
							B[7] <= 1'b1;
							
						if(Cin && C[7])
							C[7] <= 1'b0;
						else if(Cin)
							C[7] <= 1'b1;
							
						if(Din && D[7])
							D[7] <= 1'b0;
						else if(Din)
							D[7] <= 1'b1;
							
						if(Ein && E[7])
							E[7] <= 1'b0;
						else if(Ein)
							E[7] <= 1'b1;
					end		
					PLAY8:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY9;
						// data transfers
						if(Ain && A[8])
							A[8] <= 1'b0;
						else if(Ain)
							A[8] <= 1'b1;
							
						if(Bin && B[8])
							B[8] <= 1'b0;
						else if(Bin)
							B[8] <= 1'b1;
							
						if(Cin && C[8])
							C[8] <= 1'b0;
						else if(Cin)
							C[8] <= 1'b1;
							
						if(Din && D[8])
							D[8] <= 1'b0;
						else if(Din)
							D[8] <= 1'b1;
							
						if(Ein && E[8])
							E[8] <= 1'b0;
						else if(Ein)
							E[8] <= 1'b1;
					end		
					PLAY9:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY10;
						// data transfers
						if(Ain && A[9])
							A[9] <= 1'b0;
						else if(Ain)
							A[9] <= 1'b1;
							
						if(Bin && B[9])
							B[9] <= 1'b0;
						else if(Bin)
							B[9] <= 1'b1;
							
						if(Cin && C[9])
							C[9] <= 1'b0;
						else if(Cin)
							C[9] <= 1'b1;
							
						if(Din && D[9])
							D[9] <= 1'b0;
						else if(Din)
							D[9] <= 1'b1;
							
						if(Ein && E[9])
							E[9] <= 1'b0;
						else if(Ein)
							E[9] <= 1'b1;
					end		
					PLAY10:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY11;
						// data transfers
						if(Ain && A[10])
							A[10] <= 1'b0;
						else if(Ain)
							A[10] <= 1'b1;
							
						if(Bin && B[10])
							B[10] <= 1'b0;
						else if(Bin)
							B[10] <= 1'b1;
							
						if(Cin && C[10])
							C[10] <= 1'b0;
						else if(Cin)
							C[10] <= 1'b1;
							
						if(Din && D[10])
							D[10] <= 1'b0;
						else if(Din)
							D[10] <= 1'b1;
							
						if(Ein && E[10])
							E[10] <= 1'b0;
						else if(Ein)
							E[10] <= 1'b1;
					end		
					PLAY11:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY12;
						// data transfers
						if(Ain && A[11])
							A[11] <= 1'b0;
						else if(Ain)
							A[11] <= 1'b1;
							
						if(Bin && B[11])
							B[11] <= 1'b0;
						else if(Bin)
							B[11] <= 1'b1;
							
						if(Cin && C[11])
							C[11] <= 1'b0;
						else if(Cin)
							C[11] <= 1'b1;
							
						if(Din && D[11])
							D[11] <= 1'b0;
						else if(Din)
							D[11] <= 1'b1;
							
						if(Ein && E[11])
							E[11] <= 1'b0;
						else if(Ein)
							E[11] <= 1'b1;
					end		
					PLAY12:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY13;
						// data transfers
						if(Ain && A[12])
							A[12] <= 1'b0;
						else if(Ain)
							A[12] <= 1'b1;
							
						if(Bin && B[12])
							B[12] <= 1'b0;
						else if(Bin)
							B[12] <= 1'b1;
							
						if(Cin && C[12])
							C[12] <= 1'b0;
						else if(Cin)
							C[12] <= 1'b1;
							
						if(Din && D[12])
							D[12] <= 1'b0;
						else if(Din)
							D[12] <= 1'b1;
							
						if(Ein && E[12])
							E[12] <= 1'b0;
						else if(Ein)
							E[12] <= 1'b1;
					end		
					PLAY13:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY14;
						// data transfers
						if(Ain && A[13])
							A[13] <= 1'b0;
						else if(Ain)
							A[13] <= 1'b1;
							
						if(Bin && B[13])
							B[13] <= 1'b0;
						else if(Bin)
							B[13] <= 1'b1;
							
						if(Cin && C[13])
							C[13] <= 1'b0;
						else if(Cin)
							C[13] <= 1'b1;
							
						if(Din && D[13])
							D[13] <= 1'b0;
						else if(Din)
							D[13] <= 1'b1;
							
						if(Ein && E[13])
							E[13] <= 1'b0;
						else if(Ein)
							E[13] <= 1'b1;
					end		
					PLAY14:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY15;
						// data transfers
						if(Ain && A[14])
							A[14] <= 1'b0;
						else if(Ain)
							A[14] <= 1'b1;
							
						if(Bin && B[14])
							B[14] <= 1'b0;
						else if(Bin)
							B[14] <= 1'b1;
							
						if(Cin && C[14])
							C[14] <= 1'b0;
						else if(Cin)
							C[14] <= 1'b1;
							
						if(Din && D[14])
							D[14] <= 1'b0;
						else if(Din)
							D[14] <= 1'b1;
							
						if(Ein && E[14])
							E[14] <= 1'b0;
						else if(Ein)
							E[14] <= 1'b1;
					end		
					PLAY15:
					begin
						// state transfers
						if(Stop)
							state <= I;
						else
							state <= PLAY0;
						// data transfers
						if(Ain && A[15])
							A[15] <= 1'b0;
						else if(Ain)
							A[15] <= 1'b1;
							
						if(Bin && B[15])
							B[15] <= 1'b0;
						else if(Bin)
							B[15] <= 1'b1;
							
						if(Cin && C[15])
							C[15] <= 1'b0;
						else if(Cin)
							C[15] <= 1'b1;
							
						
						if(Din && D[15])
							D[15] <= 1'b0;
						else if(Din)
							D[15] <= 1'b1;
							
						
						if(Ein && E[15])
							E[15] <= 1'b0;
						else if(Ein)
							E[15] <= 1'b1;
					end
						default:		
							state <= UNK;
			endcase
		end
	end

//OFL	
	always@(*)
	begin: Recording_mux
		if(q_Play0)
		  begin
			Aout = A[0];
			Bout = B[0];
			Cout = C[0];
			Dout = D[0];
			Eout = E[0];
		  end
		else if(q_Play1)
		  begin
			Aout = A[1];
			Bout = B[1];
			Cout = C[1];
			Dout = D[1];
			Eout = E[1];
		  end
		else if(q_Play2)
		  begin
			Aout = A[2];
			Bout = B[2];
			Cout = C[2];
			Dout = D[2];
			Eout = E[2];
		  end
		else if(q_Play3)
		  begin
			Aout = A[3];
			Bout = B[3];
			Cout = C[3];
			Dout = D[3];
			Eout = E[3];
		  end
		else if(q_Play4)
		  begin
			Aout = A[4];
			Bout = B[4];
			Cout = C[4];
			Dout = D[4];
			Eout = E[4];
		  end
		else if(q_Play5)
		  begin
			Aout = A[5];
			Bout = B[5];
			Cout = C[5];
			Dout = D[5];
			Eout = E[5];
		  end
		else if(q_Play6)
		  begin
			Aout = A[6];
			Bout = B[6];
			Cout = C[6];
			Dout = D[6];
			Eout = E[6];
		  end
		else if(q_Play7)
		  begin
			Aout = A[7];
			Bout = B[7];
			Cout = C[7];
			Dout = D[7];
			Eout = E[7];
		  end
		else if(q_Play8)
		  begin
			Aout = A[8];
			Bout = B[8];
			Cout = C[8];
			Dout = D[8];
			Eout = E[8];
		  end
		else if(q_Play9)
		  begin
			Aout = A[9];
			Bout = B[9];
			Cout = C[9];
			Dout = D[9];
			Eout = E[9];
		  end
		
		else if(q_Play10)
		  begin
			Aout = A[10];
			Bout = B[10];
			Cout = C[10];
			Dout = D[10];
			Eout = E[10];
		  end
		
		else if(q_Play11)
		  begin
			Aout = A[11];
			Bout = B[11];
			Cout = C[11];
			Dout = D[11];
			Eout = E[11];
		  end
		
		else if(q_Play12)
		  begin
			Aout = A[12];
			Bout = B[12];
			Cout = C[12];
			Dout = D[12];
			Eout = E[12];
		  end
		else if(q_Play13)
		  begin
			Aout = A[13];
			Bout = B[13];
			Cout = C[13];
			Dout = D[13];
			Eout = E[13];
		  end
		else if(q_Play14)
		  begin
			Aout = A[14];
			Bout = B[14];
			Cout = C[14];
			Dout = D[14];
			Eout = E[14];
		  end
		else if(q_Play15)
		  begin
			Aout = A[15];
			Bout = B[15];
			Cout = C[15];
			Dout = D[15];
			Eout = E[15];
		  end
		else
		  begin
			Aout = 1'b0;
			Bout = 1'b0;
			Cout = 1'b0;
			Dout = 1'b0;
			Eout = 1'b0;
		  end
	end
	
endmodule

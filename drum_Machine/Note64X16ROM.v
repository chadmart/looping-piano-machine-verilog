`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:47:14 03/27/2008 
// Design Name: 
// Module Name:    Note64X16ROM 
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
//Expecting 50Khz clock
module Note64X16ROM(I,DOUT);

	
	input [5:0] I;
	output [15:0] DOUT;
	reg [15:0] DOUT;
 
   always @(I)
         case (I)
            6'b000000: DOUT <= 16'hFFFF; //No Sound? //16'h032A; //B0
            6'b000001: DOUT <= 16'h02FD;	// C1
            6'b000010: DOUT <= 16'h02D2;	// C#1 or Db1
            6'b000011: DOUT <= 16'h02A9;	// D1
            6'b000100: DOUT <= 16'h0283;	// D#1 or Eb1
            6'b000101: DOUT <= 16'h025F;	// E1
            6'b000110: DOUT <= 16'h023D;	// F1
            6'b000111: DOUT <= 16'h021D;	// F#1 or Gb1
            6'b001000: DOUT <= 16'h01FE;	// G1
            6'b001001: DOUT <= 16'h01E2;	// G#1 or Ab1
            6'b001010: DOUT <= 16'h01C7;	// A1
            6'b001011: DOUT <= 16'h01AD;	// A#1 or Bb1
            6'b001100: DOUT <= 16'h0195;	// B1
            6'b001101: DOUT <= 16'h017E;	// C2
            6'b001110: DOUT <= 16'h0169;	// C#2 or Db2
            6'b001111: DOUT <= 16'h0155;	// D2
            6'b010000: DOUT <= 16'h0141;	// D#2 or Eb2
            6'b010001: DOUT <= 16'h012F;	// E2
            6'b010010: DOUT <= 16'h011E;	// F2
            6'b010011: DOUT <= 16'h010E;	// F#2 or Gb2
            6'b010100: DOUT <= 16'h00FF;	// G2
            6'b010101: DOUT <= 16'h00F1;	// G#2 or Ab2
            6'b010110: DOUT <= 16'h00E3;	// A2
            6'b010111: DOUT <= 16'h00D7;	// A#2 or Bb2
            6'b011000: DOUT <= 16'h00CA;	// B2
            6'b011001: DOUT <= 16'h00BF;	// C3
            6'b011010: DOUT <= 16'h00B4;	// C#3 or Db3
            6'b011011: DOUT <= 16'h00AA;	// D3
            6'b011100: DOUT <= 16'h00A1;	// D#3 or Eb3
            6'b011101: DOUT <= 16'h0098;	// E3
            6'b011110: DOUT <= 16'h008F;	// F3
            6'b011111: DOUT <= 16'h0087;	// F#3 or Gb3
            6'b100000: DOUT <= 16'hFFFF; //No Sound? //16'h0080; // G3
            6'b100001: DOUT <= 16'h0078;	// G#3 or Ab3
            6'b100010: DOUT <= 16'h0072;	// A3
            6'b100011: DOUT <= 16'h006B;	// A#3 or Bb3
            6'b100100: DOUT <= 16'h0065;	// B3
            6'b100101: DOUT <= 16'h0060;	// C4
            6'b100110: DOUT <= 16'h005A;	// C#4 or Db4
            6'b100111: DOUT <= 16'h0055;	// D4
            6'b101000: DOUT <= 16'h0050;	// D#4 or Eb4
            6'b101001: DOUT <= 16'h004C;	// E4
            6'b101010: DOUT <= 16'h0048;	// F4
            6'b101011: DOUT <= 16'h0044;	// F#4 or Gb4
            6'b101100: DOUT <= 16'h0040;	// G4
            6'b101101: DOUT <= 16'h003C;	// G#4 or Ab4
            6'b101110: DOUT <= 16'h0039;	// A4
            6'b101111: DOUT <= 16'h0036;	// A#4 or Bb4
            6'b110000: DOUT <= 16'h0033;	// B4
            6'b110001: DOUT <= 16'h0030;	// C5
            6'b110010: DOUT <= 16'h002D;	// C#5 or Db5
            6'b110011: DOUT <= 16'h002B;	// D5
            6'b110100: DOUT <= 16'h0028;	// D#5 or Eb5
            6'b110101: DOUT <= 16'h0026;	// E5
            6'b110110: DOUT <= 16'h0024;	// F5
            6'b110111: DOUT <= 16'h0022;	// F#5 or Gb5
            6'b111000: DOUT <= 16'h0020;	// G5
            6'b111001: DOUT <= 16'h001E;	// G#5 or Ab5
            6'b111010: DOUT <= 16'h001C;	// A5
            6'b111011: DOUT <= 16'h001B;	// A#5 or Bb5
            6'b111100: DOUT <= 16'h0019;	// B5
            6'b111101: DOUT <= 16'h0018;	// C6
            6'b111110: DOUT <= 16'h0017;	// C#6 or Db6
            6'b111111: DOUT <= 16'h0015;	// D6
            default:  DOUT <= 16'bx;
         endcase	 

endmodule


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    01:47:14 03/27/2008 
// Design Name: 
// Module Name:    array_P_ROM 
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
module Note32X8ROM(I,DOUT);

	
	input [4:0] I;
	output [7:0] DOUT;
	reg [7:0] DOUT;
 
   always @(I)
         case (I)
            5'b00000: DOUT <= 128;
            5'b00001: DOUT <= 120;
            5'b00010: DOUT <= 114;
            5'b00011: DOUT <= 107;
            5'b00100: DOUT <= 101;
            5'b00101: DOUT <= 96;
            5'b00110: DOUT <= 90;
            5'b00111: DOUT <= 85;
            5'b01000: DOUT <= 80;
            5'b01001: DOUT <= 76;
            5'b01010: DOUT <= 72;
            5'b01011: DOUT <= 68;
            5'b01100: DOUT <= 64;
            5'b01101: DOUT <= 60;
            5'b01110: DOUT <= 57;
            5'b01111: DOUT <= 54;
            5'b10000: DOUT <= 51;
            5'b10001: DOUT <= 48;
            5'b10010: DOUT <= 45;
            5'b10011: DOUT <= 43;
            5'b10100: DOUT <= 40;
            5'b10101: DOUT <= 38;
            5'b10110: DOUT <= 36;
            5'b10111: DOUT <= 34;
            5'b11000: DOUT <= 32;
            5'b11001: DOUT <= 30;
            5'b11010: DOUT <= 28;
            5'b11011: DOUT <= 27;
            5'b11100: DOUT <= 25;
            5'b11101: DOUT <= 24;
            5'b11110: DOUT <= 23;
            5'b11111: DOUT <= 21;
            default:  DOUT <= 8'bx;
         endcase	 

endmodule


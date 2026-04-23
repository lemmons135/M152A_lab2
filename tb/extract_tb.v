`timescale 1ns / 1ps

`include "extract.v"

module extract_tb();
    // Inputs to the module
    reg [11:0] M;
    // Outputs from the module
    wire [2:0] E_in;
    wire [3:0] F_in;
    wire fifth_bit;

    // Instantiate your module
    extract uut (
        .M(M), 
        .E_in(E_in), 
        .F_in(F_in), 
        .fifth_bit(fifth_bit)
    );

    initial begin
        $display("Testing Extract Module...");
        $display("M (Magnitude) | E_in | F_in | Fifth");
        $display("------------------------------------");

        // Test Case 1: 422 (3 leading zeros)
        M = 12'b000110100110; #10;
        $display("%b |  %d  | %b |   %b", M, E_in, F_in, fifth_bit);

        // Test Case 2: 4 leading zeros
        M = 12'b000011111000; #10;
        $display("%b |  %d  | %b |   %b", M, E_in, F_in, fifth_bit);

        // Test Case 3: Small number (Exponent 0)
        M = 12'b000000001010; #10;
        $display("%b |  %d  | %b |   %b", M, E_in, F_in, fifth_bit);

        $finish;
    end
endmodule
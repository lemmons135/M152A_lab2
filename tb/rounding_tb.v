`timescale 1ns / 1ps

// `include "rounding.v"

module rounding_tb;

    // Inputs
    reg [2:0] E_in;
    reg [3:0] F_in;
    reg fifth_bit;

    // Outputs
    wire [2:0] E;
    wire [3:0] F;

    // Instantiate the Unit Under Test (UUT)
    rounding uut (
        .E_in(E_in), 
        .F_in(F_in), 
        .fifth_bit(fifth_bit), 
        .E(E), 
        .F(F)
    );

    initial begin
        // Format the output display for readability
        $display("Time\t E_in\t F_in\t 5th\t | E_out\t F_out\t Note");
        $display("--------------------------------------------------------------");

        // Case 1: Round Down (fifth_bit is 0)
        E_in = 3'b010; F_in = 4'b1010; fifth_bit = 0;
        #10;
        $display("%0t\t %b\t %b\t %b\t | %b\t\t %b\t (Round Down)", $time, E_in, F_in, fifth_bit, E, F);

        // Case 2: Round Up Fraction (no exponent change)
        E_in = 3'b010; F_in = 4'b1010; fifth_bit = 1;
        #10;
        $display("%0t\t %b\t %b\t %b\t | %b\t\t %b\t (Round Up - Fraction)", $time, E_in, F_in, fifth_bit, E, F);

        // Case 3: Round Up with Fractional Overflow (Exponent increments)
        // 4'b1111 + 1 becomes 10000, shifts to 4'b1000, E increments
        E_in = 3'b010; F_in = 4'b1111; fifth_bit = 1;
        #10;
        $display("%0t\t %b\t %b\t %b\t | %b\t\t %b\t (Round Up - Exp Incr)", $time, E_in, F_in, fifth_bit, E, F);

        // Case 4: Max Saturation (Both E and F are at max, cannot round up)
        E_in = 3'b111; F_in = 4'b1111; fifth_bit = 1;
        #10;
        $display("%0t\t %b\t %b\t %b\t | %b\t\t %b\t (Max Saturation)", $time, E_in, F_in, fifth_bit, E, F);

        #10;
        $finish;
    end
      
endmodule
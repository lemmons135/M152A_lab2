/*
 * == Floating Point Convert Test Bench ==
 * Tests the fpcvt module.
 *
 * Inputs:  D_T[11:0]       12-bit integer linear encoding in two's complement
 *
 * Outputs: S_T             Sign bit for floating point output. 0 = positive, 1 = negative
 *          E_T[2:0]        Final (rounded) exponent of float, based on fifth bit. Represents number of leading zeroes in linear encoding
 *          F_T[3:0]        Final (rounded) significand of float, based on fifth bit
 */
`timescale 1ns / 1ps

`include "signed_magnitude.v"
`include "extract.v"
`include "rounding.v"
`include "fpcvt.v"

module fpcvt_tb;

    reg [11:0] D;
    wire S;
    wire [2:0] E;
    wire [3:0] F;
    
    // Variables for decimal calculation
    real float_val;

    // Instantiate the converter
    fpcvt uut (
        .D(D), 
        .S(S), 
        .E(E), 
        .F(F)
    );

    initial begin
        $display("-------------------------------------------------------------------------");
        $display("Input (Dec) | Hex  | S | E | F | Binary F | Float Decimal (F * 2^E)");
        $display("-------------------------------------------------------------------------");

        // Helper task to run a test and print results
        // This avoids repeating the calculation logic
        run_test(12'd0);      // Zero
        run_test(12'd15);     // Small positive (No rounding)
        run_test(12'd31);     // Boundary case
        run_test(12'd63);     // Should see rounding here
        run_test(12'd1023);   // Large positive
        run_test(-12'd1);     // -1 in 2's complement
        run_test(-12'd500);   // Large negative
        run_test(12'h7FF);    // Max positive 12-bit

        $finish;
    end

    task run_test(input [11:0] test_val);
        begin
            D = test_val;
            #10;
            // Formula: F * (2^E). We use S to determine the sign.
            // 1.0 * (1 << E) is a quick way to get 2^E in Verilog
            float_val = F * (1.0 * (1 << E));
            if (S) float_val = -float_val;

            $display("%d\t    | %h  | %b | %d | %d | %b     | %f", 
                     $signed(D), D, S, E, F, F, float_val);
        end
    endtask

endmodule
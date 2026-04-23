/*
 * == Floating Point Convert Module ==
 * Compresses a 12-bit, two's complement signed integer linear encoding to its non-linear 8-bit floating point representation,
 * with a (S)ign bit, 3 (E)xponent bits, and 4 Signi(F)icand bits.
 *
 * Inputs:  D[11:0]         12-bit integer linear encoding in two's complement
 *
 * Outputs: S               Sign bit for floating point output. 0 = positive, 1 = negative
 *          E[2:0]          Final (rounded) exponent of float, based on fifth bit. Represents number of leading zeroes in linear encoding
 *          F[3:0]          Final (rounded) significand of float, based on fifth bit
 */

module fpcvt (
    input [11:0] D,
    output S,
    output [2:0] E,
    output [3:0] F
);
    // Helper wires to connect the submodules
    wire [11:0] mag;
    wire [2:0] e_pre_round;
    wire [3:0] f_pre_round;
    wire fifth_bit;

    signed_magnitude sm_insn (
        // Inputs
        // D is the input to signed magnitude
        .D(D), 
        // Outputs
        // S is the sign bit, M is the magnitude
        .S(S), 
        .M(mag)
    );

    extract ex_insn (
        // Inputs
        // mag is the magnitude output from signed magnitude
        .M(mag),
        // Outputs
        // e_pre_round is the exponent before rounding, 
        // f_pre_round is the fraction before rounding, 
        // and fifth_bit is the bit that determines rounding
        .E_in(e_pre_round),
        .F_in(f_pre_round),
        .fifth_bit(fifth_bit)
    );

    rounding r_insn (
        // Inputs
        // e_pre_round is the exponent before rounding,
        // f_pre_round is the fraction before rounding,
        // and fifth_bit is the bit that determines rounding
        .E_in(e_pre_round),
        .F_in(f_pre_round),
        .fifth_bit(fifth_bit),
        // Outputs
        // E is the final exponent after rounding, 
        // and F is the final fraction after rounding
        .E(E),
        .F(F)
    );

endmodule
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

`include "extract.v"
`include "rounding.v"
`include "signed_magnitude.v"

module fpcvt (
    input reg [11:0] D,
    output reg S,
    output reg[2:0] E,
    output reg[3:0] F
);

always @(1)
    //TODO: implement combinational fpcvt logic
    S = 1'b0;
    E = 3'b0;
    F = 4'b0;

endmodule
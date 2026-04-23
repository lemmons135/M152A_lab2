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
    input [11:0] D,
    output S,          // Removed 'reg' because these are driven by module outputs
    output [2:0] E,
    output [3:0] F
);

wire [10:0] mag_val;
wire        sign_val;
wire [2:0]  extracted_E;
wire [3:0]  extracted_F;
wire        extra_bit;

signed_magnitude sm (
    .D(D),
    .S(sign_val),
    .M(mag_val)
);

extract ex (
    .M({1'b0, mag_val}), // Concatenating a 0 to make it 12-bit for your extract input
    .E_in(extracted_E),
    .F_in(extracted_F),
    .fifth_bit(extra_bit)
);

rounding r (
    .E_in(extracted_E),
    .F_in(extracted_F),
    .fifth_bit(extra_bit),
    .E(E),
    .F(F)
);

// 3. Drive the final sign output
assign S = sign_val;

endmodule
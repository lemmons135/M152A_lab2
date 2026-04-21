module signed_magnitude (
    input wire [11:0] D, // 12-bit signed magnitude input
    output wire S, // Sign bit (1 for negative, 0 for positive)
    output wire [3:0] E, // Exponent (4 bits)
    output wire [4:0] F // Fraction/significant/mantissa (5 bits)
);
    assign S = D[11];
    assign E = D[10:7];
    assign F = D[6:2];
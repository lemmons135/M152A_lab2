/*
 * == Signed Magnitude Module ==
 * Separates a 12-bit signed two's complement integer into its sign (0/1) and magnitude (unsigned integer)
 *
 * Inputs:  D[11:0]         12-bit integer linear encoding in two's complement
 *
 * Outputs: S               Sign bit for floating point output. 0 = positive, 1 = negative
 *          M[10:0]         Magnitude of 12-bit two's complement number
 */

module signed_magnitude (
    input [11:0] D,      // 12-bit two's complement input
    output reg S,        // Sign bit
    output reg [11:0] M  // 12-bit Magnitude
);

always @(*) begin
    S = D[11]; // The sign bit is the most significant bit
    if (S) begin
        M = ~D + 1'b1; // If negative, take the two's complement to get the magnitude
    end else begin
        M = D; // if positive, the magnitude is the remaining 11 bits
    end
end

endmodule
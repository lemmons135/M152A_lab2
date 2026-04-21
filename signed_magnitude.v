module signed_magnitude (
    input reg [11:0] D, // 12-bit signed magnitude input
    output reg S, // Sign bit (1 for negative, 0 for positive)
    output reg [10:0] M // Magnitude (11 bits for the absolute value of the number)
);

always @(*) begin
    S = D[11]; // The sign bit is the most significant bit
    M = D[10:0]; // The magnitude is the remaining 11 bits
end
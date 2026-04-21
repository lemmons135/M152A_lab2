/*
 * == Rounding Module ==
 * Rounds the exponent and significand up or down (with bias towards rounding up), producing final E/F.
 *
 * Inputs:  E_in[2:0]       Exponent, extracted from the unsigned integer magnitude
 *          F_in[3:0]       Significand, extracted from the four leading bits following the last leading zero
 *          fifth_bit       Fifth bit following the last leading zero in unsigned integer magnitude. 1 = round up, 0 = round down
 *
 * Outputs: E[2:0]          Final (rounded) exponent of float, based on fifth bit. Represents number of leading zeroes in linear encoding
 *          F[3:0]          Final (rounded) significand of float, based on fifth bit
 */

`include "extract.v"

module rounding (
    input reg [2:0] E_in, //3 bit exponent
    input reg [3:0] F_in, // 4 bit fraction
    input reg fifth_bit, // fifth bit after the last leading zero
    output reg [2:0] E,
    output reg [3:0] F
);

always @(*) begin
    if (fifth_bit) begin // fifth bit determines the rounding
    // --------------- ROUND UP -------------

        // Round Up Fraction
        if (F_in != 4'b1111) begin
            // We have room to round up the fraction
            F = F_in + 1; // Increment fraction
            E = E_in; // Keep exponent the same        
        end
        else if (E_in != 3'b111) begin
        // Round Up Exponente
            // Ifthe fraction is already at its maximum, we need to round up the exponent
            F = 4'b0000; 
            E = E_in + 1; // Increment exponent
        end  
        // No Rounding Possible
        else begin
            // If both the fraction and exponent are at their maximum,
            // we can't round up any further. We will just keep them as they are.
            F = F_in; // Keep fraction the same
            E = E_in; // Keep exponent the same
        end
    end
    // --------------- ROUND DOWN -------------
    else begin
    end
end
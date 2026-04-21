/*
 * == Extraction Module ==
 * Takes an unsigned integer, counts number of leading zeroes and extracts the leading bits. Extracts fifth bit past leading zeroes to determine rounding.
 *
 * Inputs:  M[10:0]         Magnitude of 12-bit two's complement number
 *
 * Outputs: E_in[2:0]       Exponent, extracted from the unsigned integer magnitude
 *          F_in[3:0]       Significand, extracted from the four leading bits following the last leading zero
 *          fifth_bit       Fifth bit following the last leading zero in unsigned integer magnitude. 1 = round up, 0 = round down
 */
 
module extract (
    
    M
)
'include "signed_magnitude"
input reg [10:0]  M;  

output reg [2:0] E_in;
output reg [3:0] F_in;
output reg fifth_bit;



i    for
//output is extracted leading zeros for exponent, 
//significand and fifth bit for rounding 


endmodule
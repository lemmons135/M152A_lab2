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
    input [11:0] M,  
    output reg [2:0] E_in,
    output reg [3:0] F_in,
    output reg fifth_bit
);
//`include "signed_magnitude.v"

always @(*) begin
        // We use casex to look for the first '1' bit
        casex (M)
            12'b1xxxxxxxxxxx: begin // case where M only has 1 leading 0's
                E_in = 3'b111;
                F_in = 4'b1111;
                fifth_bit = 1'b0;
            end            
            12'b01xxxxxxxxxx: begin // case where M only has 1 leading 0's
                E_in = 3'b111;
                F_in = M[10:7];
                fifth_bit = M[6];
            end
            12'b001xxxxxxxxx: begin // case where M only has 2 leading 0's
                E_in = 3'b110;
                F_in = M[9:6];
                fifth_bit = M[5];
            end
            12'b0001xxxxxxxx: begin // case where M only has 3 leading 0's
                E_in = 3'b101;
                F_in = M[8:5];
                fifth_bit = M[4];
            end
            12'b00001xxxxxxx: begin //  case where M only has 4 leading 0's
                E_in = 3'b100;
                F_in = M[7:4];
                fifth_bit = M[3];
            end
            12'b000001xxxxxx: begin // case where M only has 5 leading 0's
                E_in = 3'b011;
                F_in = M[6:3];
                fifth_bit = M[2];
            end
            12'b000001xxxxx: begin // case where M only has 6 leading 0's
                E_in = 3'b010;
                F_in = M[5:2];
                fifth_bit = M[1];
            end
            12'b0000001xxxx: begin // case where M only has 7 leading 0's
                E_in = 3'b001;
                F_in = M[4:1];
                fifth_bit = M[0];
            end
            // case where the Exponent 0 case (8 or more leading zeros)
            default: begin
                E_in = 3'b000;
                F_in = M[3:0];
                fifth_bit = 1'b0; // No 5th bit available here
            end
        endcase
    end

endmodule

//output is extracted leading zeros for exponent, 
//significand and fifth bit for rounding 
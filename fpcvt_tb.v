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


module fpcvt_t;    //testbench doesn't take any inputs!

//inputs
reg [11:0] D_T;

//outputs
reg S_T;
reg [2:0] E_T;
reg [3:0] F_T;

//make an instance of our top-level compression module
fpcvt UUT   (.D(D_T),
             .S(S_T),
             .E(E_T),
             .F(F_T));

integer i;

//TODO: write test cases

initial
    for (i = 21'h1FFFFF; i >= 0; i = i - 1)
    begin
        //TODO: test test cases
        D_T = D_T + 1;
    end
    $finish;

endmodule

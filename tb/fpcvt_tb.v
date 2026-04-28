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
 
`include "fpcvt.v"

module fpcvt_t;    //testbench doesn't take any inputs!

//inputs
reg [11:0] D_T;

//outputs
wire S_T;
wire [2:0] E_T;
wire [3:0] F_T;

//make an instance of our top-level compression module
fpcvt UUT   (.D(D_T),
             .S(S_T),
             .E(E_T),
             .F(F_T));

integer i;

//test cases
reg [11:0] test_cases [0:1023]; //12 bits wide to hold 12-bit input
integer num_tests;
reg [7:0] expected_val;         //hold expected output bits

initial begin
    //NOTE: readmemb treats all whitespace as newlines, which means test_cases is 1D
    //  and contains [<num tests>, <test 1 in>, <test 1 out>, ..., <test N in>, <test N out>]
    $readmemb("test_cases", test_cases);
    num_tests = test_cases[0];  //first line should indicate number of following lines in binary

    $display("Running %0d tests...", num_tests);
    
    for (i = 1; i <= num_tests; i = i + 1) begin
        // input is at (2*i - 1) and expected is at (2*i)
        D_T          = test_cases[2*i - 1]; 
        expected_val = test_cases[2*i][7:0]; 

        #1; //wait for combinational logic
        
        if (S_T === expected_val[7] && E_T === expected_val[6:4] && F_T === expected_val[3:0]) begin
            $display("%0d | %b | %b | %b%b%b | PASS", i, D_T, expected_val, S_T, E_T, F_T);
        end else begin
            $display("%0d | %b | %b | %b%b%b | FAIL", i, D_T, expected_val, S_T, E_T, F_T);
        end
    end
end

endmodule
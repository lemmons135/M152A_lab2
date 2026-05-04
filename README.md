## Requirements

Please install [Icarus Verilog](https://steveicarus.github.io/iverilog/usage/installation.html) for running simulation. On MacOS, you can use [Homebrew](https://brew.sh/) to install:

```
brew install icarus-verilog
```

## Build

Run this command in the root project directory to build and run fpcvt test bench:

```
iverilog *.v tb/*.v
./run
```

## Test

There are some provided test cases in `test_cases`. The binary format is as follows:

- Line 1 contains the **number of test cases** in binary. Must be **<= 1024**.
- Lines 2-N contain one test case, in the format "*<12-bit input D> <8-bit expected output S,E,F>*"

Here is an example:

```
0010
000000000000 00000000
111111111111 11111111
```

You can run these test cases on the high-level **fpcvt** module with `fpcvt_tb.v`.
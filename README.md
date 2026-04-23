## Requirements

Please install [Icarus Verilog](https://steveicarus.github.io/iverilog/usage/installation.html) for running simulation. On MacOS, you can use [Homebrew](https://brew.sh/) to install:

```
brew install icarus-verilog
```

## Build

Run this command in the root project directory to build the executable:

```
iverilog -o run tb/fpcvt_tb.v
```

Then execute that test bench with:

```
./run
```
# README.md

# RISC-V Bare Metal Project

This project demonstrates a minimal bare metal RISC-V program that runs on a RISC-V system with two harts. Hart 0 sends an interrupt to Hart 1 after performing its initial setup.

## Project Structure

```
riscv-bare-metal
├── src
│   ├── main.S      # Entry point of the program
│   ├── hart0.S     # Assembly code for hart 0
│   ├── hart1.S     # Assembly code for hart 1
│   └── link.ld     # Linker script defining memory layout
├── Makefile         # Build instructions
└── README.md        # Project documentation
```

## Building the Project

To build the project, ensure you have the RISC-V toolchain installed. Then, run the following command in the project root directory:

```
make
```

This will compile the source files and generate the executable `app.elf` in the `build` directory.

## Running the Program

To run the program on a RISC-V simulator or hardware, load the generated `app.elf` file into the appropriate environment. Ensure that the system is configured to support interrupts between harts.

## Files Overview

- **src/main.S**: Initializes the system and sets up the environment for the two harts, jumping to hart 0's code.
- **src/hart0.S**: Contains the code for hart 0, which sends an interrupt to hart 1 after setup.
- **src/hart1.S**: Handles the interrupt from hart 0 and executes its designated tasks.
- **src/link.ld**: Defines the memory layout for the program, including sections for text, data, and bss.
- **Makefile**: Contains the build instructions, compiler options, and linking flags.

## License

This project is licensed under the MIT License. See the LICENSE file for more details.
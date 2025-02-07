# rv-baremetal

This repository holds test I made to test RISC-V concepts.All test should
compile (`make`) and run on spike (`make run`) using the makefiles in the repo.

There is no guarantee, the programs might not be ideomatic, but they run and
trigger the desired effect.

## Docker

The dockerfile will build a RISCV toolchain, and install spike and the proxy
kernel to experiment further.

- `build.sh` build the docker image
- `run.sh` runs the container, mounting the current directory to the container.
- `util.sh` can be sourced, to use the function `dopen`, which is a shortcut to
the `run.sh` script basically

So, to run an example, first build the container, then source `util.sh`. Call
`dopen` which opens a shell in the container. In the container, call `make` to
build the example, and `make run` to run it in spike in debug mode.

## Virtual Memory

This is an old test I did last year to turn on the MMU and use virtual memory.
It is meant to rtun on a single HART. The program intializes the core,
populates page tables, set us the SATP register, and fianlly switches to user
mode to use virtual memory.

It is a bit impractical, as I decided to implement a direct mapping for the sake
of "simplicity". At the time, I recompiled spike with added `print` statements
in its page table walker to verify if the program worked. Now, it would be a
good exercise to implement indirect mapping to see an actual change in the
adrdess space. This should not be hard, as it can be implemented in C and
not assembly :)

## basic IPI

This is a more recent example, where HART 1 send and Inter-Processor-Interrupt
to HART0. HART 0 is only waiting for an interrupt.
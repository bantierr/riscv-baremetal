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

So, to run an example:
- first build the container (`./rv-only-docker/build.sh`),
- then source `./rv-only-docker/util.sh`.
- Use the `dopen` bash function (type `dopen` in your shell) which opens a shell
in the container, mounting the current directory.
- In the container, call `make` to build the example,
- and `make run` to run it in spike in debug mode.

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

## FESVR test

this test tries to use the riscv front end server, which works this way, the
register used to pass the bits is gp:
```
Fine, I'll take the bait. This was an experiment that got out of the lab. The HTIF is a tether between a simulation host and target, not something that's supposed to resemble a real hardware device. It's not a RISC-V standard; it's a UC Berkeley standard. You can still use Spike without using HTIF; you just need to link in your own I/O devices instead.

Here is a brief sketch of the tohost format, excluding some stuff that I don't think is immediately relevant:

    Bits 63:56 indicate the "device".
    Bits 55:48 indicate the "command".
    Device 0 is the syscall device, which is used to emulate Unixy syscalls. It only implements command 0, which has two subfunctions (for legacy reasons, sorry for the bad design):
        If bit 0 is clear, then bits 47:0 represent a pointer to a struct describing the syscall. The format of the syscall struct is pretty clear if you read the pk or fesvr code.
        If bit 1 is set, then bits 47:1 represent an exit code, with a zero value indicating success and other values indicating failure.
    Device 1 is the blocking character device.
        Command 0 reads a character
        Command 1 writes a character from the 8 LSBs of tohost

To answer @scottj97's question, the reason the LSB being set in his example didn't exit the program is that the command was targeted towards the blocking character device, not towards the syscall device.

You might notice the 64-bit orientation. For RV32, the tohost register is zero-extended, so only device=0 and command=0 (i.e. HTIF syscalls/exit codes) are supported.
```
It is now more stable, the thread is at: https://github.com/riscv-software-src/riscv-isa-sim/issues/364

### Detective work:

See handle_syscall at `riscv-isa-sim/fesvr/syscall.cc` line 207, the
"entry point" of such syscalls.

The struct describing the syscall is called magicmem, defined as:
```c
target_endian<reg_t> magicmem[8];
```

And, the structure of this struct is:
```c
magicmem[0] => Syscall number
magicmem[1..8] => Arguments to the syscall
```
In `riscv-isa-sim/fesvr/syscall.cc` you can find the implementation of the
syscalls.


You can try to set `li  gp,0x1` to li  `gp,0x11` and see that spike will tell
you your program has failed.




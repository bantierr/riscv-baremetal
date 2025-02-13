.section .text
.globl hart0
.align 2
hart0:
    # p.36, spec vII, An interrupt i will trap to M-mode (causing the privilege
    # mode to change to M-mode) if all of the following are true:

    # (a) the current privilege mode is M and the MIE bit in the mstatus
    # register is set
    csrrsi zero, mstatus, 0x8 # mie is bit 3 of mstatus

    # (b) bit i is set in both mip and mie
    # MIP set by hart 1
    csrrw zero, mie, 0x8

    # (c) if register mideleg exists, bit i is not set in mideleg.

    # set mtvec so we do not cause an exception
    la t0, hart0_task
    csrw mtvec, t0

    # Wait for interrupt from hart 0
    wfi                # Wait for interrupt

    j hart0_task

hart0_task:
    li  gp,0x1
    li	t5,0x80200000
    sw	gp,0(t5)
    j   hart0_task
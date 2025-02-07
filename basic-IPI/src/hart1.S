.equiv CLINT_BASE, 0x02000000

.section .text
    .globl hart1
    .align 2
hart1:
    li t0, CLINT_BASE + 0x0  # MSIP reg for hart 0
    li t1, 1

    sw t1, 0(t0)

    # Infinite loop to prevent hart 0 from exiting
loop:
    j loop


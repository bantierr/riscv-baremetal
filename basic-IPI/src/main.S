.section .text
  .globl _start
  .align 2
_start:
    # Boot sequence puts HartId in a0
    addi a1, zero, 0x0
    beq a0, a1, hart0

    addi a1, zero, 0x1
    beq a0, a1, hart1

.pushsection .tohost,"aw",@progbits
.align 6; .global tohost; tohost: .dword 0; .size tohost, 8;
.align 6; .global fromhost; fromhost: .dword 0; .size fromhost, 8
.popsection

.section .text.init
  .globl _start
  .align 2
_start:
    j write_tohost

write_tohost:
    li  gp,0x1
    li	t5,0x80200000
    sw	gp,0(t5)
    j   write_tohost

.pushsection .tohost,"aw",@progbits
.align 6; .global tohost; tohost: .dword 0; .size tohost, 8;
.align 6; .global fromhost; fromhost: .dword 0; .size fromhost, 8
        .popsection
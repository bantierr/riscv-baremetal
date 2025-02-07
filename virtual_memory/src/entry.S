#include "vm_setup.h"

#define STACK_TOP (_end + PAGE_SIZE * 4)
#define SIZEOF_TRAPFRAME_T 288

.equiv MASK_MPP_USER_MODE, 0xFFFFFFFFFFFFE7FF

  .section .text
  .globl _start
  .align 2
_start:
  j handle_reset

  .align 2
trap_vector:
  csrr t0, mcause
  j . #hmmmm wtf are we doing here, ok just make this clean now cause we dont switch, now it is an instruction page fault

handle_reset:
  li x1, 0
  li x2, 0
  li x3, 0
  li x4, 0
  li x5, 0
  li x6, 0
  li x7, 0
  li x8, 0
  li x9, 0
  li x10, 0
  li x11, 0
  li x12, 0
  li x13, 0
  li x14, 0
  li x15, 0
  li x16, 0
  li x17, 0
  li x18, 0
  li x19, 0
  li x20, 0
  li x21, 0
  li x22, 0
  li x23, 0
  li x24, 0
  li x25, 0
  li x26, 0
  li x27, 0
  li x28, 0
  li x29, 0
  li x30, 0
  li x31, 0

  #define machine mode trap vector
  la t0, trap_vector
  csrw mtvec, t0

  #define stack
  la sp, STACK_TOP - SIZEOF_TRAPFRAME_T

  #mscratch setup
  #csrr t0, mhartid
  #slli t0, t0, 12
  #add sp, sp, t0
  #csrw mscratch, sp
  
  #jump to c entry point
  jal boot_vm

  csrr t0, mstatus
  li t1, MASK_MPP_USER_MODE
  and t0, t0, t1 # Set MPP(machine previous priviledge) to user mode
  #or t0, t0, 8 # set MIE(machine interrupt enable)
  csrw mstatus, t0

  la t0, enter_user_mode
  csrw mepc, t0 # Set user mode entry address

  mret #xRET(U,S,M)

enter_user_mode:
    nop
    li t0, 2
    li t1, 3
    add t0, t0, t1 #do a basic operation

    li t0, 0x80001000
    li t1, 42       
    ld t2, 0(t0)

    j . #jumps to current pc, loops to stop not so gracefully

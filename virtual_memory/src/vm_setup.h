#ifndef VM_SETUP_H
#define VM_SETUP_H

/*
======== MACROS ========
*/

#define PAGE_SIZE 4096
#define NR_PAGES 1
#define DRAM_BASE 0x80000000
#define PTE_BASE 0x00000000

/* page table entry (PTE) fields */
#define PTE_V     0x001 /* Valid */
#define PTE_R     0x002 /* Read */
#define PTE_W     0x004 /* Write */
#define PTE_X     0x008 /* Execute */
#define PTE_U     0x010 /* User */
#define PTE_G     0x020 /* Global */
#define PTE_A     0x040 /* Accessed */
#define PTE_D     0x080 /* Dirty */
#define PTE_SOFT  0x300 /* Reserved for Software */
#define PTE_RSVD  0x1FC0000000000000 /* Reserved for future standard use */
#define PTE_PBMT  0x6000000000000000 /* Svpbmt: Page-based memory types */
#define PTE_N     0x8000000000000000 /* Svnapot: NAPOT translation contiguity */
#define PTE_ATTR  0xFFC0000000000000 /* All attributes and reserved bits */

#define PMP_R     0x01
#define PMP_W     0x02
#define PMP_X     0x04
#define PMP_A     0x18
#define PMP_L     0x80
#define PMP_SHIFT 2

#define PMP_TOR   0x08
#define PMP_NA4   0x10
#define PMP_NAPOT 0x18

#define PTE_PPN_SHIFT 10
#define PGSHIFT 0xC

#define SATP_MODE_SV39 8


/*  CSR reg functions */
#define read_csr(reg) ({ unsigned long __tmp; \
  asm volatile ("csrr %0, " #reg : "=r"(__tmp)); \
  __tmp; })

#define write_csr(reg, val) ({ \
  asm volatile ("csrw " #reg ", %0" :: "rK"(val)); })

#define swap_csr(reg, val) ({ unsigned long __tmp; \
  asm volatile ("csrrw %0, " #reg ", %1" : "=r"(__tmp) : "rK"(val)); \
  __tmp; })

#define set_csr(reg, bit) ({ unsigned long __tmp; \
  asm volatile ("csrrs %0, " #reg ", %1" : "=r"(__tmp) : "rK"(bit)); \
  __tmp; })

#define clear_csr(reg, bit) ({ unsigned long __tmp; \
  asm volatile ("csrrc %0, " #reg ", %1" : "=r"(__tmp) : "rK"(bit)); \
  __tmp; })


#ifndef __ASSEMBLER__ //avoid compilation issues
/*
======== FUNCTIONS ========
*/


#endif


#endif //VM_SETUP_H
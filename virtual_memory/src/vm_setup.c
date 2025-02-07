#include <stdint.h>
#include "vm_setup.h"

uint64_t pt[PAGE_SIZE] __attribute__((aligned(PAGE_SIZE))); //declare one page, we use direct mapping so one level

int boot_vm()
{
    //populate the pte
    //populate_pt();
    uint64_t current_addr = PTE_BASE;
    for(int entry = 0; entry < PAGE_SIZE/8; entry += 1)
    {
        uint64_t cur_pte = 0;
        cur_pte |= (PTE_R | PTE_W | PTE_X); //set the chosen rwx priviledges
        cur_pte |= PTE_U; //user can access
        //cur_pte |= PTE_G; //make mapping global
        cur_pte |= PTE_V; //pte is valid
        cur_pte |= (PTE_A); //set valid and dirty bits
        cur_pte |= ((current_addr >> PGSHIFT) << PTE_PPN_SHIFT);

        pt[entry] = cur_pte;

        current_addr += 0x40000000; //hackerman is a superpage, 0x40000000 GB
    }

    //set the satp register
    uint64_t satp_mode = (uint64_t)(SATP_MODE_SV39) << 60;
    uint64_t satp_addr = (uint64_t)pt >> PGSHIFT; //this is not 44 bits wide :(, well it is but still
    uint64_t satp_val = satp_addr | satp_mode;
    write_csr(satp, satp_val);

    return 0;
}


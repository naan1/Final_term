// entry.S
.section .text.init
.global _start

_start:
   la sp, _stack_top
   li t0, 3 << 11
   csrw mstatus, t0
   la t0, trap_vector
   ori t0, t0, 1
   csrw mtvec, t0
   li t0, 0x880
   csrw mie, t0
   j core_main

.align 4
trap_vector:
   addi sp, sp, -32*4

   sw x1,  1*4(sp)
   sw x2,  2*4(sp)
   sw x3,  3*4(sp)
   sw x4,  4*4(sp)
   sw x5,  5*4(sp)
   sw x6,  6*4(sp)
   sw x7,  7*4(sp)
   sw x8,  8*4(sp)
   sw x9,  9*4(sp)
   sw x10, 10*4(sp)
   sw x11, 11*4(sp)
   sw x12, 12*4(sp)
   sw x13, 13*4(sp)
   sw x14, 14*4(sp)
   sw x15, 15*4(sp)
   sw x16, 16*4(sp)
   sw x17, 17*4(sp)
   sw x18, 18*4(sp)
   sw x19, 19*4(sp)
   sw x20, 20*4(sp)
   sw x21, 21*4(sp)
   sw x22, 22*4(sp)
   sw x23, 23*4(sp)
   sw x24, 24*4(sp)
   sw x25, 25*4(sp)
   sw x26, 26*4(sp)
   sw x27, 27*4(sp)
   sw x28, 28*4(sp)
   sw x29, 29*4(sp)
   sw x30, 30*4(sp)
   sw x31, 31*4(sp)

   csrr a0, mcause
   csrr a1, mepc
   call handle_trap

   lw x1,  1*4(sp)
   lw x2,  2*4(sp)
   lw x3,  3*4(sp)
   lw x4,  4*4(sp)
   lw x5,  5*4(sp)
   lw x6,  6*4(sp)
   lw x7,  7*4(sp)
   lw x8,  8*4(sp)
   lw x9,  9*4(sp)
   lw x10, 10*4(sp)
   lw x11, 11*4(sp)
   lw x12, 12*4(sp)
   lw x13, 13*4(sp)
   lw x14, 14*4(sp)
   lw x15, 15*4(sp)
   lw x16, 16*4(sp)
   lw x17, 17*4(sp)
   lw x18, 18*4(sp)
   lw x19, 19*4(sp)
   lw x20, 20*4(sp)
   lw x21, 21*4(sp)
   lw x22, 22*4(sp)
   lw x23, 23*4(sp)
   lw x24, 24*4(sp)
   lw x25, 25*4(sp)
   lw x26, 26*4(sp)
   lw x27, 27*4(sp)
   lw x28, 28*4(sp)
   lw x29, 29*4(sp)
   lw x30, 30*4(sp)
   lw x31, 31*4(sp)

   addi sp, sp, 32*4
   mret

.global switch_context
switch_context:
   addi sp, sp, -13*4
   sw ra,  0*4(sp)
   sw s0,  1*4(sp)
   sw s1,  2*4(sp)
   sw s2,  3*4(sp)
   sw s3,  4*4(sp)
   sw s4,  5*4(sp)
   sw s5,  6*4(sp)
   sw s6,  7*4(sp)
   sw s7,  8*4(sp)
   sw s8,  9*4(sp)
   sw s9,  10*4(sp)
   sw s10, 11*4(sp)
   sw s11, 12*4(sp)

   sw sp, 0(a0)
   lw sp, 0(a1)

   lw ra,  0*4(sp)
   lw s0,  1*4(sp)
   lw s1,  2*4(sp)
   lw s2,  3*4(sp)
   lw s3,  4*4(sp)
   lw s4,  5*4(sp)
   lw s5,  6*4(sp)
   lw s6,  7*4(sp)
   lw s7,  8*4(sp)
   lw s8,  9*4(sp)
   lw s9,  10*4(sp)
   lw s10, 11*4(sp)
   lw s11, 12*4(sp)

   addi sp, sp, 13*4
   ret

// core.h
#pragma once
#include <stdint.h>

#define NUM_TASKS 4
#define STACK_SIZE 1024
#define UART0_BASE 0x10000000

typedef struct {
   uint32_t* volatile sp;
   uint32_t* stack_start;
   void (*entry)(void);
   int id;
} task_t;

// CSR functions
static inline uint32_t read_csr_mstatus(void) {
   uint32_t value;
   asm volatile("csrr %0, mstatus" : "=r"(value));
   return value;
}

static inline uint32_t read_csr_mie(void) {
   uint32_t value;
   asm volatile("csrr %0, mie" : "=r"(value));
   return value;
}

// Debug functions
static inline void print_char(char c) {
   volatile uint32_t *uart = (uint32_t*)UART0_BASE;
   while ((uart[5] & (1 << 5)));
   uart[0] = c;
}

static inline void print_str(const char *s) {
   while (*s) print_char(*s++);
}

// External functions
extern void switch_context(uint32_t** old_sp, uint32_t** new_sp);

// Global variables
extern volatile task_t tasks[NUM_TASKS];
extern volatile task_t *current_task;
extern volatile uint64_t ticks;

// Function declarations
void init_tasks(void);
void schedule(void);
void task_yield(void);
void timer_init(void);
void handle_trap(uint32_t mcause, uint32_t mepc);
void uart_init(void);
void uart_putc(char c);
void uart_puts(const char *s);
void task1(void);
void task2(void);

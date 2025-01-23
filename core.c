// core.c
#include "core.h"

volatile task_t tasks[NUM_TASKS];
volatile task_t *current_task;
volatile uint64_t ticks;

static uint32_t task_stacks[NUM_TASKS][STACK_SIZE];

void timer_init(void) {
   volatile uint32_t *mtime = (uint32_t*)0x0200BFF8;
   volatile uint32_t *mtimecmp = (uint32_t*)0x02004000;
   *mtimecmp = *mtime + 10000;
}

void handle_trap(uint32_t mcause, uint32_t mepc) {
   print_str("Trap: ");
   if (mcause & 0x80000000) {
       if ((mcause & 0x7ff) == 7) {
           print_str("Timer\n");
           timer_init();
           schedule();
       }
   } else if ((mcause & 0x7ff) == 11) {
       print_str("Yield\n");
       schedule();
   }
}

void schedule(void) {
   print_str("Schedule: ");
   const int next = (current_task->id + 1) % NUM_TASKS;
   volatile task_t *next_task = &tasks[next];
   volatile task_t *prev = current_task;
   current_task = next_task;
   switch_context((uint32_t**)&prev->sp, (uint32_t**)&next_task->sp);
}

void init_tasks(void) {
   print_str("Init tasks\n");
   for(int i = 0; i < NUM_TASKS; i++) {
       tasks[i].id = i;
       tasks[i].stack_start = &task_stacks[i][STACK_SIZE-1];
       tasks[i].sp = tasks[i].stack_start;
       tasks[i].entry = (i == 0) ? task1 : task2;

       tasks[i].sp = tasks[i].stack_start;
       *(tasks[i].sp--) = (uint32_t)tasks[i].entry;
       *(tasks[i].sp--) = 0x1880;
       tasks[i].sp -= 31;
   }
   current_task = &tasks[0];
}

void uart_init(void) {
   volatile uint32_t *uart = (uint32_t*)UART0_BASE;
   uart[1] = 0x00;
   uart[3] = 0x03;
   uart[2] = 0x01;
   print_str("UART init done\n");
}

void task_yield(void) {
   asm volatile("ecall");
}

// test.c
#include "core.h"

void task1(void) {
   while(1) {
       print_str("Task 1\n");
       for(volatile int i = 0; i < 100000; i++);
       task_yield();
   }
}

void task2(void) {
   while(1) {
       print_str("Task 2\n");
       for(volatile int i = 0; i < 100000; i++);
       task_yield();
   }
}

void core_main(void) {
   print_str("Core init\n");
   uart_init();
   init_tasks();
   timer_init();
   asm volatile("csrsi mstatus, 8");
   print_str("Start scheduler\n");
   while(1) {}
}

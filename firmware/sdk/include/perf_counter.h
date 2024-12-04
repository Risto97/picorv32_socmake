#ifndef __PERF_COUNTER_H__
#define __PERF_COUNTER_H__

unsigned long read_cycles(void)
{
    unsigned long cycles;
    asm volatile ("rdcycle %0" : "=r" (cycles));
    return cycles;
}

#endif // !__PERF_COUNTER_H__

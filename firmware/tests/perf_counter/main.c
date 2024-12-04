#include <stdint.h>
#include "sim_print.h"
#include "perf_counter.h"

int main(void)
{
    for(int i = 0; i < 100000; i++){
        print_str("Perf counter: ");	
        volatile uint32_t cycles = read_cycles();
        print_hex(cycles);
        print_str("\n");	
    }
    return 0;
}

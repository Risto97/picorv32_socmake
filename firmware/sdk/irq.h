// Modified from https://github.com/enjoy-digital/litex/blob/master/litex/soc/cores/cpu/picorv32/irq.h

#ifndef _IRQ_H
#define _IRQ_H

#include <stdint.h>

extern uint32_t _irq_pending;
extern uint32_t _irq_mask;
extern uint32_t _irq_handler;
extern uint32_t _irq_enabled;

extern "C" void _irq_enable();
extern "C" void _irq_disable();
extern "C" void _irq_setmask(uint32_t);

 static inline void irq_set_state(bool ie)
{
    if (ie == true)
        _irq_enable();
    else
        _irq_disable();
}

static inline uint32_t irq_getmask(void)
{
    // PicoRV32 interrupt mask bits are high-disabled. This is the inverse of how
    // LiteX sees things.
    return ~_irq_mask;
}

static inline void irq_setmask(uint32_t mask)
{
    // PicoRV32 interrupt mask bits are high-disabled. This is the inverse of how
    // LiteX sees things.
    _irq_setmask(~mask);
}

static inline uint32_t irq_pending(void)
{
	return _irq_pending;
}


static inline void register_irq_handler(void(*irq_handler)(uint32_t,uint32_t*)) {
    _irq_handler = (uintptr_t)irq_handler;
}

#endif



#define __STDOUT_ADDR (*(volatile uint32_t*)0x10000000)

void putchar(char c)
{
	if (c == '\n')
		putchar('\r');
	__STDOUT_ADDR = c;
}

void print_str(const char *p)
{
	while (*p)
		putchar(*(p++));
}

void print_hex(unsigned int val) {
    int digits = 8;
    for (int i = (4 * digits) - 4; i >= 0; i -= 4)
        __STDOUT_ADDR = "0123456789ABCDEF"[(val >> i) % 16];
}

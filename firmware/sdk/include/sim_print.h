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

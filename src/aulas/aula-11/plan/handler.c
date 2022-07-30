volatile unsigned int *const TIMER0X = (unsigned int *)0x101E200c;
volatile unsigned int *const UART0DR = (unsigned int *)0x101f1000;
 
void print_uart0(const char *s)
{
    while(*s != '\0') /* Loop until end of string */
    {
        *UART0DR = (unsigned int)(*s); /* Transmit char */
        s++; /* Next char */
    }
}

void handler_timer()
{
    print_uart0("#");
    *TIMER0X = 0x0;
}

void entry()
{
    print_uart0("Hello World!\n");
}

void idle()
{
    print_uart0(" ");
}


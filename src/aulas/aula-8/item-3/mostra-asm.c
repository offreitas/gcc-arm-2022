#include <stdio.h>

int mostra;

int main()
{
    __asm__(
        "ldr     r3, .L2\n\t"
        "mov     r2, #1\n\t"
        "str     r2, [r3, #0]\n\t"
    );

    printf("%d\n", mostra);

    return 0;
}

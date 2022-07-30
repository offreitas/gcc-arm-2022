#include <stdio.h>

extern void int2str(int num, char* pontstr);
void impstr(char *pont);

char straluno[100];

int main()
{
    __asm__
    (
        "pronto: nop\n\t"
    );

    int2str(149, straluno);
    impstr(straluno);

    __asm__
    (
        "fim: nop\n\t"
    );

    return 0;
}

void impstr(char *pont)
{
    // add initial label
    __asm__
    ( 
        "inic_imprime: nop\n\t"
    );

    // call recursively
    if (pont[0] != 0)
    {
        // print character
        printf("%c\n", pont[0]);
     
        impstr(pont+1);
    }

    // add final label
    __asm__
    ( 
        "fim_imprime: nop\n\t"
    );

    return;
}

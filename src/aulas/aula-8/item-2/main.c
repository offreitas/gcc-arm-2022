#include <stdio.h>
#include <string.h>

extern void int2str(int num, char* pontstr);
void impnum(int num);

char straluno[100];
					
int main()
{
	impnum(11261249);
	
    return 0;
}

void impnum(int num)
{
    int2str(num, straluno);
    
    puts(straluno);
}

#include <stdio.h>

//declared to avoid warning `-Wimplicit-function-declaration`
int scheme_entry();

int main(int argc, char **argv)
{
    printf("%d\n", scheme_entry());
    return 0;
}
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <setjmp.h>

static void catch_divide_by_zero(int signo) {
    printf("Divide by zero exception %d\n", signo);
    exit(1);
}

static void generic_interrupt_handler(int signo) {
    printf("handle generic interrupt %d\n", signo);
    // exit(1);
}

int main(void) {

    //  interrupt
    if (signal(SIGINT, generic_interrupt_handler) == SIG_ERR) {
        printf("Error in catching signal\n");
    }

    //  floating point exception
    if (signal(SIGFPE, catch_divide_by_zero) == SIG_ERR) {
        printf("Error in catching signal\n");
    }

    puts("raise the attention signal");
    if (raise(SIGINT) != 0) {
        printf("Error in raising signal\n");
    }

    // divide by zero
    int a = 10;
    int b = 0;
    int c;
    // if (b == 0) {
    //     printf(stderr, "Divide by zero\n");
    //     exit(EXIT_FAILURE);
    // }
    c = a / b;
    exit(EXIT_SUCCESS);


    // return 0;
}

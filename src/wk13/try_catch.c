#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <setjmp.h>

#define TRY do { jmp_buf ex_buf__; if (setjmp(ex_buf__) == 0) {
#define CATCH } else {
#define END_TRY } } while (0)
#define THROW longjmp(ex_buf__, 1)

#define EXCEPTION1 1
#define EXCEPTION2 2
#define EXCEPTION3 3

int main(void) {

    // generic try catch
    TRY {
        printf("In TRY block\n");
        THROW;
        printf("This will not be executed\n");
    } CATCH {
        printf("Caught exception\n");
    } END_TRY;

    // try catch with exception
    TRY {
        printf("In TRY block\n");
        // THROW(EXCEPTION1);
        THROW;
        printf("This will not be executed\n");
    } CATCH {
        printf("Caught exception 1\n");
    } END_TRY;



    return 0;
}
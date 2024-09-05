#include <stdio.h>

int main() {
    /*
     * idea:
     *    a car travels 70mph
     *    how many miles can it travel in 6hrs?
     *    how many miles can it travel in 10hrs?
     *    how many miles can it travel in 15hrs?
     */

    const int speed = 70;

    int time = 6;
    int distance = speed * time;
    printf("The car can travel %d miles in %d hours\n", distance, time);

    time = 10;
    distance = speed * time;
    printf("The car can travel %d miles in %d hours\n", distance, time);

    time = 15;
    distance = speed * time;
    printf("The car can travel %d miles in %d hours\n", distance, time);

    return 0;
}
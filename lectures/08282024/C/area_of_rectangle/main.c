#include "stdio.h"

int main() {
    int length, width;

    // area of a rectangle
    printf("enter length: ");
    scanf("%d", &length);
    printf("enter width: ");
    scanf("%d", &width);
    int area = length * width;
    printf("Area of a rectangle: %d\n", area);

    return 0;
}

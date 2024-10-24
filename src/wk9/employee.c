#include <stdio.h>

struct person {
	int age;
	int pay;
	int class;
};

typedef struct person EMPLOYEE;

void printStruct(EMPLOYEEE);

int main(void) {
	EMPLOYEE a;

	a.age = 25;
	a.pay = 1000;
	a.class = 1;

	printStruct(a);
}

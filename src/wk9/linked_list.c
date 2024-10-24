#include <stdio.h>
#include <stdlib.h>

struct node {
	int data;
	struct node *next;
};

void add_head(struct node *head, int data) {
	struct node *new_node = malloc(sizeof(struct node));
	new_node->data = data;
	new_node->next = head;
	head = new_node;
}

void add_tail(struct node *head, int data) {
	struct node *new_node = malloc(sizeof(struct node));
	new_node->data = data;
	new_node->next = NULL;

	struct node *current = head;
	while (current->next != NULL) {
		current = current->next;
	}
	current->next = new_node;
}

void remove_head(struct node *head) {
	struct node *temp = head->next;
	head->next = head->next->next;
	free(temp);
}

void remove_tail(struct node *head) {
	struct node *current = head;
	while (current->next->next != NULL) {
		current = current->next;
	}
	free(current->next);
	current->next = NULL;
}

void print_list(struct node *head) {
	struct node *current = head;
	while (current != NULL) {
		printf("%d ", current->data);
		current = current->next;
	}
	printf("\n");
}


int main(void) {
	struct node *head = malloc(sizeof(struct node));

	add_head(head, 1);
	add_tail(head, 2);
	add_tail(head, 3);
	add_tail(head, 4);
	add_tail(head, 5);
	print_list(head);

	remove_head(head);
	print_list(head);

	remove_tail(head);
	print_list(head);



	return 0;
}
#include <stdio.h>
#include <stdlib.h>

struct Node {
    int iValue;
    float fValue;
    struct Node *next;
};

int main() {

    struct Node *head = (struct Node*) malloc(sizeof(struct Node));
    head->iValue = 5;
    head->fValue = 3.14;
	
	// Insert code here
    printf("head points to: %p\n", (void*)head);
    printf("iValue: %d\n", head->iValue);
    printf("fValue: %f\n", head->fValue);
    printf("Address of head (pointer itself): %p\n", (void*)&head);
    printf("Address of iValue: %p\n", (void*)&head->iValue);
    printf("Address of fValue: %p\n", (void*)&head->fValue);
    printf("Address of next: %p\n", (void*)&head->next);
	
	return 0;
}
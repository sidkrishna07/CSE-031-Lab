#include <stdio.h>
#include <stdlib.h>
// #include <malloc.h> COMMENTED CAUSES ERRORS

 int main() {
	int num;
	int *ptr;
	int **handle;

	num = 14;
	ptr = (int *) malloc(2 * sizeof(int));
	*ptr = num;
	handle = (int **) malloc(1 * sizeof(int *));
	*handle = ptr;

// Insert code here
	printf("%p\n", (void*)&num);
	printf("%p\n", (void*)ptr);
	printf("%p\n", (void*)handle);
	printf("%p\n", (void*)&ptr);
	printf("%p\n", (void*)&handle);

	return 0;
} 

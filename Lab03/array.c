#include <stdio.h>
#include <stdlib.h>

//#include <malloc.h>  REMOVED CAUSES ERROR WHEN RUNNING PROGRAM

int* bubbleSort(int arr[], int n) {
    int temp, i = 0, j = 0;
    int *s_arr = (int *) malloc(n * sizeof(int));

    // Copy arr to s_arr
    for(i = 0; i < n; i++)
        *(s_arr + i) = *(arr + i); // Using pointer notation for copying

    // Original sorting code using array notation (commented out)
    /*
    for (i = 0; i < n - 1; i++) {
        for(j = 0; j < n - 1; j++) {
            if(s_arr[j] > s_arr[j + 1]) {
                temp = s_arr[j + 1];
                s_arr[j + 1] = s_arr[j];
                s_arr[j] = temp;
            }
        }
    }
    */




    // MODIFIED CODE HERE //
    //ONLY DIFFERENCE TO THE CODE ABOVE IS POINTERS ADDED WITH * SIGN//
    for (i = 0; i < n - 1; i++) {
        for(j = 0; j < n - 1; j++) {
            if(*(s_arr + j) > *(s_arr + j + 1)) {
                temp = *(s_arr + j + 1);
                *(s_arr + j + 1) = *(s_arr + j);
                *(s_arr + j) = temp;
            }
        }
    }

    return s_arr;
}

// END OF CODE CHANGES HERE//







void printArray(int arr[], int n) {
    int i = 0;
    printf("[");
    for(i = 0; i < n; i++)
        printf("%d ", *(arr + i)); // Using pointer notation for printing
    printf("]\n");
}

int bSearch(int *arr, int left, int right, int key) {
    if (right < left) {
        return -1; 
    }

    int mid = left + (right - left) / 2;
    int midValue = *(arr + mid);

    if (midValue == key) {
        return mid;
    } else if (midValue > key) {
 
        return bSearch(arr, left, mid - 1, key);
    } else {
        return bSearch(arr, mid + 1, right, key);
    }
}


int main() {
    int i = 0, size = 0, key = 0, result = 0;
    int *array, *sorted;

    printf("How big is your array?  ");
    scanf("%d", &size);
    array = (int *) malloc(size * sizeof(int));

    for(i = 0; i < size; i++) {
        printf("Please enter array[%d]:  ", i);
        scanf("%d", &array[i]);
    }

    printf("Please wait while I sort your numbers...\n");
    sorted = bubbleSort(array, size);
    printf("Here is your original array:\n");
    printArray(array, size);
    printf("Here is your SORTED array: \n");
    printArray(sorted, size);
    printf("What number are you looking for? ");
    scanf("%d", &key);
    printf("OK, let me see if I can find a \"%d\" in the array...\n", key);
    result = bSearch(sorted, 0, size-1, key);
    if(result != -1)
        printf("Got it! A \"%d\" is at index %d.\n", key, result);
    else
        printf("I'm sorry, a \"%d\" cannot be found in the array.\n", key);

    return 0;
}

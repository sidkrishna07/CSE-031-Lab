#include <stdio.h>

int main() {
    int num, count = 0;

    float evenSum = 0, oddSum = 0;

    int evenCount = 0, oddCount = 0;

    while (1) {
        count++;
        
        printf("Enter the %d%s value: ", count, 
               count % 10 == 1 && count % 100 != 11 ? "st" : 
               count % 10 == 2 && count % 100 != 12 ? "nd" : 
               count % 10 == 3 && count % 100 != 13 ? "rd" : "th");

        scanf("%d", &num);
        if (num == 0) break;

        int sum = 0, temp = num > 0 ? num : -num;
        while (temp > 0) {
            sum += temp % 10;
            temp /= 10;
        }

        if (sum % 2 == 0) {
            evenSum += num;
            evenCount++;
        } else {
            oddSum += num;
            oddCount++;
        }
    }

    printf("\n");

    if (evenCount > 0)
        printf("Average of input values whose digits sum up to an even number: %.2f\n", evenSum / evenCount);

    if (oddCount > 0)
        printf("Average of input values whose digits sum up to an odd number: %.2f\n", oddSum / oddCount);

    if (evenCount == 0 && oddCount == 0)
        printf("There is no average to compute.\n");

    return 0;
}
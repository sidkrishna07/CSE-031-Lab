#include <stdio.h>
#include <string.h>

char* append(char s1[], char s2[]) {
    int s1len = strlen(s1);
    int s2len = strlen(s2);
    for (int k = 0; k < s2len; k++) {
        s1[k + s1len] = s2[k];
    }
    s1[s1len + s2len] = '\0';
    return s1;
}

int main() {
    char str1[20];  
    char str2[20];  
    while (1) {
        memset(str1, 0, sizeof(str1)); 

        printf("str1 = ");
        scanf("%19[^\n]%*c", str1);  

        printf("str2 = ");
        scanf("%19[^\n]%*c", str2);  

        printf("The result of appending str2 to str1 is %s.\n", append(str1, str2));
    }
    return 0;
}

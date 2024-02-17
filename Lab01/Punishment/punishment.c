#include <stdio.h>

int main() {
    int repCount = 0;

    int linewtypo = 0;

    int linenumber;

    printf("Enter the repetition count for the punishment phrase: ");

    scanf("%d", &repCount);

    printf("\n");

    while(repCount <= 0) {
        printf("You entered an invalid value for the repetition count! Please re-enter: ");
        scanf("%d", &repCount);
    }

    printf("Enter the line where you want to insert the typo: ");
    
    scanf("%d", &linewtypo);

    while(linewtypo <= 0 || linewtypo > repCount) {
        printf("You entered an invalid value for the typo placement! Please re-enter: ");
        scanf("%d", &linewtypo);
    }

    printf("\n"); 

    
    for(linenumber = 1; linenumber <= repCount; linenumber++) {
        if(linenumber == linewtypo) {
            printf("Cading wiht is C avesone!\n");
        } else {
            printf("Coding with C is awesome!\n");
        }
    }

    return 0;
}

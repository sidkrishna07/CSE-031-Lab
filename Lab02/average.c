#include <stdio.h>

int read_values(double *sum) {
  int values = 0, input = 0;
  *sum = 0; 
  printf("Enter input values (enter 0 to finish):\n");
  scanf("%d", &input);
  while(input != 0) {
    values++;
    *sum += input; 
    scanf("%d", &input);
  }
  return values;
}

int main() {
  double sum = 0;
  int values;

  values = read_values(&sum);

  if (values > 0) {
    printf("\nAverage: %g\n", sum/values);
  } else {
    printf("\nNo valid inputs were entered.\n");
  }

  return 0;
}

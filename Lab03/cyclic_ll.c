#include <stdio.h>

typedef struct node {
  int value;
  struct node *next;
} node;


//CHANGES MADE TO CODE FROM HERE//

int has_cycle(node *head) {
  if (head == NULL || head->next == NULL) {
    return 0; 
  }

  node* ptr = head;
  node* ptr2 = head; 

  while (ptr2 != NULL && ptr2->next != NULL) {
    ptr = ptr->next; 
    ptr2 = ptr2->next->next; 

    if (ptr == ptr2) {
      return 1; 
    }
  }

  return 0; 
}

// END OF CHANGES MADE TO CODE//


void test_has_cycle(void) {
  int i;
  node nodes[25]; //enough to run our tests
  for(i=0; i < sizeof(nodes)/sizeof(node); i++) {
    nodes[i].next = 0;
    nodes[i].value = 0;
  }
  nodes[0].next = &nodes[1];
  nodes[1].next = &nodes[2];
  nodes[2].next = &nodes[3];
  printf("Checking first list for cycles. There should be none, has_cycle says it has %s cycle\n",
    has_cycle(&nodes[0])?"a":"no");
  
  nodes[4].next = &nodes[5];
  nodes[5].next = &nodes[6];
  nodes[6].next = &nodes[7];
  nodes[7].next = &nodes[8];
  nodes[8].next = &nodes[9];
  nodes[9].next = &nodes[10];
  nodes[10].next = &nodes[4];
  printf("Checking second list for cycles. There should be a cycle, has_cycle says it has %s cycle\n",
    has_cycle(&nodes[4])?"a":"no");
  
  nodes[11].next = &nodes[12];
  nodes[12].next = &nodes[13];
  nodes[13].next = &nodes[14];
  nodes[14].next = &nodes[15];
  nodes[15].next = &nodes[16];
  nodes[16].next = &nodes[17];
  nodes[17].next = &nodes[14];
  printf("Checking third list for cycles. There should be a cycle, has_cycle says it has %s cycle\n",
    has_cycle(&nodes[11])?"a":"no");
  
  nodes[18].next = &nodes[18];
  printf("Checking fourth list for cycles. There should be a cycle, has_cycle says it has %s cycle\n",
    has_cycle(&nodes[18])?"a":"no");
  
  nodes[19].next = &nodes[20];
  nodes[20].next = &nodes[21];
  nodes[21].next = &nodes[22];
  nodes[22].next = &nodes[23];
  printf("Checking fifth list for cycles. There should be none, has_cycle says it has %s cycle\n",
    has_cycle(&nodes[19])?"a":"no");
  
  printf("Checking length-zero list for cycles. There should be none, has_cycle says it has %s cycle\n",
    has_cycle(NULL)?"a":"no");
}

int main(void) {
  test_has_cycle();
  return 0;
}

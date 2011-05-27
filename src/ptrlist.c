/* ptrlist.h  acb  28-9-1994
 * A package for implementing a generic linked list whose data is a void *
 */

#include <stdlib.h>
#include "ptrlist.h"

pListNode list_append(pListNode a, pListNode b)
{
  pListNode r = a;

  if(!a) return b;
  while(a->next) a=a->next;
  a->next = b;
  return r;
};

pListNode list_cons(void *data, pListNode next)
{
  pListNode r = (pListNode) malloc(sizeof(ListNode));
  r->data = data; r->next = next; return r;
};

void list_free(pListNode list, ListIterator destructor)
{
  while(list) {
    pListNode n = list->next;
    if(destructor) (*destructor)(list, NULL);
    free(list); list = n;
  };
};

int list_indexof(pListNode list, ListIterator test, void *param)
{
  int r;
  if(!list) return -1;
  if((*test)(list, param)) return 0;
  r = list_indexof(list->next, test, param);
  return (r==-1)?-1:r+1;
};

int list_length(pListNode list)
{
  return((list)?list_length(list->next)+1:0);
};

void list_mapcar(pListNode list, ListIterator iter, void *param)
{
  while(list) {
    (*iter)(list->data, param);
    list=list->next;
  };
};

pListNode list_nth(pListNode list, int index)
{
  return(list?(index?list_nth(list->next, index-1):list):NULL);
};

int free_car_destructor(pListNode n, void *foo)
{
  free(n->data);
};

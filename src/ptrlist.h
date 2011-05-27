/* ptrlist.h  acb  28-9-1994
 * A package for implementing a generic linked list whose car is a void *
 */

#ifndef __PTRLIST_H
#define __PTRLIST_H

typedef struct tagListNode {
  void *data;
  struct tagListNode *next;
} ListNode, *pListNode;

/* it is assumed that sizeof(void *) >= sizeof(int) . If this is not the
   case, then your system is incredibly bogus. */

typedef int (*ListIterator)(pListNode, void *);

/*
 *  function prototypes
 */

pListNode list_append(pListNode a, pListNode b);

pListNode list_cons(void *car, pListNode cdr);

/* free each node of the list, first applying destructor to it if nonzero */

void list_free(pListNode list, ListIterator destructor);

/* list_indexof() applies an iterator to each node and returns the index
 * of the first node for which the iterator returns a nonzero value */

int list_indexof(pListNode list, ListIterator test, void *param);

int list_length(pListNode list);

void list_mapcar(pListNode list, ListIterator iter, void *param);

pListNode list_nth(pListNode list, int index);

/* a stock destructor which free()s the data of a node */

int free_car_destructor(pListNode n, void *foo);

#endif

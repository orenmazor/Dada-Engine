/* dict.h  acb  8-5-1995
 * general-purpose string-keyed associative arrays
 */

#ifndef __DICT_H
#define __DICT_H

typedef struct dictnode {
    char *key;
    void *value;
    struct dictnode *left, *right;
} *Dict, **pDict;

typedef int (*traverse_fn)(void *data, void *aux);


void dict_def(pDict d, char *k, void *value);

void *dict_get(Dict d, char *k);

void dict_inorder_traverse(Dict d, traverse_fn fn, void *aux);

void dict_preorder_traverse(Dict d, traverse_fn fn, void *aux);

int dict_size(Dict d);

void dict_free(Dict d);

/* dictionaries have an implicit order; therefore, it makes sense to get the
 * nth element of a dictionary. Ordinal numbers are related to the infix
 * order.
 */

void *dict_nth(Dict d, int n);

/* return the ordinal number of a key */

int dict_ord(Dict d, char *key);

#endif

/* dict.c  acb  8-5-1995
 * general-purpose string-keyed associative arrays
 */

#include "dict.h"
#include <stdlib.h>

static struct dictnode *nnode(char *k, void *v)
{
    struct dictnode *n=(struct dictnode *)malloc(sizeof(struct dictnode));
    n->key=k; n->value=v; n->left=n->right=NULL;
    return n;
};

static struct dictnode *insert(struct dictnode *dn, char *k, void *val)
{
    int c;
    if(!dn) return nnode(k, val);
    c=strcmp(k, dn->key);
    if(c==0) { dn->value=val; return dn; }
    if (c<0) { dn->left=insert(dn->left, k, val); return dn; }
    dn->right=insert(dn->right, k, val); return dn;
};

void dict_def(pDict d, char *k, void *value)
{
    (*d) = insert(*d, k, value);
};

static struct dictnode *lookup(struct dictnode *d, char *k)
{
    int c;
    if(!d) return NULL;
    c = strcmp(k, d->key);
    if(!c) return d;
    if(c<0) return lookup(d->left, k);
    return lookup(d->right, k);
};

void *dict_get(Dict d, char *k)
{
    struct dictnode *dn = lookup(d, k);
    return dn?dn->value:NULL;
};

void dict_inorder_traverse(Dict d, traverse_fn fn, void *aux)
{
    if(d) {
	dict_inorder_traverse(d->left, fn, aux);
	(*fn)(d->value, aux);
	dict_inorder_traverse(d->right, fn, aux);
    };
};

void dict_preorder_traverse(Dict d, traverse_fn fn, void *aux)
{
    if(d) {
	(*fn)(d->value, aux);
	dict_inorder_traverse(d->left, fn, aux);
	dict_inorder_traverse(d->right, fn, aux);
    };
};

int dict_size(Dict d)
{
    return d?dict_size(d->left)+dict_size(d->right)+1:0;
};

void dict_free(Dict d)
{
    if(d) {
	dict_free(d->left);
	dict_free(d->right);
	free(d->value);
	free(d);
    };
};

struct traverse_stamp { void *result; int todo; char *key; };

static void nth_traverse(void *v, struct traverse_stamp *s)
{
    if(s->todo==0) { s->result=v; }
    s->todo--;
};

void *dict_nth(Dict d, int n)
{
    struct traverse_stamp s;
    s.result=NULL; s.todo = n;
    dict_inorder_traverse(d, (traverse_fn)nth_traverse, (void *)&s);
    return s.result;
};

/* return the ordinal number of a key */

int dict_ord(Dict d, char *key)
{
    int c;
    if(!d) return -1;
    c=strcmp(key, d->key);
    if(c==0) return dict_size(d->left);
    if(c<0) return dict_ord(d->left, key);
    return dict_size(d->left)+dict_ord(d->right, key)+1;
};

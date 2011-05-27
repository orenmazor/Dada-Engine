/*  variables.h  acb  Mungday 3161 (5-1-1995)
 *  global, contextual variables.
 */

/* variables are designed to give some semblance of context, i.e., by
 * storing a previous choice in a variable for future use. These are
 * the sorts of operations which are anticipated:


foo: var<<rule ;

 * if var is set, foo returns its contents, otherwise foo sets var to the
 * result of rule and returns this new value.
 */

#ifndef __VARIABLES_H
#define __VARIABLES_H

typedef enum { mu, int_t, string_t } type_t;

extern struct var *vars;

struct var {
  type_t type;
  char *name;
  union {
    char *s;
    int i;
  } value;
  struct var *left, *right;
};

/* global function prototypes */

struct var *var_lookup(struct var *tree, char *key);

char *var_fetch(char *var_name); /* return NULL if not found */

int var_fetch_int(char *var_name);

void var_put(char *var_name, char *value);

void var_put_int(char *var_name, int value);

#endif

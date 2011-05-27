/*  variables.c  acb  Mungday 3161 (5-1-1995)
 *  global, contextual variables.
 */

#include <stdlib.h>
#include <string.h>
#include "variables.h"

#ifndef __GNUC__
#define inline /* */
#endif

/* variables are stored in a tree */

struct var *vars = NULL;

static inline struct var *new_str_var(char *name, char *val) {
  struct var *v = (struct var *)malloc(sizeof(struct var));
  v->name = name; v->type = string_t; v->value.s = val; 
  v->left = v->right = NULL;
};

static inline struct var *new_int_var(char *name, int val) {
  struct var *v = (struct var *)malloc(sizeof(struct var));
  v->name = name; v->type = int_t; v->value.i = val; 
  v->left = v->right = NULL;
};

static struct var *var_insert_str(struct var *tree, char *name, char *val)
{
  if(tree) {
    if(strcmp(name, tree->name)==0) {
      tree->type = string_t;
      tree->value.s = val;
    }
    else
      if(strcmp(name, tree->name)<0)
	tree->left = var_insert_str(tree->left, name, val);
      else
	tree->right = var_insert_str(tree->right, name, val);
  } else {
    tree = new_str_var(name, val);
  };
  return tree;
};

static struct var *var_insert_int(struct var *tree, char *name, int val)
{
  if(tree) {
    if(strcmp(name, tree->name)==0) {
      tree->type = int_t;
      tree->value.i = val;
    } else
      if(strcmp(name, tree->name)<0)
	tree->left = var_insert_int(tree->left, name, val);
      else
	tree->right = var_insert_int(tree->right, name, val);
  } else {
    tree = new_int_var(name, val);
  };
  return tree;
};

inline struct var *var_lookup(struct var *tree, char *key)
{
  if(!tree) return NULL;
  if(strcmp(tree->name, key)==0) return tree;
  return var_lookup((strcmp(tree->name, key)>0)?tree->left:tree->right, key);
};

type_t var_type(struct var *tree, char *key)
{
    struct var *v = var_lookup(tree, key);
    return v?v->type:mu;
};

/* retrieve a variable's contents, and make a string if need be */
char *var_fetch(char *var_name)
{
  struct var *v = var_lookup(vars, var_name);
  if(v) {
      char *foo;
      switch(v->type) {
      case string_t: return v->value.s;
      case int_t: foo = (char *)malloc(16); sprintf(foo, "%i", v->value.i);
	  return foo;
      }
  };
  return NULL;
};

int var_fetch_int(char *var_name)
{
  struct var *v = var_lookup(vars, var_name);
  if(v) {
      switch(v->type) {
      case int_t: return v->value.i;
      }
  };
  return 0;
};

void var_put(char *var_name, char *value)
{
  vars = var_insert_str(vars, var_name, value);
};

void var_put_int(char *var_name, int value)
{
  vars = var_insert_int(vars, var_name, value);
};



/* rtn.c  acb  8-9-1994 */

#include <stdlib.h>
#include "rtn.h"
#include "strfunc.h"

pNode node_cons(enum nodetype t, char *d, pNode cdr)
{
  pNode r;
  if(r = (pNode)malloc(sizeof(Node))) {
    r->type = t;
    r->data = d; /* pre-duplicated in the lexer */
    r->params = NULL; /* parameters, if any, are added later. */
    r->next = cdr;
  };
  return r;
};

pNode node_append(pNode a, pNode b)
{
  pNode r = a;
  while(r->next)
    r = r->next;
  r->next = b;
  return a;
};

void node_map(pNode list, NodeIterator iter, aux_t param)
{
  if(list) {
    (*iter)(list, param);
    node_map(list->next, iter, param);
  };
};

pOption option_cons(pNode car, pOption cdr)
{
  pOption r;
  if(r=(pOption)malloc(sizeof(Option))) {
    r->atoms = car;
    r->next = cdr;
    r->randweight=4;
  };
  return r;
};

pOption option_append(pOption a, pOption b)
{
  pOption r = a;
  while(r->next)
    r = r->next;
  r->next = b;
  return a;
};

void option_map(pOption list, OptionIterator iter, aux_t param)
{
  if(list) {
    (*iter)(list, param);
    option_map(list->next, iter, param);
  };
};

int option_length(pOption list)
{
  return (list)?option_length(list->next)+1:0;
};

pOption option_nth(pOption list, int index)
{
  return ((list)?((index==0)?list:option_nth(list->next, index-1)):NULL);
};

#if 0
pParam param_cons(char *car, pParam cdr)
{
  pParam r;
  if(r=(pParam)malloc(sizeof(Param))) {
    r->name = car;
    r->next = cdr;
  };
  return r;
};

pParam param_append(pParam a, pParam b)
{
  pParam r = a;
  while(r->next)
    r = r->next;
  r->next = b;
  return a;
};

void param_free(pParam list)
{
  if(list) {
    param_free(list->next);
    free(list);
  };
};

#endif

/* return the index of a string in a parameter list, -1 if not present */

#if 0
static int _param_indexof(pParam list, char *nm, int futplex)
{
  if(!list) return -1;
  if(strcmp(nm, list->name)==0) return futplex;
  else return _param_indexof(list->next, nm, futplex+1);
};
#endif

static int param_indexof_iter(pListNode l, char *str)
{
  return(strcmp(l->data, str)==0);
};

int param_indexof(pListNode list, char *nm)
{
  return list_indexof(list, (ListIterator)&param_indexof_iter, (void *)nm);
};

/* this uses stderr, instead of stdout (as dump_params did). */
void param_dump(pParam params)
{
  if(params) {
    fprintf(stderr, "%s ", params->data);
    dump_params(params->next);
  };
};

/* make a new rule, sans subtrees */
pRule rule_new(char *symbol, pOption options, pParam params)
{
  pRule r;
  if(r=(pRule)malloc(sizeof(Rule))) {
    r->symbol = symbol;
    r->options = options;
    r->params = params;
    r->left = r->right = (pRule)NULL;
    r->last_choice = -1; /* no choices made, so everything's Allowed. */
  };
  return r;
};

/* a recursive insertion function */

pRule rule_insert(pRule parent, pRule newrule)
{
  if(parent) {
    if(strcmp(newrule->symbol, parent->symbol)>0) {
      parent->right = rule_insert(parent->right, newrule);
      return parent;
    } else {
      parent->left = rule_insert(parent->left, newrule);
      return parent;
    };
  } else return newrule;
};

pRule rule_find(pRule tree, char *name)
{
  int c;
  if(!tree) return NULL;
  c = strcmp(name, tree->symbol);
  if(c==0) return tree;
  if(c<0) return rule_find(tree->left, name);
  return rule_find(tree->right, name);
};

void rule_inorder_traverse(pRule tree, RuleIterator iter, aux_t param)
{
  if(tree) {
    rule_inorder_traverse(tree->left, iter, param);
    (*iter)(tree, param);
    rule_inorder_traverse(tree->right, iter, param);
  };
};

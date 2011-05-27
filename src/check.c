/* check.c  acb  21-9-1994
 * routines for checking RTNs for undefined and unuse symbols.
 */

#include <stdlib.h>
#include <stdio.h>
#include "rtn.h"
#include "map.h"
#include "transform.h"

extern pListNode transformations;

/* a rule closure; the symbolic environment of a rule */

struct rule_closure {
  pRule rules; /* other rules */
  pRule rule; /* this rule */
};

static int errors=0;

static int undef_iter2(pNode a, struct rule_closure *closure)
{
  switch(a->type) {
  case symbol: 
    {
      if(param_indexof(closure->rule->params, a->data)==-1) {
	/* this node is not a parameter */
	if(rule_find(closure->rules, a->data)==NULL) {
	  fprintf(stderr, "undefined symbol '%s' in rule '%s'\n", a->data, 
		  closure->rule->symbol);
	  errors++;
	};
	/* check any parameters passed */
	if(a->params) undef_iter2(a->params, closure);
      };
    };
    break;
  case mapping: 
    {
      /* I have been lazy and used global variables. Please forgive me. */
      if((map_lookup(mappings, a->data)==NULL) 
	 && (trans_lookup(transformations, a->data)==NULL)) {
	  fprintf(stderr, "undefined mapping or transformation '%s' in rule '%s'\n", a->data, 
		  closure->rule->symbol);
	  errors++;
      };
      /* recurse into what this mapping applies to */
      undef_iter2(a->params, closure);
    };
  };
};

static int undef_iter1(pOption o, struct rule_closure *closure)
{
  node_map(o->atoms, (NodeIterator)&undef_iter2, closure);
};

static int undef_iter0(pRule r, pRule rules)
{
  struct rule_closure closure;
  closure.rules = rules;
  closure.rule = r;
  option_map(r->options, (OptionIterator)&undef_iter1, &closure);
};

static void check_for_undefined(pRule rules)
{
  errors = 0;
  rule_inorder_traverse(rules, (RuleIterator)&undef_iter0, rules);
  if(errors>0) exit(1);
};

static void check_for_unused(pRule rules)
{
};

void check_rtn(pRule rules)
{
  check_for_undefined(rules);
  check_for_unused(rules);
};

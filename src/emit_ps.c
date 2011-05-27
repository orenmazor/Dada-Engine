/* emit_ps.c  acb  11-7-1995
 * emit a RTN as PostScript code.
 */

#include <stdio.h>
#include "rtn.h"
#include "map.h"
#include "transform.h"

#define PS_PROLOG "dadaprolog.ps"

static int ps_option_iterator(pOption o, aux_t l);

static void ps_xform_iterator(pListNode n, void *foo)
{
};

static int ps_node_iterator(pNode n, aux_t l)
{
  FILE *f=(FILE *)l;
  switch(n->type) {
  case literal: fprintf(f, "(%s)", n->data); break;
  case symbol: fprintf(f, "{%s}", n->data); break;
  case mapping: 
    ps_node_iterator(n->params, l);
    fprintf(f, " %s-map", n->data);
    break;
  case deref: ps_node_iterator(n->params, l); fprintf(f, " cvx exec"); break;
  case var_conddef: 
    fprintf(f, "/%s ", n->data); 
    ps_node_iterator(n->params, l);
    fprintf(f, " exec conddef");
    break;
  case var_def:
    fprintf(f, "/%s ", n->data); 
    ps_node_iterator(n->params, l);
    fprintf(f, " exec def");
    break;
  case var_ref: fprintf(f, "%s", n->data); break;
  case code: /* FIXME */ break;
  case silence:     ps_node_iterator(n->params, l); fprintf(f, " pop"); break;
  case choice: fprintf(f, "[\n");
    option_map(n->data, (OptionIterator)&ps_option_iterator, l);
    fprintf(f, "] choose\n"); break;
  case star:
    ps_node_iterator(n->params, f); fprintf(f, " star");
    break;
  case plus:
    ps_node_iterator(n->params, f); fprintf(f, " plus");
    break;
  case repeat_const:
    ps_node_iterator(n->params, f); fprintf(f, " %d rep", n->int_param);
    break;
    
  };
};

static int ps_option_iterator(pOption o, aux_t l)
{
  FILE *f=(FILE *)l;
  fprintf(f, "[\n");
  node_map(o->atoms, (NodeIterator)&ps_node_iterator, l);
  fprintf(f, "] {exec outputstring} forall\n");
};

static int ps_rule_iterator(pRule r, aux_t l)
{
  FILE *f=(FILE *)l;
  fprintf(f, "/%s{[\n", r->symbol);
  option_map(r->options, (OptionIterator)&ps_option_iterator, l);
  fprintf(f, "]choose}bind def\n");
};

void emit_ps(FILE *f, pRule rules, pMapping mappings, 
	     pListNode transformations, char *start_sym)
{
  fprintf(f, "%%%% modify these as desired\n\
/outputstring { %% emit a string on the stack\n\
} def\n\n");

  rule_inorder_traverse(rules, (RuleIterator)&ps_rule_iterator, (aux_t)f);
  fprintf(f, "%s\n", start_sym);
};

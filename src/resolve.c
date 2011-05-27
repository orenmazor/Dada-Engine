/* resolve.c  acb  10-9-1994
 * routines for recursively resolving a RTN.
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "rtn.h"
#include "resolve.h"
#include "dstring.h"
#include "map.h"
#include "transform.h"
#include "variables.h"
#include "machine.h"

#ifndef __GNUC__
#define inline /* no inline functions available */
#endif

#define MAX(foo,bar) (((foo)>(bar))?(foo):(bar))
#define MIN(foo,bar) (((foo)<(bar))?(foo):(bar))

/* probability frobnostication factor; the higher this is, the more the odds
 * are shifted against recent choices */

#define FROB_FACTOR 64

struct _resolve_iter_params {
  pRule rules;
  char **result;
  pParam formal; /* the rule's formal parameters, as defined */
  pParam cooked; /* cooked */
};

extern int trace, old_probability;
extern pListNode transformations;

static char *_resolve_rule(pRule, pRule, pNode, pListNode, pListNode, 
			   enum resmode);

static inline char *resolve_option(pRule rules, pOption option, 
				   pParam formal, pParam cooked);


/* resolve an atom */
static inline char *resolve_atom(pNode atom, pRule rules, pListNode formal, pListNode cooked)
{
  int index;
  char *result=NULL; /* for star and plus */
  int i;

  if(trace) printf("Resolving atom: type = %d, data = \"%s\"\n",
		   atom->type, atom->data);
  switch(atom->type) {
  case literal:
    return strdup(atom->data);
  case symbol:
    /* first, check if this symbol is a parameter of the current rule */
    if((index=param_indexof(formal, atom->data))!=-1) {
      if(index>=list_length(cooked))
	return(strdup("(parameter off end of list)"));
      else
	return(strdup(list_nth(cooked, index)->data));
    };
    /* it is not a parameter substitution; resolve from rules */
    return _resolve_rule(rules, rule_find(rules, atom->data), atom->params,
			 formal, cooked, atom->mode);
  case mapping:
      if(map_lookup(mappings, atom->data))
	  return apply_mapping(resolve_atom(atom->params, rules, formal, 
					    cooked),
			       map_lookup(mappings, atom->data));
      return apply_xform(resolve_atom(atom->params, rules, formal, cooked),
			 trans_lookup(transformations, atom->data));
  case deref:
    return _resolve_rule(rules, 
			 rule_find(rules, resolve_atom(atom->params, rules, 
						       formal, cooked)),
			 NULL, formal, cooked, atom->mode);
  case var_conddef: {
    char *val = var_fetch(atom->data);
    if(!val) {
      val = resolve_atom(atom->params, rules, formal, cooked);
      var_put(atom->data, val);
    };
    val = strdup(val); /* make a disposable copy of it */
    return val;
  };
  case var_def: {
      char *val = resolve_atom(atom->params, rules, formal, cooked);
      if(!val) val = "undefined";
      var_put(atom->data, val);
      val = strdup(val); /* make a disposable copy of it */
      return val;
  };
  case var_ref: {
      char *val = var_fetch(atom->data);      
      if(!val) {
	  fprintf(stderr, "undefined variable `%s'.\n", atom->data);
	  exit(1);
      };
      return strdup(val); /* make a disposable copy of it */      
  };
  case silence: {
    free(resolve_atom(atom->params, rules, formal, cooked));
    return NULL;
  };
  case code: return exec_stream((pInstr)atom->data);
  case plus:
      result = resolve_atom(atom->params, rules, formal, cooked);
  case star:
      while((rand()%5)>1)
	  result = dstrcat(result, 
			   resolve_atom(atom->params, rules, formal, cooked));
      return result;
  case repeat_const:
    for(i=0; i<atom->int_param; i++)
      result = dstrcat(result, 
		       resolve_atom(atom->params, rules, formal, cooked));
    return result;
  case repeat_var: {
    char *val = var_fetch(atom->data);      
    if(!val) {
      fprintf(stderr, "undefined variable `%s'.\n", atom->data);
      exit(1);
    };
    for(i=atoi(val); i>0; i--)
      result = dstrcat(result, 
		       resolve_atom(atom->params, rules, formal, cooked));
    return result;
  };
  case choice: {
      int choice;
      pOption options=(pOption)atom->data;
      int num_options = option_length(options);

      if (trace) printf("last choice: %i\n", atom->last_choice);
      do {
	  choice = random()%num_options;
      } while ((choice==atom->last_choice) && (num_options>1));
      if(trace) printf("inline choice: choose %i/%i\n", choice, num_options);
      atom->last_choice = choice;
      return resolve_option(rules, option_nth(options, choice), 
			    formal, cooked);
  };
      
  };
};

static void resolve_iterator(pNode atom, struct _resolve_iter_params *prms)
{
  *(prms->result) = dstrcat(*(prms->result), 
			    resolve_atom(atom, prms->rules, 
					 prms->formal, prms->cooked));
};

static inline char *resolve_option(pRule rules, pOption option, 
  pParam formal, pParam cooked)
{
  struct _resolve_iter_params prms;
  char *result=NULL;
  prms.rules = rules;
  prms.result = &result;
  prms.formal = formal;
  prms.cooked = cooked;
  node_map(option->atoms, (NodeIterator)&resolve_iterator, (aux_t)&prms);
  return result;
};

/* resolve a parameter (node) list into a list of strings; now checks a
   list of parameters from the parent. */

static pListNode resolve_params(pNode in, pRule rules, 
				pListNode formal, pListNode cooked)
{
  int index;

  if(in==(pNode)NULL) return (pParam)NULL;
  /* check if it's a cascading parameter */
  if((index=param_indexof(formal, in->data))!=-1) {
    char *this_result;
    if(trace) {
	fprintf(stderr, "resolve_params: formal: "); param_dump(formal);
	fprintf(stderr, "\nresolve_params: cooked: "); param_dump(cooked);
	fprintf(stderr, "\nin->data: %s\n", in->data);
	fprintf(stderr, "index of %s == %i\n", in->data, index);
    };
    this_result = (index>=list_length(cooked))?"(parameter off end of list)"
			 :list_nth(cooked, index)->data;
    if(trace) fprintf(stderr, "resolving cascading parameter: %s -> %s\n", 
		      in->data, this_result);
    return list_cons(strdup(this_result), 
		     resolve_params(in->next, rules, formal, cooked));
  };
  return list_cons((void *)resolve_atom(in, rules,
					rule_find(rules, in->data)?
					rule_find(rules, in->data)->params:
					NULL,
					resolve_params(in->params, rules,
						       formal, cooked)),
		   resolve_params(in->next, rules, formal, cooked));
};

/* select an option at random */

static int _sum_option_weights(pOption o, int* s)
{
    if(trace) fprintf(stderr, "option weight == %i\n", o->randweight);
    (*s) += o->randweight;
};

static int _incr_option_weight(pOption o, void* foo) 
{
#if 0
  o->randweight+=FROB_FACTOR; 
#else
  o->randweight=((o->randweight+1)*3)/2;
#endif
}

pOption select_option(pOption options, int *last, enum resmode mode)
{
    int num_options = option_length(options);
    if((old_probability) && (mode==plain)) {
	int choice;
	/* do it the old way */
	do { 
	    choice=random()%num_options; 
	} while ((choice==*last) && (num_options>1));
	*last=choice;
	return option_nth(options, choice);
    } else {
	/* do it the new way */
	pOption o=options;
	int sum=0;
	int ch;
	option_map(options, (OptionIterator)_sum_option_weights, (void *)&sum);
	if(trace) fprintf(stderr, "total of option weights: %i\n", sum);
	ch=sum?random()%sum:0;
	if(trace) fprintf(stderr, "random value: %i\n", ch);
	while(ch>o->randweight) {
	    ch -= o->randweight;
	    o=o->next?o->next:0;
	};
#if 0
	o->randweight= MAX(-FROB_FACTOR,o->randweight-((num_options+1)*FROB_FACTOR)); /* make this one less probable */
#else
	o->randweight = 1;
#endif
/*	if(o->randweight<0) o->randweight=0;*/
	option_map(options, _incr_option_weight, NULL);
	return o;
    };
};

/* resolve the rule rule recursively, using rules as the rule-base.
   This function now accepts the parent's formal and actual rules
   and also the resolution mode. */

static char *_resolve_rule(pRule rules, pRule rule, pNode param,
			   pListNode parent_formal, pListNode parent_cooked,
			   enum resmode mode)
{
  if(rule) {
    char *r;
    pParam cooked = resolve_params(param, rules, parent_formal, parent_cooked);
    int num_options = option_length(rule->options);
    int choice;

    if(trace) printf("Resolving rule <%s>\n", rule->symbol);

    /* make the choice */

    r = resolve_option(rules, 
		       select_option(rule->options, &(rule->last_choice), 
				     mode), rule->params, cooked);

    list_free(cooked, free_car_destructor);
    if(trace) printf("resolve_option returned \"%s\"\n", r);
    return r;
  } else return NULL;
};

char *resolve_rule(pRule rules, pRule rule)
{
  return _resolve_rule(rules, rule, NULL, NULL, NULL, plain);
};





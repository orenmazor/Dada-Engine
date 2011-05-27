/* rtn.h  acb  8-9-1994 
 *
 * Major modifications:
 * 17-9-1994: started adding parametrised rules
 * 23-9-1994 (?): started adding regular expression-based mappings
 * 2[56]-9-1994: started adding dereferencing
 * 15-2-1995: Started adding embedded imperative code
 * 29-4-1995: Started adding option prespecification and inline choices
 * 13-5-1995: Started adding the Kleene star and + operators
 * 7-6-1995:  Started adding the new random weighting system; this will 
 *            counteract seriality (the tendency for choices of the same
 *            group to be selected in sequence) more effectively than the
 *            old "last choice" mechanism.
 * 4-7-1995:  Started adding the "repeat" operator.
 */

#ifndef __RTN_H
#define __RTN_H

#include <stdio.h>

#include "ptrlist.h"

enum nodetype { 
    literal, 
    symbol, 
    mapping, 
    deref, 
    var_conddef,  /* conditional variable definition; define if not already 
		     so */
    var_def,      /* force definition of a variable */
    var_ref,      /* reference a variable */
    code,         /* a chunk of code which is executed */
    silence,      /* something which silences another node. */
    choice,       /* an inline choice */
    star,         /* the Kleene star; do something zero or more times */
    plus,         /* do something one or more times */
    repeat_const, /* do something a predefined number of times */
    repeat_var    /* look up a number of times in a variable */
};

enum resmode {
    plain,        /* resolve as always, selecting at random */
    unique,       /* do not allow duplicate choices until all choices are
		     exhausted */
    enumerate,    /* enumerate all choices on this level */
    pick          /* pick n choices without replacement */
};

#define SELECT_RANDOM -1 /* randomly perform the selection process */

typedef struct tagNode {
    enum nodetype type;
    char *data; /* literal text, symbol invocation, mapping invocation, 
		 block of code, name of variable to set or retrieve
		 or inline option list */
    struct tagNode *params; /* actual parameters, to be evaluated, or subnode 
			     for mapping or conditional definition */
    int int_param; /* an integer argument, such as a constant repeat count */
    int select;
    int last_choice; /* for inline choices */
    enum resmode mode; /* mode of resolution */
    int pick_num; /* number to pick */
    struct tagNode *next;
} Node, *pNode;

typedef struct tagOption {
    pNode atoms;
    int randweight; /* for the new, improved anti-seriality mechanism */
    struct tagOption *next;
} Option, *pOption;

/* parameters for parametrised rules */

typedef ListNode Param, *pParam;

/* rules are arranged in a binary tree */

typedef struct tagRule {
  char *symbol;
  pOption options;
  pParam params;  /* parameters for this rule, or NULL if none are used, */
  struct tagRule *left, *right;
  /* added on 07/01/25 AU; a sort of limited memory to counteract seriality
     somewhat */
  int last_choice; /* for the old anti-seriality mechanism */
} Rule, *pRule;

typedef void *aux_t; /* for auxilliary arguments to iterators */

typedef int (*NodeIterator)(pNode, aux_t);

typedef int (*OptionIterator)(pOption, aux_t);

typedef ListIterator ParamIterator;

typedef int (*RuleIterator)(pRule, aux_t);

/*
 * function prototypes
 */

pNode node_cons(enum nodetype t, char *d, pNode cdr);

pNode node_append(pNode a, pNode b);

void node_map(pNode list, NodeIterator iter, aux_t param);

pOption option_cons(pNode car, pOption cdr);

pOption option_append(pOption a, pOption b);

int option_length(pOption list);

pOption option_nth(pOption list, int index);

void option_map(pOption list, OptionIterator iter, aux_t param);

int param_indexof(pListNode list, char *nm);

/* make a new rule, sans subtrees */
pRule rule_new(char *symbol, pOption options, pParam params);

/* a recursive insertion function */

pRule rule_insert(pRule parent, pRule newrule);

/* find a rule */

pRule rule_find(pRule tree, char *name);

/* traverse the rule tree in infix order */

void rule_inorder_traverse(pRule tree, RuleIterator iter, aux_t param);

#endif

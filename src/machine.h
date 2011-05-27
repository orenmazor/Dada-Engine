/* machine.h  acb  14-2-1995
 * the embedded imperative code interpreter in pb
 * A lot of stuff lifted from rml, also by acb so it's Allowed.
 */

#ifndef __MACHINE_H
#define __MACHINE_H

#include <stdlib.h>
#include "variables.h"

#ifndef __GNU__
#define inline /* blah */
#endif

typedef struct {
  type_t type;
  union {
    int i;
    char *s;
  } contents;
} Cell, *pCell;

enum opcode {
    SET,    /* pop stack, setting variable */
    PUSHV,  /* push variable onto stack */
    PUSH,   /* push some sort of literal value */
    ADD,    /* add or concatenate */
    SUB,
    MUL,
    DIV,
    EMIT,   /* pop stack and exit, returning result */
    INVOKE, /* invoke a rule, pushing its output onto the stack */
    MOD,
    RANDOM, /* generate a random number */
    LESSER, /* select the lesser of two evils^H^H^H^H^Hnumbers */
    GREATER
};

typedef struct tagInstr {
    enum opcode opcode;
    Cell operand;
    struct tagInstr *next;
} Instr, *pInstr;

/* manipulate instruction lists */

pInstr last(pInstr a);

static inline pInstr icat(pInstr a, pInstr b)
{
  if(a) {
    pInstr l = last(a);
    l->next = b; 
    return a;
  } else return b;
};

/* return a simple instruction */
static inline pInstr e_simple(enum opcode op)
{
  pInstr result = (pInstr) malloc(sizeof(Instr));
  result->opcode = op;
  result->operand.type = mu; /* nothing */
  result->next = NULL;
  return result;
};

static inline pInstr e_set(char *name)
{
    pInstr result = e_simple(SET);
    result->operand.type = string_t;
    result->operand.contents.s = name;
    return result;
};

static inline pInstr e_pushv(char *name)
{
    pInstr result = e_simple(PUSHV);
    result->operand.type = string_t;
    result->operand.contents.s = name;
    return result;
};

static inline pInstr e_push_int(int i)
{
    pInstr result = e_simple(PUSH);
    result->operand.type = int_t;
    result->operand.contents.i = i;
    return result;
};

static inline pInstr e_push_str(char *s)
{
    pInstr result = e_simple(PUSH);
    result->operand.type = string_t;
    result->operand.contents.s = s;
    return result;
};

static inline pInstr e_invoke(char *name)
{
    pInstr result = e_simple(INVOKE);
    result->operand.type = string_t;
    result->operand.contents.s = name;
    return result;
};

char *exec_stream(pInstr s);

void dump_code(pInstr s);

#endif

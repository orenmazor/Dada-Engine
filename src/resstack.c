/* resstack.c  acb  17-7-1995
 * A stack for implementing unique/enumerated rule resolution
 */

#include <stdlib.h>
#include "limits.h"
#include "dict.h"
#include "ptrlist.h"

typedef char res_history[MAX_OPTIONS>>3];

#ifndef __GNUC__
#define inline /* */
#endif

static inline void hist_clear(res_history r) { memset(r, 0, MAX_OPTIONS>>3); };

static inline int hist_test(res_history r, int bitpos)
{
    return (r[bitpos>>3]&(0x01<<(bitpos&7)));
};

static inline void hist_set(res_history r, int bitpos)
{
    r[bitpos>>3] |= (0x01<<(bitpos&7));
};

struct hist_item { int num_opts; res_history hist; };

/* the stack; each stack frame is a list node, whose car is a dictionary
 * of hist_item structures. (The car itself is a dictionary, not a pointer to
 * one.) */

pListNode res_stack=NULL;

/* push a new stack frame */

void resstack_push_new()
{
    res_stack = list_cons(NULL, res_stack);
};

void resstack_pop()
{
    if(res_stack) {
	pListNode n;
	dict_free(res_stack->data);
	n=res_stack->next;
	free(res_stack);
	res_stack=n;
    };
};

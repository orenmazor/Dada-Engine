/* emit_c.c  acb  35 Chs 3162
 * emit a RTN as C code
 */

#include <stdio.h>
#include <stdarg.h>
#include "rtn.h"
#include "map.h"
#include "transform.h"

#include "dstring.h"

/* a structure representing state.  who knows; this may need to be
   reentrant some day... */

struct state {
    FILE* of;         /* output file */
    int temp_count;   /* number of next temporary function */
};

const char* c_prefix="dd";

/************************************************************************* 
 *
 *    utility functions 
 *
 *************************************************************************/

/* format a string, appending it to a buffer and returning the
 * new value of the buffer; the old one is freed. */

static char* append(char *prev, char* fmt, ...)
{
    char buffer[1024];
    va_list args;
    char *r;

    va_start(prev, fmt);
    vsprintf(buffer, fmt, args);
    r=malloc((prev?strlen(prev):0)+strlen(buffer)+1);
    strcpy(r,prev?prev:""); strcat(r,buffer);
    if(prev)free(prev); 
    va_end(prev);
    return r;
}

/* a standard deferred function, for lazy evaluation */


void emit_prologue(FILE* f)
{
    fprintf(f, "/*  Dada Engine C runtime prologue;  acb  36 Chs 3162\
 * Freely distributable\n */\n\
#include <stdio.h>\
#include <stdarg.h>\
\
typedef char* (dfunc)();\
\
dfunc %schoose(int num, ...)\
{\
  int ch=random()%num;\
  dfunc df;\
  va_list ap;\n\
  va_start(ap, num);\
  for(i=0; i<ch; i++)
    df=va_arg(ap, dfunc);\
  va_end(ap);\
  return df;\
}\
\
/*  end of prologue  */\n\n", 
    c_prefix);
}

static int c_rule_iterator(pRule r, aux_t l)
{
    int numopts=count_options(r->options);
    struct state *st=(struct state *)l;
    FILE* f=st->of;
    char *func=NULL;   /* the buffer in which the function source is 
			  built up */

    func=append(func, "char* %s_%s(", c_prefix, r->symbol);
    /* FIXME: parameters here */
    func=append(func, ")\n{\n");
    if(numopts>2) {	
	func=append(func, "  return %schoose(%d, ", c_prefix, numopts);
	/* FIXME: enumerate options here */
	/* we really need some sort of lazy evaluation mechanism */
	func=append(func, "  );\n");
    } else {
    }
    func=append(func, "}\n\n");
    fprintf(f, "%s", func);
}

void emit_c(FILE *f, pRule rules, pMapping mappings, 
	     pListNode transformations, char *start_sym)
{
    struct state st;
    st.of=f;
    st.temp_count=0;

    emit_prologue(f);
    
    rule_inorder_traverse(rules, (RuleIterator)&c_rule_iterator, (aux_t)&st);
}

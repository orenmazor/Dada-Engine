/* transform.h  acb  28-9-1994
 * sed-style transformation support for pb
 */

#ifndef __TRANSFORM_H
#define __TRANSFORM_H

#include <stdlib.h>
#include "ptrlist.h"
#include "config.h"
#include <regex.h>  /* the POSIX.2 regular expression functions */

#ifndef __GNUC__
#define inline /**/
#endif

#define CMDNAMELENGTH 4

typedef int AddrRange[2];

typedef struct tagTransCmd {
  int *addr;
  char cmdname[CMDNAMELENGTH];
  pListNode params;
  struct tagTransCmd *next;
} TransCmd, *pTransCmd;

/* the following are placed into a list */

typedef struct tagTransOpt {
  char *key;
  pTransCmd cmds;
} TransOpt, *pTransOpt;

typedef struct tagTransformation {
  char *name;
  pListNode options;
} Transformation, *pTransformation;


extern pListNode transformations; /* in parser.y -- all this to get out of
				     adding a new source file to Makefile!
				     Sheesh! */

/* even if we don't have inline, we don't lose anything by putting these
 * in the header, as only the parser invokes them.
 */

static inline int *new_addr_range(int a, int b) { 
  int *r = (int *)malloc(2*sizeof(int)); r[0]=a; r[1]=b; return r;
};

static inline pTransCmd new_transcmd(int *addr, char *id, pListNode args)
{
  pTransCmd r = (pTransCmd) malloc(sizeof(TransCmd)); r->addr = addr;
  strncpy(r->cmdname, id, CMDNAMELENGTH-1); free(id); /* we can do this */
  r->params = args; r->next = NULL; return r;
};

static inline pTransOpt new_transopt(char *key, pTransCmd cmds)
{
  pTransOpt r = (pTransOpt) malloc(sizeof(TransOpt));
  r->key = key; r->cmds = cmds; return r;
};

static inline pTransformation new_transformation(char *name, pListNode opts)
{
  pTransformation r = (pTransformation) malloc(sizeof(Transformation));
  r->name = name; r->options = opts; return r;
};

pTransformation trans_lookup(pListNode list, char *name);


/* match an option to a string, using regular expressions (ooh!) */
pTransOpt transopt_match(pListNode list, char *string);


/* apply_xform() either returns or frees its input */
char *apply_xform(char *input, pTransformation xfm);

#endif

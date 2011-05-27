/* transform.c  acb  9-2-1995
 * sed-style transformation support for pb
 */

#include <stdio.h>
#include "transform.h"

/* regex_subst() does not deallocate its input -- its caller has to do this */
char *regex_subst(char *in, char *from, char *to); /* in map.c */

pTransformation trans_lookup(pListNode list, char *name)
{
  return (pTransformation)((list)?(
      (strcmp(((pTransformation)list->data)->name, name)==0)?list->data:
      trans_lookup(list->next, name)):NULL);
};


/* match an option to a string, using regular expressions (ooh!) */
pTransOpt transopt_match(pListNode list, char *string)
{
    while(list) {
	regex_t key_regex;
	regmatch_t match;
	pTransOpt opt=(pTransOpt)list->data;
	
	regcomp(&key_regex, opt->key, 0);
	
	if(regexec(&key_regex, string, 1, &match, 0)==0) {
	    regfree(&key_regex);
	    return opt;
	};
	
	regfree(&key_regex);
	list=list->next;
    };
    return NULL;
};

/* put an address integer into normal form */
static inline int addr_normalise(int addr, char *input)
{
    int l=strlen(input);
    if(l==0) return 0;
    while(addr<0) addr+=l;
    addr %= l;
    return addr;
};

/* apply_xform_cmd() either returns or frees its input */

static char *apply_xform_cmd(char *input, pTransCmd cmd)
{
    int from, to, len, i;
    char *r;

    if(cmd->addr) {
	from = addr_normalise(*(cmd->addr), input);
	to = addr_normalise(*(cmd->addr+1), input);
    } else { from = 0; to = strlen(input)-1; };
    len = to-from+1;

    switch(cmd->cmdname[0]) {
    case 'd': 
	r=malloc(strlen(input)-len); *r = '\0'; 
	strncpy(r, input, from); strncat(r, input+to+1, strlen(input)-(to+1));
	free(input); return r;
    case 'l': /* lowercase the range */
	for(i=from; i<=to; i++)
	    input[i]=tolower(input[i]);
	return input;
    case 's': /* FIXME: add some sort of argument count checking */
	r = regex_subst(input, list_nth(cmd->params, 0)->data, 
			list_nth(cmd->params, 1)->data);
	free(input);
	return r;
    case 'u': /* uppercase the range */
	for(i=from; i<=to; i++)
	    input[i]=toupper(input[i]);
	return input;
    };
    fprintf(stderr, "Warning: ignoring undefined transformation `%s'\n", 
	    cmd->cmdname);
    return input;
};

/* apply_xform() either returns or frees its input */

char *apply_xform(char *input, pTransformation xfm)
{
    pTransOpt option;
    pTransCmd cmd;
    if(!xfm) return input;

    option = transopt_match(xfm->options, input);

    if(!option) return input;
    cmd = option->cmds;

    while(cmd) {
	input = apply_xform_cmd(input, cmd);
	cmd = cmd->next;
    };
    return input;
};

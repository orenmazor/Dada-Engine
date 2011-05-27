/* map.c  acb  23-9-1994
 * mapping support for pb
 */

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/types.h> /* regex.h seems to need this */
#include "config.h"
#include <regex.h>  /* the POSIX.2 regular expression functions */
#include "map.h"


pMapping mappings = NULL;


pMapAction new_replace_action(char *out)
{
  pMapAction r = (pMapAction) malloc(sizeof(MapAction));
  r->mode = replace; r->out = out;
  return r;
};

pMapAction new_subst_action(char *key, char *out)
{
  pMapAction r = (pMapAction) malloc(sizeof(MapAction));
  r->mode = subst; r->key=key; r->out = out;
  return r;
};

pMapOpt mapopt_concat(pMapOpt a, pMapOpt b)
{
  pMapOpt r = a;
  while(a->next) a=a->next;
  a->next = b;
  return r;
};

pMapOpt mapopt_cons(char *key, pMapAction act, pMapOpt cdr)
{
  pMapOpt r = (pMapOpt) malloc(sizeof(MapOpt));
  r->key = key;
  r->action = act;
  r->next = cdr;
  return r;
};

/* match an option to a string, using regular expressions (ooh!) */
pMapOpt mapopt_match(pMapOpt list, char *string)
{
  while(list) {
    regex_t key_regex;
    regmatch_t match;

    regcomp(&key_regex, list->key, 0);

    if(regexec(&key_regex, string, 1, &match, 0)==0) {
      regfree(&key_regex);
      return list;
    };

    regfree(&key_regex);
    list=list->next;
  };
  return NULL;
};

pMapping map_cons(char *n, pMapOpt opts, pMapping cdr)
{
  pMapping r = (pMapping) malloc(sizeof(Mapping));
  r->name = n;
  r->options = opts;
  r->next = cdr;
  return r;
};

pMapping map_lookup(pMapping list, char *name)
{
  return((list)?((strcmp(list->name, name)==0)?list:
		 map_lookup(list->next, name)):NULL);
};

/* apply_mapping() applies a mapping to a string. The input is assumed to
 * be heap-allocated, and is either returned unchanged or deallocated.
 * The output is heap-allocated.
 */

char *regex_subst(char *in, char *from, char *to)
{
  char *r;
  regex_t re;
  regmatch_t match;
  int len;
  int error;
  int offset = 0;

  /* check for special cases: prepend and append */
  if(strcmp(from, "^")==0) {
    r = (char *)malloc(strlen(in)+strlen(to)+1);
    strcpy(r, to); strcat(r, in);
    return r;
  };
  if(strcmp(from, "$")==0) {
    r = (char *)malloc(strlen(in)+strlen(to)+1);
    strcpy(r, in); strcat(r, to);
    return r;
  };

  if(regcomp(&re, from, 0)!=0) return NULL;

  /* first, accrue the length of the resulting string */
  len = strlen(in);

  error = regexec(&re, in+offset, 1, &match, 0);

  while(!error) {
    len += strlen(to)-(match.rm_eo-match.rm_so);
    if(match.rm_eo==0) break;
    offset+=match.rm_eo;
    error = regexec(&re, in+offset, 1, &match, REG_NOTBOL);
  };

  /* now, composite the resulting string */
  offset = 0;
  r = (char *) malloc(len+1); *r = '\0';

  error = regexec(&re, in+offset, 1, &match, 0);
  strncat(r, in+offset, match.rm_so);

  while(!error) {
    strcat(r, to);
    if(match.rm_eo==0) break;
    offset += match.rm_eo;
    error = regexec(&re, in+offset, 1, &match, 0);
/*    fprintf(stderr, "match.rm_so: %d, match.rm_eo: %d\n", 
	match.rm_so, match.rm_eo);*/
    if (error)  strcat(r, in+offset);
    else        strncat(r, in+offset, match.rm_so);
  };
  return r;
};

char *apply_mapping(char *input, pMapping m)
{
  pMapOpt option;

  if(!m) return input;

  option = mapopt_match(m->options, input);

  if(!option) return input; /* by default, let it be */

  switch(option->action->mode) {
  case replace:
    free(input);
    return(strdup(option->action->out));
  case subst:
    /* here we need to do regex substitution. Ooh, tricky! */
    {
      char *r = regex_subst(input, option->action->key, option->action->out);
      if(!r) return input; /* failed */
      free(input);
      return r;
    };
  };
};

/* map.h  acb  23-9-1994
 * mapping support for pb
 */

#ifndef __MAP_H
#define __MAP_H

/* an action performed on a string if it matches a key */

enum mapmode {
  replace,        /* completely replace the input string with another string */
  subst           /* perform an ed-style regular expression substitution */
};

typedef struct tagMapAction {
  enum mapmode mode;
  char *out; /* replacement/substitution text */
  char *key; /* key for substitution; substring matching key is replaced.
	        replacement is equivalent to substitution with key ".*" */
} MapAction, *pMapAction;

/* one option in a mapping */

typedef struct tagMapOpt {
  char *key; /* key (regular expression) to match input against */
  pMapAction action;
  struct tagMapOpt *next;
} MapOpt, *pMapOpt;

typedef struct tagMapping {
  char *name;
  pMapOpt options;
  struct tagMapping *next;
} Mapping, *pMapping;

/*
 *   e x t e r n a l  v a r i a b l e s
 */

extern pMapping mappings;

/*
 *   p r o t o t y p e s  f o l l o w
 */

pMapAction new_replace_action(char *out);

pMapAction new_subst_action(char *key, char *out);

pMapOpt mapopt_concat(pMapOpt a, pMapOpt b);

pMapOpt mapopt_cons(char *key, pMapAction act, pMapOpt cdr);

/* match an option to a string, using regular expressions (ooh!) */
pMapOpt mapopt_match(pMapOpt list, char *string);

pMapping map_cons(char *n, pMapOpt opts, pMapping cdr);

pMapping map_lookup(pMapping list, char *name);

/*
 *    f u n c t i o n s  f o r  a p p l y i n g  m a p p i n g s
 */

/* apply_mapping() applies a mapping to a string. The input is assumed to
 * be heap-allocated, and is either returned unchanged or deallocated.
 * The output is heap-allocated.
 */

char *apply_mapping(char *input, pMapping m);

#endif


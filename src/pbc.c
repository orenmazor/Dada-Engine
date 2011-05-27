/* pbc.c  acb  11-7-1995
 * The backbone of a pb compiler.
 */

#include <stdio.h>
#include "rtn.h"
#include "check.h"
#include "map.h"
#include "transform.h"

char *start_symbol = NULL; /* to override the default start symbol */
pRule rule_base;
extern pRule initial_rule;
FILE *outfile=stdout;
int dump_rtn=0, inhibit=0, verbose=0, trace=0, old_probability=0;

void use_rtn(pRule rtn)
{
/*  emit_ps(outfile, rtn, mappings, transformations, 
	  (start_symbol)?start_symbol:initial_rule->symbol);*/
    emit_c(outfile, rtn, mappings, transformations, 
	  (start_symbol)?start_symbol:initial_rule->symbol);
};

main(int argc, char *argv[])
{
  int i;
  for(i=1; i<argc; i++) {
    if(*(argv[i])=='-')
      switch(argv[i][1]) {
      case 'o': outfile=fopen(argv[++i], "w"); break;
      };
  };
  yyparse();
};

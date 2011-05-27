/* pb.c  acb  11-7-1995
 * main part of the Dada Engine pb interpreter
 * before 11-7-1995, this was in parser.y
 */

#include <stdlib.h>
#include <string.h>
#include "rtn.h"
#include "check.h"
#include "map.h"
#include "transform.h"

static char *start_symbol = NULL; /* to override the default start symbol */
pRule rule_base;
extern pRule initial_rule;
int dump_rtn=0, inhibit=0, verbose=0, trace=0, old_probability=0, wrapwidth=80;
FILE *outfile;
extern int yydebug;


/* resolve a RTN */
void use_rtn(pRule rtn)
{
  if(!rtn) return;

  if(dump_rtn) { 
    dump_rules(rtn); 
    dump_mappings(mappings); 
    dump_transformations(transformations);
  }
  check_rtn(rtn);
  rule_base = rtn;
  if(start_symbol) {
    initial_rule=rule_find(rtn, start_symbol);
    if(!initial_rule) {
      fprintf(stderr, "rule \"%s\" does not exist.\n", 
	      start_symbol);
      exit(1);
    };
  };
  if(!inhibit) 
      if(wrapwidth) {
	  print_wrapped(outfile, resolve_rule(rtn, initial_rule), wrapwidth);
	  putc('\n', outfile);
      } else
	  fprintf(outfile, "%s\n", resolve_rule(rtn, initial_rule));
};

int strtoseed(char *s)
{
    int r=0;
    if(atoi(s))return atoi(s);
    while(*s) { r+=*(s++); }
    return r;
};

main(int argc, char *argv[])
{
  int i;
  char *p;

  char *rseed=NULL; /* a random seed, in string form */

  outfile = stdout;

  /* read environment variables as needed */
  if(p=getenv("COLUMNS")) wrapwidth=atoi(p);

  /* check command-line arguments */

  for(i=1; i<argc; i++) {
    if(*(argv[i])=='-')
      switch(argv[i][1]) {
      case 'd': dump_rtn = 1;
      case 'i': inhibit = 1; break;
      case 'o': outfile=fopen(argv[++i], "w"); break;
      case 'p': old_probability=1; break;
      case 'r': rseed = argv[++i]; break;
      case 's': start_symbol = argv[++i]; break;
      case 't': trace=1; break;
      case 'v': verbose = 1; break;
      case 'w': wrapwidth = atoi(argv[++i]); break;
      case 'y': yydebug=1; break;
      };
  };
  srandom(rseed?strtoseed(rseed):time(NULL));
  yyparse();
};

/* parser.y  yacc script for the parser for pb, the programmable
 * psychobabble generator.
 * author:         acb
 * commenced:      8-9-1994
 *
 * 28-9-1994:  Started adding grammatical elements for sed-style 
 *             transformations
 * 10-2-1995:  Started adding in conditional evaluation primitives
 * 14-2-1995:  Started adding in embedded imperative code
 * 13-5-1995:  Started adding in regular expression-style syntactic
 *             features, such as the Kleene star.
 * 4-7-1995:   Got the repeat operator working
 */

%{

#include <time.h>
#include <stdlib.h> /* NULL */
#include <stdio.h>
#include "rtn.h"
#include "check.h"
#include "map.h"
#include "transform.h"
#include "machine.h"
#include "ptrlist.h"

#define YYERROR_VERBOSE 1
#define YYDEBUG 1

pRule initial_rule=NULL;

#ifndef YYBISON
int yydebug=0;
#endif

pListNode transformations = NULL;
extern int verbose;

extern void use_rtn(pRule rtn);

%}

%union {
  double f;
  int i;
  char *s;
  pNode n;
  pOption o;
  pRule r;
  pParam p; /* superceded; pListNode is a generic list of pointer-sized 
	       scalar quantities */
  pListNode l;
  pMapAction ma;
  pMapOpt mo;
  int *pi;
  pTransCmd tc;
  pTransOpt to;
  pTransformation tr;
  pInstr c;
}

%token T_XFORM
%token T_COND

%token T_EXISTS
%token T_NUM
%token T_REPEAT
%token T_UNIQUE
%token T_ENUM
%token T_PICK
%token T_RESOURCE

%token <s> T_LITERAL
%token <s> T_IDENT
%token <f> T_NUM
%token <i> T_INTEGER

%type <r> rules
%type <r> rule
%type <o> options
%type <o> option
%type <n> atoms
%type <n> atom
%type <n> atom2
%type <p> params
%type <mo> mapopt
%type <mo> mapopts
%type <ma> mapaction
%type <pi> transaddr
%type <l> translist
%type <tc> transcmd
%type <to> transopt
%type <l> transopts

%type <c> imperatives
%type <c> imperative
%type <c> expr

%right '?'
%right T_DEREF
%left '>'

%left T_ELLIPSIS
%left 'V' 'G'
%left '-' '+'
%left '*' '/' '%'
%right T_UNIQUE T_ENUM T_PICK

%%

input: rules { use_rtn($1);
  /* if(dump_rtn) { 
                 dump_rules($1); 
		 dump_mappings(mappings); 
		 dump_transformations(transformations);
	       }
	       check_rtn($1);
               rule_base = $1;
	       if(start_symbol) {
		 initial_rule=rule_find($1, start_symbol);
		 if(!initial_rule) {
		   fprintf(stderr, "rule \"%s\" does not exist.\n", 
			   start_symbol);
		   exit(1);
		 };
	       };
	       if(!inhibit) fprintf(outfile, "%s\n", 
				    resolve_rule($1, initial_rule)); */}
;

rules: /* mu */ { $$ = NULL; }
       | rules rule { 
/*	              if(initial_rule==NULL) {
			initial_rule = $2;
			if(verbose)fprintf(stderr, "Start symbol == %s\n", 
				initial_rule->symbol);
		      };*/
		      /* FIXME: add check for duplicate rules here */
	              $$ = rule_insert($1, $2); 
		    }
       | rules mapping { $$ = $1; /* mappings != rules */ }
       | rules transformation { $$ = $1; /* mappings != rules */ }
;

rule: T_IDENT ':' options ';' { pRule r = rule_new($1, $3, NULL); 
                                if(initial_rule==NULL) {
           			  initial_rule = r;
			          if(verbose)
                                    fprintf(stderr, "Start symbol == %s\n", 
				                    r->symbol);
		                };
			        $$ = r;
			      }
    | T_RESOURCE T_IDENT ':' options ';' { pRule r = rule_new($2, $4, NULL); 
			                   $$ = r;
			                 }
    | T_IDENT '(' params ')' ':' options ';' { pRule r = rule_new($1, $6, $3); 
					       $$ = r;
					     }
;

transformation: T_XFORM T_IDENT ':' transopts ';' { 
  transformations = list_cons(new_transformation($2, $4), transformations); 
/*  fprintf(stderr, "Transformation: %s\n", 
	 ((pTransformation)transformations->data)->name);*/
}
;

transopts: transopt transopts { $$ = list_cons($1, $2); };
  | transopt { $$ = list_cons($1, NULL); }
;

transopt: T_LITERAL ':' transcmd { $$ = new_transopt($1, $3);
/*				   fprintf(stderr, "xform option: %s", $1);*/
				 }
;

transcmd: transaddr T_IDENT translist ';' { $$ = new_transcmd($1, $2, $3); }
;

transaddr: T_INTEGER { $$ = new_addr_range($1, $1); }
  | T_INTEGER ',' T_INTEGER { $$ = new_addr_range($1, $3); }
  | /* mu */ { $$ = NULL; }
;

translist: T_LITERAL translist { $$ = list_cons((void *)$1, $2); }
  | { $$ = NULL; }
;

mapping: T_IDENT ':' mapopts ';' { mappings = map_cons($1, $3, mappings); }
;

mapopts: mapopts mapopt { $$ = mapopt_concat($1, $2); }
  | mapopt { $$ = $1; }
;

mapopt: T_LITERAL 'M' mapaction { $$ = mapopt_cons($1, $3, NULL); }
  | T_LITERAL 'R' T_LITERAL { 
    $$ = mapopt_cons($1, new_replace_action($3),
		     mapopt_cons($3, new_replace_action($1), NULL));
  }
;

mapaction: T_LITERAL { $$ = new_replace_action($1); }
  | T_LITERAL '/' T_LITERAL { $$ = new_subst_action($1, $3); }
;

params: params T_IDENT { $$ = list_append($1, list_cons((void *)$2, NULL)); }
  | T_IDENT { $$ = list_cons((void *)$1, NULL); }
;

options: option '|' options { $$ = option_append($1, $3); }
       | option { $$ = $1; }
;

option: atoms { $$ = option_cons($1, NULL); }
;

atoms: atoms atom { $$ = node_append($1, $2); }
     | atom { $$ = $1; }
;

atom: atom2 { $$ = $1; }
    | atom '>' T_IDENT { pNode n = node_cons(mapping, $3, NULL);
			  n->params = $1;
			  $$ = n;
			}
    | T_DEREF atom { pNode n = node_cons(deref, NULL, NULL); 
		     n->params=$2; $$=n; }
    | T_IDENT 'V' atom { pNode n = node_cons(var_conddef, $1, NULL);
			 n->params = $3;
			 $$ = n;
		       }
    | T_IDENT '=' atom { pNode n = node_cons(var_def, $1, NULL);
			 n->params = $3;
			 $$ = n;
		       }
    | '$' T_IDENT { $$ = node_cons(var_ref, $2, NULL); }
    | '{' imperatives '}' { $$ = node_cons(code, (char *)$2, NULL); }
    | '?' atom { pNode n = node_cons(silence, NULL, NULL); n->params=$2; 
		 $$ = n; }
    | atom '*' { pNode n = node_cons(star, NULL, NULL); n->params=$1; $$=n; }
    | atom '+' { pNode n = node_cons(plus, NULL, NULL); n->params=$1; $$=n; }
    | '[' options ']' { pNode n = node_cons(choice, (char *)$2, NULL);
                        n->last_choice = -1; $$=n; }
    | T_REPEAT '(' atom ',' T_INTEGER ')' { 
      pNode n = node_cons(repeat_const, NULL, NULL);
      n->params = $3; n->int_param = $5;
      $$=n; }
    | T_REPEAT '(' atom ',' T_IDENT ')' { 
      pNode n = node_cons(repeat_var, NULL, NULL);
      n->params = $3; n->data = $5;
      $$=n; }
    | T_UNIQUE atom { pNode n=$2; n->mode = unique; $$=n; }
    | T_ENUM atom { pNode n=$2; n->mode = enumerate; $$=n; }
    | T_PICK '(' T_INTEGER ',' atom ')' { pNode n=$5; n->mode = pick; 
                                          n->pick_num=$3; $$=n; }
;

atom2: T_LITERAL { $$ = node_cons(literal, $1, NULL); }
    | T_IDENT { $$ = node_cons(symbol, $1, NULL); }
    | T_IDENT '(' atoms ')' { pNode n = node_cons(symbol, $1, NULL);
			      n->params = $3;
			      $$ = n;
			    }
;


imperatives: { $$ = NULL; }
| imperative { $$ = $1; }
| imperatives ';' imperative { $$ = icat($1, $3); }
;

imperative: T_IDENT '=' expr { $$ = icat($3, e_set($1)); }
| '=' expr { $$ = icat($2, e_simple(EMIT)); }
;

expr: T_INTEGER { $$ = e_push_int($1); }
| T_LITERAL { $$ = e_push_str($1); }
| T_IDENT { $$ = e_pushv($1); }
| T_DEREF T_IDENT { $$ = e_invoke($2); }
| '(' expr ')' { $$ = $2; }
| expr '+' expr { $$ = icat($1, icat($3, e_simple(ADD))); }
| expr '-' expr { $$ = icat($1, icat($3, e_simple(SUB))); }
| expr '*' expr { $$ = icat($1, icat($3, e_simple(MUL))); }
| expr '/' expr { $$ = icat($1, icat($3, e_simple(DIV))); }
| expr '%' expr { $$ = icat($1, icat($3, e_simple(MOD))); }
| expr T_ELLIPSIS expr { $$ = icat($1, icat($3, e_simple(RANDOM))); }
| expr 'V' expr { $$ = icat($1, icat($3, e_simple(LESSER))); }
| expr 'G' expr { $$ = icat($1, icat($3, e_simple(GREATER))); }
;

%%

extern int cur_line;
extern char cur_file[1024];

yyerror(char *s)
{
  fprintf(stderr, "%s:%i: %s\n", cur_file, cur_line, s);
};

#if 0

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

  char *rseed=NULL; /* a random seed, in string form */

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
      case 'y': yydebug=1; break;
      };
  };
  srandom(rseed?strtoseed(rseed):time(NULL));
  yyparse();
};

#endif

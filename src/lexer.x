%{
/* lexer.x  lexical analyser for pb, the psychobabble generator.
 *          author:         acb
 *          commenced:      8-9-1994
 */

#include <ctype.h>
#include "rtn.h"
#include "strfunc.h"
#include "map.h"
#include "transform.h"
#include "machine.h"
#include "y.tab.h"

int cur_line = 1;
char cur_file[1024]="Wibble.";  /* the name of the current file */
%}

%s COMMENT

delim		[ \t]
white 		{delim}+
digit		[0-9]
integer         (\-?){digit}+
real            (\-?){digit}+(\.{digit}+)
ident           [A-Za-z_][A-Za-z0-9_\-]*

%%

"\n"			{ cur_line++; }
"# "[0-9]+[^\n]*	{ /* the preprocessor is trying to tell us something */
			  sscanf(yytext+2, "%d %s", &cur_line, cur_file);
			  cur_line--;
			}
"#"[^\n]*		{ /* mu */; }
"//"[^\n]*		{ /* mu */; }
"/*"		{ BEGIN COMMENT; }
<COMMENT>"\n"	{ cur_line++; }
<COMMENT>"*/"	{ BEGIN 0; }
<COMMENT>[^\*\n]*	/* mu */
<COMMENT>"*"	/* mu */

{white}		/* mu */;
{integer}      { char *s=strnnew(yytext, yyleng); 
                  yylval.i = atoi(s);
                  free(s);
                  return(T_INTEGER); 
                }
{real}          { char *s=strnnew(yytext, yyleng); 
                  yylval.f = atof(s);
                  free(s);
                  return(T_NUM); 
                }
\"[^\"]*(\\.[^\"]*)*\" { /* return a literal */
                  yylval.s = strnnew(yytext+1, yyleng-2);
                  cookstr(yylval.s);
                  return T_LITERAL;
                };
"%trans"	{ return T_XFORM; /* transformation indicator */ };
"%cond"		{ return T_COND; /* conditional evaluation indicator */ };
"%exists"	
"%E"		
"%e"		{ return T_EXISTS; /* existential predicate */ };
"%num"	
"%N"		
"%n"		{ return T_NUM; /* number function */ };
"%repeat"	{ return T_REPEAT; };
"%unique"	{ return T_UNIQUE; /* uniqueness directive */ };
"%enum"		{ return T_ENUM; /* enumeration directive */ };
"%pick"		{ return T_PICK; /* enumeration directive */ };
"%resource"	{ return T_RESOURCE; /* prepended to non-startable rule */ };
{ident}		{ /* return the identifier */
                  yylval.s = strnnew(yytext, yyleng);
                  return(T_IDENT); }
"->"		{ return('M'); /* for "Mapping" */ }
"<->"		{ return('R'); /* for "Reversible mapping" */ }
"<<"		{ return('V'); /* for "variable definition" (also choose lesser) */ }
">>"		{ return('G'); /* for "greater" */ }
"@"		{ return(T_DEREF); }
".."		{ return(T_ELLIPSIS); }
[\|=;:\(\)\,\[\]\{\}\$\>\/\*\+\-\<\%\?]	return(*yytext);

%%

#ifndef yywrap
/* GNU flex doesn't need a yywrap() to be defined; lex (at least the lex from
DEC ULTRIX) does. */
int yywrap() { return 1; }
#endif/

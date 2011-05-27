#include <stdio.h>
#include "rtn.h"
#include "map.h"
#include "transform.h"
#include "y.tab.h"

YYSTYPE yylval;

main() {
  int i;
  while(i=yylex()) { 
    printf("lexer returns (%i)  ", i);
    switch(i) {
    case T_LITERAL:
      printf("literal text: <%s>", yylval);
      break;
    case T_IDENT:
      printf("identifier: <%s>", yylval);
      break;
    };
    putchar('\n');
  };
};

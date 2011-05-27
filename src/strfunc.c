/* strfunc.c  acb  12-6-1994
 * string-handling utility functions for pb, taken from rml
 */

#include <stdlib.h>
#include <string.h>
#include "strfunc.h"

#ifndef min
#define min(x,y) (((x)<(y))?(x):(y))
#endif

/* allocate a new string containing the first l characters of s */

char *strnnew(char *s, int l)
{
  int actl; /* actual length */
  char *result;
  if(!s) return NULL;
  actl = min(strlen(s), l);
  result = (char *) malloc(actl+1);
  strncpy(result, s, actl); 
  result[actl]=0;
  return result;
};

#ifndef HAVE_STRDUP
char *strdup(char *s) { return strnnew(s, strlen(s)); }
#endif

/* concat() allocates a new string and strcat()s two strings together into it. 
 */

char *concat(char *foo, char *bar)
{
  char *r;
  if(!foo && !bar) return NULL;
  if(!foo) return strnnew(bar, strlen(bar));
  if(!bar) return strnnew(foo, strlen(foo));
  r = (char *) malloc(strlen(foo)+strlen(bar)+1);
  if(r) {
    strcpy(r, foo);
    strcat(r, bar);
    r[strlen(foo)+strlen(bar)] = '\0';
  };
  return r;
};

/* cookstr() goes through the supplied string, converting escape sequences
   to the characters that they represent. Since this never increases the 
   length of the string, it is safe to do in situ. */

int cookstr(char *str)
{
  char *from=str, *to=str;
  while(*from) {
    if((*from)=='\\') {
      from++;
      if(*from) {
	switch(*from) {
	case 'n': *(to++) = '\n'; break;
	case 't': *(to++) = '\t'; break;
	case 'v': *(to++) = '\v'; break;
	case 'b': *(to++) = '\b'; break;
	case 'r': *(to++) = '\r'; break;
	case 'f': *(to++) = '\f'; break;
	case 'a': *(to++) = '\a'; break;
	default: *(to++)=*(from);
	};
	from++;
      };
    } else {
      *(to++)=*(from++);
    };
  };
  *to='\0';
  return to-from;
};

/* itoa() formats an integer into a string, allocated on the heap */

char *itoa(int i)
{ char buffer[16]; sprintf(buffer, "%i", i); return strdup(buffer); };

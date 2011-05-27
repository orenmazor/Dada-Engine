/* dstring.c  acb  20-9-1994
 * heap-allocated dynamic strings
 */

#include <stdlib.h>
#include <string.h>

/* concatenate two strings, freeing the originals */

char *dstrcat(char *a, char *b)
{
  char *r = (char *)malloc((a?strlen(a):0)+(b?strlen(b):0)+1);
  strcpy(r, a?a:""); strcat(r, b?b:"");
  if(a)free(a); if(b)free(b);
  return r;
};


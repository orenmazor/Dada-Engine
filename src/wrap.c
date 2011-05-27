/*  wrap.c  acb  65 Afm 3161
 *  a simple word-wrapping function
 */

#include <stdio.h>
#include <string.h>

#ifndef MIN
#define MIN(a,b) ((a<b)?(a):(b))
#endif

int nextword_length(char *s)
{
    if(s) {
	char *a=strchr(s, ' '), *b=strchr(s, '\n');
	int l=strlen(s), i=a?a-s:l, j=b?b-s:l;
	return MIN(i,j);
    } else return 0;
}

/* print_wrapped()  print text wrapped to a certain width to a file 
 *  arguments:      file object to output to
 *                  string to emit
 *                  number of columns to wrap to
 */

void print_wrapped(FILE *f, char *s, int cols)
{
    int start = 1;    /* are we at the start of a line? */
    int space=cols-1; /* how much space do we have left to fill? */

    while(*s) {
	int n=nextword_length(s);
	register int i;

	/* skip whitespace */
	while(!n && (*s)) { 
	    if(*s=='\n') {
		putc('\n', f);
		start = 1;
		space = cols-1;		
	    }
	    n=nextword_length(++s);
	}

	if(n>space && !start) {
	    /* break here */
	    putc('\n', f);
	    start = 1;
	    space = cols-1;
	} 

	space -= n+1;
	for(i=0; i<n; i++) putc(*(s++), f);
	putc(' ', f);
	start = 0;
    }
}

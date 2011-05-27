/*  util.h  acb  65 Afm 3161
 *  Utility routines used in the Dada Engine
 */

#ifndef __DADA_UTIL_H
#define __DADA_UTIL_H

/* print_wrapped()  print text wrapped to a certain width to a file
 *  arguments:      file object to output to
 *                  string to emit
 *                  number of columns to wrap to
 */


void print_wrapped(FILE *f, char *s, int cols);

#endif

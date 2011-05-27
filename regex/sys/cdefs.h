/*  cdefs.h  acb  66 Afm 3161 
 *  replace sys/cdefs.h for non-POSIX systems.  4.4BSD's regex needs this.
 */

#ifndef __CDEFS_H
#define __CDEFS_H

#if defined(__STDC__) || defined(__GNUC__) || defined(__cplusplus)

#ifndef __P
#define __P(a) a
#endif

#else

#ifndef __P
#define __P(a)
#endif


#endif

#endif

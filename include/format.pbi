//  format.pbi  acb  65 Afm 3161
//  Main Dada Engine include file, for selecting the output format from
//  preprocessor defines

#ifdef HTML
#include <html.pbi>
#else
#if defined(NROFF) || defined(TROFF) || defined(DITROFF)
#include <troff.pbi>
#else
#include <plain.pbi>
#endif

#endif
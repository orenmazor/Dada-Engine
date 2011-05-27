// troff.pbi  acb  49 Chs 3162
// Definitions for UNIX (n|t|dit)roff typesetting system output
// (with the ms macro package)

#ifndef __TROFF_PBI
#define __TROFF_PBI

#include <stdmap.pbi>

// PROLOGUE: format-specific prologue
// we don't want an abstract in our output

%resource PROLOGUE: {
  TROFF_footnote_num = 0
} ".ds ABSTRACT  \n" ;

// EPILOGUE: format-specific epilogue

%resource EPILOGUE: "" ;

// BODY: called when body text is to start

%resource BODY: "\n.AB\n.AE\n"
#ifdef TROFF_2COLUMN
".2C\n"
#endif
;

// TITLE(t): generates code at start of output for title

TITLE(t): "\n.TL\n" title>upcase-first ;

// AUTHOR(au):  generates a formatted author name; usually used after the
// title

AUTHOR(au): "\n.AU\n" au "\n" ;

// AUTHOR_INST(auth inst):  generates a formatted author name and institution;
// usually used after the title.

AUTHOR_INST(auth inst): "\n.AU\n" auth "\n.AI\n" inst"\n" ;

// SECTION(title):  generates a numbered section title.

SECTION(title): "\n.NH\n" title>upcase-first "\n.PP" ;

// FOOTNOTE(text):  generates a numbered footnote

FOOTNOTE(text): { TROFF_footnote_num = TROFF_footnote_num+1 }
  "\\*{" $TROFF_footnote_num "\\*}\n.FS\n" $TROFF_footnote_num ". " text 
  "\n.FE\n" ;

// BRK: generates a line break

%resource BRK: "\n.br\n";

// PBRK: generates a paragraph break

%resource PBRK: "\n.PP\n" ;

// ************************************************************************
//
// Text styles and the like
//
// ************************************************************************

BOLD(foo): "\\fB" foo "\\fR" ;
ITALIC(foo): "\\fI" foo "\\fR" ;

#endif

// plain.pbi  acb  13-7-1995
// Definitions for plain-text output for the Dada Engine.

#ifndef __PLAIN_PBI
#define __PLAIN_PBI

#include <stdmap.pbi>

// PROLOGUE: format-specific prologue

%resource PROLOGUE: {PLAIN_section_num=0; PLAIN_footnote_num=0; 
  PLAIN_footnotes="" } "";

// EPILOGUE: format-specific epilogue

%resource EPILOGUE: "\n\n----\n" $PLAIN_footnotes;

// BODY: called when body text is to start

%resource BODY: "";

// TITLE(t): generates code at start of output for title

TITLE(t): t "\n\n" ;

// AUTHOR(au):  generates a formatted author name; usually used after the
// title

AUTHOR(au): au "\n\n" ;

// AUTHOR_INST(auth inst):  generates a formatted author name and institution;
// usually used after the title.

AUTHOR_INST(auth inst): auth "\n" inst "\n\n";

// SECTION(title):  generates a numbered section title.

SECTION(title):  { PLAIN_section_num = PLAIN_section_num+1 } "\n\n" 
	$PLAIN_section_num ". " title>upcase-first "\n";

// FOOTNOTE(text):  generates a numbered footnote

FOOTNOTE(text): ?tx=text // the inline-code parameter bug^H^H^Hfeature.
 { PLAIN_footnote_num=PLAIN_footnote_num+1 } " [" $PLAIN_footnote_num "] "
{  // append the text to the accumulating footnotes
  PLAIN_footnotes = PLAIN_footnotes + PLAIN_footnote_num+". "+tx+"\n"
}
;

// BRK: generates a line break

%resource BRK: "\n";

// PBRK: generates a paragraph break

%resource PBRK: "\n\n";

// ************************************************************************
//
// Text styles and the like
//
// ************************************************************************

// here, text styles aren't really used.

BOLD(foo): foo ;
ITALIC(foo): foo ;

#endif

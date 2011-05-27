// html.pbi  acb  13-7-1995
// Definitions for HTML output for the Dada Engine.

#ifndef __HTML_PBI
#define __HTML_PBI

#include <stdmap.pbi>

// PROLOGUE: format-specific prologue

%resource PROLOGUE: { HTML_section_num=0; HTML_footnote_num=0 ; 
  HTML_footnotes=""
} "<html><head>" {HTML_BODY="</head><body>"};

// EPILOGUE: format-specific epilogue

%resource EPILOGUE: "<hr>\n" $HTML_footnotes "</body></html>";

// BODY: called when body text is to start

%resource BODY: $HTML_BODY {HTML_BODY=""};

// TITLE(t): generates code at start of output for title

TITLE(t): "<title>" t "</title>" $HTML_BODY { HTML_BODY="" } "<h1>" t "</h1>" "\n" ;

// AUTHOR(au):  generates a formatted author name; usually used after the
// title

AUTHOR(au): "<h2>" au "</h2>\n" ;

// AUTHOR_INST(auth inst):  generates a formatted author name and institution;
// usually used after the title.

AUTHOR_INST(auth inst): "<h2>" auth "<br>\n<i>" inst "</i></h2>\n";

// SECTION(title):  generates a numbered section title.

SECTION(title): { HTML_section_num=HTML_section_num+1 } "<h3>" 
	$HTML_section_num ". " title>upcase-first "</h3>\n" ;

// FOOTNOTE(text):  generates a numbered footnote

FOOTNOTE(text): ?tx=text // parameters can't be used in inline code as such
  { HTML_footnote_num=HTML_footnote_num+1 } "<a href=\"#fn" $HTML_footnote_num 
  "\">[" $HTML_footnote_num "]</a> " {  // append the text to the accumulating footnotes
  HTML_footnotes = HTML_footnotes + "<a name=\"fn" + HTML_footnote_num + "\"> " 
   + HTML_footnote_num + ". " + tx + "</a><p>\n"
}
;

// BRK: generates a line break

%resource BRK: "<br>\n";

// PBRK: generates a paragraph break

%resource PBRK: "<p>\n";


// ************************************************************************
//
// Text styles and the like
//
// ************************************************************************


BOLD(foo): "<b>" foo "</b>";
ITALIC(foo): "<i>" foo "</i>";


#endif

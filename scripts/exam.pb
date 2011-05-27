//  exam,pb  acb  sometime 3161
//  generate intimidating but bogus exam questions

question: question-2 | question-2
	| question-2 "Be sure to refer to " issue " in your answer. "
	| question-2 "Include " evidence-type ". "
;

question-2: "Compute the " something-of " of " something ". "
	| "Are " plural " " classification "? Discuss. "
	| "Is " singular " " classification "? Discuss. "
	| "Express " something " in " express-in-what ". "
	| "Show that the " something-of " of " something " is " result ". "
;

issue: theorem-source "'s Theorem" | theory-type " theory"
	| "Plutonium Atom Totality" | "the " ordinal " law of " law-of-this
;

theorem-source: "Godel" | "Wibbel" | "Abian" | "Turing" | "Euler"
	| "Fermat" | "Bell"
;

theory-type: "game" | "set" | "match" | "interstice" | "information"
	| "ring" | "group" | "graph"
;

law-of-this: "thermodynamics" | "conservation of matter" | "gravity"
;

express-in-what: "canonical form" | "normal form" | "the " tag " domain" ;

something-of: something-of-2 | adjective " " something-of-2 
	| tag "-" something-of-2 ;

adjective: "canonical" | "minimal" | "maximal" | "inverse" ;

something-of-2: "closure" | "determinant" | "matrix" | "path" | "correlation" ;

plural: adjective " " plural-2 ;

pluralise: ".*" -> "$"/"s" ;

plural-2: "trees" | "matrices" ;

singular: adjective " " singular-2 ;

singular-2: "search" | "factorisation" ;

result: number | "{ }" | "infinity" | "uncomputable" | "the null set" ;

evidence-type: "flowcharts" | "Feynman diagrams" | "Venn diagrams"
;

something: number | set-of-numbers ;

set-of-numbers: "{ " numbers " } " ;

numbers: number " " numbers | number ;

number: digit number | digit ;

digit: "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;

classification: tag "-complete"
;

// a tag, used to make concepts seem more intimidating

tag: greek-letter | roman-letter | roman-letter roman-letter;

roman-letter: "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" | "I" | "J"
	| "K" | "L" | "M" | "N" | "O" | "P" | "Q" | "R" | "S" | "T" | "U"
	| "V" | "W" | "X" | "Y" | "Z" ;

greek-letter: "alpha" | "beta" | "gamma" | "delta" | "epsilon" | "lambda" | 
	"sigma" | "theta" | "phi" | "rho" | "omega" ;

ordinal: "first" | "second" | "third" | "fourth" | "fifth" ;


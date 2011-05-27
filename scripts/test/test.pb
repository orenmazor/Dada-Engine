// test.pb  acb  10-9-1994
// test script for psychobabble.
// With apologies to Lewis Carroll.

// the start symbol

sentence : np " " vp "." ;

// noun phrase

np 	: prep " " noun
	| prep " " adj " " noun
	;

prep	: "a" | "the";

adj	: "brillig" | "slithy" | "mimsy" | "frumious" | "vorpal" | "manxome"
	| "uffish" | "tulgey" | "frabjous" ;

// singular nouns
noun	: "frob" | "goret" | "beable" | "widget" | "futplex" ;

vp	: pverb " " np
	| "shall " fverb " " np
	| fverb " " np
	;

pverb	: "frobnicated" | "frobbed" | "wugged" ; 

fverb	: "frobnicate" | "frob" | "wug"; #the last verb dedicated to Chickenman


// a simple script to test regex-based mappings

// a mapping definition: this one is a simple rule for converting plural nouns
// to singular ones

depluralise:
	".*s" -> "s$" / ""
;

// another one: this time, it converts (some) verbs to past tense.

pasttense:
	".*" ->	"$" / "ed"
;

// productions follow

sentence: np " " vp ;

np: //"the " noun
//	| 
	"a " noun>depluralise  # trim off any trailing 's's
	;

vp: "shall " verb
	| verb>pasttense
;

noun:	"bees" | "boy" | "ball" | "balloons" ;

verb:	"touch" | "kick" | "mention" ;

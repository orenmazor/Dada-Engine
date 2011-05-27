// a grammar for making manifestoes; parts culled from the postmodernism
// grammar and other places.
// acb  sometime in 1995


S: prologue body epilogue ;

prologue: { pointnum=1 } ;

body: title points ;

epilogue: "" ;

title: "The " movement " Manifesto:\n" ;

movement: movement-prefix movement-2 | movement-prefix movement 
	| movement-prefix movement-2 | movement-prefix movement 
;

movement-prefix: "Neo" | "Sur" | "Para" | "Pata" | "Meta" | "Post" | "Anti"
	| "Non" | "Cyber"
;

movement-2: "Nihilist" | "Existentialist" |  "Realist" | "Objectivist"
	| "Ismist" | "Positivist" | "Negativist"
;

points: points points point 
	| points point point 
	| point point 
;

point: $pointnum ". " statement "\n" 
	{ 
	pointnum=pointnum+1
	} ;

statement: big-thing " is dead."
	| big-thing " is dead; " is-dead-explanation
	| big-thing " is a myth."
	| big-thing " is an illusion."
	| attribute-paradox-1(attribute)
	| thing-paradox-1(abstract-noun)
	| "there is no " nonbeable ". "
	| "those who " do-silly-thing " are " plural-derog-noun ". "
	| "we are all " what-we-are "."
	| big-thing " is nothing more than " mere-thing "."
;

mere-thing: "noise" | "the background noise of " big-thing 
	| "a stupid game" | "an obscene jest" | "a bad joke"
;

what-we-are: what-we-are-2 | what-we-are-2 " who think they're " human-adj
	| "liars"
	| "victims of " big-thing | "doomed to endless " endless-thing-2
;

// uniquely human, positive traits
human-adj: "conscious" | "free" | "intelligent" | "self-aware" ;

what-we-are-2: "automata" | "sheep" | "puppets" ;

do-silly-thing: "believe that " silly-belief
	| "seek " ideal-positive-attribute
	| "seek " ideal-positive-attribute " in " big-thing
;

silly-belief: "there is " nonbeable>prepend-a-or-an
	| big-thing " will save " big-thing
	| big-thing " is " higher-state-of-being
;

higher-state-of-being: "transcendent" | "liberating" | "independent"
	| "free" | "unlimited" | "beneficial"
;

plural-derog-noun: "fools" | "idiots"
;

prepend-a-or-an:
	"a*" -> "^"/"an "
	"e*" -> "^"/"an "
	"i*" -> "^"/"an "
	"o*" -> "^"/"an "
	"u*" -> "^"/"an "
	"*"  -> "^"/"a "
;

nonbeable: "escape" | "God" | "Santa Claus" | "free lunch" | "salvation"
	| "hope" | "recovery" | "Maxwell's Demon" | "end to the " endless-thing
;

endless-thing: endless-thing-2 | "continuum of " endless-thing-2 ;

endless-thing-2: "monotony" | "recursion" | "redundancy"
;

// paradoxes, paradoys and paradozzes

thing-paradox-1(thing): thing " is the " maximum-adj " " opposite(thing) ". "
;

maximum-adj: "greatest" | "first" | "biggest" | "original" 
;

abstract-noun: "truth" ;

attribute-paradox-1(attribute): 
	"the most " attribute " thing is the " completely-synonym
	" " opposite(attribute) 
	"."
	| "there is nothing more " attribute " than that which is "
	opposite(attribute) "."
;

completely-synonym: "completely" | "totally" | "absolutely" ;

attribute: "true" | "meaningful" | "false" ;

opposite(word): @word>opposite-map>append-synonyms ;

opposite-map:
	"true" <-> "false"
	"meaningful" <-> "absurd"
	"truth" <-> "lie"
;

append-synonyms:
	".*" -> "$"/"-synonyms" 
;

true-synonyms: "true";
false-synonyms: "false";
meaningful-synonyms: "meaningful";
absurd-synonyms: "absurd" | "meaningless";
lie-synonyms: "lie" ;

// words above are dereferenceable


// rules for "* is dead"-type sentences

is-dead-explanation: big-thing " killed it. "
	| "it committed suicide. "
	| "the cause of death is " cause-of-death ". "
	| "it died of " cause-of-death
;

cause-of-death: "gluttony" | "boredom" | "infinite recursion"
	| "despair at its own " introspective-attribute
	| "infinite regress"
	| introspective-attribute
;

introspective-attribute: "futility" | "absurdity" | "meaninglessness"
	| "lack of " ideal-positive-attribute
;

ideal-positive-attribute: "coherency" | "consistency" | "meaning" | "truth"
;


// stuff culled from pomo 
// and hacked over a bit

big-thing: "society" | "class" | "civilisation"
	| "culture" | "language" | "art" | "reality" | "truth" 
	| "sexuality" | "consciousness" | "humanity" | "personhood"
	| "individuality" | "history" | "technology" ;

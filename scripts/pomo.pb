// pomo.pb  acb  ??-09-24 AU
// pb script for generating postmodern verbiage
// Updated, format-independent version
// Copyright (C) 1995, 1996 Andrew C. Bulhak
// this script is property of acb. You are permitted to use, modify and
// distribute it as long as this notice is retained and any modifications
// in distributed copies are clearly denoted.

// if we're using troff, we want two columns

#define TROFF_2COLUMN

#include <stdmap.pbi>
#include <format.pbi>

// global variables used:
//  v-citable			name of artist who is cited throughout text
//  v-subject, v-subject-2	a noun about which this rant is (i.e., a term)
//  v-subject-3			as above, but changes in each section

// mappings start here

// trim trailing 'e's from word. Used when deriving "deconstructivist" from
// "deconstructive", for instance.

trim_e:
	".*e$" -> "e$"/""
;

strip_the:
	".*" -> "^[Tt]he "/""
;

// make an artist's name into the symbol representing his/her works

make_cite:
	".*" -> "$"/"-works"
;

make_concepts:
	".*" -> "$"/"-concepts"
;

pluralise:
	".*y$" -> "y$"/"ies"
	".*s$" -> "$"/"es"
	".*" -> "$"/"s"
;

past-tensify:
	".*e" -> "$"/"d"
	".*" -> "$"/"ed"
;

// production rules start here
//
// rules with names preceded with p- are parametric versions of other rules; 
// they accept parameters (usually for important elements)

//test: p-sentence-about-concept("foo") ;

output: PROLOGUE TITLE(title>upcase-first) formatted-authors 
  BODY sections EPILOGUE ;

title: title2>upcase-first | candid-title ": " title2>upcase-first ;

title2: 
	v-subject<<new-term " in the works of " v-citable=citable-artist
	| v-subject<<new-term " in the works of " artist
	| v-subject-2<<new-term " in the works of " v-citable=citable-artist
	| p-two-term-title(v-subject<<new-term v-subject-2<<new-term)
	| p-two-term-title(v-subject<<ideology v-subject-2<<new-term)
	| p-two-term-title(v-subject<<art-movement v-subject-2<<new-term)
	| p-three-term-title(v-subject<<art-movement v-subject2<<ideology new-term)
;

// a "foo and bar" title
p-two-term-title(foo bar): foo " and " bar | bar " and " foo ;

p-three-term-title(foo bar baz): foo ", " bar " and " baz 
	| foo ", " baz " and " bar
	| bar ", " foo " and " baz
	| bar ", " baz " and " foo
	| baz ", " foo " and " bar
	| baz ", " bar " and " foo
;

candid-title: doing-something-to>upcase-first " " intellectual
	| adj>upcase-first " " abst-noun>pluralise>upcase-first
	| "The " concrete-adj>upcase-first " " concrete-noun>upcase-first
	| "The " something-of-2>upcase-first " of " big-nebulous-thing>upcase-first
	| "The " something-of-2>upcase-first " of " big-thing>upcase-first
	| "The " big-nebulous-thing>upcase-first " of " something-of-2>upcase-first
	| big-nebulous-thing>pluralise>upcase-first " of " something-of-2>upcase-first
	| doing-something-to-movement>upcase-first " " art-movement>upcase-first
;

concrete-adj: "vermillion" | "circular" | "broken" | "forgotten" | "stone"
	| "iron" | "burning"
;
// symbolic-type objects
concrete-noun: "door" | "fruit" | "key" | "sky" | "sea" | "house" ;

doing-something-to: "reading" | "deconstructing" | "forgetting"
;

doing-something-to-movement: "reinventing" | "deconstructing"
	| "reassessing"
;

formatted-authors: authors ;

authors: authors author | author | author ;

//author: ".AU\n" name "\n.AI\n" department ", " acad-institution "\n" ;
author: AUTHOR_INST(name [department ", " acad-institution]);

// department

department: "Department of " dept-topic ;

dept-topic:	
	"English" | "Literature" | "Politics" | "Sociology" |
	"English" | "Literature" | "Politics" | "Sociology" |
// political correctness here
	"Gender Politics" | "Peace Studies" |
	"Future Studies" |
// slightly silly, perhaps
	"Ontology" | "Semiotics" | "Deconstruction" | "Sociolinguistics"
;

// institutions from whence authors come; biased towards computer-science-type
// institutions ;-)

acad-institution:	"Massachusetts Institute of Technology"
	| "Stanford University"
	| "Carnegie-Mellon University"
	| "University of California, Berkeley"
	| "University of Illinois"
// but who could forget Doctress Fruitopia's alma mater.....
	| "University of Massachusetts, Amherst"
	| "University of " university-of
	| "University of " university-of
	| something-university " University"
	| something-university " University"
// ...and, of course....
	| "Miskatonic University, Arkham, Mass."
;

university-of: "California" | "Illinois" | "Georgia" | "Massachusetts"
	| "Michigan" | "North Carolina" | "Oregon"
;

something-university: "Oxford" | "Harvard" | "Cambridge" | "Yale"
;

sections: sections section | sections section | section ;

//section: "\n.NH\n" section-title>upcase-first "\n.PP\n" paragraphs ;
section: SECTION(section-title) PBRK paragraphs ;

section-title: term " and " v-subject-3=new-term 
	| v-citable<<citable-artist " and " term
	| big-nebulous-thing>pluralise " of " something-of-2
;

// stack the odds towards the creation of more text

paragraphs: intro-paragraph PBRK paragraphs-2 ;

paragraphs-2: paragraphs PBRK paragraph 
	| paragraphs PBRK paragraph 
	| paragraphs PBRK paragraph
	| paragraph PBRK paragraph "\n\n" paragraph
	| paragraph PBRK paragraph ;

intro-paragraph: intro-sentence paragraph ;

paragraph: paragraph sentence | sentence ;

sentence:	sentence2>upcase-first | preamble>upcase-first sentence2 ;

sentence2 : 
	assumption " " implies-that result ". "
	| intellectual " uses the term '" term "' to denote " concept-desc ". "
	| justifier "we have to choose between " term " and " term ". "
	| "the " main " theme of " work	" is " concept-desc ". "
	| intellectual " " promotes " the use of " term " to " imper-vp ". "
	| plural-numeric-adj " " abst-noun>pluralise abst-description " " 
		exist ". "
	| sentence-about-citable-artist(v-citable<<citable-artist)
	| "the subject is " neut-verb>past-tensify " into a " term>strip_the " that includes " big-abst-thing " as a " big-singular-thing ". "
//	| p-sentence-about-concept(term)
;

// sentences especially suited for introductions to paragraphs.

p-intro-sent-thing-state(th st): "\"" th>upcase-first " is " st ",\" says " intellectual 
"; however, according to " foo=generic-surname footnote-cite($foo)
", it is not so much " th " that is " st ", but rather the " something-of " of "
th ". "
;

intro-sentence:	intro-sentence2>upcase-first ;

intro-sentence2: "\"" pseudo-quote>upcase-first ",\" says " intellectual ". "
	| p-intro-sent-thing-state(big-thing state-of-being)
	| "If one examines " term ", one is faced with a choice: either "
	accept-or-reject " " term " or conclude that " result ". "
	| "In the works of " v-citable<<citable-artist 
	", a predominant concept is " predominant-concept ". "
	| "the " main " theme of " work	" is " concept-desc ". "
;

predominant-concept: "the distinction between " foo = dualisable-word " and " $foo>opposite
	| "the concept of " adj " " big-abst-thing
;

// pseudo-quotes; no terminating punctuation.
pseudo-quote: big-thing " is " state-of-being
;

// we'll be ontologically masturbating in relation to the works of various
// artists and "artists" a lot.....

sent-about-citable-and-dualism(artist dualism):  
	@artist>make_cite " is about " dualism " where " @artist>make_cite
	" is about " dualism>opposite
;

sentence-about-citable-artist(artist): "the " feature-of " " @artist>make_cite 
	" " is-also-evident-in " " @artist>make_cite adverb-postjustify ". "
//	| sent-about-citable-and-dualism(artist dualism)
	| "in " @artist>make_cite ", " artist " " says-something "; in "
	@artist>make_cite however " " artist " " says-something-else(artist) 
	". "
	| justifier "the works of " artist " are " works-state-of-being ". "
;

something-about-works: ""
	| " the use of narrative in"
	| " the gender roles in"
	| " the semiotics of"
;

works-state-of-being: "postmodern" | "not postmodern" | "modernistic" 
	| "an example of " informal-adj " " ideology
	| "reminiscent of " artist
	| "empowering"
;

says-something: makes-statement-about " " term ;

says-something-else(artist): says-something 
//	| "changes " artist>artist-gender-pronoun " opinion completely, instead concentrating on " term
;

makes-statement-about: "affirms" | "denies" | "reiterates" | "deconstructs"
	| "examines" | "analyses" ;

feature-of: dualism-desc " distinction " in-term 
	| "example of " term " " in-term 
	| something-of " of " term " " in-term
;

is-also-evident-in: "emerges again in" | "is also evident in" ;

in-term: "prevalent in" | "intrinsic to" | "depicted in" 
	| "which is a central theme of" ;

adverb-postjustify: "" | ", although in a more " informal-adj " sense" ;

work: foo=generic-surname "'s" footnote-cite($foo) work-about " " term
	| "the works of " v-citable<<citable-artist
;

// parametric sentences: a parametric sentence about a concept

// an abstract alternative

accept-or-reject: "accept" | "reject" ;

p-abst-altern(conc): p-abst-altern-2(conc) | p-abst-altern-2(conc) 
	" and consequently " accept-or-reject " that " result
;

p-abst-altern-2(conc): accept-or-reject " " idea-source "'s " work-about 
	" " conc
;

p-sentence-about-concept(conc): "the " role " has a choice: either " 
	p-abst-altern(conc) " or, alternatively, " p-abst-altern(conc)
	". "
;

// descriptions of abstract things, like theories and discourses

// the general case
abst-description: " concerning " term-or-concept-desc
;

abst-desc-plural: abst-description | " that includes " ;

term-or-concept-desc: term | concept-desc ;

plural-numeric-adj:	"any number of" | "a number of" | "many"
	| "an abundance of" | "several"
;

// "a number of things *"

exist:	"exist" | "may be " found ;

found:	"found" | "discovered" | "revealed" ;

promotes: "promotes" | "suggests" ;

// imperative verb phrase "use narrative to *"

imper-vp: imper-neg-verb " " bogeyman
	| imper-verb " " big-thing
;

// something you want to do to something bad

imper-neg-verb: "attack" | "challenge" | "deconstruct" ;

imper-verb: imper-verb2 | imper-verb2 " and " imper-verb2 ;

imper-verb2: imper-neg-verb | "analyse" | "read" | "modify" ;

main-theme-of: main " theme of " | "theme characterizing"
;

main: "main" | "primary" | "characteristic" ;

// something to ``justify'' a point.

justifier:	just-name=generic-surname footnote-cite(just-name<<generic-surname) implies-that
	| "if " term " holds, "
;

// a description of a concept

concept-desc:	"the " something-of " of " adj " " big-thing
	| "the " something-between " between " big-thing " and " big-thing
	| p1-concept-desc(abst-noun)
	| "the role of the " role " as " role
	| "a " informal-adj " " big-singular-thing
;

// parametric concept descriptions, taking a noun

p1-concept-desc(thing): "not" in-fact " " thing ", but " modifier-prefix thing
  | "not " thing per-se", but " modifier-prefix thing
;

// redundant smalltalk

in-fact: ", in fact, " | ""
;

per-se: " as such" | " per se" | ", as " intellectual " would have it"
	| ", as " term " suggests" | ""
;

// modifier prefix; used to modify a word.

modifier-prefix: "post" | "neo" | "sub" | "pre" ;

something-between:	"difference" | "bridge" | "common ground" ;

thus: "thus" | "hence" | "therefore" ;

something-of: 	something-of-2 
	| something-of-2 ", and subsequent " something-of-2 ","
	| something-of-2 ", and " thus " the " something-of-2 ","
	| something-of-2 ", and eventually the " something-of-2 ","
	| something-of-2 ", and some would say the " something-of-2 ","
;

something-of-2:	"failure" | "futility" | "collapse" | "fatal flaw"
	| "rubicon" | "stasis" | "meaninglessness" | "absurdity" | "paradigm"
	| "genre" | "defining characteristic" | "dialectic" | "economy" 
;

// preamble; redundant preamble to sentence

preamble:	"however, "
	| "it could be said that "
	| "thus, "
	| "therefore, "
	| "in a sense, "
	| "but "
;

// redundant word between other words, like "however"

however: " " | ", however, " | ", although, " ;

// result: "It is stated that *"

result: result-2 | result-2 postcondition ;

result-2:
	big-abst-thing is-used-to ends
	| big-nebulous-thing comes-from source
	| big-thing optional-adv " has " property
	| big-abst-or-institution " is " state-of-being
	| "the "  purpose-word " of the " role " is " goal
	| big-abst-or-institution " is capable of " capability
;

result--1: result | "we can assume that " result
	| intellectual "'s model of " term " is one of \"" new-term "\", and "
	thus " " state-of-being
;

// something that can be used as an assumption: "If * holds", 
assumption:	term
	| intellectual "'s " work-about " " term
	| "the premise of " term
;

// binary relations

relation: " is equal to " | " is distinct from " | " is interchangeable with "
;

// value-adjectives "the conceptual paradigm of discourse is *"

value-adj: "valid" | "invalid" ;

// a primitive condition: "Assuming that *,..."

prim-condition:	assumption " is " value-adj
	| big-abst-thing relation big-abst-thing
;

// corollary: "...as long as foo is bar*"

corollary: "; if that is not the case, " result--1
	| "; otherwise, " result--1 
	| ""
;

postcondition: ", given that " prim-condition
	| ", but only if " prim-condition corollary
	| ""
;

abst-adverb: "fundamentally" | "intrinsically"
;

// i.e., "language is *"
state-of-being:	state-of-being-2 | abst-adverb " " state-of-being-2
	| "part of the " something-of-2 " of " big-abst-thing 
;

state-of-being-2:	"impossible" | "meaningless" | "unattainable"
	| "elitist" | "responsible for " bogeyman 
	| "used in the service of " bogeyman
	| "a legal fiction" | "dead"
;

property:	"intrinsic meaning" | "significance" | "objective value"
;

// ends: "foo is used to *". Predominantly negative.

ends:	neg-verb " " victim
	| pos-neg-verb " " bogeyman
;

implies-that:	"implies that " | "states that " | "holds that " 
	| "suggests that " 
;

is-used-to:	" is used to " | " serves to " | " may be used to "
;

comes-from:	" comes from " | " must come from " | " is a product of "
	| " is created by " 
;

source:	"communication" | "the collective unconscious" | "the masses"
;

// either give a new term or rehash the old term

term:	new-term
	| v-subject<<new-term
	| v-subject-2<<new-term
	| v-subject-3<<new-term
;

new-term: p-intell-term(intellectual)
	| adj " " abst-noun
	| adj " " abst-noun
	| adj " " adj " theory"
	| "the " adj " paradigm of " big-nebulous-thing
	| adj " " ideology
;

// term about an intellectual
// FIXME:  "Foucauldian" instead of "Foucaultist"
p-intell-term(i): i"ist " @i>make_concepts
;


ideology: "capitalism" | "Marxism" | "socialism" | "feminism"
	| "libertarianism" | "objectivism" | "rationalism" | "nationalism"
	| "nihilism"
;

art-movement: "surrealism" | "modernism" | "realism" | "social realism"
	| "socialist realism" | "constructivism" | "expressionism"
;

adjectivise-ism:
	".*ism" -> "ism$"/"ist"
;

self-adj: "referential" | "sufficient" | "justifying" | "supporting"
	| "falsifying" | "fulfilling"
;

// an adjective which may not be used in formal terms
informal-adj: adj | "self-" self-adj | "mythopoetical" ;

adj:	adj2
	| modifier-prefix  adj2
;

// an adj2 is an adjective which may end with "ist" or not.
adj2:	"capitalist" | adj3 | adj3>trim_e "ist" | "cultural" | "dialectic"
	| "textual"
;

adj3:	"structural" | "semiotic" | "modern" | "constructive" | "semantic"
	| "deconstructive" | "patriarchial" | "conceptual" | "material" 
;

// adverbs

optional-adv: "" | ", " adv "," ;

adv:	adv-2 | "perhaps " adv-2 | "somewhat "adv-2 ;

adv-2:	"paradoxically" | "surprisingly" | "ironically" ;

abst-noun:	abst-noun2
	|	"theory"
	|	"discourse"
	|	"narrative"
	|	"de" abst-noun2
;

abst-noun2:	"sublimation"
	|	adj3>trim_e "ism"
	|	"construction"
	|	"appropriation"
	|	"materialism"
	|	"situationism"
;

// verbs for bad concepts

neg-verb:	"marginalize" | "exploit" | "oppress" | "disempower" ;

pos-verb:	"empower" ;

neut-verb:	"interpolate" | "contextualise" ;

// verbs positive to negative concepts

pos-neg-verb:	"reinforce" | "entrench" ;

// victims

victim:	"minorities" | "the Other" | "the underprivileged" | "the proletariat"
;

// bogeymen

bogeyman:	"capitalism" | "hierarchy" | "the status quo" 
	| "class divisions" | "sexism" | neg-adj " perceptions of " big-thing
;

neg-adj: neg-adj1 | neg-adj2 | neg-adj1 ", " neg-adj2 ;

neg-adj1: "outdated" | "outmoded" | "archaic" ;

neg-adj2: "sexist" | "colonialist" | "elitist" ;

work-about:	"critique of" | "essay on" | "analysis of" | "model of" ;

big-thing:	"society" | "class" | big-abst-thing | "sexual identity" ;

big-abst-thing:	"culture" | "language" | "art" | "reality" | "truth" 
	| "sexuality" | "narrativity" | "consciousness" ;

institution:	"the Constitution" | "the media" | "academe" | "the law"
	| "government" | "the State" | "the collective" | "the establishment" ;

big-abst-or-institution: big-abst-thing | institution ;

// nebulous things: "* is a product of communication"
big-nebulous-thing:	"reality" | "discourse" | "concensus" | "expression"
	| "narrative" | "context" 
;

// "narrativity as a *"

big-singular-thing: "reality" | "whole" | "paradox" | "totality" ;

// "The discourse of *"

abst-concept: "domination" | "difference" ;

purpose-word: "purpose" | "goal" | "raison d'etre" | "task" | "significance" ;

// roles, "deconstruction is the task of the *"

role: "artist" | "observer" | "participant" | "reader" | "poet" | "writer" ;

// goals: "the goal of the artist is *"

goal: "significant form" | "deconstruction" | "social comment" ;

capability: goal | intent-variant | "truth" | "significance" ;

intent-variant: "intent" | "intention" | "intentionality" ;

// dualities

dualisable-word: "opening" | "closing" | "figure" | "ground" 
	| "within" | "without" | "creation" | "destruction" 
	| "masculine" | "feminine" ;

opposite:
	"opening" -> "closing"
	"closing" -> "opening"
	"figure" -> "ground"
	"ground" -> "figure"
// I just added reversible mappings
	"within" <-> "without"
	"creation" <-> "destruction"
	"masculine" <-> "feminine"
;

i-dualism-desc(word): word "/" word>opposite ;

dualism-desc: i-dualism-desc(dualisable-word) ;

// names of intellectuals cited in pomo texts

intellectual:	"Lacan" | "Derrida" | "Baudrillard" | "Sartre" |
	"Foucault" | "Marx" | "Debord" | "Bataille" | "Lyotard" | "Sontag"
;

// authors of books; not major intellectuals AFAIK

author: "Lodge" | "Huyssen" | "Cooke" | "Owens" | "Johnston" | "Olsen"
	| "Giddens" | "Milner" ;

// names, randomly generated

name: first-name " " generic-surname 
	| first-name " " initial generic-surname 
	| first-name " " initial initial generic-surname 
	| initial first-name " " generic-surname ;

// first names, used for making names

first-name: 
// French names
	"Jean-" jean-suffix | jean-suffix
// Germanic names
	| "Andreas" | "Hans" | "Rudolf" | "Wilhelm" | "Stefan" | "Helmut" 
	| "Ludwig"
// generic or English-sounding names
	| "David" | "John" | "Linda" | "Charles" | "Thomas"
	| "Barbara" | "Jane" | "Stephen" | "Henry" | "Agnes" | "Anna"
	| "Paul" | "Catherine" | "Martin"
;

jean-suffix: "Michel" | "Luc" | "Jacques" | "Jean" | "Francois"
;

// the surnames of people I know (of), used for effect.

generic-surname: 
// random intellectuals ;-)
"de Selby" | "Hanfkopf" | "la Fournier" | "la Tournier" | "Hamburger" |
// Lovecraftean scholars
"von Junz" | "d'Erlette" | "Geoffrey" | "Prinn" |
// people from g09, monash.test or the AlphaLab
"Bailey" | "Brophy" | "Cameron" | "Humphrey" | "Pickett" 
| "Reicher" | "Sargeant" | "Scuglia" | "Werther" | "Wilson" 
// net.crackpots
| "McElwaine" | "Abian" | "von Ludwig" // Plutonium's real name
| "Parry" | "Drucker" | "Dahmus" | "Dietrich" // a Monash local
| "Hubbard" 
// People from flat-earth, particularly those who helped with the Dada Engine
| "Porter" | "Buxton" | "Long" | "Tilton" | "Finnis"
;

// Initials

initial: "A. " | "B. " | "C. " | "D. " | "E. " | "F. " | "G. " | "H. "
	| "I. " | "J. " | "K. " | "L. " | "M. " | "N. " | "O. " | "P. "
	| "Q. " | "R. " | "S. " | "T. " | "U. " | "V. " | "W. "
	| "Y. " | "Z. "
;

initials: initial | initial initial | initial initial initial ;

year: "19" decade-digit digit ;

decade-digit: "7" | "8" ;

digit: "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;

// publishers

publisher:
// serious pomo publishers
	"University of " university-of " Press"
	| "University of " university-of " Press"
	| something-university " University Press"
	| something-university " University Press"
// technical publishers
	| "O'Reilly & Associates"
// other
	| "And/Or Press" | "Loompanics" | "Panic Button Books"
	| "Schlangekraft"
;

// a footnote, in the *roff ms package.

opt-ed: "" | "ed. " ;

footnote-cite-text(surname): surname ", " initials opt-ed "(" year ") "
	ITALIC([title "."]) " " publisher;

footnote-cite(surname): FOOTNOTE(footnote-cite-text(surname)) ;

// sources of quotes, cites, etc.

idea-source: intellectual | author | hist-intel ;

// intellectuals who are part of the historical landscape

hist-intel: "Plato" | "Voltaire" | "Nietzsche" | "Kant" | "Hegel"
	| "Hume" ;

// minor luminaries; those who are significant but not central to pomo


// names of artists whose work may be analysed and deconstructed
// Citable artists are those whose names can map to rules listing their
// works.

artist: citable-artist | uncitable-artist ;

citable-artist: "Burroughs" | "Joyce" | "Gibson"
	| "Stone" | "Pynchon" | "Spelling" | "Tarantino" | "Madonna" 
	| "Rushdie" | "Eco" ;

uncitable-artist: "Koons" | "Mapplethorpe" | "Glass" | "Lynch" | "Fellini" 
	| "Cage" | "McLaren" ;

artist-gender-pronoun:
	"Burroughs" -> "he"
	"Joyce" -> "he"
	"Gibson" -> "he"
	"Stone" -> "he"
	"Pynchon" -> "he"
	"Spelling" -> "he"
	"Tarantino" -> "he"
	"Madonna" -> "she"
;

possessivify-pronoun:
	"he" -> "his"
	"she" -> "her"
	"it" -> "its"
	"SHe" -> "hir"
;

// works of citable artists

Spelling-works:  "Beverly Hills 90210" | "Melrose Place" | "Models, Inc." ;

Pynchon-works: "Gravity's Rainbow" | "Vineland" | "The Crying of Lot 49" ;

Stone-works: "JFK" | "Natural Born Killers" | "Heaven and Earth" | "Platoon" ;

Tarantino-works: "Reservoir Dogs" | "Pulp Fiction" | "Clerks" ;

Fellini-works: 
	"8 1/2" // I remembered this because the Plan 9 window system is named
		// after it
;

Burroughs-works:	"The Naked Lunch"  | "The Soft Machine" | "Queer"
	| "Port of Saints" | "Junky" | "The Ticket that Exploded"
	| "Nova Express" | "The Last Words of Dutch Schultz"
;

Joyce-works:	"Ulysses" | "Finnegan's Wake" 
;

Gibson-works:	"Neuromancer" | "The Burning Chrome" | "Mona Lisa Overdrive" 
	| "Virtual Light";

Madonna-works:	"Erotica" | "Sex" | "Material Girl" ;

Rushdie-works: "Satanic Verses" | "Midnight's Children" ;

Eco-works: "The Name of the Rose" | "Foucault's Pendulum" ;

// concepts associated with intellectuals

Lacan-concepts: "obscurity" ;

// add Genet-concepts here

Derrida-concepts: "reading" ;

Baudrillard-concepts: "simulation" | "simulacra" | "hyperreality" ;

Sartre-concepts: "absurdity" | "existentialism" ;

Foucault-concepts: /*"panopticon" | */ "power relations" ;

Marx-concepts: "capitalism" | "socialism" | "class" ;

Debord-concepts: "image" | "situation" ;

Bataille-concepts: "`powerful communication'" ;

Lyotard-concepts: "narrative" ;

Sontag-concepts: "camp";

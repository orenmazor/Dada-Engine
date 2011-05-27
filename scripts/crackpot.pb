/* make crackpottish rants   acb 29-6-1995 
 * Now requires the C preprocessor
 *
 * Copyright (C) 1995 Andrew C. Bulhak
 */


// Global variables used:
// v-benefactors		good guys ("the Elohim", "the Pleiadians")
// v-malefactors		metaphysical bad guys ("the Grays"/"Reptoids")
// v-them			mundane bad guys ("the Illuminati"/"the Black
//				Lodge')

Start: S;

#include <stdmap.pbi>
#include <format.pbi>

// rules

S: PROLOGUE TITLE(title>upcase) 
	BODY 
	sentence-stream+ PBRK 
	paranoid-sentence-stream+ PBRK 
//	secret-hist-sentence-stream PBRK
	factoid-paragraph PBRK
	exhortation EPILOGUE ;

title: solution ": " 
	[ "the solution to all " problem-types " problems"
	| "the end of " evils
	]
	"\n"
;

//
// Sentences
//

// sentences revealing the Secret History of the Universe, or part thereof

secret-hist-sentence-stream:
	"All human history was part of a struggle between "
	benefactors " and " malefactors ". "
	[
		benefactors " came from " 
			["Sirius"|"the Pleiades"|"the stars"|"Arghata"] ", "
		[
			"bringing with them " [
				"the key to " [
					"ultimate "|"omniversal "|"cosmic "|""|
					"universal "|"celestial "
				] 
				[
					"awareness"|"harmony"|"enlightenment"|
					"truth"
				] |
				"the secrets of "["time"|"energy"]
			]
		] ". "
	]
;

benefactors: v-benefactors<<new-benefactors ;
malefactors: v-malefactors<<new-malefactors ;

new-benefactors: "the Elohim" | "the Pleadians" | "the Elder Gods"
	| "the Great White Brotherhood"
;

new-malefactors: "the Grays" | ["the Reptoids"|"the Reptilians"]
	| "the Old Ones" | "the Black Sorcerers" | "the Secret Masters"
	| "the Illuminati" | "the Secret Underground World Society"
;

// paranoid sentences, i.e., those about conspiracies, suppression, etc.

paranoid-sentence-stream:
	they " destroyed " one-who-knew-too-much " because he knew too much. "
	| one-who-knew-too-much " knew " ["too much"|"all"] " about "
	solution ["; "|["; that"|". That"] " is why "] they " destroyed him. "
	| "All " ["books"|"historical accounts"] " were " 
	["altered"|"rewritten"] " to " ulterior-purpose
	| "They altered the Bible to " ulterior-purpose
	| they " don't want anyone to know the " something-of-issue solution
	 [""|" and are willing to "["destroy"|"exterminate"] 
	" anyone who gets in their way as they did " one-who-knew-too-much 
	] ". "
	| "They " 
	["moved the Great Pyramid"|"changed the Great Pyramid's height"] 
	" to destroy its " 
	["astronomical"|"astrological"|"geometric"|"harmonic"] " alignment. "

	;


ulterior-purpose: ["hide"|"conceal"] " the " something-of-issue solution ". ";

// "the cosmic secret of *", "the truth about *"

something-of-issue: cond-upcase([[""|"cosmic "]"truth"]) " about "
	| cond-upcase([[""|"cosmic "]"secret"]) " of "
;

they:	v-them<<new-they | new-they ;

new-they: "THEY" | "they" | "the Illuminati" | "the Rosicrucians" 
	| "the Knights Templar" | "the Nine Unknown Men" | "the Black Lodge"
	| "the Secret Masters" | "the Secret Overlords" | "they" 
	| "the Secret Underground " [""|"World "] "Society" 
	| "the Freemasons";

one-who-knew-too-much: "Wilhelm Reich" | "Galileo" | "Giordano Bruno" 
	| "Tesla" ;

sentence-stream: simple-statement justification 
	law " is encoded in " 
	["the Bible"|"the works of Shakespeare"|"the decimal expansion of pi"]
	". "
	| 
	[""
	  |["Great "["minds"|"men"|"scientists"]|"Eminent researchers"]
	    " throughout history " "(" [eminent ", "]+ " etc.) "
	    " agree that "
	  |"The " ["Aztecs" | "Egyptians" | "Sumerians" | "Atlanteans"]
	   " knew that "
	]
	  law " is the " 
		[ "guiding principle of" | "governing law of"
		| trans-adj " principle behind" ] " "
	["all creation" | "the stars" | "all nature" | "the Universe"]
	[""|
	  " and yet it is virtually " ["unknown"|"unheard of"] ". "
	  [""|"Why is that? "] 
	"This is because it has been " 
	cond-upcase([[""|"ruthlessly "] "suppressed"]) 
	cond-upcase(" throughout history")
	]
	". "
	| "ALL modern " ["evils"|"problems"|"social ills"] 
	" stem from the failure to recognise " 
	[""|"and " ["live"|"be governed"] " by "]
	law ". "
;

eminent: "Einstein" | "Newton" | "Tesla" | "Velikovsky" | "Larson"
	| "Maxwell" | "Galileo" | "Copernicus" ;

simple-statement: numeric-analogy(["three"|"four"|"five"|"twelve"]);

numeric-analogy(number): "Just as there are " number " " 
	@number>append-things ", there are " number " " 
	@number>append-things ". "
;

justification: "This is because of " cond-upcase(law) ". "
;

append-things:
	".*" -> "$"/"-things"
;

three-things: "entities in the Holy Trinity" | "dimensions"
	| "colours on the flag" // note that this applies to _many_ flags
	| "component colours in white light" //| "Stooges"
;

four-things: "seasons" | "cardinal directions" | "letters in the name of God"
	| "gospels in the Bible" | "suits in a deck of cards"
	| "corners of the Earth" | "races of " ["Man"|"humanity"] 
	| "fundamental elements";

five-things: "axioms of Euclid's Geometry" | "fingers on a human hand"
	| "sides to the pyramid on the US dollar bill"
	| "days in a working week" | "vowels in the Alphabet"
;

seven-things: "days in the week" | "cavities in the human body"
	| "electrons in a nitrogen atom" | "deadly sins"
;

twelve-things: "Apostles" | "hours on a clock" | "inches in a foot" 
	| "months" | "signs of the Zodiac" | "eggs in a dozen" ;

// concrete factoids

factoid-paragraph:
	concrete-factoid factoid-consequence
;

factoid-consequence:
	cond-upcase("only") " from this value can one derive the "
	cond-upcase(["true structure of matter"|"missing mass of the universe"
	|"true orbits of the planets"|"universe's missing day"]) ". ";

concrete-factoid: number-name " is " bogus-number ". "
	| "the true " [""|"hidden "|"suppressed "] "value of pi is 3."
	["0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"]+ 
	[""|"; all mathematics textbooks have been "
	["altered"|"rewritten"|"changed"]" to "["hide"|"conceal"] " this"]
	". "
;

number-name: "the " 
	cond-upcase([["cosmic"|"universal"] " " law-adj " constant"]);

bogus-number: ["1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"] 
	["0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"]* 
	[""|"." [["0"|"1"|"2"|"3"|"4"|"5"|"6"|"7"|"8"|"9"]+]+ ]
;

//
// Exhortations and the like
//

exhortation: cond-upcase([[
	"End " evils
	] " -- " imperative])
	| "Achieve " achievements " " [ "now" | "today" ] "! "
	"Just follow these " {num_steps=3..5; step=1} $num_steps 
	" easy steps.\n"
	%repeat(step,num_steps)
	["" | "IT'S THAT EASY!" | "NOTHING COULD BE SIMPLER!"]
;

step: $step ". "
	[
	["Adopt"|"Learn"|"Memorise"] " " solution "." |
	[["Adopt"|"Accept"] " " solution " as"|
	"Make " solution | "Let " solution " be"
	]" your guide." |
	"Reject the " cond-upcase(evil-adj) [""|" and " cond-upcase(evil-adj)] 
		" doctrine of "
		["evolution"|"the spherical Earth"|"Minimum Message Length"
		|"Freudian psychology"|"relativity"|"capitalism"] "." |
	"Turn away from " ["the "|"Satan's "] "international "
	["money power"|"media brainwashing " ["empire"|"cartel"]]"."
	] "\n"
	{ step=step+1 }
;

evil-adj: "evil" | "immoral" | "Satanic" | "sinful" ;

imperative: "adopt " [ solution | long-solution ] " now! " ;

long-solution: "government based on " solution
;

problem-types: problem-type ", " problem-type " and " problem-type
;

problem-type: "economic" | "political" | "financial" | "health"
	| "energy" | "sexual" | "spiritual"
;

achievements: achievement
	| [ achievement ", " ] + achievement " and " achievement
	| [ achievement ", " ] "etc. "
;

achievement: ["immeasurable wealth" | "untold riches" ]
	| [ "ultimate " | "" ] achievement-2;

achievement-2:
	"enlightenment" 
	| "omniversal awareness" | "sexual attractiveness"
	| "cosmic power" ;

evils: evil ", " [ evil ", " ] + "etc.";

evil: "wars" | "unemployment" | "racism" | "poverty" | "famine"
	| "violence" | "disease" | "drug addiction" | "overpopulation"
	| "pollution"
;

solution:
	theory-name " " [ "physics" | "theory" ] | law | law ;

law:	v-law-1<<new-law | v-law-2<<new-law
	| v-law-1<<new-law | v-law-2<<new-law
	| new-law ;

new-law:	 ["the law of " law-name|"the LAW of " law-name>upcase]
	| "the " ["" | trans-adj " "] "principle of " law-name
	| "the " ["" | trans-adj>upcase " "] "principle of " law-name>upcase
	| ["God's"|"Nature's"] " law of " law-name
	| law-adj " law"
// not strictly laws per se, but similar enough grammatically
	| "the cycle of " law-name
;

// transcendental adjectives: "the * principle of Universal Normalisation"

trans-adj: "cosmic" | "divine" | "eternal" | "fundamental" ;

// laws: "the law of *"

law-name: law-adj " " law-subject
	| law-adj " " law-subject
	| law-adj "-" law-adj " " law-subject
;

law-adj: [""|""|"electro-"]["volumetric" | "atomic" | "harmonic" | "universal" | "cosmic" | "psychic" | "consciousness" | "natural" | "time" | "temporal" ]
;

law-subject: "normalisation" | "equivalence" | "justice" | "totality"
	| "duality" | "truth" | "compensation" | "equality"
;

// theory names: "* physics"

theory-name: ["resonation" | "vibrational"]
	| theory-adj " " theory-subject " " theory-modality
	| theory-adj " " theory-modality
;

theory-adj: "unified" | "resonating" | "harmonic" | "cosmic" | "total"
	| "universal" | "quantum"
;

theory-subject: "reality" | "energy" | "gravity"
;

theory-modality: "field" | "wave" | "vector" | "matrix" | "totality" ;

// utility rules

cond-upcase(foo): foo | foo>upcase | foo | foo>upcase ;

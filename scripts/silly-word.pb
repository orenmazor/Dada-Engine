// silly.pb  a script for generating silly words
// Copyright (C) 1995, Andrew C. Bulhak

word: word2 | prefix word2 ;

word2: random-syllable suffix
	| random-syllable
	| random-syllable "o" random-syllable suffix
	| double(random-syllable)
	| random-syllable wordlet
;

double(foo): foo foo ;

prefix-or-random: prefix | random-syllable ;

random-syllable: random-syllable-2 | plosive-cons-a random-syllable-2 ;

random-syllable-2: consonant vowel sibilant-cons // `fut'
	| sibilant-bit vowel plosive-cons
	| consonant vowel double(plosive-cons-a)
        | double-around(consonant vowel)
        | double-around(consonant "oo")
	| sibilant-bit vowel sibilant-cons plosive-cons-b  // ``schlorpht''
	| interleave-two-with-one(consonant consonant vowel) // "bodo"
;

// some ready-made silly wordlets, some with a distinctly hackerly flavour

wordlet: "snarf" | "gronk" | "blat" | "gweep" ;

double-around(foo bar): foo bar foo ;

interleave-two-with-one(foo bar baz): foo baz bar baz ;

prefix: "ur" | "meta" | "neo" | "pro" | "" ;

suffix: "le" | "licious" | "plex" | "tude" | "lap" | "ity" | "ie" ;

vowel: "a" | "e" | "i" | "o" | "u" | "ea" | "ee" | "oo"
	"ar" | "or" ;

consonant: "b" | "c" | "d" | "f" | "g" | "h" | "j" | "k" | "l" | "m" | "n" | "p" | "q" | "r" | "s" | "t" | "v" | "w" | "x" | "y" | "z" | "w" | "w" | "w" | "qu";

sibilant-bit: sibilant-cons | sibilant-cons post-sibilant ;

// a letter or string which may specifically be appended to a sibilant consonant
post-sibilant: "l" | "n" ;

sibilant-cons: "f" | "ph" | "s" | "sh" | "sch" | "x" | "z";

plosive-cons: plosive-cons-a | plosive-cons-b ;

plosive-cons-a: "b" | "d" | "p" ;
plosive-cons-b: "t" | "k" | "ck" ;


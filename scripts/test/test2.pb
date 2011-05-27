output:	output sentence
	| sentence
;

sentence: np " " vp ". "
;

prep: "the" | "a" | "some" ;

np: prep " " adj " " noun
	| prep " " noun
	| prep " " noun " with " np
;

adj:	"large" | "small" | "green" | "octangular" | "elongated"
;

noun:	"table" | "duck" | "boy" | "tree" | "ball" | "mushroom" |
	"watermelon" | "dragon" | "circle" | "planet";

vp:	pverb " " np
;

pverb:	"took" | "touched" | "pushed" | "moved" | "dropped" | "frobbed"
	| "rotated" | "removed" | "positioned"
;


// this should produce a (non-syntactic) error when read, because of
// the symbol "undefined".

foo: bar baz
;

bar : undefined | "xyzzy" ;

baz : "plugh" ;

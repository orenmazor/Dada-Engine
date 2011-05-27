// test cascading parameters for brokenness
start: foo("blah");
foo(baz): bar(baz) bar(baz) ;
bar(baz): "[" baz "]" ;

s: { i=0 } s0 ;

s0: s0 foo | foo | s0 foo ;

foo: { i=i+1 } $i "\n" ;

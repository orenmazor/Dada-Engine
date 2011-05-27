s: { res="\n" ; c=0 } a $res ;

a: a b | a c | b | c ;

b: $c { res=res+"foo" ; c=c+1 };

c: $c { res=res+"bar" ; c=c+1 };

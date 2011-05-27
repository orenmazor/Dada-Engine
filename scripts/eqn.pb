// eqn.pb  acb  Walpurgisnacht'95
// generate interesting-looking but bogus LaTeX equations.

eqn-start: eqn-prolog eqn-body eqn-epilog ;

//eqn-prolog: ".br\n.br\n.br\n.EQ\nsize 36\ndelim %%\n.EN\n" ;
//eqn-epilog: "\n.EN\n" ;
//eqn-epilog: "\n" ;
eqn-prolog: "\\documentstyle[a4wide,12pt]{report}\n\\begin{document}\n\\begin{Large}\n\\begin{center}\n\\vfill\n\\[";
eqn-epilog: "\\]\n\\end{center}\n\\end{Large}\n\\end{document}";

eqn-body: lvalue " = " equation eqcont ;

eqcont: "\\]\n\n\\[ = " equation eqcont | "" | "\\]\n\n\\[ = " equation eqcont  | "\\]\n\n\\[ = " equation eqcont  | "\\]\n\n\\[ = " equation eqcont  
	| "" | "\\]\n\n\\[ = " equation eqcont  ;

lvalue: pronumeral | pronumeral " ( " pronumeral " ) " ;

equation: "\\frac{" equation "}{" equation "}"
	| "\\frac{" equation "}{" equation "}"
	| pronumeral
	| pronumeral "_{" pronumeral "}"
	| pronumeral "_{" polynomial(pronumeral) "}"
	| sum(pronumeral)
	| integral(pronumeral)
	| polynomial(pronumeral)
	| "\\sqrt{" equation " }"
	| equation "+" equation
	| equation "-" equation
;

sum(pn): "\\sum_{" pn "=" from "}^{" to "} " pronumeral "_" pn ;

integral(pn): "\\int_{" pn "=" from "}^{" to "} " pronumeral "_" pn ".d" pn ;

from: pronumeral | "-{\\infty}" | "0" ;

to: pronumeral | "\\infty" ;

polynomial(pn): linear(pn) | quadratic(pn) | cubic(pn) ;

linear(pn): int " " pn " " plusminus " " int ;

quadratic(pn): int " " pn "^{2}" plusminus linear(pn) ;

cubic(pn): int " " pn "^{3}" plusminus quadratic(pn) ;

pronumeral: "x" | "y" | "t" | "{\\alpha}" | "{\\beta}" | "{\\gamma}" 
	| "{\\delta}" | "{\\epsilon}" | "{\\zeta}" | "{\\eta}" | "{\\theta}" 
	| "{\\iota}" | "{\\kappa}" | "{\\mu}" | "{\\nu}" | "{\\xi}" 
	| "{\\pi}" | "{\\rho}" | "{\\sigma}" | "{\\tau}" | "{\\upsilon}" 
	| "{\\phi}" | "{\\chi}" | "{\\psi}" | "{\\omega}" ;

int: digit int | digit ;

digit: "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" | "8" | "9" ;

plusminus: "+" | "-" ; 



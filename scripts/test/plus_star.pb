/* test the * and + operators */

S: S1 "\n" S2 "\n" ;

S1: A1* ;

S2: A2+ ;

A1: "This should appear 0 or more times.\n";

A2: "This should appear 1 or more times.\n";
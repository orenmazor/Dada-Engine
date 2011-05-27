// legal.pb
// legalese generator
// v1.1 mitch 19-2-96

legal: statement>upcase-first
;

statement:
[qualification ", " | ""] [condition | "" ] pronouncement [", " qualification | ""] "."
;

// convert the first character of a string to its uppercase equivalent

%trans upcase-first:
".*": 0 u ;
;

thin:
[thing | things]
;

things:
"eligible telecommunications carriers" |
"exempt telecommunications companies" |
"broadcast services" |
"special provisions concerning " thin |
"broadcast license renewal procedures" |
"automated ship distress and safety systems" |
"restrictions on " thin |
"over-the-air reception devices" |
"cable services" |
"navigation devices" |
"telecommunications services" |
"video programming services provided by telephone companies" |
"unnecessary Commission regulations and functions"
;

thing:
"broadcast spectrum flexibility" |
"broadcast ownership" |
"term of licenses" |
"direct broadcast satellite service" |
"Cable Act reform" |
"cable service provided by telephone companies" |
"preemption of " thin |
"franchising authority regulation of " thin |
"local exchange carrier" |
"telecommunications services" |
"competitive availability of " thin |
"video programming accessibility" |
"regulatory forbearance" |
"elimination of " thin |
"unnecessary Commission regulations and functions"
;

condition:
"whenever in this Act " section " is expressed in terms of " section ", "
;

section:
"an amendment or repeal" |
"an amendment to, or repeal of, a section or other provision" |
"a section or other provision of the Communications Act of 1934 (47 U.S.C. 151 et seq.)" |
"section 3 of the Communications Act of 1934 (47 U.S.C. 153)" 
;

pronouncement:
"the reference shall be considered to be made to " section |
"the terms used in this Act have the meanings provided in section 3 of the Communications Act of 1934 (47 U.S.C. 153)" |
term | amend | gen-duty
;

qualification:
"except as otherwise expressly provided" |
"except as otherwise provided in this Act" |
"as amended by this section"
;

term:
"the term `" thin "' " meaning
;

meaning:
"has the meaning given such term in section 602" |
"means " definition
;

definition:
"equipment employed on the premises of a person (other than a carrier) to originate, route, or terminate telecommunications" |
"that a person that is not an affiliate of a " thing " is able to provide " things " in such a manner that customers have " power |
" a local exchange carrier operating entity to the extent that such entity:" act "; " act "; or " act "." |
" any provider of telecommunications services, except that such term does not include aggregators of telecommunications services (as defined in section 226)."
;

power:
"the ability to route automatically, without the use of any " thing ", their " things " to the " thing " of the customer's designation from among 2 or more " things " (including such " thing ")"
;

also:
"Such term also includes features,
              functions, and capabilities that are provided by means of such
              facility or equipment, including subscriber numbers, databases,
              signaling systems, and information sufficient for billing and
              collection or used in the transmission, routing, or other
              provision of a telecommunications service."
;

amend:
"Section 3 (47 U.S.C. 153) is amended:" amending
;

amending:
" " amend2 |
" " amends "; and " amend2
;

amends:
" " amend2 "; " amends |
" " amend2 "; " amends |
" " amend2 "; " amends |
" " amend2 "; " amends |
" " amend2 "; " amends |
" " amend2
;

amend2:
"in subsections (e) and (n), by redesignating clauses (1), (2), and (3), as clauses (A), (B), and (C), respectively" | 
"in subsection (w), by redesignating paragraphs (1) through (5) as subparagraphs (A) through (E), respectively" |
"in subsections (y) and (z), by redesignating paragraphs (1) and (2) as subparagraphs (A) and (B), respectively" | 
"by redesignating subsections (a) through (ff) as paragraphs (1) through (32)" |
"by indenting paragraphs (1) through (32) 2 em spaces" |
"by changing the first letter of each defined term in such paragraphs from a capital to a lower case letter (except for `United States', `State', `State commission', and `Great Lakes Agreement')" |
"by reordering such paragraphs and the additional paragraphs added by subsection (a) in alphabetical order based on the headings of such paragraphs and renumbering such paragraphs as so reordered" |
"in section 225(a)(1), by striking `section 3(h)' and inserting `section 3'" |
"in section 332(d), by striking `section 3(n)' each place it appears and inserting `section 3'" |
"in sections 621(d)(3), 636(d), and 637(a)(2), by striking `section 3(v)' and inserting `section 3'"
;

place:
"any incorporated place of 10,000 inhabitants or more, or any part thereof, based on the most recently available population statistics of the Bureau of the Census" |
"any territory, incorporated or unincorporated, included in an urbanized area, as defined by the Bureau of the Census as of August 10, 1993"
;

fashion:
" for the transmission and routing of telephone exchange service and exchange access" |
" at any technically feasible point within the carrier's network" |
" that is at least equal in quality to that provided by the local exchange carrier to itself or to any subsidiary, affiliate, or any other party to which the carrier provides interconnection" |
" on rates, terms, and conditions that are just, reasonable, and nondiscriminatory, in accordance with the terms and conditions of the agreement and the requirements of this section and section 252"
;

act: 
" provides common carrier service to any local exchange carrier study area that does not include either: " place "; or " place |
" provides telephone exchange service, including exchange access, to fewer than 50,000 access lines" |
" provides telephone exchange service to any local exchange carrier study area with fewer than 100,000 access lines" |
" has less than 15 percent of its access lines in communities of more than 50,000 on the date of enactment of the Telecommunications Act of 1996"
;

amend4: " A telecommunications carrier shall be treated
              as a common carrier under this Act only to the extent that it
              is engaged in providing telecommunications services, except
              that the Commission shall determine whether the provision of
              fixed and mobile satellite service shall be treated as common
              carriage."
;
            
gen-duty: 
"each telecommunications carrier has the duty: " duties
;

duties:
[ ["not" | ""] duty | ["not" | "" ] duty fashion] |
dutylist "; and " [ ["not" | ""] duty | ["not" | "" ] duty fashion]
;

dutylist:
dutylist "; " [ ["not" | ""] duty | ["not" | "" ] duty fashion] |
dutylist "; " [ ["not" | ""] duty | ["not" | "" ] duty fashion] |
dutylist "; " [ ["not" | ""] duty | ["not" | "" ] duty fashion] |
dutylist "; " [ ["not" | ""] duty | ["not" | "" ] duty fashion] |
dutylist "; " [ ["not" | ""] duty | ["not" | "" ] duty fashion] |
[ ["not" | ""] duty | ["not" | "" ] duty fashion]
;
               
duty: 
" to interconnect directly or indirectly with the facilities and equipment of other telecommunications carriers" |
" to install network features, functions, or capabilities that do not comply with the guidelines and standards established pursuant to section 255 or 256" |
" to prohibit, and not to impose unreasonable or discriminatory conditions or limitations on, the resale of its telecommunications services" |
" to provide, to the extent technically feasible, number portability in accordance with requirements prescribed by the Commission" |
" to provide dialing parity to competing providers of telephone exchange service and telephone toll service" |
" to permit all providers to have nondiscriminatory access to telephone numbers, operator services, directory assistance, and directory listing, with no unreasonable dialing delays" |
" to negotiate in good faith in accordance with section 252 the particular terms and conditions of agreements to fulfill the duties described in paragraphs (1) through (5) of subsection (b) and this subsection" |
" to provide, for the facilities and equipment of any requesting telecommunications carrier, interconnection with the local exchange carrier's network" 
;
                


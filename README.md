The Dada Engine  Release 1.01
-----------------------------

The Dada Engine is a system for the nondeterministic generation
of ASCII data from grammars using recursive transition networks; or,
in English, it is a system for generating random text using rules.
Rules are specified in a language named pb, which looks a little like
yacc, only a good deal more bogus.  The language is documented in the 
Dada Engine manual which is supplied in Texinfo and PostScript formats.

Release 1.01 is a bugfix release which fixes a problem with regular
expression substitutions in 1.0.  Nothing else is changed.

Compiling and installing
------------------------

Firstly, run the shell script named "configure" in the Dada Engine
distribution directory.  This will check the characteristics of your
system and (hopefully) set up the makefiles and headers in a way that
will work.  configure, by default, sets the installation directories
in which the Dada Engine will be installed to /usr/local; if you
wish to install the Dada Engine elsewhere, you can specify a different
location by running configure with the "--prefix=pathname" argument,
i.e., "./configure --prefix=$HOME" will install the system in your
home directory.

Then run "make" in the distribution directory; this will compile the
Dada Engine.  Afterwards, for it to properly work, you must install it
by running "make install".

Sample scripts
--------------

Several sample scripts are provided in the `scripts' subdirectory.
These include:

	brag.pb*	A SubGenius brag generator
	crackpot.pb	A crackpot rant generator
	eqn.pb		A generator of bogus equations (in LaTeX format)
	exam.pb		A script to generate intimidating-looking but bogus 
			examination questions.  (unfinished)
	legal.pb*	A script to generate legalese.
	loop.pb*	A script that produces itself as output
	manifesto.pb	A manifesto generator
	pomo.pb		The Postmodernism Generator; now outputs in any
			format supported by the format library
	silly-word.pb	A silly word generator
	spout.pb*	The SubGenius Profunditied Generation Matrix
	

Acknowledgements
----------------

I am grateful to Mitchell Porter for testing the language and coding
several of the example scripts, to the Department of Computer Science
at Monash University for facilities and support, to Jamie Cameron for 
his part in the conspiracy to develop this system and to Brandon Long 
and kristin buxton for their help with getting the Dada Engine to work 
with Solaris 2.x.

Andrew C. Bulhak
acb@dev.null.org
45 Discord 3162

# Sample Outputs

## `dada ./scripts/crackpot.pb`

<html><head><title>UNIVERSAL WAVE THEORY: THE SOLUTION TO ALL SEXUAL, POLITICAL 
AND ECONOMIC PROBLEMS 
</title></head><body><h1>UNIVERSAL WAVE THEORY: THE SOLUTION TO ALL SEXUAL, 
POLITICAL AND ECONOMIC PROBLEMS 
</h1> 
Great minds throughout history (Velikovsky, Maxwell, Galileo, Copernicus, 
Einstein, Tesla, etc.) agree that the DIVINE principle of ELECTRO-ATOMIC 
JUSTICE is the fundamental principle behind the stars and yet it is virtually 
unknown. This is because it has been ruthlessly suppressed THROUGHOUT HISTORY. 
<p> 
the Black Lodge don't want anyone to know the cosmic truth about unified 
reality vector physics. They altered the Bible to conceal the COSMIC SECRET of 
time law. the Nine Unknown Men destroyed Wilhelm Reich because he knew too 
much. Galileo knew too much about God's law of universal totality; the Black 
Lodge destroyed him. the Secret Overlords don't want anyone to know the TRUTH 
about vibrational theory and are willing to exterminate anyone who gets in 
their way as they did Tesla. They changed the Great Pyramid's height to destroy 
its astrological alignment. All historical accounts were altered to hide the 
COSMIC TRUTH about resonation physics. <p> 
the true value of pi is 3.782643; all mathematics textbooks have been altered 
to conceal this. only from this value can one derive the true structure of 
matter. <p> 
Achieve cosmic power, etc. today! Just follow these 5 easy steps. 
1. Reject the sinful doctrine of Minimum Message Length. 
2. Turn away from the international money power. 
3. Reject the EVIL and immoral doctrine of capitalism. 
4. Turn away from Satan's international media brainwashing empire. 
5. Make the principle of consciousness-electro-atomic compensation your guide. 
NOTHING COULD BE SIMPLER!<hr> 
</body></html> 

## `dada ./scripts/brag.pb`

I'm a fission reactor, I fart plutonium, power plants are fueled by the breath 
of my nether part; when they plug *me* in, the lights go out in the Atlantis 
Zoo! Yes, I'm a rip-snorter, I cram coca leaves right into my backbones before 
they're picked off the *tree*! I drank *the Devil* under 666 tables, I am too 
*radioactive* to die, I'm insured for acts o' God *and* Satan! Now give me some 
more of... 

## `dada ./scripts/eqn.pb`

```tex
{\epsilon} ( {\xi} ) = 
\frac{{\phi}_{{\psi}}-\int_{{\omega}=-{\infty}}^{{\kappa}} 
{\gamma}_{\omega}.d{\omega}}{0 {\zeta} + 64}\] 

\[ = \sqrt{{\upsilon}-{\phi}_{{\epsilon}} }\] 

\[ = \frac{\sum_{{\alpha}=-{\infty}}^{\infty} {\tau}_{\alpha}}{{\pi}_{7 
{\xi}^{3}-79 {\xi}^{2}+58 {\xi} + 02}}
```

## `dada ./scripts/pomo.pb`

<html><head><title>Capitalist discourse and Derridaist 
reading</title></head><body><h1>Capitalist discourse and Derridaist 
reading</h1> 
<h2>Jean-Luc Q. T. la Tournier<br> 
<i>Department of Semiotics, Carnegie-Mellon University</i></h2> 
<h3>1. Pynchon and textual theory</h3> 
<p> 
In the works of Pynchon, a predominant concept is the distinction between 
destruction and creation. However, an abundance of narratives concerning 
capitalist discourse exist. Derridaist reading holds that the collective is 
meaningless, given that Foucault's critique of predialectic neoconstructivist 
theory is invalid. <p> 
"Truth is part of the paradigm of consciousness," says Lyotard. Thus, Tilton<a 
href="#fn1">[1]</a> states that we have to choose between capitalist discourse 
and modern nationalism. The subject is contextualised into a Derridaist reading 
that includes reality as a totality. The creation/destruction distinction 
intrinsic to Gravity's Rainbow emerges again in Gravity's Rainbow. Derrida uses 
the term 'cultural conceptualism' to denote not, in fact, theory, but 
posttheory. <p> 
"Class is responsible for capitalism," says Baudrillard; however, according to 
Brophy<a href="#fn2">[2]</a> , it is not so much class that is responsible for 
capitalism, but rather the rubicon, and some would say the defining 
characteristic, of class. Pickett<a href="#fn3">[3]</a> implies that we have to 
choose between Derridaist reading and modern nationalism. In a sense, the 
premise of capitalist discourse implies that discourse is created by the 
masses. Baudrillard uses the term 'capitalist discourse' to denote the bridge 
between society and sexual identity. <p> 
But a number of sublimations concerning the absurdity of textual sexual 
identity may be found. Marx promotes the use of Derridaist reading to modify 
truth. <p> 
The main theme of Hamburger's<a href="#fn4">[4]</a> model of semioticist 
deappropriation is a mythopoetical whole. It could be said that the subject is 
interpolated into a modern nationalism that includes culture as a paradox. <p> 
Sontag's analysis of capitalist discourse suggests that the goal of the writer 
is deconstruction. However, Lyotard uses the term 'Derridaist reading' to 
denote the role of the reader as participant. <p> 
If postcapitalist theory holds, we have to choose between modern nationalism 
and Derridaist reading. In a sense, any number of discourses concerning the 
dialectic, and some would say the stasis, of subconceptual sexual identity 
exist. <h3>2. Burroughs and capitalist discourse</h3> 
<p> 
"Society is fundamentally unattainable," says Bataille; however, according to 
de Selby<a href="#fn5">[5]</a> , it is not so much society that is 
fundamentally unattainable, but rather the meaninglessness of society. In The 
Last Words of Dutch Schultz, Burroughs denies modern nationalism; in Port of 
Saints, although, Burroughs deconstructs modern nationalism. It could be said 
that Derrida suggests the use of precultural feminism to read and analyse 
class. <p> 
The primary theme of Wilson's<a href="#fn6">[6]</a> essay on Derridaist reading 
is not narrative, but postnarrative. Debord uses the term 'capitalist 
discourse' to denote the role of the observer as reader. Therefore, the subject 
is interpolated into a modern nationalism that includes art as a reality. <p> 
Thus, the characteristic theme of the works of Burroughs is the failure, and 
subsequent collapse, of textual language. <p> 
Marx promotes the use of Foucaultist power relations to deconstruct the status 
quo. However, la Fournier<a href="#fn7">[7]</a> suggests that the works of 
Burroughs are modernistic. 

Many sublimations concerning the difference between society and sexual identity 
may be discovered. <p> 
In a sense, if Derridaist reading holds, we have to choose between modern 
nationalism and neomodernist theory. Sartre's critique of capitalist discourse 
implies that consciousness is capable of truth. But Dahmus<a 
href="#fn8">[8]</a> suggests that the works of Burroughs are not postmodern. It 
could be said that Lacan uses the term 'modern nationalism' to denote the 
economy, and hence the fatal flaw, of patriarchialist society. The subject is 
contextualised into a capitalist discourse that includes narrativity as a 
totality. <hr> 
<a name="fn1"> 1. Tilton, B. Y. N. (1984) <i>The Concensus of Futility: 
Capitalist discourse, rationalism and Sartreist absurdity.</i> And/Or 
Press</a><p> 
<a name="fn2"> 2. Brophy, Z. K. (1978) <i>Capitalist discourse and Derridaist 
reading.</i> University of North Carolina Press</a><p> 
<a name="fn3"> 3. Pickett, O. Q. V. (1984) <i>Deconstructing Lacan: Derridaist 
reading in the works of Madonna.</i> University of California Press</a><p> 
<a name="fn4"> 4. Hamburger, U. ed. (1970) <i>Capitalist discourse in the works 
of Burroughs.</i> Loompanics</a><p> 
<a name="fn5"> 5. de Selby, R. J. D. ed. (1988) <i>Rationalism, capitalist 
discourse and dialectic semanticist theory.</i> Yale University Press</a><p> 
<a name="fn6"> 6. Wilson, I. E. L. (1972) <i>Capitalist discourse and 
Derridaist reading.</i> O'Reilly & Associates</a><p> 
<a name="fn7"> 7. la Fournier, W. (1989) <i>The Iron Fruit: Capitalist 
discourse in the works of McLaren.</i> Harvard University Press</a><p> 
<a name="fn8"> 8. Dahmus, A. G. ed. (1971) <i>Derridaist reading and capitalist 
discourse.</i> Schlangekraft</a><p> 
</body></html>

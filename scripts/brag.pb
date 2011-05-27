// convert the first character of a string to its uppercase equivalent

%trans upcase-first:
".*": 0 u ;
;

brag: frag end | 
frag brag | frag brag | frag brag |
frag brag | frag brag | frag brag 
;

end: "Now give me some more of..." ;

frag:
"I " act "! " |
"Pardon my language. " |
"But " yell " let the " entities " bear witness! " |
"Even in the belly of the Thunderbird I've been casting out the " entities "; I'm busting my " body-part " and blowing my O-ring, and ripe to throw a *loaf*! " |
"For I speak *only* the " emphatic " *Truth*, and never in my days have I spoken other than! For my every utterance is a lie, including this very one you hear! " |
"I say, `" slogan "'. By God, `" slogan "', I say! " |
"I am " entity ", I am " entity "! " |
"I'll drive a mile so as not to walk a foot; I am " entity "! " |
"Yes, I'm " entity "! " |
"I drank *" being "* under " number " tables, I am too " adjective " to die, I'm insured for acts o' God *and* Satan! " |
"I was shanghaied by " entities " and " entities " from " place ", and got away with their hubcaps! " |
"I *cannot* be tracked on radar! " |
"I wear nothing uniform, I wear *no* " emphatic " uniform! " |
"Yes baby, I'm " number " feet tall and have " number " rows o' " body-part "s; I was suckled by a " pet ", I gave " she-being " a high-protein tonsil wash! " |
"I'm a bacteriological weapon, I am *armed* and *loaded*! " |
"I'm a fission reactor, I fart plutonium, power plants are fueled by the " spoor " of my " body-part "; when they plug *me* in, the lights go out in " place "! " |
"I weigh " number " pounds in zero gravity, *" attack "*! " |
"I've sired " entities " across " place ", I cook and *eat* my dead; " yell "  I'm the Unshaven Thorn Tree of " place "! " |
"I " act "! " |
being>upcase-first "'s hands are my *ideal* playground! " |
"I hold the " number>upcase-first "-Bladed Windbreaker; the wheels that turn are behind me; I think *backwards*! " |
"I do it for *fun*! " |
"My imagination is a *" emphatic "* cancer and I'll pork it before it porks me! " |
"They say a godzillion is the highest number there is. Well by God! I count to a godzillion and *one*! " |
"Yes, I'm the purple flower of " place ", give me wide berth; when I drop my drawers, " being " swoons! " |
"I use a " pet " for a prophylactic; I'm *thicker, harder* and *meaner* than the Alaskan Pipeline, and carry more " spoor "! " |
"I'll freeze *your* " spoor " before it hits the bathroom tile! " |
yell |
"I kidnapped the future and ransomed it for the past, I made *" being "* wait up for me to bleed my " pet "! " |
"My infernal " spoor " wilts the Tree of Life, I left my *" spoor "* on the Rock of Ages, *who'll " attack ", who'll spill their juice*? " |
"Who'll " attack ", whose candle will I fart out? " |
"Whoop! I'm ready! " |
"So step aside, all you butt-lipped, neurotic, insecure bespectacled " entities "! " |
"I'm " entity ", I am Not Insane! " |
"I'm a screamer and a laugher, I " act ", I am a *sight*! " |
"My physical type *cannot* be classified by science, my `familiar' is a " pet ", I feed it " entities "! " |
"I communicate without *wires* or *strings*! " |
"I am a Thuggee, I am feared in the Tongs, I have the Evil " body-part>upcase-first ", I carry the Mojo Bag; I swam *" place "* and didn't get wet! " |
"I circumcize " entities " with my teeth and make 'em leave a tip; I change tires with my *tongue* and my *tool*! " |
"Every night I hock up a lunger and extinguish the *Sun*! " |
"I'm " entity ", who'll try to " attack "? " |
"I've packed the brownies of the " entities ", I leak the Plague from my " body-part "s, opiates are the *mass* of my religion, *I " act "!* " |
"Yes, I'm a rip-snorter, I cram coca leaves right into my " body-part "s before they're picked off the *tree*! " |
"*" entities>upcase-first "* cringe at my tread! " |
"I " act ". " |
"I'm " adjective ", I'll live forever and remember it afterwards! " |
"I'm " adjective "! " |
"I'm " adjective "! " |
"Come *on* and give me cancer, I'll spit up the tumor and butter my *bread* with the juice! " |
"I'm " adjective ", I " act "! " |
"My droppings bore through the earth and erupt *volcanoes* in *" place "*! " |
"Yes, I can drink more wine and stay soberer than all the " entities " in " place "! " |
yell "*" body-part>upcase-first " Blowout*! " |
"I am a *Moray Eel*, I am a *Komodo Dragon*, I am the *Killer Whale bereft of its pup*! " |
"I have a triple " body-part ", I was sired by " being ", give me *all* your Slack! " |
"I told *" he-being "* I wouldn't go to church and He *shook my hand*! " |
"I have my *own* personal saviors, I change 'em every hour, I don't give a fuck if there's life after death, I want to know if there's even any " emphatic " *Slack* after death! " |
"I am a " emphatic " *visionary*, I see the future and the past in comic books and wine bottles; I eat *black holes* for breakfast! " |
"I " act "! " | "I " act "! " |
"I ran 'em out of Heaven and sold it to Hell for a *profit*! " |
"I'm enlightened, I achieved `Nirvana' and took it *home* with me. " |
yell |
"I'm so ugly the Speed of Light can't slow me down and Gravity won't tug at my cuffs! " |
slogan " " | slogan " "
;

emphatic: "goddamn" |  "god damn" |"GOD DAMN" | "fucking"
;

attack:
"blow me down" | "gouge with me" | "come and get me" |
"tear flesh with me"
;

spoor: "spoor" | "seed" | "breath" | "sweat" | "spew"
;

number: "seven" | "23" | "13" | "666" | "273" | "42"
;

entity:
"a Crime Fighting Master Criminal" | "a "pet |
"the bigfooted devil of Level 14" | 
"the last remaining Homo Correctus" | "the " emphatic " Man of the Future"  |
"a human being of the *first* " emphatic " water" |
"the javalina humping junkie that jumped the " entities 
;

pet: "pterodactyl" | "python" | "triceratops" | "giant lizard"
;

being: she-being | he-being
;

she-being: "Mother Nature" | "God"  | "the Anti-Virgin"
;

he-being: "the Devil" | "Father Time" | "Jesus" | "the Wolf Man"
;

entities: "bodiless fiends" | "alien jews" | "Men from Mars" | 
"heathen *Hindoos*" | "space monsters" |
"sons of God and man" | "False Prophets" | "gods" | "dinosaurs" |
"retarded space bastards" | "slabs o' wimp meat" | "dipshits"
;

body-part: "nose" | "gut" | "arm-vein" | "nether part" |
"backbone" | "brow" | "teat"
;

yell: "YEEE HAW! " | "YEE! YEEE! " | "*Yip, yip, YEEEEEEE!* "|
"YEEEEEHAW! "  | "YAH-HOOOO! "
;

slogan: "Fuck 'em if they can't take a joke!" | "Anything for a laugh!"  |
"When the Rapture comes, I'll make 'em wait!"  |
"They'll *never* clean *my* cage!" 
;

act:
"pick the " emphatic " terror of the " emphatic " " entities " out of my *" body-part "*" |
"pay no taxes" | "take drugs" |
"make a *spectacle* of myself" |
"wipe the *Pyramids* off my shoes before I enter *my* house" |
"bend *crowbars* with my meat ax and a thought" |
"bend my genes and whittle my DNA with the sheer force of my mighty *will*" |
"steer my *own* " emphatic " evolution" 
;

adjective:
"*fuel-injected*" | "*immune*" | "*radioactive*" |
"*supernatural*" | "*intense*"
;

place:
"China" | "Hong Kong" | "Asia" | "the Atlantis Zoo" | "the Cosmos" |
"a corporate galaxy" | "Hell County" | "the Bermuda Triangle"
;


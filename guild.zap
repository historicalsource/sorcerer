

	.FUNCT	BED-F,RARG=0
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	PRSA,V?WALK \?ELS10
	CALL	NOT-GOING-ANYWHERE,BED
	RSTACK	
?ELS10:	EQUAL?	PRSA,V?TAKE \FALSE
	CALL	HELD?,PRSO
	ZERO?	STACK \FALSE
	EQUAL?	PRSO,GLOBAL-SLEEP /FALSE
	EQUAL?	PRSO,GRUE,ME,BED /FALSE
	IN?	PRSO,BED /FALSE
	PRINTR	"You can't reach it from the bed."
?ELS5:	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS28
	PRINTR	"Huh?"
?ELS28:	EQUAL?	PRSA,V?WALK-TO \?ELS32
	CALL	PERFORM,V?WALK-TO,GLOBAL-SLEEP
	RTRUE	
?ELS32:	EQUAL?	PRSA,V?LIE-DOWN,V?CLIMB-ON \FALSE
	CALL	PERFORM,V?BOARD,PRSO
	RTRUE	


	.FUNCT	GLOBAL-BED-F
	EQUAL?	GLOBAL-BED,PRSO \?ELS5
	SET	'PERFORMING-SPELL,TRUE-VALUE
	CALL	PERFORM,PRSA,BED,PRSI
	RTRUE	
?ELS5:	SET	'PERFORMING-SPELL,TRUE-VALUE
	CALL	PERFORM,PRSA,PRSO,BED
	RTRUE	


	.FUNCT	BELBOZ-QUARTERS-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The personal chamber of Belboz, who presides over the Circle of Enchanters, is appointed with a beautiful woven wall hanging"
	IN?	MORGIA-PLANT,HERE \?CND8
	PRINTI	", an exotic morgia plant,"
?CND8:	PRINTR	" and a wide darkwood desk crafted by the artisans of Gurth. The hallway lies to the east."


	.FUNCT	PERCH-PSEUDO
	EQUAL?	PRSA,V?CLIMB-ON \FALSE
	PRINTR	"I'd recommend a good doctor, but we need the eggs."


	.FUNCT	PARROT-F
	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"The parrot hops to the other end of the perch."


	.FUNCT	I-PARROT
	IN?	PARROT,HERE \FALSE
	RANDOM	100
	LESS?	40,STACK /FALSE
	CRLF	
	PRINTI	"""Squawk! "
	CALL	PICK-ONE,PARROTISMS
	PRINT	STACK
	PRINTR	" Squawk!"""


	.FUNCT	BELBOZ-DESK-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"The desk has one drawer which is "
	FSET?	DESK-DRAWER,OPENBIT \?ELS10
	PRINTI	"open"
	JUMP	?CND8
?ELS10:	PRINTI	"closed"
?CND8:	PRINTI	"."
	CRLF	
	FIRST?	PRSO \TRUE
	RFALSE	
?ELS5:	EQUAL?	PRSA,V?SEARCH \?ELS27
	FSET?	DESK-DRAWER,OPENBIT /?ELS27
	FIRST?	DESK-DRAWER \?ELS27
	PRINTI	"You open the desk drawer and find "
	CALL	PRINT-CONTENTS,DESK-DRAWER
	FSET	DESK-DRAWER,OPENBIT
	PRINTR	"."
?ELS27:	EQUAL?	PRSA,V?REZROV,V?OPEN,V?CLOSE /?THN36
	EQUAL?	PRSA,V?LOOK-INSIDE,V?REACH-IN \?ELS35
?THN36:	SET	'PERFORMING-SPELL,TRUE-VALUE
	CALL	PERFORM,PRSA,DESK-DRAWER
	RTRUE	
?ELS35:	EQUAL?	PRSA,V?TAKE \?ELS39
	EQUAL?	BELBOZ-DESK,PRSI \?ELS39
	FIRST?	DESK-DRAWER \?ELS39
	CALL	PERFORM,V?TAKE,PRSO,DESK-DRAWER
	FIRST?	BELBOZ-DESK \TRUE
	RFALSE	
?ELS39:	EQUAL?	PRSA,V?PUT \FALSE
	EQUAL?	PRSI,BELBOZ-DESK \FALSE
	CALL	PERFORM,V?PUT,PRSO,DESK-DRAWER
	RTRUE	


	.FUNCT	TINY-BOX-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"There is writing on the lid of the box."
	CRLF	
	CALL	PERFORM,V?READ,PRSO
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?READ \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"
""    MAGIC AMULET

The closer this amulet is to
its owner, the brighter it may
glow. Ideal for leaving with
your loved ones if you go on
a long and hazardous journey.

This amulet is sensitized to
-> BELBOZ THE NECROMANCER

Another fine product of the
Frobozz Magic Amulet Company."""
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	MAGIC-AMULET-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"A blue jewel hangs from a long golden chain. The jewel is "
	CALL	AMULET-GLOWS
	PRINTR	"."
?ELS5:	EQUAL?	PRSA,V?RESEARCH \FALSE
	PRINTR	"The Amulet of Aggthora was a legendary jewel renowned for its powers of augury."


	.FUNCT	AMULET-DESCFCN,RARG
	PRINTI	"There is an amulet here. The amulet's jewel is "
	CALL	AMULET-GLOWS
	PRINTR	"."


	.FUNCT	AMULET-GLOWS
	CALL	IN-GUILD-HALL?
	ZERO?	STACK /?ELS5
	PRINTI	"dark"
	RTRUE	
?ELS5:	CALL	IN-MAZE-AREA?
	ZERO?	STACK /?ELS9
	PRINTI	"glowing"
	RTRUE	
?ELS9:	CALL	IN-CRATER-AREA?
	ZERO?	STACK /?ELS13
	PRINTI	"glowing brightly"
	RTRUE	
?ELS13:	CALL	IN-COAL-MINE?
	ZERO?	STACK /?ELS17
	PRINTI	"glowing very brightly"
	RTRUE	
?ELS17:	CALL	IN-END-GAME?
	ZERO?	STACK /?ELS21
	PRINTI	"pulsing with flashes of brilliant light"
	RTRUE	
?ELS21:	PRINTI	"glowing dimly"
	RTRUE	


	.FUNCT	IN-GUILD-HALL?,X=0
	ZERO?	X \?CND1
	SET	'X,HERE
?CND1:	EQUAL?	X,HALLWAY-1,HALLWAY-2,CHAMBER-OF-THE-CIRCLE /TRUE
	EQUAL?	X,YOUR-QUARTERS,BELBOZ-QUARTERS,LOBBY /TRUE
	EQUAL?	X,FROBAR-QUARTERS,HELISTAR-QUARTERS /TRUE
	EQUAL?	X,STORE-ROOM,LIBRARY,CELLAR /TRUE
	EQUAL?	X,APPRENTICE-QUARTERS,SERVANT-QUARTERS \FALSE
	RTRUE	


	.FUNCT	IN-COAL-MINE?
	EQUAL?	HERE,COAL-BIN-ROOM,DIAL-ROOM,SHAFT-BOTTOM /TRUE
	EQUAL?	HERE,SHAFT-TOP,TOP-OF-CHUTE,SLANTED-ROOM /TRUE
	EQUAL?	HERE,COAL-MINE-1,COAL-MINE-2,COAL-MINE-3 \FALSE
	RTRUE	


	.FUNCT	IN-MAZE-AREA?
	EQUAL?	HERE,TOLL-GATE,END-OF-HIGHWAY,HOLLOW /TRUE
	EQUAL?	HERE,OUTSIDE-GLASS-DOOR,GLASS-MAZE,STORE /TRUE
	EQUAL?	HERE,ENTRANCE-HALL,STONE-HUT,OUTSIDE-STORE \FALSE
	RTRUE	


	.FUNCT	IN-CRATER-AREA?
	EQUAL?	HERE,HIGHWAY,BEND,EDGE-OF-CRATER /TRUE
	EQUAL?	HERE,CRATER,WINDING-TUNNEL,HALL-OF-CARVINGS /TRUE
	EQUAL?	HERE,EDGE-OF-CHASM,BARE-PASSAGE,SOOTY-ROOM /TRUE
	EQUAL?	HERE,ELBOW-ROOM,TREE-ROOM,PARK-ENTRANCE /TRUE
	EQUAL?	HERE,EAST-END-OF-MIDWAY,FLUME,HAUNTED-HOUSE /TRUE
	EQUAL?	HERE,WEST-END-OF-MIDWAY,ROLLER-COASTER,ARCADE /TRUE
	EQUAL?	HERE,CASINO \FALSE
	RTRUE	


	.FUNCT	IN-END-GAME?
	EQUAL?	HERE,OCEAN-NORTH,OCEAN-SOUTH,BELBOZ-HIDEOUT /TRUE
	EQUAL?	HERE,MOUTH-OF-RIVER,GRUE-LAIR,MAMMOTH-CAVERN /TRUE
	EQUAL?	HERE,CHAMBER-OF-LIVING-DEATH,COVE,LAGOON-FLOOR /TRUE
	EQUAL?	HERE,HALL-OF-ETERNAL-PAIN,LAGOON \FALSE
	RTRUE	


	.FUNCT	JOURNAL-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?EXAMINE,V?READ \?ELS5
	FSET?	JOURNAL,OPENBIT \?ELS10
	PRINTI	"You skim through the pages of the journal, a combination diary and notebook. Most of the notations, written in Belboz's familiar flowing script, deal with meetings of the Circle and business of the Guild.

There is one interesting entry toward the end of the book. Belboz refers to an ancient and evil force known simply as Jeearr, a demon whose powers could endanger the Circle and possibly the entire kingdom. He has decided to conduct some dangerous exploratory experiments, operating alone to shield the Circle from the perils involved.

The last three entries are strange and frightening -- written in a hand quite different from that of Belboz, and in a language totally unfamiliar to you.

On the inside cover is an inscription, written in a light script, which reads ""Current code: "
	GET	CODE-TABLE,CODE-NUMBER
	PRINT	STACK
	PRINTR	"""."
?ELS10:	PRINTR	"It's closed and sealed with a lock."
?ELS5:	EQUAL?	PRSA,V?REZROV,V?UNLOCK,V?OPEN \FALSE
	FSET?	JOURNAL,OPENBIT \?ELS23
	PRINTR	"The journal is already open!"
?ELS23:	EQUAL?	PRSA,V?REZROV \?ELS27
	PRINTR	"The journal seems to bear a spell protecting it against the simple rezrov spell."
?ELS27:	ZERO?	PRSI \?CND32
	IN?	KEY,PROTAGONIST \?ELS37
	SET	'PRSI,KEY
	PRINTI	"(with the key)"
	CRLF	
	JUMP	?CND32
?ELS37:	SET	'PRSI,HANDS
?CND32:	EQUAL?	PRSI,KEY \?ELS46
	FSET	JOURNAL,OPENBIT
	PRINTR	"The journal springs open."
?ELS46:	PRINTI	"You can't unlock it with"
	CALL	ARTICLE,PRSI
	PRINTR	"."


	.FUNCT	WHEEL-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"Like most infotaters, this one has several windows and a rotating data wheel. It is leather-bound and beautifully illustrated. "
	CALL	INFOTATER-NOTE
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?READ \?ELS9
	PRINTI	"The infotater has entries on a dozen native beasts. "
	CALL	INFOTATER-NOTE
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?SPIN,V?TURN \?ELS13
	PRINTR	"Refer to the infotater in your SORCERER package."
?ELS13:	EQUAL?	PRSA,V?RESEARCH \FALSE
	PRINTR	"The infotater, which popular legends say was invented by Entharion the Wise, is the best way to store data ever discovered."


	.FUNCT	INFOTATER-NOTE
	PRINTR	"(NOTE: This is the infotater included in your game package.)"


	.FUNCT	WALL-HANGING-F
	EQUAL?	PRSA,V?LOOK-UNDER,V?LOOK-BEHIND,V?MOVE /?THN6
	EQUAL?	PRSA,V?RAISE,V?SHAKE,V?RUB \?ELS5
?THN6:	FSET?	KEY,TOUCHBIT /?ELS12
	MOVE	KEY,HERE
	CALL	THIS-IS-IT,KEY
	FSET	KEY,TOUCHBIT
	ADD	SCORE,15 >SCORE
	PRINTR	"As you move the tapestry, a key falls out from behind it and lands on the floor."
?ELS12:	PRINTR	"Nope, no more keys."
?ELS5:	EQUAL?	PRSA,V?UNTIE,V?TAKE \?ELS20
	PRINTR	"It looks too well fastened to remove from the wall."
?ELS20:	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"It is a beautiful piece of local handiwork, given to Belboz by the grateful townspeople after his (admittedly showy) pyrotechnical destruction of the evil giant Amathradonis. The hanging is affixed to the wall at its upper corners."


	.FUNCT	MORGIA-PLANT-F
	EQUAL?	PRSA,V?MEEF \?ELS5
	MOVE	MORGIA-PLANT,DIAL
	PRINTR	"The morgia plant, particularly susceptible to the meef spell, shrivels up and vanishes."
?ELS5:	EQUAL?	PRSA,V?TAKE \?ELS9
	PRINTR	"The plant is so heavy you succeed only in budging it a few inches."
?ELS9:	EQUAL?	PRSA,V?EAT \?ELS13
	PRINTR	"Morgias taste terrible; besides, Belboz wouldn't like someone munching on his favorite plant."
?ELS13:	EQUAL?	PRSA,V?RESEARCH \FALSE
	PRINTR	"A beautiful and exotic plant, the morgia is well-known for its susceptibility to magic spells."


	.FUNCT	HALLWAY-1-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	HALLWAY-DESC
	PRINTI	"A heavy wooden door, currently "
	FSET?	CHAMBER-DOOR,OPENBIT \?ELS10
	PRINTI	"open"
	JUMP	?CND8
?ELS10:	PRINTI	"closed"
?CND8:	PRINTR	", leads north."


	.FUNCT	HALLWAY-2-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	CALL	HALLWAY-DESC
	PRINTR	"A large marble archway to the south leads into an open area."


	.FUNCT	HALLWAY-DESC
	PRINTI	"Rooms lie to the east and west from this north-south corridor. "
	RTRUE	


	.FUNCT	CHAMBER-OF-THE-CIRCLE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"The meeting place of the Circle of Enchanters is a large, round room with a high domed ceiling. A table occupies the center of the room. Engraved on the wall is a list of tenets, the Guild's code of honor. The only door, at the southernmost point of the perimeter, is "
	FSET?	CHAMBER-DOOR,OPENBIT \?ELS10
	PRINTI	"open"
	JUMP	?CND8
?ELS10:	PRINTI	"closed"
?CND8:	PRINTR	"."


	.FUNCT	TABLE-PSEUDO
	EQUAL?	PRSA,V?CLIMB-ON,V?PUT-ON \?ELS5
	SET	'TABLE-WARNING,TRUE-VALUE
	PRINTR	"A warning nymph appears, floating over the table. ""The servants just finished waxing the table, and it's still wet."" With a sly grin, the nymph vanishes."
?ELS5:	ZERO?	TABLE-WARNING /FALSE
	EQUAL?	PRSA,V?PULVER \FALSE
	PRINTR	"That would cause the wax to dry dull and yellowish!"


	.FUNCT	MARBLE-PSEUDO
	RFALSE	


	.FUNCT	I-MAILMAN
	MOVE	MAGAZINE,MAILBOX
	FCLEAR	MAILBOX,OPENBIT
	IN?	MATCHBOOK,MAILBOX \?CND1
	MOVE	VILSTU-VIAL,MAILBOX
	MOVE	MATCHBOOK,DIAL
?CND1:	EQUAL?	HERE,LOBBY \?ELS8
	SET	'MAILMAN-FOLLOW,TRUE-VALUE
	CALL	QUEUE,I-MAILMAN-FOLLOW,1
	PUT	STACK,0,1
	CRLF	
	PRINTR	"A member of the Messengers Guild walks up and puts something in the receptacle. He closes it, and rings the doorbell. Noticing you, he gives a friendly wave before departing."
?ELS8:	CALL	IN-GUILD-HALL?
	ZERO?	STACK /FALSE
	CRLF	
	PRINTR	"The Guild Hall doorbell chimes."


	.FUNCT	I-MAILMAN-FOLLOW
	SET	'MAILMAN-FOLLOW,FALSE-VALUE
	RFALSE	


	.FUNCT	MAGAZINE-F
	EQUAL?	PRSA,V?READ,V?LOOK-INSIDE,V?OPEN \FALSE
	PRINTI	"This month's cover story is about Belboz! Other stories relate the explosion of spell scroll manufacturers, and the coming shakedown in the magic potion industry. The address label on the cover reads:

"
	CALL	FIXED-FONT-ON
	PRINTI	"    ""Z5 ACCAR256 4-964
    Hall of the Guild of Enchanters
    Village of Accardi-By-The-Sea
    Land of Frobozz"""
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	VILSTU-VIAL-F
	EQUAL?	PRSA,V?READ \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"
       ""VILSTU POTION
(obviate need for breathing)"""
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	VILSTU-POTION-F
	EQUAL?	PRSA,V?DRINK,V?EAT \?ELS5
	IN?	VILSTU-VIAL,PROTAGONIST /?ELS5
	CALL	POTION-POUR,VILSTU-VIAL
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?RESEARCH \?ELS9
	CALL	READ-ABOUT-POTIONS,3
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?DRINK,V?EAT \?ELS11
	MOVE	VILSTU-POTION,DIAL
	ZERO?	UNDER-INFLUENCE /?CND12
	CALL	TWO-POTIONS
	RTRUE	
?CND12:	SET	'UNDER-INFLUENCE,VILSTU-POTION
	CALL	QUEUE,I-BREATHE,19
	PUT	STACK,0,1
	SET	'VILSTUED,TRUE-VALUE
	EQUAL?	HERE,COAL-BIN-ROOM,DIAL-ROOM \?CND16
	CALL	INT,I-SUFFOCATE
	PUT	STACK,0,0
	CALL	QUEUE,I-OLDER-SELF,1
	PUT	STACK,0,1
?CND16:	PRINTR	"The orange potion tasted like pepper, and made your nose tingle."
?ELS11:	EQUAL?	PRSA,V?DROP \?ELS22
	CALL	PERFORM,V?POUR,PRSO,PRSI
	RTRUE	
?ELS22:	EQUAL?	PRSA,V?POUR \FALSE
	EQUAL?	PRSO,VILSTU-POTION \FALSE
	CALL	POTION-POUR,VILSTU-VIAL
	RSTACK	


	.FUNCT	I-BREATHE
	INC	'BREATH-SHORTAGE
	EQUAL?	UNDER-INFLUENCE,VILSTU-POTION \?CND1
	SET	'UNDER-INFLUENCE,FALSE-VALUE
?CND1:	EQUAL?	BREATH-SHORTAGE,1 \?ELS8
	CALL	QUEUE,I-BREATHE,4
	PUT	STACK,0,1
	CRLF	
	PRINTI	"You feel the vilstu potion beginning to wear off"
	CALL	IN-COAL-MINE?
	ZERO?	STACK /?CND11
	PRINTI	", and the air here seems pretty unbreathable"
?CND11:	PRINTR	"."
?ELS8:	EQUAL?	BREATH-SHORTAGE,2 \?ELS19
	CALL	QUEUE,I-BREATHE,6
	PUT	STACK,0,1
	CRLF	
	PRINTI	"The vilstu potion has almost completely worn off now"
	CALL	IN-COAL-MINE?
	ZERO?	STACK /?CND22
	PRINTI	", and I doubt you could survive here without it"
?CND22:	PRINTR	"."
?ELS19:	SET	'VILSTUED,FALSE-VALUE
	EQUAL?	HERE,LAGOON-FLOOR \?CND31
	CALL	QUEUE,I-DROWN,-1
	PUT	STACK,0,1
?CND31:	CRLF	
	PRINTI	"You feel the final effects of the vilstu potion vanish"
	CALL	IN-COAL-MINE?
	ZERO?	STACK /?ELS40
	CALL	JIGS-UP,STR?167
	RSTACK	
?ELS40:	SET	'AWAKE,8
	SET	'LOAD-ALLOWED,20
	SET	'FUMBLE-NUMBER,1
	CALL	QUEUE,I-TIRED,8
	PUT	STACK,0,1
	PRINTR	", leaving you totally exhausted (an unfortunate side effect)."


	.FUNCT	STAND-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"A volume lies open on the stand."


	.FUNCT	ENCYCLOPEDIA-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTI	"The volume lies open to "
	ZERO?	VOLUME-USED /?ELS12
	PRINTR	"a random entry."
?ELS12:	PRINTI	"an entry about the Glass Maze of King Duncanthrax. "
	CALL	PERFORM,V?RESEARCH,MAZE
	CRLF	
	PRINTR	"You could probably read about all sorts of other interesting people, places, and things by looking them up in the encyclopedia."
?ELS5:	EQUAL?	PRSA,V?OPEN \?ELS23
	PRINTR	"It is."
?ELS23:	EQUAL?	PRSA,V?CLOSE \?ELS27
	PRINTR	"Why bother?"
?ELS27:	EQUAL?	PRSA,V?TAKE \?ELS31
	PRINTR	"A library nymph appears, sitting on your wrist. ""Sorry, but the encyclopedia is never to be removed from the stand."" Kicking you gently in the thumb, the nymph vanishes."
?ELS31:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	CALL	PERFORM,V?READ,PRSO
	RTRUE	


	.FUNCT	BERZIO-VIAL-F
	EQUAL?	PRSA,V?READ \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"
        ""BERZIO POTION
(obviate need for food or drink)"""
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	BERZIO-POTION-F
	EQUAL?	PRSA,V?DRINK,V?EAT \?ELS5
	IN?	BERZIO-VIAL,PROTAGONIST /?ELS5
	CALL	POTION-POUR,BERZIO-VIAL
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?RESEARCH \?ELS9
	CALL	READ-ABOUT-POTIONS,1
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?DRINK,V?EAT \?ELS11
	MOVE	BERZIO-POTION,DIAL
	SET	'BERZIOED,TRUE-VALUE
	CALL	QUEUE,I-UNBERZIO,100
	PUT	STACK,0,1
	ADD	SCORE,10 >SCORE
	PRINTI	"The potion was completely tasteless."
	GRTR?	HUNGER-LEVEL,0 /?THN17
	GRTR?	THIRST-LEVEL,0 \?CND14
?THN17:	PRINTI	" You no longer feel hungry and thirsty, though."
?CND14:	SET	'HUNGER-LEVEL,0
	SET	'THIRST-LEVEL,0
	CRLF	
	RTRUE	
?ELS11:	EQUAL?	PRSA,V?DROP \?ELS22
	CALL	PERFORM,V?POUR,PRSO,PRSI
	RTRUE	
?ELS22:	EQUAL?	PRSA,V?POUR \FALSE
	EQUAL?	PRSO,BERZIO-POTION \FALSE
	CALL	POTION-POUR,BERZIO-VIAL
	RSTACK	


	.FUNCT	I-UNBERZIO
	SET	'BERZIOED,FALSE-VALUE
	RFALSE	


	.FUNCT	MATCHBOOK-F
	EQUAL?	PRSA,V?CLOSE \?ELS5
	PRINTR	"Why bother?"
?ELS5:	EQUAL?	PRSA,V?COUNT,V?EXAMINE,V?OPEN /?THN10
	EQUAL?	PRSA,V?STRIKE \?ELS9
?THN10:	PRINTR	"The matches are all gone, but there is some printing on the inner cover."
?ELS9:	EQUAL?	PRSA,V?READ \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"""Amazing Vilstu Potion!

Get by without breathing! Amaze your
friends! Be the first person on the
block to own some!

Order today by dropping this in any
mailbox. Our shipping department will
use the latest in temporal travel
techniques to insure that your potion
arrives the same day you order it!
(Orders received before noon will
arrive the day before you order)."""
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	CALENDAR-F
	EQUAL?	PRSA,V?LOOK-INSIDE,V?OPEN \FALSE
	CALL	PERFORM,V?READ,CALENDAR
	RTRUE	


	.FUNCT	COBWEB-PSEUDO
	RFALSE	


	.FUNCT	TRUNK-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	EQUAL?	PRSO,TRUNK \?ELS5
	PRINTR	"It's too heavy to even budge."
?ELS5:	FSET?	TRUNK,OPENBIT /FALSE
	EQUAL?	PRSA,V?OPEN \?ELS16
	PRINTR	"The lid won't budge."
?ELS16:	EQUAL?	PRSA,V?UNLOCK \?ELS20
	PRINTR	"Perhaps the buttons..."
?ELS20:	EQUAL?	PRSA,V?REZROV \FALSE
	PRINTR	"The lid bulges outward for a moment."


	.FUNCT	BUTTON-F
	EQUAL?	PRSA,V?LOOK-UNDER \?ELS5
	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?PUSH \FALSE
	PRINTI	"There is a click from the lid of the trunk"
	EQUAL?	PRSO,BLACK-BUTTON \?ELS18
	EQUAL?	NEXT-NUMBER,1 /?THN15
?ELS18:	EQUAL?	PRSO,GRAY-BUTTON \?ELS20
	EQUAL?	NEXT-NUMBER,2 /?THN15
?ELS20:	EQUAL?	PRSO,RED-BUTTON \?ELS22
	EQUAL?	NEXT-NUMBER,3 /?THN15
?ELS22:	EQUAL?	PRSO,PURPLE-BUTTON \?ELS24
	EQUAL?	NEXT-NUMBER,4 /?THN15
?ELS24:	EQUAL?	PRSO,WHITE-BUTTON \?ELS14
	EQUAL?	NEXT-NUMBER,5 \?ELS14
?THN15:	INC	'CURRENT-TLOC
	GET	NEXT-CODE-TABLE,CURRENT-TLOC >NEXT-NUMBER
	ZERO?	NEXT-NUMBER \?CND12
	ZERO?	TRUNK-SCREWED \?CND12
	FSET	TRUNK,OPENBIT
	ADD	SCORE,25 >SCORE
	PRINTI	". A moment later, the lid of the trunk swings slowly open, revealing "
	CALL	PRINT-CONTENTS,TRUNK
	JUMP	?CND12
?ELS14:	SET	'TRUNK-SCREWED,TRUE-VALUE
?CND12:	PRINTR	"."

	.ENDI

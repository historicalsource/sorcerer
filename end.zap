

	.FUNCT	COVE-F,RARG,X=0
	EQUAL?	RARG,M-ENTER \FALSE
	FSET?	COVE,TOUCHBIT /FALSE
	ZERO?	BOOK-BELONGS-IN-LAGOON /?CND8
	MOVE	SPELL-BOOK,LAGOON-FLOOR
?CND8:	PUT	VEZZAS,6,0
	ADD	SCORE,20 >SCORE
	CALL	INT,I-SUFFOCATE
	PUT	STACK,0,0
	CALL	INT,I-YOUNGER-SELF
	PUT	STACK,0,0
	CALL	INT,I-OLDER-SELF
	PUT	STACK,0,0
	ZERO?	GOLMACKED /?ELS14
	ZERO?	COMBO-REVEALED \?ELS14
	CALL	POOF
	JUMP	?CND12
?ELS14:	ZERO?	GOLMACKED \?CND12
	CALL	HELD?,ROPE
	ZERO?	STACK /?CND19
	MOVE	ROPE,DIAL
	SET	'X,TRUE-VALUE
?CND19:	CALL	HELD?,BEAM
	ZERO?	STACK /?CND22
	MOVE	BEAM,DIAL
	SET	'X,TRUE-VALUE
?CND22:	CALL	HELD?,VARDIK-SCROLL
	ZERO?	STACK /?CND25
	MOVE	VARDIK-SCROLL,DIAL
	SET	'X,TRUE-VALUE
?CND25:	CALL	HELD?,GOLMAC-SCROLL
	ZERO?	STACK /?CND28
	MOVE	GOLMAC-SCROLL,DIAL
	SET	'X,TRUE-VALUE
?CND28:	ZERO?	X /?CND12
	PRINTI	"As you slide down the chute, some of your possessions suddenly vanish! "
?CND12:	PRINTI	"You fly out of the chute and land just at the edge of some water..."
	CRLF	
	CRLF	
	RTRUE	


	.FUNCT	POOF
	SET	'POOFED,TRUE-VALUE
	PRINTI	"Suddenly, without the slightest fanfare, you cease to exist!"
	CRLF	
	CALL	FINISH
	RSTACK	


	.FUNCT	OCEAN-SHORE-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are "
	ZERO?	FLYING /?ELS10
	PRINTI	"floating above"
	JUMP	?CND8
?ELS10:	PRINTI	"standing on"
?CND8:	PRINTI	" the western shore of the mighty Flathead Ocean. According to legends you read at the University, the eastern shore of this ocean is a strange land of magical beings and priceless treasures. "
	EQUAL?	HERE,OCEAN-NORTH \?ELS22
	PRINTI	"You could go north along the shore; the edge of a small cove lies to the southwest."
	JUMP	?CND20
?ELS22:	PRINTI	"The beach to the south is blocked by a tall cliff; a lagoon shore lies to the northwest."
?CND20:	CRLF	
	RTRUE	


	.FUNCT	OCEAN-F,X=0
	EQUAL?	HERE,GUN-EMPLACEMENT,TURRET,TOP-OF-FALLS \?ELS5
	PRINTR	"The ocean lies far below you."
?ELS5:	EQUAL?	PRSA,V?PULVER \?ELS9
	SET	'PERFORMING-SPELL,TRUE-VALUE
	CALL	PERFORM,V?PULVER,LAGOON-OBJECT
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?DRINK-FROM,V?DRINK \?ELS11
	CALL	PERFORM,V?DRINK,WATER
	RTRUE	
?ELS11:	EQUAL?	PRSA,V?EXAMINE \?ELS13
	PRINTR	"It streches east as far as the eye can see."
?ELS13:	EQUAL?	PRSA,V?RESEARCH \?ELS17
	PRINTR	"The Flathead Ocean, called the Great Sea by the ancients, has a very unusual feature -- its western shore basks in the sunlight while its eastern shore lies far underground."
?ELS17:	EQUAL?	PRSA,V?PUT \?ELS21
	EQUAL?	OCEAN,PRSI \?ELS21
	MOVE	PRSO,DIAL
	CALL	SPLASH
	RSTACK	
?ELS21:	EQUAL?	PRSA,V?THROUGH \FALSE
	CALL	JIGS-UP,STR?318
	RSTACK	


	.FUNCT	CLIFF-PSEUDO
	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP \FALSE
	ZERO?	FLYING /?ELS10
	PRINTR	"The cliff is too high to fly over."
?ELS10:	PRINTR	"The cliff is unclimbable."


	.FUNCT	LAGOON-OBJECT-F
	EQUAL?	PRSA,V?THROUGH \?ELS5
	EQUAL?	HERE,LAGOON,LAGOON-FLOOR \?ELS10
	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS10:	CALL	GOTO,LAGOON
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?PUT \?ELS14
	EQUAL?	HERE,LAGOON-FLOOR /?ELS14
	EQUAL?	PRSI,LAGOON-OBJECT \?ELS14
	MOVE	PRSO,LAGOON-FLOOR
	FSET?	PRSO,SCROLLBIT /?THN20
	EQUAL?	PRSO,SPELL-BOOK \?CND17
?THN20:	FSET	PRSO,MUNGBIT
?CND17:	CALL	SPLASH
	RSTACK	
?ELS14:	EQUAL?	PRSA,V?EXAMINE \?ELS23
	PRINTR	"The water looks calm and hospitable."
?ELS23:	EQUAL?	PRSA,V?DRINK-FROM,V?DRINK \?ELS27
	CALL	PERFORM,V?DRINK,WATER
	RTRUE	
?ELS27:	EQUAL?	PRSA,V?PULVER \FALSE
	PRINTR	"The water level seems to drop an inch or two, for a moment."


	.FUNCT	LAGOON-F,RARG,X
	EQUAL?	RARG,M-ENTER \?ELS5
	FIRST?	PROTAGONIST >X /?KLU35
?KLU35:	
?PRG6:	ZERO?	X /TRUE
	FSET?	X,SCROLLBIT /?THN15
	EQUAL?	X,SPELL-BOOK \?CND12
?THN15:	FSET	X,MUNGBIT
?CND12:	NEXT?	X >X /?KLU36
?KLU36:	JUMP	?PRG6
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are "
	ZERO?	FLYING /?ELS25
	PRINTI	"flying over"
	JUMP	?CND23
?ELS25:	PRINTI	"swimming on"
?CND23:	PRINTR	" the surface of a calm lagoon, whose sandy floor is visible below. A curved beach surrounds this inlet on its western side."


	.FUNCT	LAGOON-FLOOR-ENTER-F
	ZERO?	FLYING /?ELS5
	CALL	WHILE-FLYING
	RFALSE	
?ELS5:	RETURN	LAGOON-FLOOR


	.FUNCT	SAND-PSEUDO
	EQUAL?	PSEUDO-OBJECT,PRSO \?ELS5
	SET	'PERFORMING-SPELL,TRUE-VALUE
	CALL	PERFORM,PRSA,GROUND,PRSI
	RTRUE	
?ELS5:	SET	'PERFORMING-SPELL,TRUE-VALUE
	CALL	PERFORM,PRSA,PRSO,GROUND
	RTRUE	


	.FUNCT	LAGOON-FLOOR-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	CALL	QUEUE,I-DROWN,-1
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	I-DROWN
	EQUAL?	HERE,LAGOON-FLOOR \?ELS5
	ZERO?	VILSTUED \FALSE
	INC	'UNDERWATER-COUNTER
	EQUAL?	UNDERWATER-COUNTER,3 \?ELS14
	CRLF	
	PRINTR	"You won't be able to hold your breath much longer."
?ELS14:	EQUAL?	UNDERWATER-COUNTER,4 \?ELS18
	CRLF	
	PRINTR	"Better get some fresh air soon!"
?ELS18:	EQUAL?	UNDERWATER-COUNTER,5 \FALSE
	SET	'UNDERWATER-COUNTER,0
	CRLF	
	CALL	JIGS-UP,STR?320
	RSTACK	
?ELS5:	SET	'UNDERWATER-COUNTER,0
	CALL	INT,I-DROWN
	PUT	STACK,0,0
	RFALSE	


	.FUNCT	CORAL-PSEUDO
	EQUAL?	PRSA,V?EXAMINE \FALSE
	IN?	HERE,SPENSEWEEDS \FALSE
	PRINTR	"The coral is covered by swaying spenseweeds."


	.FUNCT	SPENSEWEEDS-F
	EQUAL?	PRSA,V?MEEF \?ELS5
	MOVE	SPENSEWEEDS,DIAL
	MOVE	CRATE,HERE
	CALL	THIS-IS-IT,CRATE
	PRINTR	"The spenseweeds wilt away, revealing a wooden crate labelled with black lettering."
?ELS5:	EQUAL?	PRSA,V?LOOK-UNDER \FALSE
	PRINTR	"That's difficult -- they're well rooted in the coral."


	.FUNCT	CRATE-F
	EQUAL?	PRSA,V?REZROV,V?OPEN \?ELS5
	ZERO?	CRATE-POINT \?ELS5
	SET	'CRATE-POINT,TRUE-VALUE
	ADD	SCORE,15 >SCORE
	RFALSE	
?ELS5:	EQUAL?	PRSA,V?READ \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"Stencilled diagonally across the crate:

    GRUE PROTECTION KIT

Below, in much smaller letters:

    FROM:
    Frobozz Magic Grue Accessories Co.

    TO:
    Aragain Brothers Circus
    Attn: Grue Trainer"
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	BRASS-LANTERN-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTI	"It is a battery-powered lantern like those used by adventurers and explorers. It is currently "
	FSET?	BRASS-LANTERN,ONBIT \?ELS10
	PRINTI	"on"
	JUMP	?CND8
?ELS10:	PRINTI	"off"
?CND8:	PRINTR	"."


	.FUNCT	GRUE-REPELLENT-F
	EQUAL?	PRSA,V?SHAKE \?ELS5
	ZERO?	SPRAY-USED? /?ELS10
	PRINTR	"The can seems empty."
?ELS10:	PRINTR	"There is a sloshing sound from inside."
?ELS5:	EQUAL?	PRSA,V?PUT-ON,V?SPRAY \FALSE
	EQUAL?	PRSO,GRUE-REPELLENT \FALSE
	ZERO?	SPRAY-USED? /?ELS26
	PRINTR	"The repellent is all gone."
?ELS26:	ZERO?	PRSI \?ELS31
	SET	'SPRAY-USED?,TRUE-VALUE
	PRINTR	"The spray stinks amazingly for a few moments, then drifts away."
?ELS31:	EQUAL?	PRSI,ME \?CND36
	CALL	QUEUE,I-SPRAY,5
	PUT	STACK,0,1
	SET	'SPRAYED?,TRUE-VALUE
?CND36:	SET	'SPRAY-USED?,TRUE-VALUE
	PRINTR	"The spray smells like a mixture of old socks and burning rubber. If I were a grue I'd sure stay clear!"


	.FUNCT	I-SPRAY
	SET	'SPRAYED?,FALSE-VALUE
	CRLF	
	PRINTR	"That horrible smell is much less pungent now."


	.FUNCT	MOUTH-OF-RIVER-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"A mighty river spills into the ocean here. Looking up the river valley, you see a tall waterfall. Atop a cliff, high above you, is the rampart of a fortress. A cave entrance "
	IN?	VINES,HERE \?ELS10
	PRINTI	"at the base of the cliff to the west is blocked by writhing green vines"
	JUMP	?CND8
?ELS10:	PRINTI	"lies to the west"
?CND8:	PRINTR	"."
?ELS5:	EQUAL?	RARG,M-END \FALSE
	IN?	VINES,HERE \FALSE
	RANDOM	100
	LESS?	15,STACK /FALSE
	CRLF	
	PRINTI	"Suddenly you realize that, without really thinking about it, you were "
	ZERO?	FLYING /?ELS27
	PRINTI	"flying"
	JUMP	?CND25
?ELS27:	PRINTI	"walking"
?CND25:	PRINTR	" toward the wriggling vines. As you stop, a feeling of annoyance seems to radiate from the plants."


	.FUNCT	VINES-F
	EQUAL?	PRSA,V?MEEF \?ELS5
	MOVE	VINES,DIAL
	PRINTR	"You can almost feel a wave of pain from the vines as they shrivel away."
?ELS5:	EQUAL?	PRSA,V?KILL,V?ATTACK \?ELS9
	CALL	JIGS-UP,STR?324
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?BITE,V?KICK,V?THROUGH /?THN12
	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-UP,V?TAKE /?THN12
	EQUAL?	PRSA,V?RUB,V?MOVE,V?PUSH \FALSE
?THN12:	CALL	DO-WALK,P?WEST
	RSTACK	


	.FUNCT	VINES-EXIT-F
	IN?	VINES,HERE \?ELS5
	CALL	JIGS-UP,STR?325
	RFALSE	
?ELS5:	RETURN	GRUE-LAIR


	.FUNCT	GRUE-LAIR-F,RARG
	ZERO?	SPRAYED? \FALSE
	EQUAL?	RARG,M-END \FALSE
	IN?	GRUE-SUIT,PROTAGONIST /FALSE
	ZERO?	LIT \?THN13
	ZERO?	BLORTED /?ELS12
?THN13:	CALL	JIGS-UP,STR?327
	RSTACK	
?ELS12:	CALL	JIGS-UP,STR?328
	RSTACK	


	.FUNCT	MUTATED-GRUES-F
	EQUAL?	PRSA,V?FROTZ \?ELS5
	PRINTR	"One of the grues gives off a flash of light but, strangely, it doesn't seem to notice or care."
?ELS5:	EQUAL?	PRSA,V?RESEARCH \FALSE
	CALL	PERFORM,V?RESEARCH,GRUE
	RTRUE	


	.FUNCT	MUTATED-GRUES-DESCFCN,RARG
	ZERO?	LIT \?THN6
	ZERO?	BLORTED /?ELS5
?THN6:	ZERO?	SPRAYED? /?ELS12
	CALL	LIT-MESSAGE
	PRINTR	"They stagger about the room, covering their noses and making horrid gurgling noises."
?ELS12:	IN?	GRUE-SUIT,PROTAGONIST \?ELS17
	CALL	LIT-MESSAGE
	PRINTR	"They seem to be ignoring you, aside from a few suspicious gurgles in your direction."
?ELS17:	CALL	LIT-MESSAGE
	PRINTR	"Baring tremendous fangs, they form a circle around you..."
?ELS5:	PRINTR	"There are terrifying gurgling noises from the darkness!"


	.FUNCT	LIT-MESSAGE
	PRINTI	"A pack of grues fills the room! "
	ZERO?	LIT /FALSE
	PRINTI	"The grues, contrary to all conventional wisdom, aren't bothered by your light in the least. They must be mutated grues, no longer fearing light! "
	RTRUE	


	.FUNCT	MAMMOTH-CAVERN-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	ADD	SCORE,CAVERN-POINT >SCORE
	SET	'CAVERN-POINT,0
	PUT	VEZZAS,7,0
	RTRUE	


	.FUNCT	MACHINERY-F
	EQUAL?	PRSA,V?LAMP-ON,V?MUNG \?ELS5
	CALL	JIGS-UP,STR?330
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?READ,V?EXAMINE \FALSE
	PRINTR	"You notice, on one machine, a tiny plaque which reads:

FROBOZZ MAGIC MUTATED GRUE BREEDER CO."


	.FUNCT	CHAMBER-OF-LIVING-DEATH-F,RARG
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	PRSA,V?VERSION,V?SAVE,V?QUIT /?ELS5
	EQUAL?	PRSA,V?RESTART,V?RESTORE /?ELS5
	EQUAL?	PRSA,V?SUPER-BRIEF,V?VERBOSE,V?BRIEF /?ELS5
	EQUAL?	PRSA,V?UNSCRIPT,V?SCRIPT /?ELS5
	CALL	AGONY
	RTRUE	
?ELS5:	EQUAL?	RARG,M-END \FALSE
	PRINTR	"Hideous parasites descend upon you and tear the flesh from your bones, gnaw the eyes from your sockets, and feast upon your very brain tissue. Amazingly, you do not die, and your body regenerates itself as you await the next attack..."


	.FUNCT	PARASITES-PSEUDO
	RFALSE	


	.FUNCT	HALL-OF-ETERNAL-DEATH-F,RARG
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	PRSA,V?VERSION,V?SAVE,V?QUIT /?ELS5
	EQUAL?	PRSA,V?RESTART,V?RESTORE /?ELS5
	EQUAL?	PRSA,V?SUPER-BRIEF,V?VERBOSE,V?BRIEF /?ELS5
	EQUAL?	PRSA,V?UNSCRIPT,V?SCRIPT /?ELS5
	CALL	AGONY
	RTRUE	
?ELS5:	EQUAL?	RARG,M-END \FALSE
	PRINTR	"Disembodied forces suck the very thoughts from your mind, savoring each moment and growing stronger. Every second is an agonizing torment, as though thousands of raging fires were exploding in your skull, filling you with a pain greater than you could ever imagine."


	.FUNCT	FORCE-PSEUDO
	RFALSE	


	.FUNCT	AGONY
	PRINTR	"Your agony is too great to concentrate on such an action."


	.FUNCT	BLACK-DOOR-F
	EQUAL?	PRSA,V?REZROV,V?OPEN \FALSE
	PRINTI	"As the door opens, hundreds of slime-covered tentacles stream out and drag you across the threshold..."
	CRLF	
	CRLF	
	CALL	ROB,PROTAGONIST
	CALL	INT,I-TIRED
	PUT	STACK,0,0
	CALL	INT,I-THIRST
	PUT	STACK,0,0
	CALL	INT,I-HUNGER
	PUT	STACK,0,0
	CALL	WEAR-OFF-SPELLS
	CALL	GOTO,CHAMBER-OF-LIVING-DEATH
	RSTACK	


	.FUNCT	SILVER-DOOR-F
	EQUAL?	PRSA,V?REZROV,V?OPEN \FALSE
	PRINTI	"The door blows open, knocking you to the ground. You are pulled through the open doorway by an unseen force..."
	CRLF	
	CRLF	
	CALL	ROB,PROTAGONIST
	CALL	INT,I-TIRED
	PUT	STACK,0,0
	CALL	INT,I-HUNGER
	PUT	STACK,0,0
	CALL	INT,I-THIRST
	PUT	STACK,0,0
	CALL	WEAR-OFF-SPELLS
	CALL	GOTO,HALL-OF-ETERNAL-PAIN
	RSTACK	


	.FUNCT	WHITE-DOOR-F
	EQUAL?	PRSA,V?REZROV,V?OPEN \FALSE
	EQUAL?	HERE,BELBOZ-HIDEOUT \?CND6
	CALL	DO-WALK,P?EAST
	RTRUE	
?CND6:	ADD	SCORE,WHITE-DOOR-SCORE >SCORE
	SET	'WHITE-DOOR-SCORE,0
	PRINTI	"The door creaks slowly open. Within, you see someone lying as though asleep. You feel yourself drawn into the room..."
	CRLF	
	CRLF	
	CALL	QUEUE,I-BELBOZ-AWAKES,8
	PUT	STACK,0,1
	CALL	GOTO,BELBOZ-HIDEOUT
	RSTACK	


	.FUNCT	I-UNVARDIK
	SET	'VARDIKED,FALSE-VALUE
	CRLF	
	PRINTR	"Your head feels numb for a moment, and your mind feels suddenly open and unprotected."


	.FUNCT	KILL-BELBOZ
	ZERO?	BELBOZ-GASPARED /?ELS5
	SET	'BELBOZ-GASPARED,FALSE-VALUE
	PRINTI	"As you stab Belboz, an apparition rises from his body. Floating above him like a cloud of fog, it howls with laughter. A moment later, gaspar begins to heal the wounds, and the spirit flows back into the body."
	CRLF	
	CRLF	
	CALL	I-BELBOZ-AWAKES
	RSTACK	
?ELS5:	PRINTI	"You stab the knife time and again into Belboz, who writhes in pain, eyes bulging outward. Sickened and dizzy, you stagger back."
	CRLF	
	CRLF	
	SET	'BELBOZ-DEAD,TRUE-VALUE
	CALL	SWANZO-BELBOZ
	RSTACK	


	.FUNCT	SWANZO-BELBOZ
	PRINTI	"A wispy translucent shape rises from the "
	ZERO?	BELBOZ-DEAD /?ELS5
	PRINTI	"corpse"
	JUMP	?CND3
?ELS5:	PRINTI	"body"
?CND3:	PRINTI	" of Belboz. It speaks in a voice so deep that your whole body seems to hear it. ""Foolish Charlatan! I am forced to flee that weak, old body -- I shall take your own, instead! Already I have sucked all knowledge, all secrets from that ancient Enchanter. Now begins an epoch of evil transcending even your worst nightmares; a reign of terror that will last a thousand thousand years!"" The shape blows toward you on a cold wind."
	CRLF	
	CRLF	
	ZERO?	VARDIKED /?ELS19
	PRINTI	"Jeearr surrounds you like a cloud and begins to contract. Suddenly, it strikes your invisible protection and recoils as if burned. ""No!"" it cries. ""Such a guileless Enchanter developing a mind shield?"" The cloud is thinner, the voice fainter. ""It cannot be! I cannot survive ... without a host."" The demon roils in agony, then thins and dissipates. There is a final scream of pain, then silence."
	CRLF	
	CRLF	
	ZERO?	BELBOZ-DEAD /?ELS27
	PRINTI	"Jeearr is vanquished; the kingdom is saved. But you - you are stranded in a land unknown, and your closest friend, the greatest Enchanter of his age, lies dead by your own hand. Kneeling by his blood-soaked corpse, you beg for another chance..."
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS27:	PRINTI	"Belboz moans softly, and begins stirring. He sees you and rises, instantly alert. After posing a few well-chosen questions, he casts a brief but unfamiliar spell.

An instant later, "
	IN?	GRUE-SUIT,PROTAGONIST \?CND35
	PRINTI	"your grue suit has vanished and "
?CND35:	PRINTI	"you are standing in the Chamber of the Circle. The Circle of Enchanters is assembled. Belboz speaks. ""Once again, this young Enchanter has done a matchless service to the Guild and to the entire kingdom, displaying resourcefulness and imagination worthy of the greatest of Enchanters. I grow old, and must soon step down as Head of the Circle. But let it be known that a successor has been found."""
	CRLF	
	CRLF	
	ADD	SCORE,25 >SCORE
	SET	'HERE,CHAMBER-OF-THE-CIRCLE
	CALL	V-SCORE
	USL	
	CRLF	
	PRINTI	"Here ends the second chapter of the Enchanter saga, in which, by virtue of your skills, you have been appointed as the next leader of the Circle of Enchanters. The final adventure awaits you as the Enchanter series concludes."
	CRLF	
	IN?	MORGIA-PLANT,BELBOZ-QUARTERS /?CND44
	CRLF	
	PRINTI	"You hear a distant bellow. ""What happened to my morgia plant?"""
	CRLF	
?CND44:	CALL	FINISH,TRUE-VALUE
	RSTACK	
?ELS19:	PRINTI	"You feel an overwhelming sense of oppression as the demon seizes control of your mind and body. The monster reaches into the recesses of your mind, adding your hard-earned magic powers to its own. As it settles comfortably into your skull, the demon grants you a vision of the future. You see the enslaved people of the land toiling to erect great idols to Jeearr. Parents offer up their own children upon these altars, as the rivers of the land fill with blood. And YOU embody Jeearr; you are cursed by ten thousand generations of victims; your face adorns the idols. And worst of all, you remain awake and aware, a witness to horror, never sleeping, and never, ever to escape."
	CRLF	
	SET	'SCORE,-99
	CALL	FINISH
	RSTACK	


	.FUNCT	I-BELBOZ-AWAKES
	EQUAL?	HERE,BELBOZ-HIDEOUT \FALSE
	CRLF	
	PRINTI	"Suddenly, Belboz's eyes flicker and he leaps to his feet. His face is unrecognizable, a twisted mask of hatred. ""Meddlesome Enchanter! I should have killed you all before I left! But better late than never..."" Lightning bolts flash toward you from his fingers, but rather than dying, you find yourself in the..."
	CRLF	
	CRLF	
	CALL	ROB,PROTAGONIST
	CALL	INT,I-TIRED
	PUT	STACK,0,0
	CALL	INT,I-THIRST
	PUT	STACK,0,0
	CALL	INT,I-HUNGER
	PUT	STACK,0,0
	CALL	WEAR-OFF-SPELLS
	CALL	GOTO,HALL-OF-ETERNAL-PAIN
	RSTACK	

	.ENDI

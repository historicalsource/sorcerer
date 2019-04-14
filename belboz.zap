

	.FUNCT	I-WAKE-UP
	CALL	JIGS-UP,STR?190
	RSTACK	


	.FUNCT	TREE-F
	EQUAL?	PRSA,V?CLIMB-UP,V?CLIMB-FOO \?ELS5
	CALL	DO-WALK,P?UP
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?CLIMB-DOWN \?ELS7
	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS7:	EQUAL?	PRSA,V?LOOK-UNDER \?ELS9
	CALL	PERFORM,V?EXAMINE,GROUND
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?MEEF \FALSE
	SET	'PERFORMING-SPELL,TRUE-VALUE
	CALL	PERFORM,V?MEEF,FOREST
	RTRUE	


	.FUNCT	HELLHOUND-F
	EQUAL?	PRSA,V?RESEARCH \FALSE
	CALL	PERFORM,V?RESEARCH,LOBBY
	RTRUE	


	.FUNCT	I-HELLHOUND
	EQUAL?	HERE,TWISTED-FOREST \?ELS5
	ZERO?	HELLHOUND-WARNING /?ELS10
	CALL	JIGS-UP,STR?192
	RSTACK	
?ELS10:	SET	'HELLHOUND-WARNING,TRUE-VALUE
	CRLF	
	PRINTR	"A hellhound is racing straight toward you, its open jaws displaying rows of razor-sharp teeth."
?ELS5:	EQUAL?	HERE,TREE-BRANCH \?ELS17
	PRINTR	"The hellhound leaps madly about the base of the tree, gnashing its jaws."
?ELS17:	MOVE	HELLHOUND,DIAL
	CALL	INT,I-HELLHOUND
	PUT	STACK,0,0
	PRINTR	"The hellhound stops at the edge of the forest and bellows. After a moment, it turns and slinks into the trees."


	.FUNCT	TREE-BRANCH-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"You are "
	ZERO?	FLYING /?ELS10
	PRINTI	"flying near"
	JUMP	?CND8
?ELS10:	PRINTI	"on"
?CND8:	PRINTR	" a large gnarled branch of an old and twisted tree."
?ELS5:	EQUAL?	RARG,M-ENTER \FALSE
	CALL	QUEUE,I-BOA,-1
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	TREE-UP-F
	PRINTI	"You can't "
	ZERO?	FLYING /?ELS5
	PRINTI	"fly"
	JUMP	?CND3
?ELS5:	PRINTI	"climb"
?CND3:	PRINTI	" any higher."
	CRLF	
	RFALSE	


	.FUNCT	BOA-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"Your average giant carnivorous snake -- except that this one has three heads and an appetite to match."


	.FUNCT	I-BOA
	EQUAL?	HERE,TREE-BRANCH \?ELS5
	ZERO?	FLYING \FALSE
	ZERO?	BOA-WARNING /?ELS13
	CALL	JIGS-UP,STR?193
	RSTACK	
?ELS13:	SET	'BOA-WARNING,TRUE-VALUE
	CRLF	
	PRINTR	"A giant boa constrictor is slithering along the branch toward you!"
?ELS5:	SET	'BOA-WARNING,FALSE-VALUE
	CALL	INT,I-BOA
	PUT	STACK,0,0
	RFALSE	


	.FUNCT	FENCE-PSEUDO
	EQUAL?	PRSA,V?LEAP,V?CLIMB-FOO,V?CLIMB-OVER \FALSE
	PRINTR	"It's too tall."


	.FUNCT	SIGNPOST-F
	EQUAL?	PRSA,V?READ \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"
""  *** !!! >>> WARNING <<< !!! ***
     This path is protected by a
          Magic Mine Field
          installed by the
   Frobozz Magic Mine Field Company"
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	MINE-FIELD-EXIT-F
	EQUAL?	PRSO,P?SOUTH \?ELS5
	RANDOM	100
	LESS?	50,STACK /?ELS5
	RETURN	FOREST-EDGE
?ELS5:	ZERO?	FLYING /?CND10
	PRINTI	"Unfortunately, one of the properties of magic mine fields is their ability to blow you up even if you're floating above them. "
?CND10:	CALL	JIGS-UP,STR?198
	RFALSE	


	.FUNCT	SNAKE-PIT-PSEUDO
	EQUAL?	PRSA,V?THROUGH \FALSE
	CALL	LOOK-AROUND-YOU
	RSTACK	


	.FUNCT	CRACK-PSEUDO
	EQUAL?	PRSA,V?THROUGH \FALSE
	CALL	DO-WALK,P?DOWN
	RSTACK	


	.FUNCT	SNAKE-PIT-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	RANDOM	3
	ADD	1,STACK
	CALL	QUEUE,I-SNAKE-PIT,STACK
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	I-SNAKE-PIT
	EQUAL?	HERE,SNAKE-PIT \?ELS5
	CALL	JIGS-UP,STR?200
	RSTACK	
?ELS5:	CALL	INT,I-SNAKE-PIT
	PUT	STACK,0,0
	RTRUE	


	.FUNCT	MOSS-F
	EQUAL?	PRSA,V?MEEF \?ELS5
	PRINTR	"A few patches of the moss and lichens become brown and dry."
?ELS5:	EQUAL?	PRSA,V?EAT \FALSE
	CALL	JIGS-UP,STR?202
	RSTACK	


	.FUNCT	MEADOW-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	CALL	QUEUE,I-LOCUSTS,-1
	PUT	STACK,0,1
	RFALSE	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are in the center of a "
	IN?	MEADOW-OBJECT,HERE \?ELS12
	PRINTI	"rolling meadow of tall grass"
	JUMP	?CND10
?ELS12:	PRINTI	"barren field"
?CND10:	PRINTR	". To the east is the turret of a ruined castle, and from the northeast comes the sound of rushing water."


	.FUNCT	MEADOW-OBJECT-F
	EQUAL?	HERE,MEADOW /?ELS5
	EQUAL?	PRSA,V?MEEF,V?RUB \?ELS5
	PRINTR	"The meadow is too far away."
?ELS5:	EQUAL?	PRSA,V?MEEF \FALSE
	MOVE	MEADOW-OBJECT,DIAL
	PRINTR	"The grass vanishes as far as the eye can see."


	.FUNCT	PLAGUE-OF-LOCUSTS-F
	EQUAL?	PRSA,V?LOOK-UNDER \FALSE
	CALL	PERFORM,V?EXAMINE,MEADOW-OBJECT
	RTRUE	


	.FUNCT	I-LOCUSTS
	EQUAL?	HERE,MEADOW /?ELS5
	CALL	INT,I-LOCUSTS
	PUT	STACK,0,0
	SET	'LOCUST-WARNING,0
	RFALSE	
?ELS5:	ZERO?	LOCUST-WARNING \?ELS7
	INC	'LOCUST-WARNING
	CRLF	
	PRINTR	"A swarm of bloodsucking locusts appears on the horizon."
?ELS7:	EQUAL?	LOCUST-WARNING,1 \?ELS11
	INC	'LOCUST-WARNING
	CRLF	
	PRINTR	"The locusts are much closer now, blotting out the sun like a black storm cloud."
?ELS11:	SET	'LOCUST-WARNING,0
	CALL	JIGS-UP,STR?203
	RSTACK	


	.FUNCT	RIVER-BANK-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	PRINTI	"You are on a muddy bank "
	ZERO?	RIVER-EVAPORATED /?ELS10
	PRINTI	"above a dried-up river bed"
	JUMP	?CND8
?ELS10:	PRINTI	"of a fast-moving river, full of sharp rocks and foaming rapids, flowing to the southwest. The ground is soft and eroded, and continually threatens to dump you into the turbulent waters"
?CND8:	PRINTR	". A field lies to the southwest, and a trail leads southeast along the bank."
?ELS5:	EQUAL?	RARG,M-END \FALSE
	LESS?	BANK-COUNTER,3 \?ELS26
	INC	'BANK-COUNTER
	RFALSE	
?ELS26:	ZERO?	RIVER-EVAPORATED \FALSE
	ZERO?	FLYING \FALSE
	RANDOM	100
	LESS?	75,STACK /FALSE
	CALL	JIGS-UP,STR?205
	RSTACK	


	.FUNCT	ROCK-PSEUDO
	EQUAL?	PRSA,V?CROSS \FALSE
	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	RIVER-ENTER-F
	ZERO?	RIVER-EVAPORATED /?ELS5
	RETURN	RIVER-BED
?ELS5:	ZERO?	FLYING /?ELS8
	CALL	JIGS-UP,STR?206
	RFALSE	
?ELS8:	PRINTI	"You'd never survive the rapids."
	CRLF	
	RFALSE	


	.FUNCT	RIVER-F
	EQUAL?	HERE,GUN-EMPLACEMENT,TURRET \?ELS5
	PRINTR	"The river lies far below."
?ELS5:	ZERO?	RIVER-EVAPORATED /?ELS9
	PRINTR	"River? What river?"
?ELS9:	EQUAL?	PRSA,V?DRINK-FROM,V?DRINK \?ELS14
	CALL	PERFORM,V?DRINK,WATER
	RTRUE	
?ELS14:	EQUAL?	PRSA,V?PULVER \?ELS16
	EQUAL?	HERE,RIVER-BANK \?ELS21
	SET	'RIVER-EVAPORATED,TRUE-VALUE
	CALL	QUEUE,I-TRICKLE,3
	PUT	STACK,0,1
	PRINTR	"The river dries up, leaving only a few puddles between the rocks! It's now safe to climb down into the river bed."
?ELS21:	PRINTR	"The water level drops several feet, but quickly surges back."
?ELS16:	EQUAL?	PRSA,V?EXAMINE \?ELS29
	PRINTR	"The river flows quickly by below you."
?ELS29:	EQUAL?	PRSA,V?PUT \?ELS33
	EQUAL?	RIVER,PRSI \?ELS33
	MOVE	PRSO,DIAL
	CALL	SPLASH
	RSTACK	
?ELS33:	EQUAL?	PRSA,V?THROUGH \FALSE
	CALL	DO-WALK,P?NORTH
	RSTACK	


	.FUNCT	I-TRICKLE
	CALL	QUEUE,I-FLOOD,2
	PUT	STACK,0,1
	EQUAL?	HERE,RIVER-BANK,RIVER-BED /?THN6
	EQUAL?	HERE,STAGNANT-POOL,TOP-OF-FALLS \FALSE
?THN6:	CRLF	
	PRINTR	"A trickle of water begins flowing down the center of the river bed."


	.FUNCT	I-FLOOD
	SET	'RIVER-EVAPORATED,FALSE-VALUE
	CALL	FLOOD-LOOP,RIVER-BED
	CALL	FLOOD-LOOP,STAGNANT-POOL
	CALL	FLOOD-LOOP,TOP-OF-FALLS
	CRLF	
	EQUAL?	HERE,STAGNANT-POOL,RIVER-BED,TOP-OF-FALLS \?ELS5
	CALL	JIGS-UP,STR?207
	RSTACK	
?ELS5:	EQUAL?	HERE,RIVER-BANK \?ELS7
	PRINTR	"A wall of water rushes down the river bed as the river returns with a vengeance."
?ELS7:	EQUAL?	HERE,HIDDEN-CAVE \FALSE
	PRINTR	"There is a roar of water from outside the cave. The lower part of the cave, near the mouth, fills with a pool of swirling water!"


	.FUNCT	FLOOD-LOOP,LOC,X,N
	FIRST?	LOC >X /?KLU14
?KLU14:	ZERO?	X /TRUE
?PRG4:	NEXT?	X >N /?KLU15
?KLU15:	EQUAL?	X,PROTAGONIST /?CND6
	MOVE	X,DIAL
?CND6:	ZERO?	N /TRUE
	SET	'X,N
	JUMP	?PRG4


	.FUNCT	UNDERGROWTH-F
	EQUAL?	PRSA,V?MEEF \FALSE
	PRINTR	"The nearest part of the undergrowth withers away ... revealing more undergrowth."


	.FUNCT	BANKS-F
	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-DOWN,V?CLIMB-UP \FALSE
	CALL	V-WALK-AROUND
	RSTACK	


	.FUNCT	RIVER-BED-OBJECT-F
	EQUAL?	PRSA,V?THROUGH \?ELS5
	EQUAL?	HERE,RIVER-BANK \?ELS10
	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS10:	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXIT,V?DROP \FALSE
	EQUAL?	HERE,RIVER-BANK \?ELS19
	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS19:	CALL	DO-WALK,P?UP
	RSTACK	


	.FUNCT	RIVER-BED-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	PUT	VEZZAS,1,0
	RFALSE	


	.FUNCT	PUDDLE-PSEUDO
	EQUAL?	PRSA,V?THROUGH \?ELS5
	PRINTR	"The puddles are very shallow."
?ELS5:	EQUAL?	PRSA,V?PULVER \FALSE
	SET	'PERFORMING-SPELL,TRUE-VALUE
	CALL	PERFORM,V?PULVER,WATER
	RTRUE	


	.FUNCT	FISH-PSEUDO
	EQUAL?	PRSA,V?TAKE \FALSE
	PRINTR	"They squirm from your grasp."


	.FUNCT	TENTACLE-DEATH
	ZERO?	FLYING /?ELS3
	PRINTI	"You fly over the surface of the pool."
	JUMP	?CND1
?ELS3:	PRINTI	"You wade into the stagnant pool."
?CND1:	CALL	JIGS-UP,STR?210
	RFALSE	


	.FUNCT	RIVER-EXIT-F
	PRINTI	"The banks are too "
	ZERO?	FLYING /?ELS5
	PRINTI	"high to fly over."
	CRLF	
	RFALSE	
?ELS5:	PRINTI	"steep to climb."
	CRLF	
	RFALSE	


	.FUNCT	WATERFALL-EXIT-F
	ZERO?	FLYING /?ELS3
	PRINTI	"That would be foolhardy, as flying spells are of limited duration."
	CRLF	
	RFALSE	
?ELS3:	PRINTI	"That would involve quite a plunge."
	CRLF	
	RFALSE	


	.FUNCT	TOP-OF-CLIFF-PSEUDO
	EQUAL?	PRSA,V?CLIMB-DOWN \?ELS5
	PRINTR	"Impossible."
?ELS5:	EQUAL?	PRSA,V?LEAP \FALSE
	CALL	JIGS-UP,STR?212
	RSTACK	


	.FUNCT	HAZE-PSEUDO
	EQUAL?	PRSA,V?RUB \FALSE
	PRINTR	"From here?"


	.FUNCT	WATERFALL-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"It's no Aragain Falls, but it's pretty impressive."
?ELS5:	EQUAL?	PRSA,V?LEAP \?ELS9
	EQUAL?	HERE,TOP-OF-FALLS \?ELS9
	SET	'PRSO,FALSE-VALUE
	CALL	PERFORM,V?LEAP
	RTRUE	
?ELS9:	EQUAL?	HERE,MOUTH-OF-RIVER,TURRET \FALSE
	EQUAL?	PRSA,V?SMELL,V?RUB,V?LEAP /?THN16
	EQUAL?	PRSA,V?LISTEN \FALSE
?THN16:	PRINTR	"From here?"


	.FUNCT	HIDDEN-CAVE-F,RARG
	EQUAL?	RARG,M-ENTER \?ELS5
	FSET?	HIDDEN-CAVE,TOUCHBIT /?ELS5
	ADD	SCORE,20 >SCORE
	RETURN	SCORE
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"This is a hollow area under the northeast bank of the river. The floor rises away from the mouth of the cave, which is at its southwest end. "
	ZERO?	RIVER-EVAPORATED \?CND12
	PRINTI	"The mouth is filled with a pool of swirling water. "
?CND12:	PRINTR	"A dark hole leads downward at the far end of the cave."


	.FUNCT	BAT-GUANO-F
	EQUAL?	PRSA,V?TAKE \FALSE
	FSET?	FWEEP-SCROLL,TOUCHBIT /FALSE
	FSET	FWEEP-SCROLL,TOUCHBIT
	FSET	BAT-GUANO,TOUCHBIT
	FCLEAR	BAT-GUANO,TRYTAKEBIT
	FCLEAR	BAT-GUANO,NDESCBIT
	MOVE	BAT-GUANO,PROTAGONIST
	PRINTR	"As you take the guano, the soiled scroll falls to the ground."


	.FUNCT	BLORT-VIAL-F
	EQUAL?	PRSA,V?READ \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"
        ""BLORT POTION
(ability to see in dark places)"""
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	BLORT-POTION-F
	EQUAL?	PRSA,V?DRINK,V?EAT \?ELS5
	CALL	HELD?,BLORT-VIAL
	ZERO?	STACK \?ELS5
	CALL	POTION-POUR,BLORT-VIAL
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?RESEARCH \?ELS9
	CALL	READ-ABOUT-POTIONS,1
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?DRINK,V?EAT \?ELS11
	MOVE	BLORT-POTION,DIAL
	ZERO?	UNDER-INFLUENCE /?CND12
	CALL	TWO-POTIONS
	RTRUE	
?CND12:	CALL	QUEUE,I-UNBLORT,24
	PUT	STACK,0,1
	SET	'BLORTED,TRUE-VALUE
	SET	'UNDER-INFLUENCE,BLORT-POTION
	PRINTR	"The amber potion tasted like chives, and made your eyes tingle."
?ELS11:	EQUAL?	PRSA,V?DROP \?ELS19
	CALL	PERFORM,V?POUR,PRSO,PRSI
	RTRUE	
?ELS19:	EQUAL?	PRSA,V?POUR \FALSE
	EQUAL?	PRSO,BLORT-POTION \FALSE
	CALL	POTION-POUR,BLORT-VIAL
	RSTACK	


	.FUNCT	I-UNBLORT
	SET	'BLORTED,FALSE-VALUE
	EQUAL?	UNDER-INFLUENCE,BLORT-POTION \?CND1
	SET	'UNDER-INFLUENCE,FALSE-VALUE
?CND1:	CRLF	
	PRINTI	"Your eyes tingle for a moment."
	ZERO?	LIT \?CND6
	PRINTI	" You can no longer see anything around you!"
?CND6:	CRLF	
	RTRUE	


	.FUNCT	I-UNFWEEP
	SET	'FWEEPED,FALSE-VALUE
	SET	'FLYING,FALSE-VALUE
	CRLF	
	PRINTI	"After a moment of futilely flapping your arms, you realize that the fweep spell has worn off. "
	EQUAL?	HERE,GLASS-MAZE \?ELS5
	CALL	NO-FLOOR?
	ZERO?	STACK /?ELS5
	CALL	JIGS-UP,STR?216
	JUMP	?CND3
?ELS5:	EQUAL?	HERE,TREE-BRANCH \?ELS9
	CALL	SETTLE-ONTO-BRANCH
	JUMP	?CND3
?ELS9:	EQUAL?	HERE,LAGOON \?ELS11
	CALL	SPLASH-INTO-WATER
	JUMP	?CND3
?ELS11:	PRINTI	"You fall several feet to the ground."
	CRLF	
?CND3:	GRTR?	AWAKE,8 \FALSE
	CALL	I-TIRED
	RSTACK	


	.FUNCT	DRAWBRIDGE-F,RARG
	EQUAL?	RARG,M-END \?ELS5
	ZERO?	FLYING \?ELS5
	ZERO?	DRAWBRIDGE-MOVE /?ELS12
	RANDOM	100
	LESS?	40,STACK /?ELS18
	PRINTI	"With a scream of splintering wood, part of the drawbridge collapses and spills you into the moat. "
	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS18:	PRINTR	"The bridge continues to creak."
?ELS12:	SET	'DRAWBRIDGE-MOVE,TRUE-VALUE
	RFALSE	
?ELS5:	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are "
	ZERO?	FLYING /?ELS33
	PRINTI	"floating over"
	JUMP	?CND31
?ELS33:	PRINTI	"standing on"
?CND31:	PRINTI	" the drawbridge of a ruined castle which lies to your east. The wood of the bridge looks severely rotted"
	ZERO?	FLYING /?ELS45
	PRINTI	". The moat is"
	JUMP	?CND43
?ELS45:	PRINTI	" and creaks ominously beneath you. The moat, although an easy dive from here, looks dangerous,"
?CND43:	PRINTR	" full of sinister shapes beneath the surface of the water. To the west is a wide field."


	.FUNCT	DRAWBRIDGE-EXIT-F
	CALL	JIGS-UP,STR?217
	RFALSE	


	.FUNCT	MOAT-F
	EQUAL?	PRSA,V?PULVER \?ELS5
	PRINTR	"The moat dries up, leaving vicious-looking creatures flopping around in puddles. Immediately, the castle's automatic moat-filler turns on, and refills the moat."
?ELS5:	EQUAL?	PRSA,V?DRINK-FROM,V?DRINK \?ELS9
	CALL	PERFORM,V?DRINK,WATER
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?EXAMINE \?ELS11
	PRINTR	"The water is murky, and lily pads cover most of the surface. Dark shapes swim about below the surface."
?ELS11:	EQUAL?	PRSA,V?THROUGH,V?LEAP \FALSE
	CALL	DO-WALK,P?DOWN
	RSTACK	


	.FUNCT	BRIDGE-F
	EQUAL?	PRSA,V?LOOK-UNDER \?ELS5
	CALL	PERFORM,V?EXAMINE,MOAT
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?LISTEN \FALSE
	PRINTR	"Creak, creak."


	.FUNCT	TURRET-PSEUDO
	EQUAL?	PRSA,V?THROUGH \?ELS5
	EQUAL?	HERE,RUINS \?ELS10
	CALL	DO-WALK,P?UP
	RSTACK	
?ELS10:	EQUAL?	HERE,MEADOW \?ELS12
	CALL	CANT-ENTER,IT
	RSTACK	
?ELS12:	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXIT,V?DROP \?ELS16
	EQUAL?	HERE,TURRET \?ELS21
	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS21:	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS16:	EQUAL?	PRSA,V?LEAP \FALSE
	EQUAL?	HERE,TURRET \FALSE
	SET	'PRSO,FALSE-VALUE
	CALL	PERFORM,V?LEAP
	RTRUE	


	.FUNCT	TORTURE-DEVICES-F
	EQUAL?	PRSA,V?EXAMINE \FALSE
	PRINTR	"All the usual torture devices are here, all quite mean and deadly looking."


	.FUNCT	FLAXO-VIAL-F
	EQUAL?	PRSA,V?READ \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"
   ""FLAXO POTION
(exquisite torture)"""
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	FLAXO-POTION-F
	EQUAL?	PRSA,V?DRINK,V?EAT \?ELS5
	CALL	HELD?,FLAXO-VIAL
	ZERO?	STACK \?ELS5
	CALL	POTION-POUR,FLAXO-VIAL
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?RESEARCH \?ELS9
	CALL	READ-ABOUT-POTIONS,2
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?DRINK,V?EAT \?ELS11
	MOVE	FLAXO-POTION,DIAL
	PRINTI	"The potion tastes like a combination of anchovies, prune juice, and garlic powder. As you finish swallowing the potion, a well-muscled troll saunters in"
	EQUAL?	HERE,TORTURE-CHAMBER \?CND14
	PRINTI	" and straps you to a torture device"
?CND14:	PRINTR	". He whacks your head with a wooden two-by-four, grunting ""You are playing Sorcerer. It was written by S. Eric Meretzky. You will have fun and enjoy yourself."" He repeats this action 999 more times, then vanishes without a trace."
?ELS11:	EQUAL?	PRSA,V?DROP \?ELS22
	CALL	PERFORM,V?POUR,PRSO,PRSI
	RTRUE	
?ELS22:	EQUAL?	PRSA,V?POUR \FALSE
	EQUAL?	PRSO,FLAXO-POTION \FALSE
	CALL	POTION-POUR,FLAXO-VIAL
	RSTACK	


	.FUNCT	PIT-OF-BONES-EXIT-F
	ZERO?	FLYING /?ELS3
	PRINTI	"You can't fly high enough to reach the hole."
	CRLF	
	RFALSE	
?ELS3:	PRINTI	"The hole is too high to reach."
	CRLF	
	RFALSE	


	.FUNCT	BONES-PSEUDO
	EQUAL?	PRSA,V?DIG,V?SEARCH,V?TAKE \?ELS5
	PRINTR	"They're at the bottom of the pit."
?ELS5:	EQUAL?	PRSA,V?MALYON \FALSE
	CALL	JIGS-UP,STR?225
	RSTACK	


	.FUNCT	PIT-PSEUDO
	EQUAL?	PRSA,V?THROUGH,V?LEAP \?ELS5
	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	PRINTR	"Bones. Lots of bones."


	.FUNCT	TOLL-GATE-CROSSING-F
	FSET?	GATE,OPENBIT \?ELS5
	RETURN	OUTSIDE-STORE
?ELS5:	ZERO?	FLYING /?ELS7
	CALL	PERFORM,V?CLIMB-OVER,GATE
	RFALSE	
?ELS7:	PRINTI	"A sturdy toll gate blocks the highway."
	CRLF	
	RFALSE	


	.FUNCT	GATE-F
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS5
	CALL	OPEN-CLOSE
	ZERO?	STACK \TRUE
	PRINTR	"Only the gnome can do that."
?ELS5:	EQUAL?	PRSA,V?REZROV \?ELS16
	FSET?	GATE,OPENBIT /FALSE
	ZERO?	GNOME-SLEEPING /?ELS23
	SET	'GNOME-SLEEPING,FALSE-VALUE
	CALL	QUEUE,I-GNOME,2
	PUT	STACK,0,1
	PRINTR	"The gate flies open, waking the gnome, who leaps up and slams it closed again. ""Hey! This is a toll gate! Nobody gets through here without paying the one zorkmid toll. Not nobody, not no how."""
?ELS23:	SET	'GNOME-SLEEPING,TRUE-VALUE
	CALL	JIGS-UP,STR?228
	RSTACK	
?ELS16:	EQUAL?	PRSA,V?CLIMB-FOO,V?CLIMB-OVER \FALSE
	PRINTR	"The gate extends to the roof of the tunnel, and there are pointed nasties all over it."


	.FUNCT	BOOTH-F
	EQUAL?	PRSA,V?THROUGH \?ELS5
	FSET?	GATE,OPENBIT \?ELS10
	CALL	JIGS-UP,STR?229
	RSTACK	
?ELS10:	PRINTR	"The booth is on the other side of the toll gate."
?ELS5:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	FSET?	GATE,OPENBIT \?ELS21
	PRINTR	"It's dark inside the toll booth."
?ELS21:	CALL	PERFORM,V?THROUGH,BOOTH
	RTRUE	


	.FUNCT	GNOME-DESCFCN,RARG
	ZERO?	GNOME-SLEEPING /?ELS5
	PRINTR	"A fat old gnome with a long white beard is sleeping soundly just outside the toll booth. His loud snores echo around the caverns."
?ELS5:	PRINTR	"A chubby gnome stands behind the toll gate, grinning broadly."


	.FUNCT	GNOME-F
	EQUAL?	GNOME,WINNER \?ELS5
	ZERO?	GNOME-SLEEPING /?ELS10
	CALL	POOR-LISTENERS
	CALL	STOP
	RSTACK	
?ELS10:	EQUAL?	PRSA,V?OPEN \?ELS13
	EQUAL?	PRSO,GATE \?ELS13
	PRINTR	"""You'll have to pay the toll first,"" explains the gnome cheerfully, ""and the toll is one zorkmid."""
?ELS13:	PRINTI	"""Conversing with customers is disallowed by union rules."""
	CRLF	
	CALL	STOP
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?KICK,V?SHAKE \?ELS23
	ZERO?	GNOME-SLEEPING /?ELS23
	CALL	PERFORM,V?ALARM,GNOME
	RTRUE	
?ELS23:	EQUAL?	PRSA,V?LISTEN \?ELS27
	ZERO?	GNOME-SLEEPING /?ELS27
	PRINTR	"The gnome snores loudly."
?ELS27:	EQUAL?	PRSA,V?ALARM \?ELS33
	ZERO?	GNOME-SLEEPING \?ELS38
	PRINTR	"He's awake!"
?ELS38:	FSET?	GATE,OPENBIT \?ELS42
	PRINTR	"The gnome opens one eye and looks at you. ""You again! Just go through. Let me sleep."" He begins snoring again."
?ELS42:	ZERO?	GNOME-ANNOYED /?ELS46
	CALL	JIGS-UP,STR?230
	RSTACK	
?ELS46:	SET	'GNOME-SLEEPING,FALSE-VALUE
	CALL	QUEUE,I-GNOME,2
	PUT	STACK,0,1
	PRINTR	"The gnome stirs a bit and opens one eye, which wanders around until it notices you. He jumps to his feet. ""One zorkmid, please,"" he yells with a smile."
?ELS33:	EQUAL?	PRSA,V?ASK-FOR,V?ASK-ABOUT,V?GIVE \?ELS53
	ZERO?	GNOME-SLEEPING /?ELS53
	PRINTR	"The gnome is asleep, remember?"
?ELS53:	FSET?	GATE,OPENBIT \?ELS59
	EQUAL?	PRSA,V?REACH-IN,V?LOOK-INSIDE,V?SEARCH /?THN62
	EQUAL?	PRSA,V?PICK \?ELS59
?THN62:	ZERO?	COIN-STOLEN \?ELS59
	ZERO?	FWEEPED \?ELS59
	SET	'COIN-STOLEN,TRUE-VALUE
	MOVE	ZORKMID,PROTAGONIST
	PRINTR	"You carefully search the sleeping gnome, and take the zorkmid coin you find in his pocket!"
?ELS59:	EQUAL?	PRSA,V?GIVE \?ELS67
	EQUAL?	PRSO,ZORKMID \?ELS67
	FSET?	ZORKMID,ONBIT \?CND70
	CALL	GNOME-REFUSES
	RTRUE	
?CND70:	FSET	GATE,OPENBIT
	SET	'GNOME-SLEEPING,TRUE-VALUE
	MOVE	ZORKMID,DIAL
	CALL	INT,I-GNOME
	PUT	STACK,0,0
	ADD	SCORE,20 >SCORE
	PRINTR	"The gnome pockets the coin and opens the gate. Before you can take a step the gnome falls asleep again."
?ELS67:	EQUAL?	PRSA,V?YOMIN \FALSE
	ZERO?	GNOME-SLEEPING /?ELS81
	PRINTR	"The thoughts of the sleeping gnome are focused on certain activities involving female gnomes. Embarrassed, you withdraw."
?ELS81:	PRINTR	"The thoughts of the gnome seem evenly divided between getting money from you and getting back to sleep."


	.FUNCT	GNOME-REFUSES
	PRINTR	"The gnome refuses, saying ""That coin is giving off light, and is therefore not legal tender."""


	.FUNCT	I-GNOME
	CALL	QUEUE,I-GNOME,-1
	PUT	STACK,0,1
	EQUAL?	HERE,TOLL-GATE \?ELS5
	INC	'PATIENCE-COUNTER
	EQUAL?	PATIENCE-COUNTER,5 \?ELS10
	SET	'GNOME-SLEEPING,TRUE-VALUE
	CALL	INT,I-GNOME
	PUT	STACK,0,0
	SET	'GNOME-ANNOYED,TRUE-VALUE
	CRLF	
	PRINTR	"""Thanks for nothing, chum,"" growls the gnome as he resumes his nap."
?ELS10:	CRLF	
	PRINTR	"""Well?"" asks the gnome, tapping impatiently. ""You've interrupted my nap. Are you going to pay the toll, or not?"""
?ELS5:	SET	'GNOME-SLEEPING,TRUE-VALUE
	SET	'PATIENCE-COUNTER,3
	CALL	INT,I-GNOME
	PUT	STACK,0,0
	RFALSE	


	.FUNCT	SIGN-PSEUDO
	EQUAL?	PRSA,V?READ \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"
""ZEKE'S APPLIANCE STORE

 Official outlet for all
Frobozz Magic Appliances"""
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	STORE-PSEUDO
	EQUAL?	PRSA,V?THROUGH \?ELS5
	EQUAL?	HERE,STORE \?ELS10
	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS10:	CALL	DO-WALK,P?SOUTH
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?DROP,V?EXIT \?ELS14
	EQUAL?	HERE,STORE \?ELS19
	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS19:	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS14:	EQUAL?	PRSA,V?LOOK-INSIDE \FALSE
	EQUAL?	HERE,STORE \?ELS28
	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS28:	CALL	MAKE-OUT
	RSTACK	


	.FUNCT	WAXER-F
	EQUAL?	PRSA,V?LAMP-ON \?ELS5
	CALL	HELD?,WAXER
	ZERO?	STACK /?ELS10
	PRINTR	"Better put it down, first."
?ELS10:	ZERO?	FWEEPED /?ELS14
	CALL	BATTY
	RSTACK	
?ELS14:	EQUAL?	HERE,LAGOON,LAGOON-FLOOR \?ELS17
	CALL	JIGS-UP,STR?233
	RSTACK	
?ELS17:	EQUAL?	HERE,MINE-FIELD \?ELS19
	SET	'FLYING,FALSE-VALUE
	MOVE	WAXER,DIAL
	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS19:	PRINTI	"The waxer whirrs about the "
	LOC	PROTAGONIST
	FSET?	STACK,VEHBIT \?ELS26
	PRINTI	"vehicle"
	JUMP	?CND24
?ELS26:	PRINTI	"room"
?CND24:	PRINTR	" for a minute, polishing the floor."
?ELS5:	EQUAL?	PRSA,V?LAMP-OFF \FALSE
	PRINTR	"It is."


	.FUNCT	CRATER-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You are "
	ZERO?	FLYING /?ELS10
	PRINTI	"floating near"
	JUMP	?CND8
?ELS10:	PRINTI	"standing in"
?CND8:	PRINTR	" the center of an enormous crater, strewn with debris. Several points around the perimeter look climbable."


	.FUNCT	CRATER-OUT-F
	CALL	V-WALK-AROUND
	RFALSE	


	.FUNCT	CRATER-EXIT-F
	ZERO?	FLYING /?ELS5
	PRINTI	"As you try to fly over the rim here, a heavy gust of wind blows you back."
	CRLF	
	RFALSE	
?ELS5:	PRINTI	"You attempt to climb the rim here, but the rubble is loose and you slide back down."
	CRLF	
	RFALSE	


	.FUNCT	CRATER-PSEUDO
	EQUAL?	PRSA,V?THROUGH \?ELS5
	EQUAL?	HERE,CRATER \?ELS10
	PRINTR	"Where do you think you are?"
?ELS10:	EQUAL?	HERE,EDGE-OF-CRATER \?ELS14
	CALL	DO-WALK,P?SW
	RSTACK	
?ELS14:	EQUAL?	HERE,EDGE-OF-CHASM \?ELS16
	CALL	DO-WALK,P?EAST
	RSTACK	
?ELS16:	EQUAL?	HERE,SLIMY-ROOM \?ELS18
	CALL	DO-WALK,P?SOUTH
	RSTACK	
?ELS18:	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?CLIMB-FOO \?ELS22
	CALL	V-WALK-AROUND
	RSTACK	
?ELS22:	EQUAL?	PRSA,V?DISEMBARK,V?EXIT,V?LEAVE \FALSE
	EQUAL?	HERE,CRATER \?ELS29
	CALL	DO-WALK,P?UP
	RSTACK	
?ELS29:	CALL	LOOK-AROUND-YOU
	RSTACK	


	.FUNCT	CHASM-EXIT-F
	ZERO?	FLYING /?ELS5
	PRINTI	"You fly easily across the chasm..."
	CRLF	
	CRLF	
	EQUAL?	HERE,BARE-PASSAGE \?ELS13
	RETURN	EDGE-OF-CHASM
?ELS13:	RETURN	BARE-PASSAGE
?ELS5:	PRINTI	"If you really want to jump across the chasm, just say so."
	CRLF	
	RFALSE	


	.FUNCT	CHASM-PSEUDO
	EQUAL?	PRSA,V?LEAP \FALSE
	RANDOM	100
	LESS?	75,STACK /?ELS10
	CALL	JIGS-UP,STR?238
	RSTACK	
?ELS10:	EQUAL?	HERE,EDGE-OF-CHASM \?ELS17
	CALL	GOTO,BARE-PASSAGE
	RSTACK	
?ELS17:	CALL	GOTO,EDGE-OF-CHASM
	RSTACK	


	.FUNCT	TREE-ROOM-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	PUT	VEZZAS,3,0
	RFALSE	


	.FUNCT	ZORKMID-TREE-F
	EQUAL?	PRSA,V?EXAMINE \?ELS5
	PRINTR	"It is laden with zorkmids, glinting in the light."
?ELS5:	EQUAL?	PRSA,V?REZROV \?ELS9
	CALL	V-SWANZO
	RSTACK	
?ELS9:	EQUAL?	PRSA,V?CLIMB-UP,V?CLIMB-FOO \FALSE
	PRINTR	"The branches don't look sturdy enough."


	.FUNCT	ZORKMID-F
	EQUAL?	PRSA,V?PICK \?ELS5
	FSET?	PRSO,TRYTAKEBIT \?ELS5
	EQUAL?	ZORKMID,PRSO \?ELS5
	CALL	PERFORM,V?TAKE,PRSO,PRSI
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?TAKE \?ELS9
	FSET?	PRSO,TRYTAKEBIT \?ELS9
	FCLEAR	PRSO,TRYTAKEBIT
	FCLEAR	PRSO,NDESCBIT
	MOVE	ZORKMID-TREE,DIAL
	MOVE	ZORKMID,PROTAGONIST
	ADD	SCORE,15 >SCORE
	PRINTR	"As you pluck the first zorkmid, the tree shimmers and vanishes! (I guess it was just an illusion.) You are left holding a solitary zorkmid coin."
?ELS9:	EQUAL?	PRSA,V?EXAMINE,V?COUNT \?ELS15
	IN?	ZORKMID-TREE,HERE \?ELS15
	PRINTR	"There are countless coins, hanging from every branch of the tree."
?ELS15:	EQUAL?	PRSA,V?EXAMINE \?ELS21
	PRINTR	"The coin pictures a man with an incredibly flat head, wearing a gaudy crown."
?ELS21:	EQUAL?	PRSA,V?BITE \?ELS25
	PRINTR	"Yep, it's real."
?ELS25:	EQUAL?	PRSA,V?RESEARCH \FALSE
	PRINTI	"An article in the monetary section explains that the zorkmid was the unit of currency of the Great Underground Empire, and is still used in most parts of the kingdom today. A picture of a zorkmid coin is included. "
	CALL	PERFORM,V?EXAMINE,ZORKMID
	RTRUE	


	.FUNCT	HALL-OF-CARVINGS-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	PRINTI	"You have entered a large room whose walls are covered with intricate carvings. "
	ZERO?	DRAGON-MOVED /?ELS10
	PRINTI	"A passage has been recently opened to the south, and is only partially blocked by a huge stone dragon, poised in the midst of an attack."
	JUMP	?CND8
?ELS10:	PRINTI	"The largest and most striking carving, on the southern wall, is of a huge sleeping dragon!"
?CND8:	PRINTR	" A winding tunnel leads north."


	.FUNCT	DRAGON-F
	EQUAL?	PRSA,V?MALYON \FALSE
	ZERO?	MALYON-YONKED /?ELS10
	ZERO?	DRAGON-MOVED /?ELS16
	CALL	JIGS-UP,STR?243
	RSTACK	
?ELS16:	SET	'DRAGON-MOVED,TRUE-VALUE
	PRINTR	"The dragon is suddenly imbued with life and begins to move. It shakes itself loose from the wall, which crumbles down upon the dragon, revealing a southward passage! The dragon howls with pain and anger. Spotting you, the dragon rears back its head, smoke billowing from its nostrils. Then, just as it seems that you will be barbecued, the dragon reverts to stone!"
?ELS10:	PRINTR	"The dragon seems to shiver for a moment, but that is all."

	.ENDI

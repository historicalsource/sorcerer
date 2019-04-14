

	.FUNCT	V-VERBOSE
	SET	'VERBOSE,TRUE-VALUE
	SET	'SUPER-BRIEF,FALSE-VALUE
	PRINTI	"Maximum verbosity."
	CRLF	
	CRLF	
	CALL	V-LOOK
	RSTACK	


	.FUNCT	V-BRIEF
	SET	'VERBOSE,FALSE-VALUE
	SET	'SUPER-BRIEF,FALSE-VALUE
	PRINTR	"Brief descriptions."


	.FUNCT	V-SUPER-BRIEF
	SET	'SUPER-BRIEF,TRUE-VALUE
	PRINTR	"Superbrief descriptions."


	.FUNCT	V-DIAGNOSE,BOTH=0
	LESS?	AWAKE,0 \?ELS3
	PRINTI	"You are wide awake"
	JUMP	?CND1
?ELS3:	PRINTI	"You are "
	GET	TIRED-TELL,AWAKE
	PRINT	STACK
?CND1:	PRINTI	", and you are in good health."
	GRTR?	HUNGER-LEVEL,0 /?THN15
	GRTR?	THIRST-LEVEL,0 \?CND12
?THN15:	PRINTI	" You feel "
	GRTR?	HUNGER-LEVEL,0 \?CND19
	SET	'BOTH,TRUE-VALUE
	GET	HUNGER-THIRST-TABLE,HUNGER-LEVEL
	PRINT	STACK
	PRINTI	" hungry"
?CND19:	GRTR?	THIRST-LEVEL,0 \?CND26
	ZERO?	BOTH /?CND29
	PRINTI	", and "
?CND29:	GET	HUNGER-THIRST-TABLE,THIRST-LEVEL
	PRINT	STACK
	PRINTI	" thirsty"
?CND26:	PRINTI	"."
?CND12:	ZERO?	BITTEN /?CND41
	PRINTI	" You have a small bite on your hand which doesn't seem too serious."
?CND41:	CRLF	
	RTRUE	


	.FUNCT	V-INVENTORY
	FIRST?	PROTAGONIST \?ELS5
	CALL	PRINT-CONT,PROTAGONIST
	RSTACK	
?ELS5:	PRINTI	"You are empty-"
	ZERO?	FWEEPED /?ELS12
	PRINTI	"taloned"
	JUMP	?CND10
?ELS12:	PRINTI	"handed"
?CND10:	PRINTR	"."


	.FUNCT	V-QUIT
	CALL	V-SCORE
	CALL	DO-YOU-WISH,STR?18
	CALL	YES?
	ZERO?	STACK /?ELS5
	QUIT	
	RTRUE	
?ELS5:	PRINTR	"Ok."


	.FUNCT	V-RESTART
	CALL	V-SCORE
	CALL	DO-YOU-WISH,STR?19
	CALL	YES?
	ZERO?	STACK /FALSE
	PRINTI	"Restarting."
	CRLF	
	RESTART	
	PRINTR	"Failed."


	.FUNCT	DO-YOU-WISH,STRING
	CRLF	
	PRINTI	"Do you wish to "
	PRINT	STRING
	PRINTI	"? (Y is affirmative): "
	RTRUE	


	.FUNCT	FINISH,REPEATING=0
	CRLF	
	ZERO?	REPEATING \?CND1
	CALL	V-SCORE
	CRLF	
?CND1:	PRINTI	"Would you like to restart the game from the beginning, restore a saved game position, or end this session of the game? (Type RESTART, RESTORE, or QUIT):

>"
	PUTB	P-INBUF,0,10
	READ	P-INBUF,P-LEXV
	PUTB	P-INBUF,0,60
	GET	P-LEXV,1
	EQUAL?	STACK,W?RESTAR \?ELS10
	RESTART	
	PRINTI	"Failed."
	CRLF	
	CALL	FINISH,TRUE-VALUE
	RSTACK	
?ELS10:	GET	P-LEXV,1
	EQUAL?	STACK,W?RESTOR \?ELS14
	CALL	V-RESTORE
	CALL	FINISH,TRUE-VALUE
	RSTACK	
?ELS14:	GET	P-LEXV,1
	EQUAL?	STACK,W?QUIT,W?Q \?ELS16
	QUIT	
	RTRUE	
?ELS16:	CALL	FINISH,TRUE-VALUE
	RSTACK	


	.FUNCT	YES?
?FCN:	PRINTI	">"
	PUTB	P-INBUF,0,10
	READ	P-INBUF,P-LEXV
	PUTB	P-INBUF,0,60
	GET	P-LEXV,1
	EQUAL?	STACK,W?YES,W?Y /TRUE
	GET	P-LEXV,1
	EQUAL?	STACK,W?NO,W?N /FALSE
	PRINTI	"Please type YES or NO."
	CRLF	
	CRLF	
	JUMP	?FCN


	.FUNCT	V-RESTORE
	RESTORE	 /FALSE
	PRINTR	"Failed."


	.FUNCT	V-SAVE
	SAVE	 \?ELS5
	PRINTR	"Ok."
?ELS5:	PRINTR	"Failed."


	.FUNCT	V-SCORE
	ZERO?	POOFED /?ELS3
	PRINTI	"If you still existed, your score would be "
	JUMP	?CND1
?ELS3:	PRINTI	"Your score is "
?CND1:	PRINTN	SCORE
	PRINTI	" of a possible 400, in "
	PRINTN	MOVES
	PRINTI	" move"
	EQUAL?	MOVES,1 /?CND13
	PRINTI	"s"
?CND13:	PRINTI	". This puts you in the class of "
	LESS?	SCORE,0 \?ELS22
	PRINTI	"Menace to Society"
	JUMP	?CND20
?ELS22:	DIV	SCORE,50
	GET	RANKINGS,STACK
	PRINT	STACK
?CND20:	PRINTR	"."


	.FUNCT	V-SCRIPT
	GET	0,8
	BOR	STACK,1
	PUT	0,8,STACK
	PRINTI	"Here begins"
	PRINT	COPR-NOTICE
	CRLF	
	CALL	V-VERSION
	RSTACK	


	.FUNCT	V-UNSCRIPT
	PRINTI	"Here ends"
	PRINT	COPR-NOTICE
	CRLF	
	CALL	V-VERSION
	GET	0,8
	BAND	STACK,-2
	PUT	0,8,STACK
	RTRUE	


	.FUNCT	V-VERSION,CNT=17
	PRINTI	"SORCERER
Infocom interactive fiction - a fantasy story
Copyright (c) 1984 by Infocom, Inc. All rights reserved.
SORCERER is a trademark of Infocom, Inc.
Release "
	GET	0,1
	BAND	STACK,2047
	PRINTN	STACK
	PRINTI	" / Serial number "
?PRG5:	IGRTR?	'CNT,23 \?ELS9
	JUMP	?REP6
?ELS9:	GETB	0,CNT
	PRINTC	STACK
	JUMP	?PRG5
?REP6:	CRLF	
	RTRUE	


	.FUNCT	V-$VERIFY
	EQUAL?	PRSO,INTNUM \?ELS5
	EQUAL?	P-NUMBER,502 \?ELS5
	PRINTN	SERIAL
	CRLF	
	RTRUE	
?ELS5:	PRINTI	"Performing the VERIFY spell..."
	CRLF	
	VERIFY	 \?ELS18
	PRINTR	"Good."
?ELS18:	CRLF	
	PRINTR	"** Bad **"


	.FUNCT	V-$COMMAND
	DIRIN	1
	RTRUE	


	.FUNCT	V-$RANDOM
	EQUAL?	PRSO,INTNUM /?ELS5
	PRINTR	"Illegal call to #RANDOM."
?ELS5:	SUB	0,P-NUMBER
	RANDOM	STACK
	RTRUE	


	.FUNCT	V-$RECORD
	DIROUT	D-RECORD-ON
	RTRUE	


	.FUNCT	V-$UNRECORD
	DIROUT	D-RECORD-OFF
	RTRUE	


	.FUNCT	V-ALARM
	EQUAL?	PRSO,ROOMS \?ELS5
	CALL	PERFORM,V?ALARM,ME
	RTRUE	
?ELS5:	PRINTI	"I don't think that"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" is sleeping."


	.FUNCT	V-ANSWER
	PRINTI	"Nobody seems to be awaiting your answer."
	CRLF	
	CALL	STOP
	RSTACK	


	.FUNCT	V-ASK-ABOUT
	EQUAL?	PRSO,ME \?ELS5
	CALL	PERFORM,V?TELL,ME
	RTRUE	
?ELS5:	FSET?	PRSO,ACTORBIT \?ELS7
	PRINTI	"After a moment's thought,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" denies any knowledge of"
	CALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTI	"."
	EQUAL?	PRSO,PRSI \?CND14
	PRINTI	" (Rather disingenuous, if you ask me.)"
?CND14:	CRLF	
	RTRUE	
?ELS7:	CALL	PERFORM,V?TELL,PRSO
	RTRUE	


	.FUNCT	V-ASK-FOR
	EQUAL?	PRSO,YOUNGER-SELF \?CND1
	EQUAL?	PRSI,SPELL-BOOK \?CND1
	CALL	SPELL-BOOK-PASS-OFF-CHECK
	ZERO?	STACK \TRUE
?CND1:	PRINTI	"Unsurprisingly,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" is not likely to oblige."


	.FUNCT	V-ATTACK
	CALL	IKILL,STR?30
	RSTACK	


	.FUNCT	V-BITE
	CALL	HACK-HACK,STR?31
	RSTACK	


	.FUNCT	PRE-BOARD,AV
	LOC	PROTAGONIST >AV
	FSET?	PRSO,VEHBIT \?ELS3
	ZERO?	FLYING /?ELS6
	CALL	WHILE-FLYING
	RETURN	2
?ELS6:	FSET?	AV,VEHBIT \FALSE
	PRINTI	"You are already in"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	"!"
	CRLF	
	RETURN	2
?ELS3:	PRINTI	"You can't get into"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	"!"
	CRLF	
	RETURN	2


	.FUNCT	V-BOARD
	MOVE	PROTAGONIST,PRSO
	PRINTI	"You are now in"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	"."
	CRLF	
	GETP	PRSO,P?ACTION
	CALL	STACK,M-ENTER
	RSTACK	


	.FUNCT	V-BURN
	ZERO?	PRSI \?ELS5
	PRINTR	"Your blazing gaze is insufficient."
?ELS5:	CALL	WITH???
	RSTACK	


	.FUNCT	V-CHASTISE
	PRINTR	"Use prepositions to indicate precisely what you want to do: LOOK AT the object, LOOK INSIDE it, LOOK UNDER it, etc."


	.FUNCT	V-CLIMB-DOWN
	EQUAL?	PRSO,ROOMS \?ELS5
	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS5:	CALL	V-DEFLATE
	RSTACK	


	.FUNCT	V-CLIMB-FOO
	EQUAL?	PRSO,ROOMS \?ELS5
	CALL	DO-WALK,P?UP
	RSTACK	
?ELS5:	CALL	V-DEFLATE
	RSTACK	


	.FUNCT	V-CLIMB-ON
	FSET?	PRSO,VEHBIT \?ELS5
	CALL	PERFORM,V?BOARD,PRSO
	RTRUE	
?ELS5:	PRINTI	"You can't climb onto"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"."


	.FUNCT	V-CLIMB-OVER
	PRINTR	"You can't do that."


	.FUNCT	V-CLIMB-UP
	EQUAL?	PRSO,ROOMS \?ELS5
	CALL	DO-WALK,P?UP
	RSTACK	
?ELS5:	CALL	V-DEFLATE
	RSTACK	


	.FUNCT	V-CLOSE
	FSET?	PRSO,SCROLLBIT \?ELS5
	CALL	TELL-ME-HOW
	RSTACK	
?ELS5:	FSET?	PRSO,ACTORBIT \?ELS7
	PRINTR	"Huh?"
?ELS7:	FSET?	PRSO,SURFACEBIT \?ELS11
	PRINTI	"There's no way to close"
	CALL	ARTICLE,PRSO
	PRINTR	"."
?ELS11:	FSET?	PRSO,DOORBIT \?ELS17
	FSET?	PRSO,OPENBIT \?ELS22
	PRINTI	"Okay,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" is now closed."
	CRLF	
	FCLEAR	PRSO,OPENBIT
	RTRUE	
?ELS22:	CALL	ALREADY-CLOSED
	RSTACK	
?ELS17:	FSET?	PRSO,CONTBIT /?THN31
	EQUAL?	PRSO,JOURNAL \?ELS30
?THN31:	FSET?	PRSO,OPENBIT \?ELS37
	FCLEAR	PRSO,OPENBIT
	PRINTI	"Closed."
	CALL	LIT?,HERE >LIT
	ZERO?	LIT \?CND40
	ZERO?	BLORTED \?CND40
	PRINTI	" "
	CALL	NOW-BLACK
?CND40:	CRLF	
	RTRUE	
?ELS37:	CALL	ALREADY-CLOSED
	RSTACK	
?ELS30:	CALL	TELL-ME-HOW
	RSTACK	


	.FUNCT	V-COMBO
	IN?	YOUNGER-SELF,HERE \?ELS5
	EQUAL?	PRSO,INTNUM \?ELS5
	PRINTR	"Don't tell me. Talk to your confused twin over there."
?ELS5:	PRINTR	"What are you talking about?"


	.FUNCT	V-COMPARE
	CALL	V-SIT
	RSTACK	


	.FUNCT	V-COUNT
	PRINTR	"You have lost your mind."


	.FUNCT	V-CROSS
	PRINTR	"You can't cross that!"


	.FUNCT	V-CURSE
	PRINTR	"Such language from an Enchanter!"


	.FUNCT	V-CUT
	FSET?	PRSO,ACTORBIT \?ELS5
	CALL	PERFORM,V?KILL,PRSO,PRSI
	RTRUE	
?ELS5:	FSET?	PRSO,SCROLLBIT \?ELS7
	FSET?	PRSI,WEAPONBIT \?ELS7
	MOVE	PRSO,DIAL
	PRINTI	"Your skillful"
	PRINTD	PRSI
	PRINTI	"smanship slices"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" into slivers, which vanish."
?ELS7:	FSET?	PRSI,WEAPONBIT /?ELS15
	PRINTI	"I doubt that the ""cutting edge"" of"
	CALL	ARTICLE,PRSI
	PRINTR	" is adequate."
?ELS15:	PRINTI	"Strange concept, cutting"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"...."


	.FUNCT	V-DEFLATE
	PRINTR	"Bizarre."


	.FUNCT	V-DIG
	ZERO?	FLYING /?ELS5
	CALL	WHILE-FLYING
	RSTACK	
?ELS5:	CALL	V-SIT
	RSTACK	


	.FUNCT	V-DISEMBARK
	LOC	PROTAGONIST
	EQUAL?	STACK,PRSO /?ELS5
	CALL	LOOK-AROUND-YOU
	RETURN	2
?ELS5:	PRINTI	"You are now on your feet."
	CRLF	
	MOVE	PROTAGONIST,HERE
	RTRUE	


	.FUNCT	V-DRINK,S
	PRINTR	"You can't drink that!"


	.FUNCT	V-DRINK-FROM,X
	EQUAL?	PRSO,WATER \?ELS5
	CALL	PERFORM,V?DRINK,PRSO
	RTRUE	
?ELS5:	FSET?	PRSO,VIALBIT \?ELS7
	FSET?	PRSO,OPENBIT \?ELS12
	FIRST?	PRSO \?ELS17
	FIRST?	PRSO >X /?KLU30
?KLU30:	CALL	PERFORM,V?DRINK,X
	RTRUE	
?ELS17:	PRINTR	"The vial is empty."
?ELS12:	PRINTR	"The vial is closed!"
?ELS7:	PRINTR	"How peculiar!"


	.FUNCT	V-DROP
	CALL	IDROP
	ZERO?	STACK /FALSE
	EQUAL?	HERE,COAL-BIN-ROOM,DIAL-ROOM \?ELS10
	GETP	PRSO,P?SIZE
	LESS?	STACK,20 \?ELS10
	CALL	BURIED-IN-COAL,STR?32
	RSTACK	
?ELS10:	EQUAL?	HERE,HAUNTED-HOUSE \?CND15
	MOVE	PRSO,DIAL
?CND15:	PRINTR	"Dropped."


	.FUNCT	V-EAT
	PRINTR	"Did they teach you to eat that in survival school?"


	.FUNCT	V-ENTER,VEHICLE
	CALL	FIND-IN,HERE,VEHBIT >VEHICLE
	ZERO?	VEHICLE /?ELS5
	CALL	PERFORM,V?BOARD,VEHICLE
	RTRUE	
?ELS5:	CALL	DO-WALK,P?IN
	RSTACK	


	.FUNCT	PRE-EXAMINE
	ZERO?	LIT \FALSE
	ZERO?	BLORTED \FALSE
	CALL	TOO-DARK
	RSTACK	


	.FUNCT	V-EXAMINE
	GETP	PRSO,P?TEXT
	ZERO?	STACK /?ELS5
	CALL	PERFORM,V?READ,PRSO
	RTRUE	
?ELS5:	FSET?	PRSO,DOORBIT \?ELS7
	CALL	V-LOOK-INSIDE
	RSTACK	
?ELS7:	FSET?	PRSO,CONTBIT \?ELS9
	FSET?	PRSO,OPENBIT \?ELS14
	CALL	V-LOOK-INSIDE
	RSTACK	
?ELS14:	PRINTR	"It's closed."
?ELS9:	FSET?	PRSO,ONBIT \?ELS20
	PRINTI	"Someone must have cast the frotz spell on"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	", because it is glowing brightly."
?ELS20:	PRINTI	"You see nothing special about"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"."


	.FUNCT	V-EXIT
	FSET?	PRSO,VEHBIT \?ELS5
	CALL	PERFORM,V?DISEMBARK,PRSO
	RTRUE	
?ELS5:	CALL	DO-WALK,P?OUT
	RSTACK	


	.FUNCT	V-EXORCISE
	PRINTR	"You can't do that with mere words!"


	.FUNCT	V-FILL
	ZERO?	PRSI \?ELS5
	CALL	GLOBAL-IN?,WATER,HERE
	ZERO?	STACK /?ELS10
	CALL	PERFORM,V?FILL,PRSO,WATER
	RTRUE	
?ELS10:	PRINTR	"There's nothing to fill it with."
?ELS5:	PRINTR	"Huh?"


	.FUNCT	V-FIND,WHERE=0,L
	LOC	PRSO >L
	EQUAL?	PRSO,HANDS \?ELS5
	PRINTR	"Within six feet of your head, assuming you haven't left that somewhere."
?ELS5:	EQUAL?	PRSO,ME \?ELS9
	PRINTR	"You're around here somewhere..."
?ELS9:	IN?	PRSO,PROTAGONIST \?ELS13
	PRINTR	"You have it!"
?ELS13:	IN?	PRSO,HERE /?THN18
	EQUAL?	PRSO,PSEUDO-OBJECT \?ELS17
?THN18:	FSET?	PRSO,ACTORBIT \?ELS22
	PRINTI	"He's"
	JUMP	?CND20
?ELS22:	PRINTI	"It's"
?CND20:	PRINTR	" right in front of you."
?ELS17:	IN?	PRSO,LOCAL-GLOBALS \?ELS32
	PRINTR	"You're the magician!"
?ELS32:	FSET?	L,ACTORBIT \?ELS36
	CALL	VISIBLE?,L
	ZERO?	STACK /?ELS36
	PRINTI	"As far as you can tell,"
	CALL	ARTICLE,L,TRUE-VALUE
	PRINTR	" has it."
?ELS36:	FSET?	L,CONTBIT \?ELS44
	CALL	VISIBLE?,L
	ZERO?	STACK /?ELS44
	PRINTI	"It's in"
	CALL	ARTICLE,L,TRUE-VALUE
	PRINTR	"."
?ELS44:	ZERO?	WHERE /?ELS52
	PRINTR	"Beats me."
?ELS52:	PRINTR	"You'll have to do that yourself."


	.FUNCT	V-FIRST-LOOK
	CALL	DESCRIBE-ROOM
	ZERO?	STACK /FALSE
	ZERO?	SUPER-BRIEF \FALSE
	CALL	DESCRIBE-OBJECTS
	RSTACK	


	.FUNCT	V-FLY
	ZERO?	PRSO /?THN6
	EQUAL?	PRSO,ME \?ELS5
?THN6:	ZERO?	FLYING /?ELS12
	PRINTR	"You are!"
?ELS12:	PRINTR	"Perhaps a spell would be useful..."
?ELS5:	EQUAL?	PRSO,P-DIRECTION \?ELS21
	CALL	PERFORM,V?WALK,PRSO
	RTRUE	
?ELS21:	PRINTI	"You can't make"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" fly!"


	.FUNCT	V-FOLLOW
	IN?	PRSO,HERE \?ELS5
	PRINTI	"But"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" is right here!"
?ELS5:	EQUAL?	PRSO,TURRET \?ELS11
	ZERO?	MAILMAN-FOLLOW /?ELS11
	CALL	DO-WALK,P?SOUTH
	RSTACK	
?ELS11:	CALL	V-SIT
	RSTACK	


	.FUNCT	V-FORGET
	PRINTR	"You might also try not thinking about a purple hippopotamus!"


	.FUNCT	PRE-GIVE
	CALL	HELD?,PRSO
	ZERO?	STACK \?ELS5
	PRINTR	"That's easy for you to say since you don't even have it."
?ELS5:	FSET?	PRSO,SPELLBIT \FALSE
	PRINTR	"The spell is permanently inscribed in your spell book!"


	.FUNCT	V-GIVE
	FSET?	PRSI,ACTORBIT /?ELS5
	PRINTI	"You can't give"
	CALL	ARTICLE,PRSO
	PRINTI	" to"
	CALL	ARTICLE,PRSI
	PRINTR	"!"
?ELS5:	PRINTI	"Politely,"
	CALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTR	" refuses your offer."


	.FUNCT	V-HELLO
	ZERO?	PRSO /?ELS5
	FSET?	PRSO,ACTORBIT \?ELS11
	PRINTI	"Silently,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" bows his head to you in greeting."
?ELS11:	PRINTI	"Only schizophrenics say ""Hello"" to"
	CALL	ARTICLE,PRSO
	PRINTR	"."
?ELS5:	CALL	PICK-ONE,HELLOS
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	V-HELP
	PRINTR	"If you're really stuck, maps and InvisiClues hint booklets are available. If you have misplaced the order form that came in your package, send us a  note at:
  P.O. Box 620
  Garden City, NY 11530
  Dept. Z5
and we'll be happy to send you an order form."


	.FUNCT	V-HIDE
	ZERO?	PRSO \?ELS5
	PRINTI	"There's no place to hide here."
	CRLF	
	RETURN	2
?ELS5:	ZERO?	PRSI /?ELS11
	FSET?	PRSI,ACTORBIT \?ELS11
	PRINTI	"Why hide it when"
	CALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTR	" isn't interested in it."
?ELS11:	ZERO?	PRSI \FALSE
	PRINTR	"From what? From whom? Why?"


	.FUNCT	V-INFLATE
	PRINTR	"How can you inflate that?"


	.FUNCT	V-KICK
	CALL	HACK-HACK,STR?37
	RSTACK	


	.FUNCT	V-KILL
	CALL	IKILL,STR?38
	RSTACK	


	.FUNCT	IKILL,STR
	ZERO?	PRSO \?ELS3
	PRINTI	"There is nothing here to "
	PRINT	STR
	PRINTI	"."
	CRLF	
	JUMP	?CND1
?ELS3:	ZERO?	PRSI \?CND1
	CALL	HELD?,KNIFE
	ZERO?	STACK /?CND1
	SET	'PRSI,KNIFE
	PRINTI	"(with the "
	PRINTD	PRSI
	PRINTI	")"
	CRLF	
	CALL	PERFORM,V?KILL,PRSO,PRSI
	RTRUE	
?CND1:	FSET?	PRSO,ACTORBIT /?ELS16
	EQUAL?	PRSO,BOA,HELLHOUND,DORN-BEAST /?ELS16
	PRINTI	"I've known strange people, but fighting"
	CALL	ARTICLE,PRSO
	PRINTR	"?"
?ELS16:	ZERO?	PRSI /?THN25
	EQUAL?	PRSI,HANDS \?ELS24
?THN25:	PRINTI	"Trying to "
	PRINT	STR
	CALL	ARTICLE,PRSO
	PRINTR	" with your bare hands is suicidal."
?ELS24:	IN?	PRSI,PROTAGONIST /?ELS32
	PRINTI	"You aren't even holding"
	CALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTR	"."
?ELS32:	FSET?	PRSI,WEAPONBIT /?ELS38
	PRINTI	"Trying to "
	PRINT	STR
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" with"
	CALL	ARTICLE,PRSI
	PRINTR	" is suicidal."
?ELS38:	PRINTR	"You'd never survive the attack."


	.FUNCT	V-KNOCK
	FSET?	PRSO,DOORBIT \?ELS5
	PRINTR	"Nobody's home."
?ELS5:	PRINTI	"Why knock on"
	CALL	ARTICLE,PRSO
	PRINTR	"?"


	.FUNCT	V-KISS
	PRINTR	"I'd sooner kiss a pig."


	.FUNCT	V-LAMP-OFF
	FSET?	PRSO,LIGHTBIT \?ELS3
	FSET?	PRSO,ONBIT /?ELS6
	PRINTR	"It is already off."
?ELS6:	FCLEAR	PRSO,ONBIT
	ZERO?	LIT /?CND11
	CALL	LIT?,HERE >LIT
?CND11:	PRINTI	"Okay,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" is now off."
	CRLF	
	CALL	LIT?,HERE >LIT
	ZERO?	LIT \TRUE
	ZERO?	BLORTED \TRUE
	CALL	NOW-BLACK
	CRLF	
	RTRUE	
?ELS3:	FSET?	PRSO,ONBIT \?ELS25
	PRINTR	"How? It's glowing by magic."
?ELS25:	PRINTR	"You can't turn that off."


	.FUNCT	V-LAMP-ON
	FSET?	PRSO,LIGHTBIT \?ELS3
	FSET?	PRSO,ONBIT \?ELS6
	PRINTR	"It is already on."
?ELS6:	FSET	PRSO,ONBIT
	PRINTI	"Okay,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" is now on."
	CRLF	
	ZERO?	LIT \TRUE
	ZERO?	BLORTED \TRUE
	CALL	LIT?,HERE >LIT
	CRLF	
	CALL	V-LOOK
	RTRUE	
?ELS3:	PRINTR	"You can't turn that on."


	.FUNCT	V-LAND
	ZERO?	FLYING /?ELS5
	PRINTR	"You'll have to wait for the spell to wear off."
?ELS5:	CALL	LOOK-AROUND-YOU
	RSTACK	


	.FUNCT	V-LAUNCH
	FSET?	PRSO,VEHBIT \?ELS5
	PRINTR	"You can't launch that by saying ""launch""!"
?ELS5:	PRINTR	"Huh?"


	.FUNCT	V-LEAN-ON
	PRINTR	"Are you so very tired, then?"


	.FUNCT	V-LEAP
	ZERO?	FLYING /?ELS5
	CALL	WHILE-FLYING
	RSTACK	
?ELS5:	ZERO?	PRSO /?ELS8
	IN?	PRSO,HERE \?ELS14
	CALL	V-SKIP
	RSTACK	
?ELS14:	PRINTR	"That would be a good trick."
?ELS8:	EQUAL?	HERE,RIVER-BANK,DRAWBRIDGE,TOP-OF-FALLS /?THN21
	EQUAL?	HERE,TURRET,EDGE-OF-CHASM,BARE-PASSAGE /?THN21
	EQUAL?	HERE,TREE-BRANCH,GUN-EMPLACEMENT /?THN21
	ZERO?	RIDE-IN-PROGRESS /?ELS20
?THN21:	CALL	JIGS-UP,STR?39
	RSTACK	
?ELS20:	EQUAL?	HERE,LAGOON,DRAWBRIDGE /?THN25
	EQUAL?	HERE,COAL-BIN-ROOM,TOP-OF-CHUTE \?ELS24
?THN25:	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS24:	CALL	V-SKIP
	RSTACK	


	.FUNCT	V-LEAVE
	CALL	DO-WALK,P?OUT
	RSTACK	


	.FUNCT	V-LIE-DOWN
	CALL	PERFORM,V?SLEEP
	RTRUE	


	.FUNCT	V-LISTEN
	PRINTI	"At the moment,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" makes no sound."


	.FUNCT	V-LOCK
	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	V-LOOK
	CALL	DESCRIBE-ROOM,TRUE-VALUE
	ZERO?	STACK /FALSE
	CALL	DESCRIBE-OBJECTS,TRUE-VALUE
	RSTACK	


	.FUNCT	V-LOOK-BEHIND
	PRINTI	"There is nothing behind"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"."


	.FUNCT	V-LOOK-DOWN
	ZERO?	LIT \?ELS5
	ZERO?	BLORTED \?ELS5
	CALL	TOO-DARK
	RSTACK	
?ELS5:	EQUAL?	PRSO,ROOMS \?ELS9
	CALL	PERFORM,V?EXAMINE,GROUND
	RTRUE	
?ELS9:	CALL	PERFORM,V?LOOK-INSIDE,PRSO
	RTRUE	


	.FUNCT	V-LOOK-INSIDE
	FSET?	PRSO,ACTORBIT \?ELS5
	PRINTR	"There is nothing special to be seen."
?ELS5:	FSET?	PRSO,SURFACEBIT \?ELS9
	FIRST?	PRSO \?ELS14
	CALL	PRINT-CONT,PRSO
	RSTACK	
?ELS14:	PRINTI	"There is nothing on"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"."
?ELS9:	FSET?	PRSO,DOORBIT \?ELS22
	PRINTI	"All you can tell is that"
	FSET?	PRSO,OPENBIT \?ELS27
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" is open."
	JUMP	?CND25
?ELS27:	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" is closed."
?CND25:	CRLF	
	RTRUE	
?ELS22:	FSET?	PRSO,SCROLLBIT \?ELS35
	CALL	PERFORM,V?READ,PRSO
	RTRUE	
?ELS35:	FSET?	PRSO,CONTBIT \?ELS37
	LOC	PROTAGONIST
	EQUAL?	PRSO,STACK \?ELS42
	MOVE	PROTAGONIST,ROOMS
	FIRST?	PRSO \?ELS45
	CALL	PRINT-CONT,PRSO
	JUMP	?CND43
?ELS45:	PRINTI	"It's empty (not counting you)."
	CRLF	
?CND43:	MOVE	PROTAGONIST,PRSO
	RTRUE	
?ELS42:	CALL	SEE-INSIDE?,PRSO
	ZERO?	STACK /?ELS51
	FIRST?	PRSO \?ELS56
	CALL	PRINT-CONT,PRSO
	RSTACK	
?ELS56:	PRINTR	"It's empty."
?ELS51:	FSET?	PRSO,OPENBIT /?ELS62
	FIRST?	PRSO \?ELS62
	CALL	PERFORM,V?OPEN,PRSO
	RTRUE	
?ELS62:	PRINTI	"It seems that"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" is closed."
?ELS37:	PRINTI	"You can't look inside"
	CALL	ARTICLE,PRSO
	PRINTR	"."


	.FUNCT	V-LOOK-UNDER
	CALL	HELD?,PRSO
	ZERO?	STACK /?ELS5
	PRINTI	"You're "
	FSET?	PRSO,WEARBIT \?ELS10
	PRINTI	"wear"
	JUMP	?CND8
?ELS10:	PRINTI	"hold"
?CND8:	PRINTR	"ing it!"
?ELS5:	PRINTI	"There is nothing but "
	EQUAL?	HERE,LAGOON-FLOOR \?ELS25
	PRINTI	"sand"
	JUMP	?CND23
?ELS25:	PRINTI	"dust"
?CND23:	PRINTR	" there."


	.FUNCT	V-LOWER
	CALL	V-RAISE
	RSTACK	


	.FUNCT	V-LOWER-INTO
	CALL	V-RAISE
	RSTACK	


	.FUNCT	V-MELT
	PRINTI	"I'm not sure that"
	CALL	ARTICLE,PRSO
	PRINTR	" can be melted."


	.FUNCT	V-MOVE
	CALL	HELD?,PRSO
	ZERO?	STACK /?ELS5
	PRINTR	"Why juggle objects?"
?ELS5:	FSET?	PRSO,TAKEBIT \?ELS9
	PRINTI	"Moving"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" reveals nothing."
?ELS9:	PRINTI	"You can't move"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"."


	.FUNCT	V-MUNG
	CALL	HACK-HACK,STR?40
	RSTACK	


	.FUNCT	PRE-OPEN
	ZERO?	FWEEPED /FALSE
	CALL	BATTY
	RSTACK	


	.FUNCT	V-OPEN,F,STR
	FSET?	PRSO,SCROLLBIT \?ELS5
	CALL	TELL-ME-HOW
	RSTACK	
?ELS5:	EQUAL?	PRSO,ACTORBIT \?ELS7
	PRINTR	"Huh?"
?ELS7:	FSET?	PRSO,VIALBIT \?ELS11
	EQUAL?	HERE,LAGOON,LAGOON-FLOOR \?ELS11
	FIRST?	PRSO \?ELS11
	FIRST?	PRSO /?KLU57
?KLU57:	REMOVE	STACK
	PRINTR	"As you open the vial it fills with water, washing away the potion. A moment later a fish swims by, acting very strangely."
?ELS11:	FSET?	PRSO,DOORBIT \?ELS17
	FSET?	PRSO,OPENBIT \?ELS22
	CALL	ALREADY-OPEN
	RSTACK	
?ELS22:	FSET	PRSO,OPENBIT
	PRINTI	"Okay,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" is now open."
?ELS17:	FSET?	PRSO,CONTBIT \?ELS30
	FSET?	PRSO,OPENBIT \?ELS35
	CALL	ALREADY-OPEN
	RSTACK	
?ELS35:	FSET	PRSO,OPENBIT
	FSET	PRSO,TOUCHBIT
	FIRST?	PRSO \?THN43
	FSET?	PRSO,TRANSBIT \?ELS42
?THN43:	PRINTR	"Opened."
?ELS42:	PRINTI	"Opening"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" reveals "
	CALL	PRINT-CONTENTS,PRSO
	PRINTR	"."
?ELS30:	CALL	TELL-ME-HOW
	RSTACK	


	.FUNCT	V-PAY
	ZERO?	PRSI \?CND1
	EQUAL?	PRSO,ZORKMID \?ELS6
	CALL	FIND-IN,HERE,ACTORBIT >PRSI
	ZERO?	PRSI /?ELS9
	CALL	PERFORM,V?GIVE,PRSO,PRSI
	RTRUE	
?ELS9:	PRINTR	"There's no one here to pay."
?ELS6:	CALL	HELD?,ZORKMID
	ZERO?	STACK /?ELS16
	SET	'PRSI,ZORKMID
	JUMP	?CND1
?ELS16:	PRINTR	"Pay with what?"
?CND4:	
?CND1:	EQUAL?	PRSI,ZORKMID \?ELS25
	CALL	PERFORM,V?GIVE,PRSI,PRSO
	RTRUE	
?ELS25:	CALL	WITH???
	RSTACK	


	.FUNCT	V-PICK
	PRINTR	"You can't pick that!"


	.FUNCT	V-PLAY
	PRINTR	"How peculiar!"


	.FUNCT	V-PLUG
	PRINTR	"This has no effect."


	.FUNCT	V-POINT
	PRINTR	"It's usually impolite to point."


	.FUNCT	V-POUR
	PRINTR	"You can't pour that!"


	.FUNCT	V-PUMP
	PRINTR	"It's not clear how."


	.FUNCT	V-PUSH
	CALL	HACK-HACK,STR?41
	RSTACK	


	.FUNCT	V-PUSH-TO
	PRINTR	"You can't push things to that."


	.FUNCT	PRE-PUT
	IN?	PRSO,GLOBAL-OBJECTS /?THN6
	FSET?	PRSO,TAKEBIT /FALSE
?THN6:	PRINTR	"Nice try."


	.FUNCT	V-PUT,?TMP1
	FSET?	PRSI,OPENBIT /?ELS5
	FSET?	PRSI,DOORBIT /?ELS5
	FSET?	PRSI,CONTBIT /?ELS5
	FSET?	PRSI,SURFACEBIT /?ELS5
	FSET?	PRSI,VEHBIT /?ELS5
	PRINTR	"You can't do that."
?ELS5:	FSET?	PRSI,OPENBIT /?ELS11
	FSET?	PRSI,SURFACEBIT /?ELS11
	CALL	THIS-IS-IT,PRSI
	PRINTI	"Inspection reveals that"
	CALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTR	" isn't open."
?ELS11:	EQUAL?	PRSI,PRSO \?ELS19
	PRINTR	"How can you do that?"
?ELS19:	IN?	PRSO,PRSI \?ELS23
	PRINTI	"I think"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" is already in"
	CALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTR	"."
?ELS23:	CALL	WEIGHT,PRSI >?TMP1
	CALL	WEIGHT,PRSO
	ADD	?TMP1,STACK >?TMP1
	GETP	PRSI,P?SIZE
	SUB	?TMP1,STACK >?TMP1
	GETP	PRSI,P?CAPACITY
	GRTR?	?TMP1,STACK \?ELS31
	PRINTR	"There's no room."
?ELS31:	CALL	HELD?,PRSO
	ZERO?	STACK \?ELS35
	CALL	ITAKE
	EQUAL?	STACK,M-FATAL,FALSE-VALUE /TRUE
?ELS35:	MOVE	PRSO,PRSI
	FSET	PRSO,TOUCHBIT
	PRINTR	"Done."


	.FUNCT	V-PUT-BEHIND
	PRINTR	"That hiding place is too obvious."


	.FUNCT	V-PUT-ON
	EQUAL?	PRSI,ME \?ELS5
	CALL	PERFORM,V?WEAR,PRSO
	RTRUE	
?ELS5:	FSET?	PRSI,SURFACEBIT \?ELS7
	CALL	V-PUT
	RSTACK	
?ELS7:	PRINTI	"There's no good surface on"
	CALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTR	"."


	.FUNCT	V-PUT-UNDER
	PRINTR	"You can't put anything under that."


	.FUNCT	V-RAPE
	PRINTR	"What a (ahem!) strange idea."


	.FUNCT	V-RAISE
	CALL	HACK-HACK,STR?42
	RSTACK	


	.FUNCT	V-REACH-IN,OBJ
	FSET?	PRSO,CONTBIT \?THN6
	FSET?	PRSO,ACTORBIT \?ELS5
?THN6:	PRINTR	"What a maroon!"
?ELS5:	FSET?	PRSO,OPENBIT /?ELS11
	PRINTR	"It's not open."
?ELS11:	FIRST?	PRSO >OBJ \?THN16
	FSET?	OBJ,INVISIBLE /?THN16
	FSET?	OBJ,TAKEBIT /?ELS15
?THN16:	PRINTR	"It's empty."
?ELS15:	PRINTI	"You reach into"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" and feel something."


	.FUNCT	PRE-READ
	ZERO?	FWEEPED /?ELS5
	CALL	BATTY
	RSTACK	
?ELS5:	EQUAL?	PRSO,SPELL-BOOK /FALSE
	FSET?	PRSO,SPELLBIT \?ELS10
	IN?	PRSO,SPELL-BOOK /FALSE
?ELS10:	ZERO?	LIT \?ELS14
	ZERO?	BLORTED \?ELS14
	PRINTR	"It is impossible to read in the dark."
?ELS14:	ZERO?	PRSI /FALSE
	FSET?	PRSI,TRANSBIT /FALSE
	PRINTI	"How does one look through"
	CALL	ARTICLE,PRSI
	PRINTR	"?"


	.FUNCT	V-READ
	FSET?	PRSO,READBIT /?THN6
	FSET?	PRSO,SPELLBIT \?ELS5
?THN6:	GETP	PRSO,P?TEXT
	PRINT	STACK
	CRLF	
	RTRUE	
?ELS5:	PRINTI	"How can you read"
	CALL	ARTICLE,PRSO
	PRINTR	"?"


	.FUNCT	V-REPLY
	PRINTI	"It is hardly likely that"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" is interested."
	CRLF	
	CALL	STOP
	RSTACK	


	.FUNCT	PRE-RESEARCH
	ZERO?	PRSI \?CND1
	EQUAL?	HERE,LIBRARY \?CND1
	SET	'PRSI,ENCYCLOPEDIA
?CND1:	EQUAL?	PRSO,ROOMS \?ELS10
	ZERO?	LIT /?CND11
	CALL	TOO-DARK
	RTRUE	
?CND11:	EQUAL?	HERE,GLASS-MAZE \?ELS18
	CALL	PERFORM,V?EXAMINE,MAZE
	RTRUE	
?ELS18:	FSET?	HERE,INSIDEBIT \?ELS20
	CALL	PERFORM,V?EXAMINE,CEILING
	RTRUE	
?ELS20:	CALL	PERFORM,V?EXAMINE,SKY
	RTRUE	
?ELS10:	ZERO?	PRSI \?ELS24
	EQUAL?	PRSO,LOWER-CHUTE,UPPER-CHUTE,STAIRS /?THN27
	EQUAL?	PRSO,CHIMNEY,FIREPLACE,FLAG-POLE /?THN27
	EQUAL?	PRSO,PSEUDO-OBJECT,ZORKMID-TREE,TREE \?ELS24
?THN27:	CALL	MAKE-OUT
	RSTACK	
?ELS24:	ZERO?	LIT \?ELS30
	ZERO?	BLORTED \?ELS30
	CALL	PERFORM,V?READ,ENCYCLOPEDIA
	RTRUE	
?ELS30:	ZERO?	PRSI \?ELS34
	PRINTR	"There's no encyclopedia here to look it up in."
?ELS34:	EQUAL?	PRSI,ENCYCLOPEDIA /?ELS38
	PRINTI	"You can't read about things in"
	CALL	ARTICLE,PRSI
	PRINTR	"."
?ELS38:	SET	'VOLUME-USED,TRUE-VALUE
	RFALSE	


	.FUNCT	V-RESEARCH
	EQUAL?	PRSO,LOBBY,CELLAR,STORE-ROOM \?ELS5
	PRINTR	"The spot where the entry should be is blank, as though the text were magically excised or transported to some other location."
?ELS5:	EQUAL?	PRSO,COAL-MINE-1 \?ELS9
	PRINTR	"Entharion the Wise united many warring tribes to form the kingdom of Quendor. He ruled from Largoneth Castle, near the ancient cities of Galepath and Mareilon. Our current calendar dates from the first year of his reign."
?ELS9:	EQUAL?	PRSO,COAL-MINE-2 \?ELS13
	PRINTR	"Duncanthrax was King of Quendor from 659 GUE through 688 GUE. Known as the ""Bellicose King"", he extended Quendor's domain, even conquering lands across the Great Sea (thus forming what his great-great-grandson, Dimwit Flathead, named the Great Underground Empire). Duncanthrax was quite eccentric, and his castle, Egreth, was reputed to be located in the most dangerous and deadly territory in the known lands."
?ELS13:	EQUAL?	PRSO,COAL-MINE-3 \?ELS17
	PRINTR	"Lord Dimwit Flathead the Excessive, a descendant of King Duncanthrax, ruled the Great Underground Empire from 770 GUE until 789 GUE. His accomplishments, achieved by overtaxing the kingdom, include Flood Control Dam #3 and the Royal Museum. Extremely vain, he renamed the Great Sea the Flathead Ocean, and preferred to spend his time in the strange lands that lay across it."
?ELS17:	EQUAL?	PRSO,SLANTED-ROOM \?ELS21
	PRINTR	"The Wizard of Frobozz was once a member of the influential Accardi chapter of the Enchanter's Guild. He was exiled by Dimwit Flathead after accidentally turning Flathead's castle into a mountain of fudge."
?ELS21:	EQUAL?	PRSO,OCEAN-NORTH \?ELS25
	PRINTR	"Flood Control Dam #3, a great engineering feat, is the source of the Frigid River."
?ELS25:	EQUAL?	PRSO,OCEAN-SOUTH \?ELS29
	PRINTR	"The article describes the exhibits of the Royal Museum, which included the crown jewels and a sandstone & marble maze."
?ELS29:	EQUAL?	PRSO,SHAFT-BOTTOM \?ELS33
	PRINTR	"Largoneth was the castle of Entharion the Wise."
?ELS33:	EQUAL?	PRSO,END-OF-HIGHWAY \?ELS37
	PRINTR	"A short article calls it an ancient city of Quendor."
?ELS37:	EQUAL?	PRSO,STONE-HUT \?ELS41
	PRINTR	"The entry says ""See GREAT UNDERGROUND EMPIRE."""
?ELS41:	EQUAL?	PRSO,ENTRANCE-HALL \?ELS45
	PRINTR	"Formerly known as Quendor, the Great Underground Empire reached its height under King Duncanthrax, began declining under the excessive rule of Dimwit Flathead, and finally fell in 883 GUE. The area is now called the Land of Frobozz, after its largest province."
?ELS45:	EQUAL?	PRSO,CRATER \?ELS49
	PRINTR	"The entry says ""See FLATHEAD OCEAN."""
?ELS49:	EQUAL?	PRSO,EDGE-OF-CHASM \?ELS53
	PRINTR	"The tiniest of articles mentions that Accardi-By-The-Sea is a village in the Land of Frobozz."
?ELS53:	EQUAL?	PRSO,BELBOZ-HIDEOUT \?ELS57
	PRINTR	"Miznia is a province in the southlands, mostly jungle."
?ELS57:	EQUAL?	PRSO,SOOTY-ROOM \?ELS61
	PRINTR	"The Frigid River, the mightiest in the Great Underground Empire, runs from Flood Control Dam #3 to Aragain Falls."
?ELS61:	EQUAL?	PRSO,DIAL-ROOM \?ELS65
	PRINTR	"According to this article, Aragain Falls is the most breathtaking and awesome waterfall in the known lands. It lies at the end of the Frigid River, and was a favorite honeymoon spot during the 8th and 9th centuries."
?ELS65:	EQUAL?	PRSO,BARE-PASSAGE \?ELS69
	PRINTR	"Amathradonis was a terrible giant who terrorized Accardi-By-The-Sea for many centuries. He was finally vanquished by Belboz the Necromancer in 952 GUE."
?ELS69:	EQUAL?	PRSO,ELBOW-ROOM \?ELS73
	PRINTR	"Nymphs are tiny, magical beings. They are known for their exuberance, fondness for practical jokes, and willingness to perform small tasks. The leading temporary nymph services agency is the venerable firm Nymph-O-Mania."
?ELS73:	EQUAL?	PRSO,HALLWAY-2 \?ELS77
	PRINTR	"Zork is a classic folk myth about a treasure-hunting adventurer who became a master of magic. It has been translated into novels, theatricals, giant wall murals ... almost every imaginable medium."
?ELS77:	EQUAL?	PRSO,TREE-ROOM \?ELS81
	PRINTR	"The encyclopedia describes it as one of the southlands, known for its fine artisans, and a popular vacation spot."
?ELS81:	EQUAL?	PRSO,HOLLOW \?ELS85
	PRINTR	"Antharia an island in the Flathead Ocean, is very prosperous thanks to its rich marble quarries."
?ELS85:	EQUAL?	PRSO,WINDING-TUNNEL \?ELS89
	PRINTR	"A leading manufacturer of magic scrolls and potions."
?ELS89:	EQUAL?	PRSO,BEND \?ELS93
	PRINTR	"The Kovalli Desert lies beyond the mountains that formed the western boundary of ancient Quendor. It is an uncrossable wasteland, believed to stretch to the edge of the world."
?ELS93:	EQUAL?	PRSO,FOREST-EDGE \?ELS97
	PRINTR	"Lonely Mountain is a towering peak to the west of Largoneth Castle."
?ELS97:	EQUAL?	PRSO,SLIMY-ROOM \?ELS101
	PRINTR	"A long article tells that Krill was a powerful warlock who plotted to overthrow the Circle of Enchanters and enslave this corner of the kingdom. He almost achieved his goal, but was vanquished by a young Enchanter."
?ELS101:	EQUAL?	PRSO,RIVER-BED \?ELS105
	PRINTR	"The article points out that the Servants Guild is not the most respected of trade guilds."
?ELS105:	EQUAL?	PRSO,STAGNANT-POOL \?ELS109
	PRINTR	"It is a corrupt and simplified form of Double Fannucci, popular in taverns, and frequently played for stakes."
?ELS109:	EQUAL?	PRSO,RUINS \?ELS113
	PRINTR	"A complex, thinking man's version of Gabber Tumper, and probably the most popular game in the world."
?ELS113:	EQUAL?	PRSO,TOP-OF-FALLS \?ELS117
	PRINTR	"The capital and biggest city in Frobozz, and the center of the spell scroll and infotater industries. The port of Borphee is the busiest on the Flathead Ocean."
?ELS117:	EQUAL?	PRSO,TURRET \?ELS121
	PRINTR	"The Messengers Guild is among the oldest guilds, and its members are incredibly dedicated. Their motto is ""Not even really bad precipitation or very early nightfall will prevent us from completing our route."""
?ELS121:	EQUAL?	PRSO,DUNGEON \?ELS125
	PRINTR	"Temporal travel technology, though in existence for many centuries, is still considered to be experimental by the magic industry. Several government agencies are currently looking into its potential long-term effects."
?ELS125:	EQUAL?	PRSO,HIGHWAY \?ELS129
	PRINTR	"The Enchanter's Guild can date its roots to the reign of Entharion, over 900 years ago. Chapters are usually located in small villages, since the bustle of city life interferes with an Enchanter's work (""Excuse me, I locked my keys in my house. Could you please rezrov my door?""). The most influential chapter is Accardi Chapter, home of the Circle of Enchanters."
?ELS129:	EQUAL?	PRSO,STORE \?ELS133
	PRINTR	"Gnomes are a race of short, furry people known for their greed and business acumen. They are often employed as toll and fare collectors, bank tellers, ticket sellers, and presidents of small software firms."
?ELS133:	EQUAL?	PRSO,SHAFT-TOP \?ELS137
	PRINTR	"Trolls are a race of ferocious, semi-intelligent creatures. They are often employed as security guards and bouncers."
?ELS137:	EQUAL?	PRSO,YOUR-QUARTERS \?ELS141
	PRINTR	"The leading supplier of designer spell books."
?ELS141:	EQUAL?	PRSO,FROBAR-QUARTERS \?ELS145
	PRINTR	"The head of one chapter of the Enchanters Guild."
?ELS145:	EQUAL?	PRSO,HELISTAR-QUARTERS \?ELS149
	PRINTR	"A village in the northlands."
?ELS149:	EQUAL?	PRSO,SERVANT-QUARTERS \?ELS153
	PRINTR	"According to this article, there are two meanings for Sorcerer. In general, it refers to a powerful magic-user. More specifically, the term is used by the Enchanters Guild to denote a senior member of the Circle."
?ELS153:	EQUAL?	PRSO,APPRENTICE-QUARTERS \?ELS157
	PRINTR	"A famous chasm near Accardi-By-The-Sea."
?ELS157:	EQUAL?	PRSO,OUTSIDE-GLASS-DOOR \?ELS161
	PRINTR	"The most prestigious engineering school in the land."
?ELS161:	PRINTI	"You look in the encyclopedia but find no entry about"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"."


	.FUNCT	V-RUB
	CALL	HACK-HACK,STR?43
	RSTACK	


	.FUNCT	V-SAY,V
	CALL	FIND-IN,HERE,ACTORBIT >V
	ZERO?	V /?ELS5
	PRINTI	"You must address"
	CALL	ARTICLE,V,TRUE-VALUE
	PRINTI	" directly."
	CRLF	
	CALL	STOP
	RSTACK	
?ELS5:	GET	P-LEXV,P-CONT
	EQUAL?	STACK,W?HELLO \?ELS11
	SET	'QUOTE-FLAG,FALSE-VALUE
	RTRUE	
?ELS11:	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-CONT,FALSE-VALUE
	CALL	PERFORM,V?TELL,ME
	RTRUE	


	.FUNCT	V-SEARCH
	ZERO?	FWEEPED /?ELS5
	CALL	BATTY
	RSTACK	
?ELS5:	PRINTR	"You find nothing unusual."


	.FUNCT	V-SEND
	FSET?	PRSO,ACTORBIT \?ELS5
	PRINTI	"Why would you send for"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"?"
?ELS5:	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	V-SGIVE
	CALL	PERFORM,V?GIVE,PRSI,PRSO
	RTRUE	


	.FUNCT	V-SHAKE
	FSET?	PRSO,ACTORBIT \?ELS5
	PRINTR	"Be real."
?ELS5:	FSET?	PRSO,TAKEBIT /?ELS9
	PRINTR	"You can't take it; thus, you can't shake it!"
?ELS9:	PRINTR	"There's no point in shaking that."


	.FUNCT	V-SHARPEN
	PRINTR	"You'll never sharpen anything with that!"


	.FUNCT	V-SHOOT
	PRINTR	"Don't bother applying for a job as an armaments expert."


	.FUNCT	V-SHOW
	PRINTI	"I doubt"
	CALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTR	" is interested."


	.FUNCT	V-SIT
	PRINTR	"That would be a waste of time."


	.FUNCT	V-SKIP
	PRINTR	"Wasn't that fun?"


	.FUNCT	V-SLEEP,TOLD?=0
	ZERO?	FLYING /?ELS5
	PRINTR	"You'd better settle down before thinking about settling down."
?ELS5:	EQUAL?	AWAKE,-1 \?ELS10
	PRINTR	"You settle down to sleep, but you really aren't tired, so you thrash around for a while and then give up."
?ELS10:	INC	'REAL-SPELL-MAX
	SET	'SPELL-MAX,REAL-SPELL-MAX
	SET	'SPELL-ROOM,SPELL-MAX
	ADD	MOVES,50 >MOVES
	SET	'LAST-SLEPT,MOVES
	SET	'LOAD-ALLOWED,LOAD-MAX
	SET	'FUMBLE-NUMBER,7
	CALL	QUEUE,I-TIRED,80
	PUT	STACK,0,1
	SET	'AWAKE,-1
	CALL	FORGET-ALL
	CALL	WEAR-OFF-SPELLS
	FSET?	TWISTED-FOREST,TOUCHBIT /?CND15
	PRINTI	"You drift off to sleep and dream of the distant Kovalli Desert. Waves of heat from the sand make breathing hard, and the bright sunlight burns against your eyelids. Suddenly you awake -- the Guild Hall is on fire! Through the thick smoke, you see Belboz standing before you. But no, this could not be Belboz, his face an unrecognizable mask of hatred, his outstretched arms dripping with blood.

He who is not Belboz speaks, in a voice filled with malevolence. ""So, you are the young Enchanter that Belboz thinks so highly of. That senile wizard thought you would be the one to rescue him from my clutches. I wonder why I bothered to come at all -- an insect like you poses no threat! Still..."" He gestures and your surroundings change."
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
	CALL	GOTO,CHAMBER-OF-LIVING-DEATH
	RTRUE	
?CND15:	EQUAL?	HERE,RIVER-BED,STAGNANT-POOL,TOP-OF-FALLS \?CND20
	CALL	JIGS-UP,STR?44
	RTRUE	
?CND20:	CALL	IN-COAL-MINE?
	ZERO?	STACK /?CND23
	ZERO?	VILSTUED /?CND23
	CALL	JIGS-UP,STR?45
	RTRUE	
?CND23:	CALL	IN-COAL-MINE?
	ZERO?	STACK /?CND28
	CALL	JIGS-UP,STR?46
	RTRUE	
?CND28:	EQUAL?	HERE,TWISTED-FOREST \?CND31
	CALL	JIGS-UP,STR?47
	RTRUE	
?CND31:	EQUAL?	HERE,TREE-BRANCH \?CND34
	CALL	JIGS-UP,STR?48
	RTRUE	
?CND34:	EQUAL?	HERE,SNAKE-PIT \?CND37
	CALL	JIGS-UP,STR?49
	RTRUE	
?CND37:	EQUAL?	HERE,MINE-FIELD \?CND40
	CALL	JIGS-UP,STR?50
	RTRUE	
?CND40:	EQUAL?	HERE,MEADOW \?CND43
	CALL	JIGS-UP,STR?51
	RTRUE	
?CND43:	EQUAL?	HERE,DRAWBRIDGE \?CND46
	PRINTI	"You are rudely awakened by the collapse of the rotting drawbridge. "
	CALL	DO-WALK,P?DOWN
	RTRUE	
?CND46:	EQUAL?	HERE,RIVER-BANK \?CND51
	CALL	JIGS-UP,STR?52
	RTRUE	
?CND51:	EQUAL?	HERE,HOLLOW \?CND54
	CALL	JIGS-UP,STR?53
	RTRUE	
?CND54:	EQUAL?	HERE,LAGOON,LAGOON-FLOOR \?CND57
	CALL	JIGS-UP,STR?54
	RTRUE	
?CND57:	EQUAL?	HERE,BELBOZ-HIDEOUT \?CND60
	PRINTI	"An unknown amount of time later you awake and look around. "
	CALL	I-BELBOZ-AWAKES
	RTRUE	
?CND60:	IN?	PROTAGONIST,BED \?ELS67
	ZERO?	TOLD? \?ELS67
	PRINTI	"You're not all that tired, but the bed is very comfortable."
	CRLF	
	JUMP	?CND65
?ELS67:	ZERO?	RIDE-IN-PROGRESS /?ELS73
	CALL	END-RIDE
	PRINTI	"Hard to believe that you could fall asleep during such an exciting ride, but you are pretty tired."
	CRLF	
	JUMP	?CND65
?ELS73:	PRINTI	"Ah, sleep! It's been a long day and rest will do you good. You spread your cloak on the floor and drift off, renewing your powers and refreshing your mind. Time passes as you snore blissfully."
	CRLF	
?CND65:	CRLF	
	MOVE	PROTAGONIST,HERE
	RANDOM	100
	LESS?	50,STACK /?ELS85
	PRINTR	"You sleep uneventfully, awake refreshed, and rise to your feet."
?ELS85:	CALL	PICK-ONE,DREAMS
	PRINT	STACK
	PRINTR	" You awaken and stand."


	.FUNCT	V-SMELL
	PRINTI	"It smells just like"
	CALL	ARTICLE,PRSO
	PRINTR	"."


	.FUNCT	V-SPAY
	CALL	PERFORM,V?PAY,PRSI,PRSO
	RTRUE	


	.FUNCT	V-SPIN
	PRINTR	"You can't spin that!"


	.FUNCT	V-SPRAY
	ZERO?	PRSI \?ELS5
	EQUAL?	PRSO,GRUE-REPELLENT \?ELS10
	PRINTR	"Specify who or what you want to spray."
?ELS10:	CALL	HELD?,GRUE-REPELLENT
	ZERO?	STACK /?ELS14
	CALL	PERFORM,V?SPRAY,GRUE-REPELLENT,PRSO
	RTRUE	
?ELS14:	PRINTR	"You don't have anything that sprays!"
?ELS5:	CALL	V-SQUEEZE
	RSTACK	


	.FUNCT	V-SQUEEZE
	PRINTR	"How singularly useless."


	.FUNCT	PRE-SSHOW
	CALL	PERFORM,V?SHOW,PRSI,PRSO
	RTRUE	


	.FUNCT	V-SSHOW
	CALL	V-SGIVE
	RSTACK	


	.FUNCT	V-SSPRAY
	CALL	PERFORM,V?SPRAY,PRSI,PRSO
	RTRUE	


	.FUNCT	V-STAND
	LOC	PROTAGONIST
	FSET?	STACK,VEHBIT \?ELS5
	LOC	PROTAGONIST
	CALL	PERFORM,V?DISEMBARK,STACK
	RTRUE	
?ELS5:	ZERO?	FLYING /?ELS7
	CALL	WHILE-FLYING
	RSTACK	
?ELS7:	PRINTR	"You are already standing."


	.FUNCT	V-STAND-ON
	CALL	V-SIT
	RSTACK	


	.FUNCT	V-STRIKE
	CALL	PERFORM,V?ATTACK,PRSO
	RTRUE	


	.FUNCT	V-SWING
	ZERO?	PRSI \?ELS5
	PRINTR	"Whoosh!"
?ELS5:	CALL	PERFORM,V?ATTACK,PRSI,PRSO
	RTRUE	


	.FUNCT	V-SWIM
	ZERO?	PRSO /?ELS5
	CALL	PERFORM,V?THROUGH,PRSO
	RTRUE	
?ELS5:	EQUAL?	HERE,LAGOON,LAGOON-FLOOR \?ELS8
	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS8:	EQUAL?	HERE,COVE,OCEAN-NORTH,OCEAN-SOUTH \?ELS10
	CALL	PERFORM,V?THROUGH,LAGOON-OBJECT
	RTRUE	
?ELS10:	EQUAL?	HERE,RIVER-BANK \?ELS12
	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS12:	EQUAL?	HERE,MOUTH-OF-RIVER \?ELS14
	CALL	DO-WALK,P?EAST
	RSTACK	
?ELS14:	EQUAL?	HERE,HIDDEN-CAVE \?ELS16
	CALL	DO-WALK,P?OUT
	RSTACK	
?ELS16:	EQUAL?	HERE,DRAWBRIDGE \?ELS18
	CALL	DO-WALK,P?DOWN
	RSTACK	
?ELS18:	EQUAL?	HERE,STAGNANT-POOL \?ELS20
	CALL	DO-WALK,P?NW
	RSTACK	
?ELS20:	PRINTR	"There's nothing to swim in!"


	.FUNCT	PRE-TAKE,L
	LOC	PRSO >L
	ZERO?	FWEEPED /?ELS5
	CALL	BATTY
	RSTACK	
?ELS5:	IN?	PRSO,PROTAGONIST \?ELS8
	FSET?	PRSO,WEARBIT \?ELS13
	PRINTR	"You are already wearing it."
?ELS13:	PRINTR	"You already have it."
?ELS8:	FSET?	PRSO,SPELLBIT \?ELS21
	ZERO?	L /?ELS21
	FSET?	L,SCROLLBIT \?ELS21
	CALL	ACCESSIBLE?,L
	ZERO?	STACK /?ELS21
	CALL	PERFORM,V?TAKE,L
	RTRUE	
?ELS21:	ZERO?	L /?ELS25
	FSET?	L,CONTBIT \?ELS25
	FSET?	L,OPENBIT /?ELS25
	PRINTR	"You can't reach that."
?ELS25:	ZERO?	PRSI /?ELS31
	EQUAL?	PRSO,ME \?ELS37
	CALL	PERFORM,V?DROP,PRSI
	RTRUE	
?ELS37:	EQUAL?	PRSI,L /?ELS39
	EQUAL?	PRSI,BELBOZ-DESK /?ELS39
	PRINTI	"But"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" isn't in"
	CALL	ARTICLE,PRSI,TRUE-VALUE
	PRINTR	"."
?ELS39:	SET	'PRSI,FALSE-VALUE
	RFALSE	
?ELS31:	LOC	PROTAGONIST
	EQUAL?	PRSO,STACK \FALSE
	PRINTR	"You are in it!"


	.FUNCT	V-TAKE
	CALL	ITAKE
	EQUAL?	STACK,TRUE-VALUE \FALSE
	FSET?	PRSO,WEARBIT \?ELS10
	PRINTI	"You are now wearing"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"."
?ELS10:	ZERO?	FLYING /?ELS16
	PRINTR	"You swoop low and pick it up."
?ELS16:	EQUAL?	PRSO,ROPE \?CND22
	ZERO?	ROPE-PLACED \?THN27
	ZERO?	ROPE-IN-LOWER-CHUTE /?CND22
?THN27:	SET	'ROPE-PLACED,FALSE-VALUE
	SET	'ROPE-IN-LOWER-CHUTE,FALSE-VALUE
	FCLEAR	BEAM,TRYTAKEBIT
	FCLEAR	ROPE,TRYTAKEBIT
?CND22:	PRINTR	"Taken."


	.FUNCT	V-TAKE-OFF
	LOC	PROTAGONIST
	EQUAL?	PRSO,STACK \?ELS5
	CALL	PERFORM,V?DISEMBARK,PRSO
	RTRUE	
?ELS5:	CALL	HELD?,PRSO
	ZERO?	STACK /?ELS7
	FSET?	PRSO,WEARBIT \?ELS7
	CALL	PERFORM,V?DROP,PRSO
	RTRUE	
?ELS7:	PRINTR	"You're not wearing that!"


	.FUNCT	V-TELL
	FSET?	PRSO,ACTORBIT \?ELS5
	ZERO?	P-CONT /?ELS10
	SET	'WINNER,PRSO
	LOC	WINNER >HERE
	RETURN	HERE
?ELS10:	EQUAL?	PRSO,GNOME \?ELS13
	ZERO?	GNOME-SLEEPING /?ELS13
	CALL	POOR-LISTENERS
	RSTACK	
?ELS13:	PRINTI	"Hmmm..."
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" looks at you expectantly, as though he thought you were about to talk."
?ELS5:	EQUAL?	PRSO,PARROT \?ELS23
	PRINTI	"Although the parrot is a marvelous imitator of human speech, it is incapable of understanding or initiating any."
	CRLF	
	CALL	STOP
	RSTACK	
?ELS23:	PRINTI	"You can't talk to"
	CALL	ARTICLE,PRSO
	PRINTI	"!"
	CRLF	
	CALL	STOP
	RSTACK	


	.FUNCT	V-THANK
	FSET?	PRSO,ACTORBIT \?ELS5
	PRINTI	"You do so, but"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" seems less than overjoyed."
?ELS5:	PRINTR	"The Circle will revoke your certificate if you keep this up."


	.FUNCT	V-THROUGH
	FSET?	PRSO,DOORBIT \?ELS5
	CALL	OTHER-SIDE,PRSO
	CALL	DO-WALK,STACK
	RTRUE	
?ELS5:	FSET?	PRSO,VEHBIT \?ELS7
	CALL	PERFORM,V?BOARD,PRSO
	RTRUE	
?ELS7:	FSET?	PRSO,TAKEBIT /?ELS9
	PRINTI	"You hit your head against"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" as you attempt this feat."
?ELS9:	IN?	PRSO,PROTAGONIST \?ELS15
	PRINTR	"That would involve quite a contortion!"
?ELS15:	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	V-THROW
	CALL	IDROP
	ZERO?	STACK /FALSE
	EQUAL?	HERE,COAL-BIN-ROOM,DIAL-ROOM \?ELS10
	GETP	PRSO,P?SIZE
	LESS?	STACK,20 \?ELS10
	CALL	BURIED-IN-COAL,STR?55
	RSTACK	
?ELS10:	EQUAL?	HERE,HAUNTED-HOUSE \?CND15
	MOVE	PRSO,DIAL
?CND15:	PRINTR	"Thrown."


	.FUNCT	V-THROW-OFF
	PRINTR	"You can't throw anything off that!"


	.FUNCT	V-TIE
	PRINTI	"You can't tie"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" to that."


	.FUNCT	V-TIE-UP
	PRINTR	"You could certainly never tie it with that!"


	.FUNCT	V-TIME,X
	SUB	MOVES,LAST-SLEPT >X
	PRINTI	"It's "
	LESS?	X,15 \?ELS5
	PRINTI	"early morning"
	JUMP	?CND3
?ELS5:	LESS?	X,30 \?ELS9
	PRINTI	"mid-morning"
	JUMP	?CND3
?ELS9:	LESS?	X,50 \?ELS13
	PRINTI	"mid-day"
	JUMP	?CND3
?ELS13:	LESS?	X,65 \?ELS17
	PRINTI	"late afternoon"
	JUMP	?CND3
?ELS17:	LESS?	X,80 \?ELS21
	PRINTI	"early evening"
	JUMP	?CND3
?ELS21:	PRINTI	"late evening"
?CND3:	PRINTR	"."


	.FUNCT	V-TORTURE
	EQUAL?	HERE,TORTURE-CHAMBER /?ELS5
	PRINTR	"There are no torture devices here!"
?ELS5:	EQUAL?	PRSO,ME \?ELS9
	CALL	JIGS-UP,STR?56
	RSTACK	
?ELS9:	PRINTI	"Despite your best effort,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" fails to divulge any useful information."


	.FUNCT	V-TURN
	PRINTR	"This has no effect."


	.FUNCT	V-UNLOCK
	CALL	V-LOCK
	RSTACK	


	.FUNCT	V-UNTIE
	PRINTR	"This cannot be tied, so it cannot be untied!"


	.FUNCT	V-WALK,PT,PTS,STR,OBJ,RM
	ZERO?	P-WALK-DIR \?ELS5
	CALL	PERFORM,V?WALK-TO,PRSO
	RTRUE	
?ELS5:	GETPT	HERE,PRSO >PT
	ZERO?	PT /?ELS7
	PTSIZE	PT >PTS
	EQUAL?	PTS,UEXIT \?ELS12
	GETB	PT,REXIT
	CALL	GOTO,STACK
	RSTACK	
?ELS12:	EQUAL?	PTS,NEXIT \?ELS14
	GET	PT,NEXITSTR
	PRINT	STACK
	CRLF	
	RETURN	2
?ELS14:	EQUAL?	PTS,FEXIT \?ELS20
	GET	PT,FEXITFCN
	CALL	STACK >RM
	ZERO?	RM /?ELS25
	CALL	GOTO,RM
	RSTACK	
?ELS25:	EQUAL?	HERE,GLASS-MAZE /FALSE
	EQUAL?	HERE,PARK-ENTRANCE /FALSE
	RETURN	2
?ELS20:	EQUAL?	PTS,CEXIT \?ELS40
	GETB	PT,CEXITFLAG
	VALUE	STACK
	ZERO?	STACK /?ELS45
	GETB	PT,REXIT
	CALL	GOTO,STACK
	RSTACK	
?ELS45:	GET	PT,CEXITSTR >STR
	ZERO?	STR /?ELS47
	PRINT	STR
	CRLF	
	RETURN	2
?ELS47:	CALL	CANT-GO
	RETURN	2
?ELS40:	EQUAL?	PTS,DEXIT \FALSE
	GETB	PT,DEXITOBJ >OBJ
	FSET?	OBJ,OPENBIT \?ELS62
	GETB	PT,REXIT
	CALL	GOTO,STACK
	RSTACK	
?ELS62:	GET	PT,DEXITSTR >STR
	ZERO?	STR /?ELS64
	PRINT	STR
	CRLF	
	CALL	THIS-IS-IT,OBJ
	RETURN	2
?ELS64:	PRINTI	"The "
	PRINTD	OBJ
	PRINTI	" is closed."
	CRLF	
	CALL	THIS-IS-IT,OBJ
	RETURN	2
?ELS7:	ZERO?	FLYING /?ELS76
	EQUAL?	PRSO,P?UP \?ELS76
	PRINTI	"You're already flying as high as you can."
	CRLF	
	RETURN	2
?ELS76:	CALL	CANT-GO
	RETURN	2


	.FUNCT	V-WALK-AROUND
	PRINTR	"Please use compass directions for movement."


	.FUNCT	V-WALK-TO
	IN?	PRSO,HERE /?THN6
	CALL	GLOBAL-IN?,PRSO,HERE
	ZERO?	STACK /?ELS5
?THN6:	PRINTR	"It's here!"
?ELS5:	CALL	V-WALK-AROUND
	RSTACK	


	.FUNCT	V-WAIT,NUM=3
	PRINTI	"Time passes..."
	CRLF	
?PRG3:	DLESS?	'NUM,0 \?ELS7
	JUMP	?REP4
?ELS7:	CALL	CLOCKER
	ZERO?	STACK /?PRG3
?REP4:	SET	'CLOCK-WAIT,TRUE-VALUE
	RETURN	CLOCK-WAIT


	.FUNCT	V-WAIT-FOR
	LOC	PRSO
	EQUAL?	STACK,HERE,PROTAGONIST \?ELS5
	PRINTR	"It's already here!"
?ELS5:	PRINTR	"You will probably be waiting quite a while."


	.FUNCT	V-WAVE
	CALL	HACK-HACK,STR?57
	RSTACK	


	.FUNCT	V-WAVE-AT
	PRINTI	"Despite your friendly nature,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" isn't likely to respond."


	.FUNCT	V-WAX
	ZERO?	PRSI \?ELS3
	CALL	VISIBLE?,WAXER
	ZERO?	STACK /?ELS3
	SET	'PRSI,WAXER
	JUMP	?CND1
?ELS3:	ZERO?	PRSI \?CND1
	PRINTR	"With what?"
?CND1:	EQUAL?	PRSI,WAXER \?ELS14
	EQUAL?	PRSO,GROUND \?ELS14
	CALL	PERFORM,V?LAMP-ON,WAXER
	RTRUE	
?ELS14:	CALL	WITH???
	RSTACK	


	.FUNCT	V-WEAR
	FSET?	PRSO,WEARBIT /?ELS5
	PRINTI	"You can't wear"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"."
?ELS5:	CALL	PERFORM,V?TAKE,PRSO
	RTRUE	


	.FUNCT	V-WHAT
	PRINTR	"Try reading an encyclopedia."


	.FUNCT	V-WHERE
	EQUAL?	PRSO,RIVER-BED \?ELS5
	PRINTR	"Out doing their daily errands, probably."
?ELS5:	CALL	V-FIND,TRUE-VALUE
	RSTACK	


	.FUNCT	V-WHO
	FSET?	PRSO,ACTORBIT \?ELS5
	CALL	PERFORM,V?WHAT,PRSO
	RTRUE	
?ELS5:	EQUAL?	PRSO,COAL-MINE-1,COAL-MINE-2,COAL-MINE-3 /?THN8
	EQUAL?	PRSO,SLANTED-ROOM,BARE-PASSAGE,SLIMY-ROOM /?THN8
	EQUAL?	PRSO,RIVER-BED,TURRET,FROBAR-QUARTERS \?ELS7
?THN8:	CALL	PERFORM,V?WHAT,PRSO
	RTRUE	
?ELS7:	PRINTR	"That's not a person!"


	.FUNCT	V-YELL
	PRINTI	"Aarrrrrgggggggghhhhhhhhhhh!"
	CRLF	
	EQUAL?	HERE,TOLL-GATE \FALSE
	ZERO?	GNOME-SLEEPING /FALSE
	ZERO?	LIT \?THN10
	ZERO?	BLORTED /FALSE
?THN10:	CRLF	
	CALL	PERFORM,V?ALARM,GNOME
	RTRUE	


	.FUNCT	PRE-CAST,SPELL,SCROLL
	ZERO?	PERFORMING-SPELL /?CND1
	SET	'PERFORMING-SPELL,FALSE-VALUE
	RFALSE	
?CND1:	EQUAL?	PRSA,V?GNUSTO \?ELS9
	PUSH	GNUSTO-SPELL
	JUMP	?CND5
?ELS9:	EQUAL?	PRSA,V?FROTZ \?ELS11
	PUSH	FROTZ-SPELL
	JUMP	?CND5
?ELS11:	EQUAL?	PRSA,V?REZROV \?ELS13
	PUSH	REZROV-SPELL
	JUMP	?CND5
?ELS13:	EQUAL?	PRSA,V?IZYUK \?ELS15
	PUSH	IZYUK-SPELL
	JUMP	?CND5
?ELS15:	EQUAL?	PRSA,V?AIMFIZ \?ELS17
	PUSH	AIMFIZ-SPELL
	JUMP	?CND5
?ELS17:	EQUAL?	PRSA,V?FWEEP \?ELS19
	PUSH	FWEEP-SPELL
	JUMP	?CND5
?ELS19:	EQUAL?	PRSA,V?SWANZO \?ELS21
	PUSH	SWANZO-SPELL
	JUMP	?CND5
?ELS21:	EQUAL?	PRSA,V?GOLMAC \?ELS23
	PUSH	GOLMAC-SPELL
	JUMP	?CND5
?ELS23:	EQUAL?	PRSA,V?VARDIK \?ELS25
	PUSH	VARDIK-SPELL
	JUMP	?CND5
?ELS25:	EQUAL?	PRSA,V?PULVER \?ELS27
	PUSH	PULVER-SPELL
	JUMP	?CND5
?ELS27:	EQUAL?	PRSA,V?MEEF \?ELS29
	PUSH	MEEF-SPELL
	JUMP	?CND5
?ELS29:	EQUAL?	PRSA,V?VEZZA \?ELS31
	PUSH	VEZZA-SPELL
	JUMP	?CND5
?ELS31:	EQUAL?	PRSA,V?GASPAR \?ELS33
	PUSH	GASPAR-SPELL
	JUMP	?CND5
?ELS33:	EQUAL?	PRSA,V?YOMIN \?ELS35
	PUSH	YOMIN-SPELL
	JUMP	?CND5
?ELS35:	EQUAL?	PRSA,V?YONK \?ELS37
	PUSH	YONK-SPELL
	JUMP	?CND5
?ELS37:	EQUAL?	PRSA,V?MALYON \?PRD7
	PUSH	MALYON-SPELL
	JUMP	?CND5
?PRD7:	PUSH	0
?CND5:	SET	'SPELL,STACK
	EQUAL?	SPELL,PRSO /?THN43
	LOC	SPELL
	EQUAL?	STACK,PRSO \?ELS42
	LOC	SPELL
	EQUAL?	STACK,SPELL-BOOK /?ELS42
?THN43:	PRINTR	"As you must remember from Thaumaturgy 101, you cannot cast a spell upon itself, or upon the scroll it is written on."
?ELS42:	LOC	SPELL
	FSET?	STACK,MUNGBIT \?ELS50
	CALL	ALWAYS-MEMORIZED,SPELL
	ZERO?	STACK \?ELS50
	GETP	SPELL,P?COUNT
	ZERO?	STACK \?ELS50
	PRINTR	"The spell is no longer readable."
?ELS50:	LOC	SPELL
	FSET?	STACK,SCROLLBIT \?CND40
	LOC	SPELL >SCROLL
	IN?	SCROLL,PROTAGONIST \?ELS59
	EQUAL?	SPELL,YONK-SPELL \?CND60
	CALL	VISIBLE?,PRSO
	ZERO?	STACK /FALSE
?CND60:	MOVE	SCROLL,DIAL
	PRINTI	"As you cast the spell, the "
	PRINTD	SCROLL
	PRINTI	" vanishes!"
	CRLF	
	CRLF	
	PUTP	SPELL,P?COUNT,1
	JUMP	?CND40
?ELS59:	FSET?	SPELL,TOUCHBIT /?THN69
	IN?	SCROLL,HERE \?ELS68
?THN69:	PRINTI	"You don't have the "
	PRINTD	SPELL
	PRINTR	" memorized, nor do you have the scroll on which it is written."
?ELS68:	PRINTI	"The "
	PRINTD	SPELL
	PRINTR	" is not committed to memory, and you haven't seen any scroll on which it is written."
?CND40:	ZERO?	FWEEPED /?ELS81
	PRINTI	"When you attempt to incant the "
	PRINTD	SPELL
	PRINTR	", all that comes out is a high-pitched squeak!"
?ELS81:	CALL	ALWAYS-MEMORIZED,SPELL
	ZERO?	STACK \FALSE
	GETP	SPELL,P?COUNT
	ZERO?	STACK \?ELS88
	CALL	THIS-IS-IT,SPELL
	PRINTI	"You don't have the "
	PRINTD	SPELL
	PRINTR	" committed to memory!"
?ELS88:	GETP	SPELL,P?COUNT
	SUB	STACK,1
	PUTP	SPELL,P?COUNT,STACK
	INC	'SPELL-ROOM
	RFALSE	


	.FUNCT	V-CAST,VRB
	FSET?	PRSO,SPELLBIT /?ELS5
	PRINTI	"You might as well be casting with a fly rod, as to try to cast"
	CALL	ARTICLE,PRSO
	PRINTR	"."
?ELS5:	EQUAL?	PRSO,GNUSTO-SPELL \?ELS16
	PUSH	V?GNUSTO
	JUMP	?CND12
?ELS16:	EQUAL?	PRSO,FROTZ-SPELL \?ELS18
	PUSH	V?FROTZ
	JUMP	?CND12
?ELS18:	EQUAL?	PRSO,REZROV-SPELL \?ELS20
	PUSH	V?REZROV
	JUMP	?CND12
?ELS20:	EQUAL?	PRSO,IZYUK-SPELL \?ELS22
	PUSH	V?IZYUK
	JUMP	?CND12
?ELS22:	EQUAL?	PRSO,AIMFIZ-SPELL \?ELS24
	PUSH	V?AIMFIZ
	JUMP	?CND12
?ELS24:	EQUAL?	PRSO,FWEEP-SPELL \?ELS26
	PUSH	V?FWEEP
	JUMP	?CND12
?ELS26:	EQUAL?	PRSO,SWANZO-SPELL \?ELS28
	PUSH	V?SWANZO
	JUMP	?CND12
?ELS28:	EQUAL?	PRSO,GOLMAC-SPELL \?ELS30
	PUSH	V?GOLMAC
	JUMP	?CND12
?ELS30:	EQUAL?	PRSO,VARDIK-SPELL \?ELS32
	PUSH	V?VARDIK
	JUMP	?CND12
?ELS32:	EQUAL?	PRSO,PULVER-SPELL \?ELS34
	PUSH	V?PULVER
	JUMP	?CND12
?ELS34:	EQUAL?	PRSO,MEEF-SPELL \?ELS36
	PUSH	V?MEEF
	JUMP	?CND12
?ELS36:	EQUAL?	PRSO,VEZZA-SPELL \?ELS38
	PUSH	V?VEZZA
	JUMP	?CND12
?ELS38:	EQUAL?	PRSO,GASPAR-SPELL \?ELS40
	PUSH	V?GASPAR
	JUMP	?CND12
?ELS40:	EQUAL?	PRSO,YOMIN-SPELL \?ELS42
	PUSH	V?YOMIN
	JUMP	?CND12
?ELS42:	EQUAL?	PRSO,YONK-SPELL \?ELS44
	PUSH	V?YONK
	JUMP	?CND12
?ELS44:	EQUAL?	PRSO,MALYON-SPELL \?ELS46
	PUSH	V?MALYON
	JUMP	?CND12
?ELS46:	PRINTR	"Bug #90"
?CND12:	SET	'VRB,STACK
	ZERO?	PRSI \?ELS53
	PRINTR	"You might as well be casting it away as not cast it on something."
?ELS53:	CALL	PERFORM,VRB,PRSI
	RTRUE	


	.FUNCT	V-SPELLS,CNT,S,ANY=0,OS=0,TMP
	GET	ALL-SPELLS,0 >CNT
	PRINTI	"The gnusto, rezrov, and frotz spells are yours forever. Other than that, you have "
?PRG3:	ZERO?	CNT \?CND5
	ZERO?	OS /?CND8
	CALL	SPELL-PRINT,OS,ANY,TRUE-VALUE
	SET	'ANY,TRUE-VALUE
?CND8:	ZERO?	ANY \?ELS14
	PRINTI	"no spells memorized."
	JUMP	?CND12
?ELS14:	PRINTI	" committed to memory."
?CND12:	CRLF	
	RTRUE	
?CND5:	GET	ALL-SPELLS,CNT
	CALL	SPELL-TIMES,STACK >TMP
	ZERO?	TMP /?CND21
	ZERO?	OS /?CND24
	CALL	SPELL-PRINT,OS,ANY
	SET	'ANY,TRUE-VALUE
?CND24:	SET	'OS,TMP
?CND21:	DEC	'CNT
	JUMP	?PRG3


	.FUNCT	SPELL-PRINT,S,ANY,PAND?=0,X
	ZERO?	ANY /?CND1
	ZERO?	PAND? /?ELS7
	PRINTI	" and "
	JUMP	?CND1
?ELS7:	PRINTI	", "
?CND1:	PRINTI	"the "
	PRINTD	S
	PRINTI	" "
	GETP	S,P?COUNT
	SUB	STACK,1 >X
	GRTR?	X,4 \?CND17
	SET	'X,4
?CND17:	GET	COUNTERS,X
	PRINT	STACK
	RETURN	S


	.FUNCT	SPELL-TIMES,S
	GETP	S,P?COUNT
	GRTR?	STACK,0 \FALSE
	IN?	S,SPELL-BOOK \?ELS10
	RETURN	S
?ELS10:	EQUAL?	S,AIMFIZ-SPELL \?ELS12
	IN?	AIMFIZ-SPELL,AIMFIZ-SCROLL /?ELS12
	RETURN	S
?ELS12:	EQUAL?	S,YONK-SPELL \FALSE
	IN?	YONK-SPELL,YONK-SCROLL /FALSE
	RETURN	S


	.FUNCT	V-LEARN
	PRINTR	"You don't have that spell, if indeed that is a spell."


	.FUNCT	V-AIMFIZ
	EQUAL?	PRSO,COAL-MINE-1,COAL-MINE-2,COAL-MINE-3 \?ELS5
	CALL	JIGS-UP,STR?63
	RSTACK	
?ELS5:	EQUAL?	PRSO,SLANTED-ROOM \?ELS7
	CALL	JIGS-UP,STR?64
	RSTACK	
?ELS7:	EQUAL?	PRSO,SLIMY-ROOM \?ELS9
	PRINTI	"You join Krill in oblivion."
	CRLF	
	CALL	FINISH
	RSTACK	
?ELS9:	EQUAL?	PRSO,RIVER-BED \?ELS13
	CALL	JIGS-UP,STR?65
	RSTACK	
?ELS13:	EQUAL?	PRSO,TURRET \?ELS15
	CALL	JIGS-UP,STR?66
	RSTACK	
?ELS15:	EQUAL?	PRSO,FROBAR-QUARTERS \?ELS17
	CALL	JIGS-UP,STR?67
	RSTACK	
?ELS17:	EQUAL?	PRSO,SERVANT-QUARTERS \?ELS19
	SET	'PERFORMING-SPELL,TRUE-VALUE
	CALL	PERFORM,V?AIMFIZ,ME
	RTRUE	
?ELS19:	CALL	V-SWANZO
	RSTACK	


	.FUNCT	V-AIMFIZ-TO
	EQUAL?	PRSO,ME /?ELS5
	PRINTR	"This spell only has an effect on the caster."
?ELS5:	PRINTI	"You should just say ""aimfiz "
	PRINTD	PRSI
	PRINTR	"""."


	.FUNCT	V-GASPAR
	ZERO?	PRSO \?CND1
	SET	'PERFORMING-SPELL,TRUE-VALUE
	CALL	PERFORM,V?GASPAR,ME
	RTRUE	
?CND1:	PRINTI	"How nice --"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" is now provided for in the event of "
	FSET?	PRSO,ACTORBIT \?ELS10
	PRINTI	"his"
	JUMP	?CND8
?ELS10:	PRINTI	"its"
?CND8:	PRINTR	" death."


	.FUNCT	V-GNUSTO,SCROLL
	IN?	SPELL-BOOK,PROTAGONIST /?ELS5
	PRINTR	"The spell quests around in your hands, looking for your spell book, and not finding it, fades reluctantly."
?ELS5:	FSET?	PRSO,SPELLBIT /?ELS9
	PRINTI	"You can't inscribe"
	CALL	ARTICLE,PRSO
	PRINTR	" in your spell book!"
?ELS9:	IN?	PRSO,SPELL-BOOK \?ELS15
	PRINTR	"You already have that spell inscribed in your book!"
?ELS15:	LOC	PRSO
	FSET?	STACK,MUNGBIT \?ELS19
	PRINTR	"The spell no longer readable."
?ELS19:	LOC	PRSO >SCROLL
	FSET?	SCROLL,SCROLLBIT \?ELS28
	CALL	HELD?,SCROLL
	ZERO?	STACK /?ELS28
	EQUAL?	PRSO,AIMFIZ-SPELL,YONK-SPELL \?ELS35
	PRINT	BOOK-GLOWS
	PRINTI	"In a spectacular effort of magic, the powers of the gnusto spell attempt to copy the "
	PRINTD	PRSO
	PRINTI	" into your book, but the spell is too long, too complicated, and too powerful. The glow fades, but fortunately the "
	PRINTD	SCROLL
	PRINTR	" remains intact."
?ELS35:	MOVE	SCROLL,DIAL
	MOVE	PRSO,SPELL-BOOK
	PUTP	PRSO,P?COUNT,0
	PRINT	BOOK-GLOWS
	PRINTI	"Slowly, ornately, the words of the "
	PRINTD	PRSO
	PRINTI	" are inscribed, glowing even more brightly than the book itself. The book's brightness fades, "
	FSET?	SPELL-BOOK,MUNGBIT \?ELS44
	PRINTI	"and the spell is now illegible in the damp, ruined book. T"
	JUMP	?CND42
?ELS44:	PRINTI	"but the spell remains! However, t"
?CND42:	PRINTR	"he scroll on which it was written vanishes as the last word is copied."
?ELS28:	PRINTR	"You must have a legible spell scroll in your hands before the gnusto spell will work on it."


	.FUNCT	V-FROTZ,OLIT
	SET	'OLIT,LIT
	FSET?	PRSO,ONBIT \?ELS5
	PRINTI	"Have you forgotten that you already frotzed"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	"?"
?ELS5:	FSET?	PRSO,TAKEBIT /?THN12
	FSET?	PRSO,ACTORBIT \?ELS11
?THN12:	FSET	PRSO,ONBIT
	EQUAL?	PRSO,BAT-GUANO,FWEEP-SCROLL /?CND14
	FSET	PRSO,TOUCHBIT
?CND14:	PRINTI	"There is an almost blinding flash of light as"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" begins to glow! It slowly fades to a less painful level, but"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" is now quite usable as a light source."
	EQUAL?	PRSO,PARK-GNOME /?THN26
	EQUAL?	PRSO,GNOME \?CND23
	ZERO?	GNOME-SLEEPING \?CND23
?THN26:	CALL	JIGS-UP,STR?69
	RTRUE	
?CND23:	CRLF	
	CALL	LIT?,HERE >LIT
	ZERO?	OLIT \TRUE
	ZERO?	LIT /TRUE
	CRLF	
	CALL	V-LOOK
	RTRUE	
?ELS11:	CALL	V-SWANZO
	RSTACK	


	.FUNCT	V-FWEEP,X,N
	ZERO?	PRSO /?THN6
	EQUAL?	PRSO,ME \?ELS5
?THN6:	ZERO?	RIDE-IN-PROGRESS /?ELS10
	CALL	FLY-DURING-RIDE
	RTRUE	
?ELS10:	EQUAL?	HERE,LAGOON,LAGOON-FLOOR \?CND8
	CALL	JIGS-UP,STR?70
	RTRUE	
?CND8:	SET	'FWEEPED,TRUE-VALUE
	SET	'FLYING,TRUE-VALUE
	CALL	QUEUE,I-UNFWEEP,15
	PUT	STACK,0,1
	CALL	INT,I-FLY
	PUT	STACK,0,0
	FIRST?	PROTAGONIST >X /?KLU37
?KLU37:	PRINTI	"With keen disappointment, you note that nothing has changed. Then, you slowly realize that you are black, have two wing-like appendages, and are flying a few feet above the ground."
	ZERO?	X /?CND16
	PRINTI	" Understandably, you dropped everything you were carrying."
?CND16:	EQUAL?	HERE,GLASS-MAZE \?CND22
	CALL	RADAR-VIEW
?CND22:	CRLF	
?PRG25:	ZERO?	X /TRUE
	NEXT?	X >N /?KLU38
?KLU38:	MOVE	X,HERE
	SET	'X,N
	JUMP	?PRG25
?ELS5:	PRINTR	"The fweep spell can be cast only on yourself."


	.FUNCT	V-IZYUK
	ZERO?	FLYING /?ELS5
	EQUAL?	PRSO,ME \?ELS5
	PRINTR	"You are already flying."
?ELS5:	ZERO?	PRSO /?THN12
	EQUAL?	PRSO,ME \?ELS11
?THN12:	ZERO?	RIDE-IN-PROGRESS /?CND14
	CALL	FLY-DURING-RIDE
	RTRUE	
?CND14:	EQUAL?	HERE,LAGOON-FLOOR \?CND18
	PRINTI	"Gloooop! "
?CND18:	PRINTI	"You are now floating serenely in midair."
	CRLF	
	EQUAL?	HERE,LAGOON-FLOOR \?CND25
	CALL	DO-WALK,P?UP
?CND25:	SET	'FLYING,TRUE-VALUE
	CALL	QUEUE,I-FLY,3
	PUT	STACK,0,1
	MOVE	PROTAGONIST,HERE
	RTRUE	
?ELS11:	EQUAL?	PRSO,FLAG \?ELS29
	CALL	V-FLY
	RSTACK	
?ELS29:	CALL	PERFORM,V?FLY,PRSO
	RTRUE	


	.FUNCT	FLY-DURING-RIDE
	PRINTI	"You fly out of the "
	EQUAL?	HERE,FLUME \?ELS5
	PRINTI	"log boat"
	JUMP	?CND3
?ELS5:	PRINTI	"car"
?CND3:	PRINTI	", and immediately splat into one of the structural cross-beams of the "
	EQUAL?	HERE,FLUME \?ELS16
	PRINTI	"flume"
	JUMP	?CND14
?ELS16:	PRINTI	"roller coaster"
?CND14:	CALL	JIGS-UP,STR?71
	RSTACK	


	.FUNCT	V-MALYON
	FSET?	PRSO,ACTORBIT \?ELS5
	PRINTI	"Wow! It looks like"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" is now alive! What a magician you are!"
?ELS5:	FSET?	PRSO,TAKEBIT \?ELS11
	PRINTI	"As you complete the spell,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" comes alive! It blinks, dances a little jig, and a moment later returns to normal."
?ELS11:	CALL	V-SWANZO
	RSTACK	


	.FUNCT	V-MEEF
	CALL	V-SWANZO
	RSTACK	


	.FUNCT	V-PULVER
	EQUAL?	PRSO,FOOBLE-POTION,FLAXO-POTION,BLORT-POTION /?THN6
	EQUAL?	PRSO,VILSTU-POTION,BERZIO-POTION \?ELS5
?THN6:	MOVE	PRSO,DIAL
	PRINTR	"The potion vanishes."
?ELS5:	PRINTI	"After completing the spell,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" remains unchanged. It must not be a liquid."


	.FUNCT	V-REZROV
	FSET?	PRSO,CONTBIT /?THN6
	FSET?	PRSO,DOORBIT \?ELS5
?THN6:	FSET?	PRSO,OPENBIT \?ELS12
	CALL	ALREADY-OPEN
	RSTACK	
?ELS12:	FSET?	PRSO,SCROLLBIT /?ELS14
	PRINTI	"Silently,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" swings open"
	FIRST?	PRSO \?CND19
	PRINTI	", revealing "
	CALL	PRINT-CONTENTS,PRSO
?CND19:	PRINTI	". Like swatting a fly with a sledge hammer, if you ask me."
	CRLF	
	FSET	PRSO,OPENBIT
	RTRUE	
?ELS14:	CALL	V-SWANZO
	RSTACK	
?ELS5:	CALL	V-SWANZO
	RSTACK	


	.FUNCT	V-SWANZO
	PRINTI	"Although you complete the spell, nothing seems to have happened"
	EQUAL?	PRSA,V?AIMFIZ \?CND3
	PRINTI	". Perhaps this spell only works on people"
?CND3:	PRINTR	"."


	.FUNCT	V-GOLMAC
	FSET?	PRSO,ACTORBIT \?ELS5
	EQUAL?	PRSO,BELBOZ,JEEARR /?ELS5
	MOVE	PRSO,DIAL
	PRINTI	"With a puff of smoke,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" vanishes!"
?ELS5:	PRINTI	"There is a puff of smoke, but when it clears"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" is still there."


	.FUNCT	V-VARDIK
	PRINTI	"The mind of"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	FSET?	PRSO,ACTORBIT /?CND3
	PRINTI	" (if it has one)"
?CND3:	PRINTR	" is now shielded against evil spirits."


	.FUNCT	V-VEZZA,VISION
	ZERO?	PRSO /?THN6
	EQUAL?	PRSO,ME \?ELS5
?THN6:	PRINTI	"You see "
?PRG10:	RANDOM	10
	GET	VEZZAS,STACK >VISION
	ZERO?	VISION /?PRG10
	PRINT	VISION
	PRINTR	" A moment later, the vision fades."
?ELS5:	PRINTI	"Thanks to you,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" is given a brilliant but momentary glimpse of "
	FSET?	PRSO,ACTORBIT \?ELS27
	PRINTI	"his"
	JUMP	?CND25
?ELS27:	PRINTI	"its"
?CND25:	PRINTR	" own future."


	.FUNCT	V-YOMIN
	PRINTI	"I'm afraid"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" doesn't have much of a mind for you to read."


	.FUNCT	V-YONK
	FSET?	PRSO,SPELLBIT /?ELS5
	PRINTR	"Nothing happens. I think this spell is meant to be cast on other spells..."
?ELS5:	PRINTI	"The words of the spell glow brightly for a moment."
	CRLF	
	EQUAL?	PRSO,MALYON-SPELL \FALSE
	SET	'MALYON-YONKED,TRUE-VALUE
	RETURN	MALYON-YONKED


	.FUNCT	ITAKE,VB=1,CNT,OBJ,?TMP1
	ZERO?	FWEEPED /?ELS5
	ZERO?	VB /FALSE
	CALL	BATTY
	RFALSE	
?ELS5:	FSET?	PRSO,TAKEBIT /?ELS12
	ZERO?	VB /FALSE
	CALL	PICK-ONE,YUKS
	PRINT	STACK
	CRLF	
	RFALSE	
?ELS12:	IN?	PRSO,YOUNGER-SELF \?ELS20
	EQUAL?	PRSO,SPELL-BOOK \?ELS20
	CALL	SPELL-BOOK-PASS-OFF-CHECK
	ZERO?	STACK /?ELS20
	RETURN	2
?ELS20:	IN?	PRSO,YOUNGER-SELF /?THN27
	IN?	PRSO,OLDER-SELF \?ELS26
?THN27:	PRINTI	"Your twin refuses to part with"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	"."
	CRLF	
	RETURN	2
?ELS26:	LOC	PRSO
	IN?	STACK,PROTAGONIST /?ELS36
	CALL	WEIGHT,PRSO >?TMP1
	CALL	WEIGHT,PROTAGONIST
	ADD	?TMP1,STACK
	GRTR?	STACK,LOAD-ALLOWED \?ELS36
	ZERO?	VB /?CND39
	FIRST?	PROTAGONIST \?ELS45
	PRINTI	"Your load is too heavy"
	JUMP	?CND43
?ELS45:	PRINTI	"It's a little too heavy"
?CND43:	LESS?	LOAD-ALLOWED,LOAD-MAX \?CND52
	PRINTI	", especially in light of your exhaustion"
?CND52:	PRINTI	"."
	CRLF	
?CND39:	RETURN	2
?ELS36:	CALL	CCOUNT,PROTAGONIST >CNT
	GRTR?	CNT,FUMBLE-NUMBER \?ELS62
	ZERO?	VB /?CND63
	PRINTI	"You're holding too many things already."
	CRLF	
?CND63:	RETURN	2
?ELS62:	MOVE	PRSO,PROTAGONIST
	CALL	SCORE-OBJECT
	FSET	PRSO,TOUCHBIT
	RTRUE	


	.FUNCT	SCORE-OBJECT
	EQUAL?	PRSO,SWANZO-SCROLL \?ELS5
	EQUAL?	HERE,STONE-HUT \?ELS5
	ADD	SCORE,SWANZO-POINT >SCORE
	SET	'SWANZO-POINT,0
	RETURN	SWANZO-POINT
?ELS5:	EQUAL?	PRSO,VARDIK-SCROLL \?ELS9
	FSET?	VARDIK-SCROLL,TOUCHBIT /?ELS9
	ADD	SCORE,25 >SCORE
	RETURN	SCORE
?ELS9:	EQUAL?	PRSO,VILSTU-VIAL \?ELS13
	FSET?	VILSTU-VIAL,TOUCHBIT /?ELS13
	ADD	SCORE,10 >SCORE
	RETURN	SCORE
?ELS13:	EQUAL?	PRSO,MEEF-SCROLL \?ELS17
	FSET?	MEEF-SCROLL,TOUCHBIT /?ELS17
	ADD	SCORE,10 >SCORE
	RETURN	SCORE
?ELS17:	EQUAL?	PRSO,YONK-SCROLL \FALSE
	FSET?	YONK-SCROLL,TOUCHBIT /FALSE
	ADD	SCORE,10 >SCORE
	RETURN	SCORE


	.FUNCT	IDROP
	EQUAL?	PRSO,HANDS \?ELS5
	CALL	V-LOCK
	RFALSE	
?ELS5:	IN?	PRSO,PROTAGONIST /?ELS7
	LOC	PRSO
	IN?	STACK,PROTAGONIST /?ELS7
	PRINTI	"You're not carrying"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	"."
	CRLF	
	RFALSE	
?ELS7:	IN?	PRSO,PROTAGONIST /?ELS15
	LOC	PRSO
	FSET?	STACK,OPENBIT /?ELS15
	PRINTI	"Impossible since"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTI	" is closed."
	CRLF	
	RFALSE	
?ELS15:	EQUAL?	HERE,TREE-BRANCH \?ELS23
	MOVE	PRSO,TWISTED-FOREST
	RTRUE	
?ELS23:	EQUAL?	HERE,LAGOON \?ELS25
	MOVE	PRSO,LAGOON-FLOOR
	RTRUE	
?ELS25:	EQUAL?	HERE,GLASS-MAZE \?ELS27
	CALL	NO-FLOOR?
	ZERO?	STACK /?ELS27
	CALL	DROP-IN-MAZE
	MOVE	PRSO,DIAL
	PRINTR	"It drops into the shimmering light below you. A moment later, you hear a gentle thud."
?ELS27:	LOC	PROTAGONIST
	MOVE	PRSO,STACK
	RTRUE	


	.FUNCT	CCOUNT,OBJ,CNT=0,X
	FIRST?	OBJ >X \?CND1
?PRG4:	FSET?	X,WEARBIT /?CND6
	INC	'CNT
?CND6:	NEXT?	X >X /?PRG4
?CND1:	RETURN	CNT


	.FUNCT	WEIGHT,OBJ,CONT,WT=0
	FIRST?	OBJ >CONT \?CND1
?PRG4:	EQUAL?	OBJ,PLAYER \?ELS8
	FSET?	CONT,WEARBIT \?ELS8
	INC	'WT
	JUMP	?CND6
?ELS8:	CALL	WEIGHT,CONT
	ADD	WT,STACK >WT
?CND6:	NEXT?	CONT >CONT /?PRG4
?CND1:	GETP	OBJ,P?SIZE
	ADD	WT,STACK
	RSTACK	


	.FUNCT	DESCRIBE-ROOM,LOOK?=0,V?,STR,AV
	ZERO?	LOOK? /?ORP4
	PUSH	LOOK?
	JUMP	?THN1
?ORP4:	PUSH	VERBOSE
?THN1:	POP	'V?
	ZERO?	LIT \?CND5
	ZERO?	BLORTED \?CND5
	PRINTI	"It is pitch black"
	ZERO?	FWEEPED /?CND12
	PRINTI	", and your bat sonar-sense isn't much help in this terrain"
?CND12:	PRINTI	"."
	EQUAL?	HERE,GRUE-LAIR \?ELS22
	PRINTI	" Gurgling noises come from every direction!"
	JUMP	?CND20
?ELS22:	ZERO?	SPRAYED? \?CND20
	PRINTI	" Dangerous creatures, such as grues, probably abound in the darkness."
?CND20:	CRLF	
	RETURN	FALSE-VALUE
?CND5:	FSET?	HERE,TOUCHBIT /?CND29
	FSET	HERE,TOUCHBIT
	SET	'V?,TRUE-VALUE
?CND29:	IN?	HERE,ROOMS \?CND32
	PRINTD	HERE
	ZERO?	FLYING /?CND37
	PRINTI	" (you are flying)"
?CND37:	LOC	PROTAGONIST
	FSET?	STACK,VEHBIT /?CND32
	CRLF	
?CND32:	ZERO?	LOOK? \?THN49
	ZERO?	SUPER-BRIEF /?THN49
	EQUAL?	HERE,GLASS-MAZE \TRUE
?THN49:	LOC	PROTAGONIST >AV
	FSET?	AV,VEHBIT \?CND51
	PRINTI	", in the "
	PRINTD	AV
	CRLF	
?CND51:	ZERO?	V? /?ELS58
	GETP	HERE,P?ACTION
	CALL	STACK,M-LOOK
	ZERO?	STACK \TRUE
?ELS58:	ZERO?	V? /?ELS62
	GETP	HERE,P?LDESC >STR
	ZERO?	STR /?ELS62
	PRINT	STR
	CRLF	
	JUMP	?CND56
?ELS62:	GETP	HERE,P?ACTION
	CALL	STACK,M-FLASH
?CND56:	EQUAL?	HERE,AV /TRUE
	FSET?	AV,VEHBIT \TRUE
	GETP	AV,P?ACTION
	CALL	STACK,M-LOOK
	RTRUE	


	.FUNCT	DESCRIBE-OBJECTS,V?=0
	ZERO?	LIT \?THN6
	ZERO?	BLORTED /?ELS5
?THN6:	FIRST?	HERE \FALSE
	ZERO?	V? /?ORP16
	PUSH	V?
	JUMP	?THN13
?ORP16:	PUSH	VERBOSE
?THN13:	POP	'V?
	CALL	PRINT-CONT,HERE,V?,-1
	RSTACK	
?ELS5:	CALL	TOO-DARK
	RSTACK	


	.FUNCT	DESCRIBE-OBJECT,OBJ,V?,LEVEL,STR=0,AV
	SET	'DESC-OBJECT,OBJ
	ZERO?	LEVEL \?ELS3
	GETP	OBJ,P?DESCFCN
	CALL	STACK,M-OBJDESC
	ZERO?	STACK \TRUE
?ELS3:	ZERO?	LEVEL \?ELS7
	FSET?	OBJ,TOUCHBIT /?ELS13
	GETP	OBJ,P?FDESC >STR
	ZERO?	STR \?THN10
?ELS13:	GETP	OBJ,P?LDESC >STR
	ZERO?	STR /?ELS7
?THN10:	PRINT	STR
	JUMP	?CND1
?ELS7:	ZERO?	LEVEL \?ELS17
	EQUAL?	OBJ,OLDER-SELF \?CND18
	ZERO?	OLDER-INTRODUCED /TRUE
?CND18:	PRINTI	"There is"
	CALL	ARTICLE,OBJ
	PRINTI	" here"
	CALL	PARANTHETICAL-NOTES,OBJ
	PRINTI	"."
	JUMP	?CND1
?ELS17:	GET	INDENTS,LEVEL
	PRINT	STACK
	CALL	SPACELESS-ARTICLE,OBJ
	CALL	PARANTHETICAL-NOTES,OBJ
?CND1:	ZERO?	LEVEL \?CND33
	LOC	PROTAGONIST >AV
	ZERO?	AV /?CND33
	FSET?	AV,VEHBIT \?CND33
	PRINTI	" (outside the "
	PRINTD	AV
	PRINTI	")"
?CND33:	CRLF	
	CALL	SEE-INSIDE?,OBJ
	ZERO?	STACK /FALSE
	FIRST?	OBJ \FALSE
	CALL	PRINT-CONT,OBJ,V?,LEVEL
	RSTACK	


	.FUNCT	PARANTHETICAL-NOTES,OBJ
	EQUAL?	OBJ,ROPE \?ELS5
	ZERO?	ROPE-TO-BEAM /?ELS5
	PRINTI	" (tied to the beam)"
	RTRUE	
?ELS5:	FSET?	OBJ,WEARBIT \?ELS11
	IN?	OBJ,PROTAGONIST \?ELS11
	PRINTI	" (being worn"
	FSET?	OBJ,ONBIT \?ELS20
	PRINTI	" and providing light)"
	RTRUE	
?ELS20:	PRINTI	")"
	RTRUE	
?ELS11:	FSET?	OBJ,ONBIT \FALSE
	PRINTI	" (providing light)"
	RTRUE	


	.FUNCT	PRINT-CONT,OBJ,V?=0,LEVEL=0,Y,1ST?,AV,STR,PV?=0,INV?=0
	FIRST?	OBJ >Y \TRUE
	LOC	PROTAGONIST
	FSET?	STACK,VEHBIT \?ELS6
	LOC	PROTAGONIST >AV
	JUMP	?CND4
?ELS6:	SET	'AV,FALSE-VALUE
?CND4:	SET	'1ST?,TRUE-VALUE
	LOC	OBJ
	EQUAL?	PROTAGONIST,OBJ,STACK \?ELS11
	SET	'INV?,TRUE-VALUE
	JUMP	?CND9
?ELS11:	
?PRG14:	ZERO?	Y \?ELS18
	JUMP	?CND9
?ELS18:	EQUAL?	Y,AV \?ELS20
	SET	'PV?,TRUE-VALUE
	JUMP	?CND16
?ELS20:	EQUAL?	Y,PROTAGONIST \?ELS22
	JUMP	?CND16
?ELS22:	FSET?	Y,INVISIBLE /?CND16
	FSET?	Y,TOUCHBIT /?CND16
	GETP	Y,P?FDESC >STR
	ZERO?	STR /?CND16
	FSET?	Y,NDESCBIT /?CND27
	PRINT	STR
	CRLF	
?CND27:	CALL	SEE-INSIDE?,Y
	ZERO?	STACK /?CND16
	LOC	Y
	GETP	STACK,P?DESCFCN
	ZERO?	STACK \?CND16
	FIRST?	Y \?CND16
	CALL	PRINT-CONT,Y,V?,0
?CND16:	NEXT?	Y >Y /?KLU74
?KLU74:	JUMP	?PRG14
?CND9:	FIRST?	OBJ >Y /?KLU75
?KLU75:	
?PRG37:	ZERO?	Y \?ELS41
	ZERO?	PV? /?CND42
	ZERO?	AV /?CND42
	FIRST?	AV \?CND42
	CALL	PRINT-CONT,AV,V?,LEVEL
?CND42:	ZERO?	1ST? \FALSE
	RTRUE	
?ELS41:	EQUAL?	Y,AV,PROTAGONIST \?ELS50
	JUMP	?CND39
?ELS50:	FSET?	Y,INVISIBLE /?CND39
	ZERO?	INV? \?THN55
	FSET?	Y,TOUCHBIT /?THN55
	GETP	Y,P?FDESC
	ZERO?	STACK \?CND39
?THN55:	FSET?	Y,NDESCBIT /?ELS59
	ZERO?	1ST? /?CND60
	CALL	FIRSTER,OBJ,LEVEL
	ZERO?	STACK /?CND64
	LESS?	LEVEL,0 \?CND64
	SET	'LEVEL,0
?CND64:	INC	'LEVEL
	SET	'1ST?,FALSE-VALUE
?CND60:	CALL	DESCRIBE-OBJECT,Y,V?,LEVEL
	JUMP	?CND39
?ELS59:	FIRST?	Y \?CND39
	CALL	SEE-INSIDE?,Y
	ZERO?	STACK /?CND39
	CALL	PRINT-CONT,Y,V?,LEVEL
?CND39:	NEXT?	Y >Y /?KLU76
?KLU76:	JUMP	?PRG37


	.FUNCT	PRINT-CONTENTS,OBJ,F,N,1ST?=1,IT?=0,TWO?=0
	FIRST?	OBJ >F \FALSE
?PRG6:	NEXT?	F >N /?KLU36
?KLU36:	ZERO?	1ST? /?ELS10
	SET	'1ST?,FALSE-VALUE
	JUMP	?CND8
?ELS10:	PRINTI	", "
	ZERO?	N \?CND8
	PRINTI	"and "
?CND8:	CALL	SPACELESS-ARTICLE,F
	ZERO?	IT? \?ELS23
	ZERO?	TWO? \?ELS23
	SET	'IT?,F
	JUMP	?CND21
?ELS23:	SET	'TWO?,TRUE-VALUE
	SET	'IT?,FALSE-VALUE
?CND21:	SET	'F,N
	ZERO?	F \?PRG6
	ZERO?	IT? /TRUE
	ZERO?	TWO? \TRUE
	CALL	THIS-IS-IT,IT?
	RTRUE	


	.FUNCT	FIRSTER,OBJ,LEVEL
	EQUAL?	OBJ,PROTAGONIST \?ELS5
	PRINTR	"You are carrying:"
?ELS5:	IN?	OBJ,ROOMS /FALSE
	GRTR?	LEVEL,0 \?CND10
	GET	INDENTS,LEVEL
	PRINT	STACK
?CND10:	FSET?	OBJ,SURFACEBIT \?ELS19
	PRINTI	"Sitting on the "
	PRINTD	OBJ
	PRINTR	" is:"
?ELS19:	FSET?	OBJ,ACTORBIT \?ELS23
	PRINTI	"It looks like"
	CALL	ARTICLE,OBJ,TRUE-VALUE
	PRINTR	" is holding:"
?ELS23:	PRINTI	"The "
	PRINTD	OBJ
	PRINTR	" contains:"


	.FUNCT	GOTO,RM,V?=1,OLIT,OHERE
	SET	'OHERE,HERE
	SET	'OLIT,LIT
	MOVE	PROTAGONIST,RM
	SET	'HERE,RM
	CALL	LIT?,HERE >LIT
	ZERO?	OLIT \?CND1
	ZERO?	LIT \?CND1
	ZERO?	SPRAYED? \?CND1
	ZERO?	RESURRECTING \?CND1
	EQUAL?	HERE,HAUNTED-HOUSE /?CND1
	IN?	GRUE-SUIT,PROTAGONIST /?CND1
	RANDOM	100
	LESS?	80,STACK /?CND1
	ZERO?	BLORTED /?ELS8
	CALL	JIGS-UP,STR?81
	RTRUE	
?ELS8:	CALL	JIGS-UP,STR?82
	RTRUE	
?CND1:	SET	'RESURRECTING,FALSE-VALUE
	CALL	ROPE-BEAM-CHECK,TRUE-VALUE
	GETP	HERE,P?ACTION
	CALL	STACK,M-ENTER
	EQUAL?	HERE,RM \TRUE
	ZERO?	V? /TRUE
	CALL	V-FIRST-LOOK
	RTRUE	


	.FUNCT	ROPE-BEAM-CHECK,PRINT=0
	CALL	HELD?,BEAM
	ZERO?	STACK /?ELS5
	CALL	HELD?,ROPE
	ZERO?	STACK \?ELS5
	ZERO?	ROPE-TO-BEAM /?ELS5
	MOVE	ROPE,PROTAGONIST
	SET	'ROPE-PLACED,FALSE-VALUE
	SET	'ROPE-IN-LOWER-CHUTE,FALSE-VALUE
	FCLEAR	BEAM,TRYTAKEBIT
	FCLEAR	ROPE,TRYTAKEBIT
	ZERO?	PRINT /FALSE
	PRINTR	"(taking the rope first)"
?ELS5:	CALL	HELD?,ROPE
	ZERO?	STACK /FALSE
	CALL	HELD?,BEAM
	ZERO?	STACK \FALSE
	ZERO?	ROPE-TO-BEAM /FALSE
	MOVE	BEAM,PROTAGONIST
	ZERO?	PRINT /FALSE
	PRINTR	"(taking the beam of wood first)"


	.FUNCT	JIGS-UP,DESC,STARVED=0
	ZERO?	DESC /?CND1
	PRINT	DESC
	CRLF	
?CND1:	CALL	FORGET-ALL
	CALL	KILL-INTERRUPTS
	ZERO?	SLEEPING /?ELS11
	CRLF	
	PRINTI	"...and a moment later you wake up in a cold sweat and realize you've been dreaming."
	CRLF	
	SET	'SLEEPING,FALSE-VALUE
	FCLEAR	TWISTED-FOREST,TOUCHBIT
	FCLEAR	TREE-BRANCH,TOUCHBIT
	FCLEAR	FOREST-EDGE,TOUCHBIT
	FCLEAR	MINE-FIELD,TOUCHBIT
	FCLEAR	SNAKE-PIT,TOUCHBIT
	FCLEAR	MEADOW,TOUCHBIT
	FCLEAR	RIVER-BANK,TOUCHBIT
	FCLEAR	FORT-ENTRANCE,TOUCHBIT
	FCLEAR	DRAWBRIDGE,TOUCHBIT
	FCLEAR	RUINS,TOUCHBIT
	CALL	QUEUE,I-PARROT,-1
	PUT	STACK,0,1
	CALL	QUEUE,I-MAILMAN,25
	PUT	STACK,0,1
	CALL	QUEUE,I-TIRED,80
	PUT	STACK,0,1
	CALL	QUEUE,I-HUNGER,21
	PUT	STACK,0,1
	CALL	QUEUE,I-THIRST,18
	PUT	STACK,0,1
	SET	'LAST-SLEPT,MOVES
	RANDOM	12 >CODE-NUMBER
	MUL	CODE-NUMBER,6 >CURRENT-TLOC
	GET	NEXT-CODE-TABLE,CURRENT-TLOC >NEXT-NUMBER
	ADD	SCORE,5 >SCORE
	MOVE	SPELL-BOOK,PROTAGONIST
	SET	'HERE,YOUR-QUARTERS
	MOVE	PROTAGONIST,BED
	CRLF	
	CALL	V-VERSION
	CRLF	
	SET	'PRSO,FALSE-VALUE
	SET	'LIT,FALSE-VALUE
	PRINTR	"Your frotz spell seems to have worn off during the night, and it is now pitch black."
?ELS11:	PRINTI	" 
    ****  You have died  ****

"
	ZERO?	RESURRECTION-ROOM /?ELS25
	IN?	SWANZO-SCROLL,PROTAGONIST \?CND27
	ZERO?	SWANZO-POINT /?CND27
	MOVE	SWANZO-SCROLL,HOLLOW
	FCLEAR	SWANZO-SCROLL,TOUCHBIT
?CND27:	CALL	ROPE-BEAM-CHECK
	CALL	RANDOMIZE-OBJECTS
	CALL	WEAR-OFF-SPELLS
	PRINTI	"Your guardian angel, draped in white, appears floating in the nothingness before you. ""Gotten in a bit of a scrape, eh?"" he asks, writing frantically in a notebook. ""I'd love to chat, but we're so busy this month."" "
	EQUAL?	RESURRECTION-ROOM,GLASS-MAZE \?ELS36
	PRINTI	"The angel looks pained. ""I hate resurrections in these stupid glass mazes! I can never tell one room from the next."" A moment later, you appear in the maze. Unfortunately, this is one of the floor-less rooms. This time, your demise is permanent."
	CRLF	
	CALL	FINISH
	JUMP	?CND34
?ELS36:	EQUAL?	RESURRECTION-ROOM,RIVER-BED,STAGNANT-POOL,TOP-OF-FALLS \?ELS40
	ZERO?	RIVER-EVAPORATED \?ELS40
	PRINTI	"A moment later you find yourself at the bottom of a river, between a whirpool, some sharp rocks, and a school of river sharks. This time, your death is terminal."
	CRLF	
	CALL	FINISH
	JUMP	?CND34
?ELS40:	CALL	IN-GUILD-HALL?,RESURRECTION-ROOM
	ZERO?	STACK /?ELS46
	FSET?	TWISTED-FOREST,TOUCHBIT \?ELS46
	PRINTI	"A look of consternation crosses the angel's face. ""According to the records, you're to be resurrected in your local Guild Hall. But that's quite far, and I've had a rough day. How about Egreth Castle instead, hmmm?"" Being disembodied, you find it difficult to object, and a moment later you are among the..."
	SET	'RESURRECTION-ROOM,RUINS
	JUMP	?CND34
?ELS46:	PRINTI	"The angel twitches his nose, and the nothingness is replaced by..."
?CND34:	CRLF	
	CRLF	
	SET	'RESURRECTING,TRUE-VALUE
	CALL	GOTO,RESURRECTION-ROOM
	EQUAL?	RESURRECTION-ROOM,HOLLOW \?CND55
	SET	'ROOM-NUMBER,24
	ZERO?	SPLATTERED \?CND55
	SET	'DORN-BEAST-WARNING,FALSE-VALUE
	SET	'DORN-BEAST-ROOM,0
	SET	'LAST-DORN-ROOM,0
	CALL	QUEUE,I-DORN-BEAST,2
	PUT	STACK,0,1
?CND55:	ZERO?	STARVED /?CND61
	PRINTI	"Unfortunately, you are still long overdue for a meal and immediately drop dead again."
	CRLF	
	CALL	FINISH
?CND61:	CALL	IN-COAL-MINE?
	ZERO?	STACK /?CND67
	CALL	QUEUE,I-SUFFOCATE,2
	PUT	STACK,0,1
	PRINTI	"The air here is almost unbreathable."
	CRLF	
?CND67:	SET	'RESURRECTION-ROOM,FALSE-VALUE
	SET	'P-CONT,FALSE-VALUE
	RETURN	2
?ELS25:	PRINTI	"Unfortunately, you made no provisions for your untimely death."
	CRLF	
	CALL	FINISH
	RSTACK	


	.FUNCT	RANDOMIZE-OBJECTS,F,N
	FIRST?	PROTAGONIST >F /?KLU17
?KLU17:	
?PRG1:	ZERO?	F /TRUE
	NEXT?	F >N /?KLU18
?KLU18:	FSET?	F,SCROLLBIT \?CND7
	EQUAL?	HERE,HAUNTED-HOUSE,COAL-BIN-ROOM,DIAL-ROOM \?ELS12
	MOVE	F,DIAL
	JUMP	?CND7
?ELS12:	MOVE	F,HERE
?CND7:	SET	'F,N
	JUMP	?PRG1


	.FUNCT	KILL-INTERRUPTS
	CALL	INT,I-WAKE-UP
	PUT	STACK,0,0
	CALL	INT,I-HELLHOUND
	PUT	STACK,0,0
	SET	'HELLHOUND-WARNING,FALSE-VALUE
	CALL	INT,I-BOA
	PUT	STACK,0,0
	SET	'BOA-WARNING,FALSE-VALUE
	CALL	INT,I-LOCUSTS
	PUT	STACK,0,0
	SET	'LOCUST-WARNING,0
	CALL	INT,I-SUFFOCATE
	PUT	STACK,0,0
	CALL	INT,I-FLUME-TRIP
	PUT	STACK,0,0
	CALL	END-RIDE
	SET	'ROOM-NUMBER,13
	SET	'DORN-BEAST-ROOM,0
	SET	'LAST-DORN-ROOM,0
	CALL	INT,I-DORN-BEAST
	PUT	STACK,0,0
	SET	'DORN-BEAST-WARNING,FALSE-VALUE
	FCLEAR	DORN-BEAST,NDESCBIT
	MOVE	DORN-BEAST,DIAL
	SET	'FWEEPED,FALSE-VALUE
	SET	'SUFFOCATE-WARNING,FALSE-VALUE
	CALL	INT,I-UNFWEEP
	PUT	STACK,0,0
	CALL	INT,I-BELBOZ-AWAKES
	PUT	STACK,0,0
	RTRUE	


	.FUNCT	THIS-IS-IT,OBJ
	SET	'P-IT-OBJECT,OBJ
	RETURN	P-IT-OBJECT


	.FUNCT	VISIBLE?,OBJ,L
	LOC	OBJ >L
	CALL	ACCESSIBLE?,OBJ
	ZERO?	STACK \TRUE
	CALL	SEE-INSIDE?,L
	ZERO?	STACK /FALSE
	CALL	VISIBLE?,L
	ZERO?	STACK /FALSE
	RTRUE	


	.FUNCT	OTHER-SIDE,DOBJ,P=0,TEE
?PRG1:	NEXTP	HERE,P >P
	LESS?	P,LOW-DIRECTION /FALSE
	GETPT	HERE,P >TEE
	PTSIZE	TEE
	EQUAL?	STACK,DEXIT \?PRG1
	GETB	TEE,DEXITOBJ
	EQUAL?	STACK,DOBJ \?PRG1
	RETURN	P


	.FUNCT	NOTHING-HELD?,X,N
	FIRST?	PROTAGONIST >X /?KLU12
?KLU12:	
?PRG1:	ZERO?	X /TRUE
	FSET?	X,WEARBIT \FALSE
	NEXT?	X >X /?KLU13
?KLU13:	JUMP	?PRG1


	.FUNCT	HELD?,OBJ
	ZERO?	OBJ /FALSE
	IN?	OBJ,PROTAGONIST /TRUE
	IN?	OBJ,ROOMS /FALSE
	IN?	OBJ,GLOBAL-OBJECTS /FALSE
	LOC	OBJ
	CALL	HELD?,STACK
	RSTACK	


	.FUNCT	SEE-INSIDE?,OBJ
	FSET?	OBJ,INVISIBLE /FALSE
	FSET?	OBJ,TRANSBIT /TRUE
	FSET?	OBJ,OPENBIT /TRUE
	RFALSE	


	.FUNCT	GLOBAL-IN?,OBJ1,OBJ2,TEE
	GETPT	OBJ2,P?GLOBAL >TEE
	ZERO?	TEE /FALSE
	PTSIZE	TEE
	SUB	STACK,1
	CALL	ZMEMQB,OBJ1,TEE,STACK
	RSTACK	


	.FUNCT	FIND-IN,WHERE,WHAT,W
	FIRST?	WHERE >W /?KLU11
?KLU11:	ZERO?	W /FALSE
?PRG4:	FSET?	W,WHAT \?ELS8
	RETURN	W
?ELS8:	NEXT?	W >W /?PRG4
	RFALSE	


	.FUNCT	DO-WALK,DIR
	SET	'P-WALK-DIR,DIR
	CALL	PERFORM,V?WALK,DIR
	RSTACK	


	.FUNCT	ROB,WHO,N,X
	FIRST?	WHO >X /?KLU6
?KLU6:	
?PRG1:	ZERO?	X /TRUE
	NEXT?	X >N /?KLU7
?KLU7:	MOVE	X,DIAL
	SET	'X,N
	JUMP	?PRG1


	.FUNCT	STOP
	SET	'P-CONT,FALSE-VALUE
	SET	'QUOTE-FLAG,FALSE-VALUE
	RETURN	2


	.FUNCT	HACK-HACK,STR
	PRINT	STR
	CALL	ARTICLE,PRSO,TRUE-VALUE
	CALL	PICK-ONE,HO-HUM
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	OPEN-CLOSE
	EQUAL?	PRSA,V?OPEN \?ELS5
	FSET?	PRSO,OPENBIT \?ELS5
	CALL	ALREADY-OPEN
	RTRUE	
?ELS5:	EQUAL?	PRSA,V?CLOSE \FALSE
	FSET?	PRSO,OPENBIT /FALSE
	CALL	ALREADY-CLOSED
	RTRUE	


	.FUNCT	SPACELESS-ARTICLE,OBJ,THE=0
	FSET?	OBJ,NARTICLEBIT \?ELS3
	JUMP	?CND1
?ELS3:	ZERO?	THE /?ELS5
	PRINTI	"the "
	JUMP	?CND1
?ELS5:	FSET?	OBJ,VOWELBIT \?ELS10
	PRINTI	"an "
	JUMP	?CND1
?ELS10:	PRINTI	"a "
?CND1:	PRINTD	OBJ
	RTRUE	


	.FUNCT	ARTICLE,OBJ,THE=0
	PRINTI	" "
	ZERO?	THE /?ELS7
	CALL	SPACELESS-ARTICLE,OBJ,TRUE-VALUE
	RSTACK	
?ELS7:	CALL	SPACELESS-ARTICLE,OBJ
	RSTACK	


	.FUNCT	CANT-ENTER,LOC,LEAVE=0
	PRINTI	"You can't "
	ZERO?	LEAVE /?ELS5
	PRINTI	"leave"
	JUMP	?CND3
?ELS5:	PRINTI	"enter"
?CND3:	CALL	ARTICLE,LOC,TRUE-VALUE
	PRINTR	" from here."


	.FUNCT	YOU-CANT-SEE-ANY,STRING
	PRINTI	"You can't see any "
	PRINT	STRING
	PRINTR	" here!"


	.FUNCT	WITH???
	PRINTI	"With"
	CALL	ARTICLE,PRSI
	PRINTR	"??!?"


	.FUNCT	TELL-ME-HOW
	PRINTI	"You must tell me how to do that to"
	CALL	ARTICLE,PRSO
	PRINTR	"."


	.FUNCT	NOT-GOING-ANYWHERE,VEHICLE
	PRINTI	"You're not going anywhere until you get out of the "
	PRINTD	VEHICLE
	PRINTR	"."


	.FUNCT	SPLASH
	PRINTI	"With a splash,"
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" plunges into the water."


	.FUNCT	BURIED-IN-COAL,STRING
	MOVE	PRSO,DIAL
	PRINTI	"When you "
	PRINT	STRING
	CALL	ARTICLE,PRSO,TRUE-VALUE
	PRINTR	" it falls between the lumps of coal and is buried."


	.FUNCT	LOOK-AROUND-YOU
	PRINTR	"Look around you."


	.FUNCT	BATTY
	PRINTR	"You're batty!"


	.FUNCT	TOO-DARK
	PRINTI	"It's too dark to see"
	ZERO?	FWEEPED /?ELS5
	PRINTI	", and your bat sonar-sense isn't of much help, either."
	JUMP	?CND3
?ELS5:	PRINTI	"!"
?CND3:	CRLF	
	RTRUE	


	.FUNCT	WHILE-FLYING
	PRINTR	"While flying?"


	.FUNCT	CANT-GO
	PRINTR	"You can't go that way."


	.FUNCT	NOW-BLACK
	PRINTR	"It is now pitch black."


	.FUNCT	ALREADY-OPEN
	PRINTR	"It is already open."


	.FUNCT	ALREADY-CLOSED
	PRINTR	"It is already closed."


	.FUNCT	MAKE-OUT
	PRINTR	"You can't make out anything."


	.FUNCT	BOOK-DAMP
	PRINTR	"The book is damp and the writing unreadable."


	.FUNCT	REFERRING
	PRINTR	"I don't see what you're referring to."


	.FUNCT	POOR-LISTENERS
	PRINTR	"Sleeping gnomes make poor listeners."


	.FUNCT	SETTLE-ONTO-BRANCH
	PRINTR	"You settle onto the branch."


	.FUNCT	SPLASH-INTO-WATER
	PRINTR	"You splash down into the water."

	.ENDI

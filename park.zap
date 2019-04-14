

	.FUNCT	BOZBARLAND-F
	EQUAL?	PRSA,V?THROUGH \?ELS5
	EQUAL?	HERE,PARK-ENTRANCE \?ELS10
	CALL	DO-WALK,P?WEST
	RSTACK	
?ELS10:	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?DROP,V?EXIT \?ELS14
	EQUAL?	HERE,EAST-END-OF-MIDWAY \?ELS19
	CALL	DO-WALK,P?EAST
	RSTACK	
?ELS19:	EQUAL?	HERE,PARK-ENTRANCE \?ELS21
	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS21:	CALL	CANT-ENTER,BOZBARLAND,TRUE-VALUE
	RSTACK	
?ELS14:	EQUAL?	PRSA,V?RESEARCH \FALSE
	PRINTR	"Bozbarland was a magical futuristic fantasy amusement park, oft referred to as the entertainment capital of the Great Underground Empire. The lower classes usually called it simply Zorky Park."


	.FUNCT	PARK-SIGN-PSEUDO
	EQUAL?	PRSA,V?READ \FALSE
	CALL	FIXED-FONT-ON
	PRINTI	"
$$$$$ WELCOME TO BOZBARLAND $$$$$
    The Entertainment Capital
          of the Empire"
	CRLF	
	CALL	FIXED-FONT-OFF
	RSTACK	


	.FUNCT	AMUSEMENT-PARK-ENTER-F
	ZERO?	PARK-FEE-PAID /?ELS5
	RETURN	EAST-END-OF-MIDWAY
?ELS5:	IN?	PARK-GNOME,HERE \?ELS8
	PRINTI	"As you bounce off the barrier, the gnome admonishes, ""Tsk, tsk ... you can't enter without paying your zorkmid!"""
	CRLF	
	RFALSE	
?ELS8:	MOVE	PARK-GNOME,HERE
	CALL	QUEUE,I-PARK-GNOME,6
	PUT	STACK,0,1
	PRINTI	"You bounce off an invisible barrier. A moment later a gnome appears, dressed in a gaudy plaid outfit. ""Admission to the park is only one zorkmid. What a bargain, chum, eh?"""
	CRLF	
	RFALSE	


	.FUNCT	I-PARK-GNOME
	MOVE	PARK-GNOME,DIAL
	EQUAL?	HERE,PARK-ENTRANCE \FALSE
	CRLF	
	PRINTR	"""Well, I can't wait all day, buddy,"" growls the gnome before vanishing."


	.FUNCT	PARK-GNOME-F
	EQUAL?	PRSA,V?TELL \?ELS5
	PRINTI	"""Listen, fella, I was in the middle of something important and I don't have time to gab. Gonna pay the admission fee, or not?"""
	CRLF	
	CALL	STOP
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?YOMIN \?ELS9
	PRINTR	"The gnome is thinking about the poker game you interrupted."
?ELS9:	EQUAL?	PRSA,V?GIVE \FALSE
	EQUAL?	PRSI,PARK-GNOME \FALSE
	EQUAL?	PRSO,ZORKMID \FALSE
	FSET?	ZORKMID,ONBIT \?CND16
	CALL	GNOME-REFUSES
	RTRUE	
?CND16:	MOVE	ZORKMID,DIAL
	MOVE	PARK-GNOME,DIAL
	SET	'PARK-FEE-PAID,TRUE-VALUE
	CALL	INT,I-PARK-GNOME
	PUT	STACK,0,0
	PRINTR	"""Okay, you can go through now, bub. Enjoy your trip to Bozbarland."" The gnome vanishes as suddenly as he appeared."


	.FUNCT	MIDWAY-PSEUDO
	EQUAL?	PRSA,V?THROUGH \?ELS5
	EQUAL?	HERE,FLUME,ARCADE \?ELS10
	CALL	DO-WALK,P?NORTH
	RSTACK	
?ELS10:	EQUAL?	HERE,ROLLER-COASTER,HAUNTED-HOUSE \?ELS12
	CALL	DO-WALK,P?SOUTH
	RSTACK	
?ELS12:	EQUAL?	HERE,CASINO \?ELS14
	CALL	DO-WALK,P?EAST
	RSTACK	
?ELS14:	CALL	LOOK-AROUND-YOU
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?EXIT,V?DROP \FALSE
	CALL	V-WALK-AROUND
	RSTACK	


	.FUNCT	EAST-END-OF-MIDWAY-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	PUT	VEZZAS,4,0
	RFALSE	


	.FUNCT	HAUNTED-HOUSE-F,RARG
	EQUAL?	RARG,M-LOOK \?ELS5
	ZERO?	LIT /?ELS8
	PRINTI	"Something about this place seems to soak up all light, so that it"
	JUMP	?CND6
?ELS8:	ZERO?	BLORTED /?ELS13
	PRINTI	"Despite the effects of the blort potion, this place "
	JUMP	?CND6
?ELS13:	PRINTI	"It"
?CND6:	PRINTR	" is quite dark. You can see vague shapes swaying about in the darkness."
?ELS5:	EQUAL?	RARG,M-ENTER \FALSE
	CALL	QUEUE,I-HAUNT,1
	PUT	STACK,0,1
	RFALSE	


	.FUNCT	I-HAUNT
	CALL	QUEUE,I-HAUNT,-1
	PUT	STACK,0,1
	EQUAL?	HERE,HAUNTED-HOUSE /?ELS5
	CALL	INT,I-HAUNT
	PUT	STACK,0,0
	RFALSE	
?ELS5:	RANDOM	100
	LESS?	65,STACK /FALSE
	CRLF	
	CALL	PICK-ONE,HAUNT-TABLE
	PRINT	STACK
	CRLF	
	RTRUE	


	.FUNCT	START-RIDE,LOC,X,N
	SET	'RIDE-IN-PROGRESS,TRUE-VALUE
	FIRST?	LOC >X /?KLU11
?KLU11:	
?PRG1:	NEXT?	X >N /?KLU12
?KLU12:	EQUAL?	X,PROTAGONIST,CAR,LOG-BOAT /?CND3
	FSET	X,INVISIBLE
?CND3:	ZERO?	N /TRUE
	SET	'X,N
	JUMP	?PRG1


	.FUNCT	END-RIDE,X,N
	SET	'RIDE-IN-PROGRESS,FALSE-VALUE
	SET	'RIDE-COUNTER,0
	CALL	INT,I-FLUME-TRIP
	PUT	STACK,0,0
	CALL	INT,I-ROLLER-COASTER-TRIP
	PUT	STACK,0,0
	FIRST?	FLUME >X /?KLU15
?KLU15:	
?PRG1:	NEXT?	X >N /?KLU16
?KLU16:	FCLEAR	X,INVISIBLE
	ZERO?	N \?ELS5
	JUMP	?REP2
?ELS5:	SET	'X,N
	JUMP	?PRG1
?REP2:	FIRST?	ROLLER-COASTER >X /?KLU17
?KLU17:	
?PRG8:	NEXT?	X >N /?KLU18
?KLU18:	FCLEAR	X,INVISIBLE
	ZERO?	N /TRUE
	SET	'X,N
	JUMP	?PRG8


	.FUNCT	SITS-AT-PLATFORM,VEHICLE
	PRINTI	" A "
	PRINTD	VEHICLE
	PRINTI	" sits at the platform, beckoning you to enter."
	RTRUE	


	.FUNCT	PARK-NYMPH,VEHICLE
	PRINTI	"An amusement park nymph appears for a moment, warning you not to leave the "
	PRINTD	VEHICLE
	PRINTR	" during the course of the ride."


	.FUNCT	PLAQUE
	PRINTI	" A small plaque hangs nearby. The midway is visible to the "
	RTRUE	


	.FUNCT	PLAQUE-PSEUDO
	EQUAL?	PRSA,V?EXAMINE,V?READ \FALSE
	PRINTI	"""Constructed by the Frobozz Magic "
	EQUAL?	HERE,FLUME \?ELS10
	PRINTI	"Flume"
	JUMP	?CND8
?ELS10:	PRINTI	"Roller Coaster"
?CND8:	PRINTR	" Company."""


	.FUNCT	FLUME-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	ZERO?	RIDE-IN-PROGRESS \TRUE
	PRINTI	"You are at the boarding platform of a fast-moving flume, flowing off beyond your view."
	CALL	PLAQUE
	PRINTI	"north."
	IN?	PROTAGONIST,LOG-BOAT /?CND18
	CALL	SITS-AT-PLATFORM,LOG-BOAT
?CND18:	CRLF	
	RTRUE	


	.FUNCT	FLUME-OBJECT-F
	EQUAL?	PRSA,V?PULVER \?ELS5
	PRINTR	"In order to prevent damage to public life and property, flumes are protected against this sort of prank."
?ELS5:	EQUAL?	PRSA,V?BOARD \?ELS9
	CALL	PERFORM,V?BOARD,LOG-BOAT
	RTRUE	
?ELS9:	EQUAL?	PRSA,V?RESEARCH \FALSE
	PRINTR	"Flumes are artifical water channels, usually with boat rides. The boat is typically a hollowed-out log. The largest flume of this kind is in Bozbarland."


	.FUNCT	LOG-BOAT-F,RARG=0
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	PRSA,V?WALK \?ELS5
	CALL	NOT-GOING-ANYWHERE,LOG-BOAT
	RSTACK	
?ELS5:	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS12
	PRINTR	"Huh?"
?ELS12:	EQUAL?	PRSA,V?CLIMB-ON,V?ENTER,V?THROUGH \?ELS16
	CALL	PERFORM,V?BOARD,PRSO
	RTRUE	
?ELS16:	EQUAL?	PRSA,V?STAND,V?DISEMBARK,V?DROP /?THN21
	EQUAL?	PRSA,V?EXIT \?ELS18
?THN21:	ZERO?	RIDE-IN-PROGRESS /?ELS18
	CALL	END-RIDE
	CALL	JIGS-UP,STR?266
	RSTACK	
?ELS18:	EQUAL?	PRSA,V?BOARD \FALSE
	ZERO?	RIDE-IN-PROGRESS \FALSE
	CALL	START-RIDE,FLUME
	MOVE	PROTAGONIST,LOG-BOAT
	CALL	QUEUE,I-FLUME-TRIP,2
	PUT	STACK,0,1
	PRINTI	"As you enter the log boat, it lurches away from the platform and is carried swiftly away by the current of the flume. "
	CALL	PARK-NYMPH,LOG-BOAT
	RSTACK	


	.FUNCT	I-FLUME-TRIP
	CALL	QUEUE,I-FLUME-TRIP,-1
	PUT	STACK,0,1
	INC	'RIDE-COUNTER
	ZERO?	RIDE-IN-PROGRESS \?CND1
	CALL	INT,I-FLUME-TRIP
	PUT	STACK,0,0
	SET	'RIDE-COUNTER,0
	RFALSE	
?CND1:	CRLF	
	EQUAL?	RIDE-COUNTER,1 \?ELS8
	PRINTR	"The flume is wide here, and straight as an arrow. The ride is quite relaxing."
?ELS8:	EQUAL?	RIDE-COUNTER,2 \?ELS12
	PRINTR	"You enter a stretch of sharp, winding curves! Spray dashes your face as you are tossed about the log boat!"
?ELS12:	EQUAL?	RIDE-COUNTER,3 \?ELS16
	PRINTR	"The twists and turns are left behind as you approach the mouth of a dark tunnel."
?ELS16:	EQUAL?	RIDE-COUNTER,4 \?ELS20
	ZERO?	LIT \?THN26
	ZERO?	BLORTED /?ELS25
?THN26:	PRINTR	"The flume winds through a tunnel whose walls are black as coal. You pass an opening which provides a brief glimpse of troglodytes digging and hauling coal."
?ELS25:	PRINTR	"It is pitch black. The roar of the flume's current echoes about the tunnel. A spot of light is visible ahead."
?ELS20:	EQUAL?	RIDE-COUNTER,5 \?ELS35
	PRINTR	"The log boat leaves the tunnel and passes through a series of rapids, shooting straight toward jagged rocks and then veering away at the last moment!"
?ELS35:	EQUAL?	RIDE-COUNTER,6 \?ELS39
	PRINTR	"Magically, the flume flows uphill here! The current slows as the boat climbs and climbs..."
?ELS39:	EQUAL?	RIDE-COUNTER,7 \?ELS43
	PRINTR	"You reach the crest of the flume's final drop. You can see swirling white water below!"
?ELS43:	EQUAL?	RIDE-COUNTER,8 \?ELS47
	PRINTR	"The log boat plunges down into the swirling waters at the base of the slope! Huge splashes of water spray off in every direction, but amazingly you stay dry!"
?ELS47:	EQUAL?	RIDE-COUNTER,9 \FALSE
	CALL	END-RIDE
	CALL	INT,I-FLUME-TRIP
	PUT	STACK,0,0
	PRINTR	"The boat floats serenely around a final turn and pulls up to the boarding platform."


	.FUNCT	ROLLER-COASTER-F,RARG
	EQUAL?	RARG,M-LOOK \FALSE
	ZERO?	RIDE-IN-PROGRESS \TRUE
	PRINTI	"You are at the boarding platform of a huge roller coaster, sprawling above and around you in every direction."
	CALL	PLAQUE
	PRINTI	"south."
	IN?	PROTAGONIST,CAR /?CND18
	CALL	SITS-AT-PLATFORM,CAR
?CND18:	CRLF	
	RTRUE	


	.FUNCT	CAR-F,RARG=0
	EQUAL?	RARG,M-BEG \?ELS5
	EQUAL?	PRSA,V?WALK \?ELS5
	CALL	NOT-GOING-ANYWHERE,CAR
	RSTACK	
?ELS5:	ZERO?	RARG \FALSE
	EQUAL?	PRSA,V?CLOSE,V?OPEN \?ELS12
	PRINTR	"Huh?"
?ELS12:	EQUAL?	PRSA,V?CLIMB-ON,V?ENTER,V?THROUGH \?ELS16
	CALL	PERFORM,V?BOARD,PRSO
	RTRUE	
?ELS16:	EQUAL?	PRSA,V?STAND,V?DISEMBARK,V?DROP /?THN21
	EQUAL?	PRSA,V?EXIT \?ELS18
?THN21:	ZERO?	RIDE-IN-PROGRESS /?ELS18
	CALL	END-RIDE
	CALL	JIGS-UP,STR?267
	RSTACK	
?ELS18:	EQUAL?	PRSA,V?EXIT,V?DROP \?ELS24
	CALL	PERFORM,V?DISEMBARK,PRSO
	RTRUE	
?ELS24:	EQUAL?	PRSA,V?BOARD \FALSE
	ZERO?	RIDE-IN-PROGRESS \FALSE
	CALL	START-RIDE,ROLLER-COASTER
	MOVE	PROTAGONIST,CAR
	CALL	QUEUE,I-ROLLER-COASTER-TRIP,2
	PUT	STACK,0,1
	PRINTI	"As you enter the car, it rolls away from the platform in a gentle curve. "
	CALL	PARK-NYMPH,CAR
	RSTACK	


	.FUNCT	I-ROLLER-COASTER-TRIP
	CALL	QUEUE,I-ROLLER-COASTER-TRIP,-1
	PUT	STACK,0,1
	INC	'RIDE-COUNTER
	ZERO?	RIDE-IN-PROGRESS \?CND1
	CALL	INT,I-ROLLER-COASTER-TRIP
	PUT	STACK,0,0
	CALL	END-RIDE
	RFALSE	
?CND1:	CRLF	
	EQUAL?	RIDE-COUNTER,1 \?ELS8
	PRINTR	"The car, propelled by some unseen force, rolls up a huge incline. The crest grows tantalizingly closer."
?ELS8:	EQUAL?	RIDE-COUNTER,2 \?ELS12
	PRINTR	"You reach the crest, the highest point of the roller coaster! The park is laid out beneath you like a map; the lights of the midway, the booths of the arcade, the sparkling blue ribbon of water that must be the flume. In the distance is a wide crater. The sounds and smells of the park seem distant, and time feels suspended for a moment."
?ELS12:	EQUAL?	RIDE-COUNTER,3 \?ELS16
	PRINTR	"The breath is swept from your lungs as the car begins diving, seemingly straight downward. You rise from the seat as the ground rushes closer! At the last moment, the car swings upward, and your stomach settles in your ankles."
?ELS16:	EQUAL?	RIDE-COUNTER,4 \?ELS20
	PRINTR	"The car zips through a series of wild turns and sharp drops. Wooden roller coaster supports whiz past, inches from your head!"
?ELS20:	EQUAL?	RIDE-COUNTER,5 \?ELS24
	PRINTR	"This section of track is shaped like a corkscrew, and as the car hurtles forward it turns upside down almost every second. It is impossible to tell up from down, as the ground seems to spin around you."
?ELS24:	EQUAL?	RIDE-COUNTER,6 \?ELS28
	PRINTR	"The car shoots into a rapid climb, which gets progressively slower and steeper. Your heart beats wildly as the track begins to swing back above you, and you realize that you are entering a giant loop!"
?ELS28:	EQUAL?	RIDE-COUNTER,7 \?ELS32
	PRINTR	"As you reach the highest point of the loop, you hang completely upside-down for a brief moment. The blood rushes to your head as the ground suspended ""above"" you like a canopy. Then, you hurtle down the far side of the loop with breakneck speed!"
?ELS32:	EQUAL?	RIDE-COUNTER,8 \?ELS36
	PRINTI	"The roller coaster speeds out of the loop and into a tunnel"
	ZERO?	LIT \?THN42
	ZERO?	BLORTED /?ELS41
?THN42:	PRINTI	", which seems to run through the middle of a haunted house! Wispy ghosts and ghoulish skeletons brush past you"
	JUMP	?CND39
?ELS41:	PRINTI	". You shiver as horrible slimy things brush across your face"
?CND39:	PRINTR	"."
?ELS36:	EQUAL?	RIDE-COUNTER,9 \FALSE
	CALL	END-RIDE
	CALL	INT,I-ROLLER-COASTER-TRIP
	PUT	STACK,0,0
	PRINTR	"The car zooms out into daylight, and glides to a stop at the boarding platform."


	.FUNCT	ARCADE-F,RARG
	EQUAL?	RARG,M-END \FALSE
	ZERO?	HAWKER-SUBDUED \FALSE
	IN?	BALL,HAWKER \FALSE
	PRINTR	"""C'mon, pal!"" cries the hawker from the game booth. ""Try your luck!"" He holds the ball out toward you."


	.FUNCT	ARCADE-EXIT-F
	CALL	HELD?,BALL
	ZERO?	STACK /?CND1
	PRINTI	"The hawker yells after you, ""Hey buddy, come back with that ball!"""
	CRLF	
	CRLF	
	RETURN	WEST-END-OF-MIDWAY
?CND1:	RETURN	WEST-END-OF-MIDWAY


	.FUNCT	BOOTH-PSEUDO
	EQUAL?	PRSA,V?THROUGH \FALSE
	PRINTR	"The hawker pushes you away."


	.FUNCT	HAWKER-F
	EQUAL?	HAWKER,WINNER \?ELS5
	EQUAL?	PRSO,BALL \?ELS10
	EQUAL?	PRSI,ME \?ELS10
	EQUAL?	PRSA,V?GIVE \?ELS10
	SET	'WINNER,PROTAGONIST
	CALL	PERFORM,V?TAKE,BALL
	RTRUE	
?ELS10:	PRINTI	"""No time to gab, kid."
	ZERO?	HAWKER-SUBDUED \?CND17
	PRINTI	" C'mon and give it a try. One hit wins!"
?CND17:	PRINTI	""""
	CRLF	
	CALL	STOP
	RSTACK	
?ELS5:	EQUAL?	PRSA,V?YOMIN \?ELS25
	PRINTR	"The hawker is thinking about finding a good stogie, whatever that is."
?ELS25:	EQUAL?	PRSA,V?AIMFIZ \FALSE
	CALL	JIGS-UP,STR?270
	RSTACK	


	.FUNCT	BALL-F
	EQUAL?	PRSA,V?TAKE \?ELS5
	FCLEAR	BALL,NDESCBIT
	FCLEAR	BALL,TRYTAKEBIT
	RFALSE	
?ELS5:	EQUAL?	PRSA,V?ATTACK \?ELS7
	EQUAL?	PRSO,RABBITS \?ELS7
	CALL	PERFORM,V?THROW,BALL,RABBITS
	RTRUE	
?ELS7:	EQUAL?	PRSA,V?THROW \FALSE
	EQUAL?	PRSI,RABBITS \FALSE
	CALL	HELD?,BALL
	ZERO?	STACK /FALSE
	ZERO?	FOOBLED /?ELS18
	MOVE	MALYON-SCROLL,PROTAGONIST
	ADD	SCORE,10 >SCORE
	SET	'HAWKER-SUBDUED,TRUE-VALUE
	MOVE	BALL,DIAL
	PRINTR	"A tremendous pitch sends a bunny spinning. ""What an arm, kid, what an arm!"" cries the hawker. He hands you a glittering scroll from the shelf of prizes. ""Here's your prize, now scram."""
?ELS18:	MOVE	BALL,HAWKER
	FSET	BALL,NDESCBIT
	FSET	BALL,TRYTAKEBIT
	CALL	PICK-ONE,MISSES
	PRINT	STACK
	PRINTR	" This game is harder than it looks. The hawker, leering, retrieves the ball."


	.FUNCT	RABBITS-F
	EQUAL?	PRSA,V?MALYON \FALSE
	PRINTR	"The bunnies hop away and the startled hawker scrambles after them. He returns a moment later, holding the again inanimate bunnies, and gives you a nasty glare."


	.FUNCT	CASINO-F,RARG
	EQUAL?	RARG,M-ENTER \FALSE
	ZERO?	JACKPOT-DUMPED /FALSE
	SET	'JACKPOT-DUMPED,FALSE-VALUE
	PRINTI	"You enter just as a group of casino nymphs finish cleaning up the last of the zorkmid coins."
	CRLF	
	CRLF	
	RTRUE	


	.FUNCT	LEVER-PSEUDO,A,B,C
	EQUAL?	PRSA,V?PUSH,V?MOVE \FALSE
	ZERO?	FWEEPED /?ELS10
	CALL	BATTY
	RSTACK	
?ELS10:	ZERO?	SLOT-MACHINE-BROKEN /?ELS13
	PRINTR	"The machine rattles loudly and makes a few feeble pings."
?ELS13:	RANDOM	100
	LESS?	25,STACK /?ELS21
	GET	SLOT-MACHINE-TABLE,1 >A
	JUMP	?CND19
?ELS21:	RANDOM	100
	LESS?	33,STACK /?ELS23
	GET	SLOT-MACHINE-TABLE,2 >A
	JUMP	?CND19
?ELS23:	RANDOM	100
	LESS?	50,STACK /?ELS25
	GET	SLOT-MACHINE-TABLE,3 >A
	JUMP	?CND19
?ELS25:	GET	SLOT-MACHINE-TABLE,4 >A
?CND19:	RANDOM	100
	LESS?	25,STACK /?ELS30
	GET	SLOT-MACHINE-TABLE,1 >B
	JUMP	?CND28
?ELS30:	RANDOM	100
	LESS?	33,STACK /?ELS32
	GET	SLOT-MACHINE-TABLE,2 >B
	JUMP	?CND28
?ELS32:	RANDOM	100
	LESS?	50,STACK /?ELS34
	GET	SLOT-MACHINE-TABLE,3 >B
	JUMP	?CND28
?ELS34:	GET	SLOT-MACHINE-TABLE,4 >B
?CND28:	RANDOM	100
	LESS?	25,STACK /?ELS39
	GET	SLOT-MACHINE-TABLE,1 >C
	JUMP	?CND37
?ELS39:	RANDOM	100
	LESS?	33,STACK /?ELS41
	GET	SLOT-MACHINE-TABLE,2 >C
	JUMP	?CND37
?ELS41:	RANDOM	100
	LESS?	50,STACK /?ELS43
	GET	SLOT-MACHINE-TABLE,3 >C
	JUMP	?CND37
?ELS43:	GET	SLOT-MACHINE-TABLE,4 >C
?CND37:	PRINTI	"Ping!
A "
	PRINT	A
	PRINTI	" appears in the first section of the display.
Ping!
A "
	PRINT	B
	PRINTI	" appears in the second section of the display.
Ping!
A "
	PRINT	C
	PRINTI	" appears in the third section of the display."
	CRLF	
	EQUAL?	A,B \TRUE
	EQUAL?	A,C \TRUE
	GET	SLOT-MACHINE-TABLE,1
	EQUAL?	A,STACK \?ELS59
	SET	'JACKPOT-DUMPED,TRUE-VALUE
	CALL	JIGS-UP,STR?277
	RSTACK	
?ELS59:	MOVE	ZORKMID,HERE
	SET	'SLOT-MACHINE-BROKEN,TRUE-VALUE
	PRINTR	"Ping! Ping! Ping!
A zorkmid coin drops out of the machine and lands at your feet."

	.ENDI

"PARK.ZIL for
				SORCERER
	(c) Copyright 1984  Infocom, Inc.  All Rights Reserved"

<OBJECT BOZBARLAND
	(IN LOCAL-GLOBALS)
	(DESC "amusement park")
	(SYNONYM PARK BOZBAR)
	(ADJECTIVE AMUSEM ZORKY)
	(FLAGS NDESCBIT VOWELBIT)
	(ACTION BOZBARLAND-F)>

<ROUTINE BOZBARLAND-F ()
	 <COND (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,PARK-ENTRANCE>
		       <DO-WALK ,P?WEST>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? EXIT DROP>
		<COND (<EQUAL? ,HERE ,EAST-END-OF-MIDWAY>
		       <DO-WALK ,P?EAST>)
		      (<EQUAL? ,HERE ,PARK-ENTRANCE>
		       <LOOK-AROUND-YOU>)
		      (T
		       <CANT-ENTER ,BOZBARLAND T>)>)
	       (<VERB? RESEARCH>
		<TELL
"Bozbarland was a magical futuristic fantasy amusement park, oft referred
to as the entertainment capital of the Great Underground Empire. The lower
classes usually called it simply Zorky Park." CR>)>>

<ROOM PARK-ENTRANCE
      (IN ROOMS)
      (DESC "Park Entrance")
      (LDESC
"This looks like the entrance to a run-down amusement park, no longer
gaudy with lights and glitter. A sign above the entrance proclaims
\"Welcome to Bozbarland - The Entertainment Capital of the Empire.\"
The park lies to the west and a tunnel leads northeast.")
      (NE TO WINDING-TUNNEL)
      (WEST PER AMUSEMENT-PARK-ENTER-F)
      (FLAGS INSIDEBIT RLANDBIT)
      (GLOBAL BOZBARLAND)
      (PSEUDO "SIGN" PARK-SIGN-PSEUDO)>

<ROUTINE PARK-SIGN-PSEUDO ()
	 <COND (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL "|
$$$$$ WELCOME TO BOZBARLAND $$$$$|
    The Entertainment Capital|
          of the Empire" CR>
		<FIXED-FONT-OFF>)>>

<ROUTINE AMUSEMENT-PARK-ENTER-F ()
	 <COND (,PARK-FEE-PAID
		,EAST-END-OF-MIDWAY)
	       (<IN? ,PARK-GNOME ,HERE>
		<TELL
"As you bounce off the barrier, the gnome admonishes, \"Tsk, tsk ... you
can't enter without paying your zorkmid!\"" CR>
		<RFALSE>)
	       (T
		<MOVE ,PARK-GNOME ,HERE>
		<ENABLE <QUEUE I-PARK-GNOME 6>>
		<TELL
"You bounce off an invisible barrier. A moment later a gnome appears,
dressed in a gaudy plaid outfit. \"Admission to the park is only one
zorkmid. What a bargain, chum, eh?\"" CR>
		<RFALSE>)>>

<ROUTINE I-PARK-GNOME ()
	 <MOVE ,PARK-GNOME ,DIAL>
	 <COND (<EQUAL? ,HERE ,PARK-ENTRANCE>
		<TELL CR
"\"Well, I can't wait all day, buddy,\" growls the gnome before
vanishing." CR>)>>

<OBJECT PARK-GNOME
	(IN DIAL)
	(DESC "gnome")
	(LDESC
"A gnome, dressed in flashy attire, stands here looking impatient.")
	(SYNONYM GNOME)
	(FLAGS ACTORBIT)
	(ACTION PARK-GNOME-F)>

<GLOBAL PARK-FEE-PAID <>>

<ROUTINE PARK-GNOME-F ()
	 <COND (<VERB? TELL>
		<TELL
"\"Listen, fella, I was in the middle of something important and I don't
have time to gab. Gonna pay the admission fee, or not?\"" CR>
		<STOP>)
	       (<VERB? YOMIN>
		<TELL
"The gnome is thinking about the poker game you interrupted." CR>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSI ,PARK-GNOME>
		     <EQUAL? ,PRSO ,ZORKMID>>
		<COND (<FSET? ,ZORKMID ,ONBIT>
		       <GNOME-REFUSES>
		       <RTRUE>)>
		<MOVE ,ZORKMID ,DIAL>
		<MOVE ,PARK-GNOME ,DIAL>
		<SETG PARK-FEE-PAID T>
		<DISABLE <INT I-PARK-GNOME>>
		<TELL
"\"Okay, you can go through now, bub. Enjoy your trip to
Bozbarland.\" The gnome vanishes as suddenly as he appeared." CR>)>>

<ROUTINE MIDWAY-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,FLUME ,ARCADE>
		       <DO-WALK ,P?NORTH>)
		      (<EQUAL? ,HERE ,ROLLER-COASTER ,HAUNTED-HOUSE>
		       <DO-WALK ,P?SOUTH>)
		      (<EQUAL? ,HERE ,CASINO>
		       <DO-WALK ,P?EAST>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? DROP EXIT>
		<V-WALK-AROUND>)>>

<ROOM EAST-END-OF-MIDWAY
      (IN ROOMS)
      (DESC "East End of Midway")
      (LDESC
"You are at the eastern end of a long midway. The park entrance lies
to the east, and rides lie to the north and south.")
      (NORTH TO HAUNTED-HOUSE)
      (SOUTH TO FLUME)
      (WEST TO WEST-END-OF-MIDWAY)
      (EAST TO PARK-ENTRANCE)
      (FLAGS RLANDBIT ONBIT INSIDEBIT)
      (GLOBAL BOZBARLAND)
      (PSEUDO "MIDWAY" MIDWAY-PSEUDO)
      (ACTION EAST-END-OF-MIDWAY-F)>

<ROUTINE EAST-END-OF-MIDWAY-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<PUT ,VEZZAS 4 0>
		<RFALSE>)>>

<ROOM WEST-END-OF-MIDWAY
      (IN ROOMS)
      (DESC "West End of Midway")
      (LDESC
"Entrances lead north, west and south, and the rest of the
midway lies to the east.")
      (WEST TO CASINO)
      (SOUTH TO ARCADE)
      (NORTH TO ROLLER-COASTER)
      (EAST TO EAST-END-OF-MIDWAY)
      (FLAGS RLANDBIT ONBIT INSIDEBIT)
      (GLOBAL BOZBARLAND)
      (PSEUDO "MIDWAY" MIDWAY-PSEUDO)>

<ROOM HAUNTED-HOUSE
      (IN ROOMS)
      (DESC "Haunted House")
      (SOUTH TO EAST-END-OF-MIDWAY)
      (NORTH TO HAUNTED-HOUSE)
      (EAST TO HAUNTED-HOUSE)
      (WEST TO HAUNTED-HOUSE)
      (NE TO HAUNTED-HOUSE)
      (NW TO HAUNTED-HOUSE)
      (SE TO HAUNTED-HOUSE)
      (SW TO HAUNTED-HOUSE)
      (UP TO HAUNTED-HOUSE)
      (DOWN TO HAUNTED-HOUSE)
      (FLAGS INSIDEBIT RLANDBIT)
      (GLOBAL BOZBARLAND)
      (PSEUDO "MIDWAY" MIDWAY-PSEUDO)
      (ACTION HAUNTED-HOUSE-F)>

<ROUTINE HAUNTED-HOUSE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,LIT
		       <TELL
"Something about this place seems to soak up all light, so that it">)
		      (,BLORTED
		       <TELL
"Despite the effects of the blort potion, this place ">)
	              (T
		       <TELL "It">)>
		<TELL
" is quite dark. You can see vague shapes swaying about in the darkness." CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<ENABLE <QUEUE I-HAUNT 1>>
		<RFALSE>)>>

<ROUTINE I-HAUNT ()
	 <ENABLE <QUEUE I-HAUNT -1>>
	 <COND (<NOT <EQUAL? ,HERE ,HAUNTED-HOUSE>>
		<DISABLE <INT I-HAUNT>>
		<RFALSE>)
	       (<PROB 65>
	        <TELL CR <PICK-ONE ,HAUNT-TABLE> CR>)
	       (T
		<RFALSE>)>>

<GLOBAL HAUNT-TABLE
	<PLTABLE
	 "You feel a cold breath on your shoulder. You whirl around,
but there is nothing there."
	 "Something slimy brushes across your face."
	 "An unseen door creaks slowly open."
	 "Something slithers across your foot."
	 "You feel a strange shiver in your chest, almost as though
something had passed through your body."
	 "From several directions comes a sound like rattling chains."
	 "A long silence is suddenly broken by a piercing scream!"
	 "A glowing apparition sails by, briefly illuminating
a spiral staircase and wooden balcony."
	 "A deep-throated chuckle echoes about the room."
	 "A roller coaster car zooms past, almost knocking you over!">>

<GLOBAL RIDE-IN-PROGRESS <>>

<GLOBAL RIDE-COUNTER 0>

<ROUTINE START-RIDE (LOC "AUX" X N)
	 <SETG RIDE-IN-PROGRESS T>
	 <SET X <FIRST? .LOC>>
	 <REPEAT ()
		 <SET N <NEXT? .X>>
		 <COND (<NOT <EQUAL? .X ,PROTAGONIST ,CAR ,LOG-BOAT>>
			<FSET .X ,INVISIBLE>)>
		 <COND (<NOT .N>
			<RETURN>)
		       (T
			<SET X .N>)>>>

<ROUTINE END-RIDE ("AUX" X N)
	 <SETG RIDE-IN-PROGRESS <>>
	 <SETG RIDE-COUNTER 0>
	 <DISABLE <INT I-FLUME-TRIP>>
	 <DISABLE <INT I-ROLLER-COASTER-TRIP>>
	 <SET X <FIRST? ,FLUME>>
	 <REPEAT ()
		 <SET N <NEXT? .X>>
		 <FCLEAR .X ,INVISIBLE>
		 <COND (<NOT .N>
			<RETURN>)
		       (T
			<SET X .N>)>>
	 <SET X <FIRST? ,ROLLER-COASTER>>
	 <REPEAT ()
		 <SET N <NEXT? .X>>
		 <FCLEAR .X ,INVISIBLE>
		 <COND (<NOT .N>
			<RETURN>)
		       (T
			<SET X .N>)>>>

<ROUTINE SITS-AT-PLATFORM (VEHICLE)
	 <TELL " A " D .VEHICLE " sits at the platform, beckoning
you to enter.">>

<ROUTINE PARK-NYMPH (VEHICLE)
	 <TELL "An amusement park nymph appears for a moment, warning
you not to leave the " D .VEHICLE " during the course of the ride." CR>>

<ROUTINE PLAQUE ()
	 <TELL
" A small plaque hangs nearby. The midway is visible to the ">>

<ROUTINE PLAQUE-PSEUDO ()
	 <COND (<VERB? READ EXAMINE>
		<TELL "\"Constructed by the Frobozz Magic ">
		<COND (<EQUAL? ,HERE ,FLUME>
		       <TELL "Flume">)
		      (T
		       <TELL "Roller Coaster">)>
		<TELL " Company.\"" CR>)>>

<ROOM FLUME
      (IN ROOMS)
      (DESC "Flume")
      (NORTH TO EAST-END-OF-MIDWAY)
      (FLAGS RLANDBIT ONBIT INSIDEBIT)
      (GLOBAL WATER BOZBARLAND)
      (PSEUDO "MIDWAY" MIDWAY-PSEUDO "PLAQUE" PLAQUE-PSEUDO)
      (ACTION FLUME-F)>

<ROUTINE FLUME-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,RIDE-IN-PROGRESS
		       <RTRUE>)
		      (T
		       <TELL
"You are at the boarding platform of a fast-moving flume, flowing
off beyond your view.">
		       <PLAQUE>
		       <TELL "north.">
		       <COND (<NOT <IN? ,PROTAGONIST ,LOG-BOAT>>
			      <SITS-AT-PLATFORM ,LOG-BOAT>)>
		       <CRLF>)>)>>

<OBJECT FLUME-OBJECT
	(IN FLUME)
	(DESC "flume")
	(SYNONYM FLUME FLUMES)
	(FLAGS NDESCBIT)
	(ACTION FLUME-OBJECT-F)>

<ROUTINE FLUME-OBJECT-F ()
	 <COND (<VERB? PULVER>
		<TELL
"In order to prevent damage to public life and property, flumes are
protected against this sort of prank." CR>)
	       (<VERB? BOARD>
		<PERFORM ,V?BOARD ,LOG-BOAT>
		<RTRUE>)
	       (<VERB? RESEARCH>
		<TELL
"Flumes are artifical water channels, usually with boat rides. The
boat is typically a hollowed-out log. The largest flume of this kind
is in Bozbarland." CR>)>>

<OBJECT LOG-BOAT
	(IN FLUME)
	(DESC "log boat")
	(SYNONYM BOAT)
	(ADJECTIVE LOG)
	(FLAGS VEHBIT OPENBIT CONTBIT SEARCHBIT NDESCBIT)
	(ACTION LOG-BOAT-F)>

<ROUTINE LOG-BOAT-F ("OPTIONAL" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK>>
		<NOT-GOING-ANYWHERE ,LOG-BOAT>)
	       (.RARG
		<RFALSE>)
	       (<VERB? OPEN CLOSE>
		<TELL "Huh?" CR>)
	       (<VERB? THROUGH ENTER CLIMB-ON>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<AND <VERB? DROP DISEMBARK STAND EXIT>
		     ,RIDE-IN-PROGRESS>
		<END-RIDE>
		<JIGS-UP
"Bad time to leave the log boat. The flume is fast and rough.">)
	       (<AND <VERB? BOARD>
		     <NOT ,RIDE-IN-PROGRESS>>
		<START-RIDE ,FLUME>
		<MOVE ,PROTAGONIST ,LOG-BOAT>
		<ENABLE <QUEUE I-FLUME-TRIP 2>>
		<TELL
"As you enter the log boat, it lurches away from the platform and is
carried swiftly away by the current of the flume. ">
		<PARK-NYMPH ,LOG-BOAT>)>>

<ROUTINE I-FLUME-TRIP ()
	 <ENABLE <QUEUE I-FLUME-TRIP -1>>
	 <SETG RIDE-COUNTER <+ ,RIDE-COUNTER 1>>
	 <COND (<NOT ,RIDE-IN-PROGRESS>
		<DISABLE <INT I-FLUME-TRIP>>
		<SETG RIDE-COUNTER 0>
		<RFALSE>)>
	 <CRLF>
	 <COND (<EQUAL? ,RIDE-COUNTER 1>
		<TELL
"The flume is wide here, and straight as an arrow.
The ride is quite relaxing." CR>)
	       (<EQUAL? ,RIDE-COUNTER 2>
		<TELL
"You enter a stretch of sharp, winding curves! Spray dashes your face as you
are tossed about the log boat!" CR>)
	       (<EQUAL? ,RIDE-COUNTER 3>
		<TELL
"The twists and turns are left behind as you approach the
mouth of a dark tunnel." CR>)
	       (<EQUAL? ,RIDE-COUNTER 4>
		<COND (<OR ,LIT ,BLORTED>
		       <TELL
"The flume winds through a tunnel whose walls are black as coal.
You pass an opening which provides a brief glimpse of troglodytes
digging and hauling coal." CR>)
		      (T
		       <TELL
"It is pitch black. The roar of the flume's current echoes about the tunnel.
A spot of light is visible ahead." CR>)>)
	       (<EQUAL? ,RIDE-COUNTER 5>
		<TELL
"The log boat leaves the tunnel and passes through a series of rapids, shooting
straight toward jagged rocks and then veering away at the last moment!" CR>)
	       (<EQUAL? ,RIDE-COUNTER 6>
		<TELL
"Magically, the flume flows uphill here! The current slows as the boat
climbs and climbs..." CR>)
	       (<EQUAL? ,RIDE-COUNTER 7>
		<TELL
"You reach the crest of the flume's final drop. You can see swirling
white water below!" CR>)
	       (<EQUAL? ,RIDE-COUNTER 8>
		<TELL
"The log boat plunges down into the swirling waters at the base of
the slope! Huge splashes of water spray off in every direction, but
amazingly you stay dry!" CR>)
	       (<EQUAL? ,RIDE-COUNTER 9>
		<END-RIDE>
		<DISABLE <INT I-FLUME-TRIP>>
		<TELL
"The boat floats serenely around a final turn and pulls up to the boarding
platform." CR>)>> 

<ROOM ROLLER-COASTER
      (IN ROOMS)
      (DESC "Roller Coaster")
      (SOUTH TO WEST-END-OF-MIDWAY)
      (FLAGS RLANDBIT ONBIT INSIDEBIT)
      (GLOBAL BOZBARLAND)
      (PSEUDO "MIDWAY" MIDWAY-PSEUDO "PLAQUE" PLAQUE-PSEUDO)
      (ACTION ROLLER-COASTER-F)>

<ROUTINE ROLLER-COASTER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<COND (,RIDE-IN-PROGRESS
		       <RTRUE>)
		      (T
		       <TELL
"You are at the boarding platform of a huge roller coaster, sprawling
above and around you in every direction.">
		       <PLAQUE>
		       <TELL "south.">
		       <COND (<NOT <IN? ,PROTAGONIST ,CAR>>
			      <SITS-AT-PLATFORM ,CAR>)>
		       <CRLF>)>)>>

<OBJECT CAR
	(IN ROLLER-COASTER)
	(DESC "car")
	(SYNONYM CAR)
	(FLAGS VEHBIT CONTBIT OPENBIT SEARCHBIT NDESCBIT)
	(ACTION CAR-F)>

<ROUTINE CAR-F ("OPTIONAL" (RARG <>))
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <VERB? WALK>>
		<NOT-GOING-ANYWHERE ,CAR>)
	       (.RARG
		<RFALSE>)
	       (<VERB? OPEN CLOSE>
		<TELL "Huh?" CR>)
	       (<VERB? THROUGH ENTER CLIMB-ON>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (<AND <VERB? DROP DISEMBARK STAND EXIT>
		     ,RIDE-IN-PROGRESS>
		<END-RIDE>
		<JIGS-UP
"Dumb idea. Your body ricochets off several wooden supports as it
plummets to the ground.">)
	       (<VERB? DROP EXIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (<AND <VERB? BOARD>
		     <NOT ,RIDE-IN-PROGRESS>>
		<START-RIDE ,ROLLER-COASTER>
		<MOVE ,PROTAGONIST ,CAR>
		<ENABLE <QUEUE I-ROLLER-COASTER-TRIP 2>>
		<TELL
"As you enter the car, it rolls away from the platform in a gentle curve. ">
		<PARK-NYMPH ,CAR>)>>

<ROUTINE I-ROLLER-COASTER-TRIP ()
	 <ENABLE <QUEUE I-ROLLER-COASTER-TRIP -1>>
	 <SETG RIDE-COUNTER <+ ,RIDE-COUNTER 1>>
	 <COND (<NOT ,RIDE-IN-PROGRESS>
		<DISABLE <INT I-ROLLER-COASTER-TRIP>>
		<END-RIDE>
		<RFALSE>)>
	 <CRLF>
	 <COND (<EQUAL? ,RIDE-COUNTER 1>
		<TELL
"The car, propelled by some unseen force, rolls up a huge incline. The
crest grows tantalizingly closer." CR>)
	       (<EQUAL? ,RIDE-COUNTER 2>
		<TELL
"You reach the crest, the highest point of the roller coaster! The park
is laid out beneath you like a map; the lights of the midway, the
booths of the arcade, the sparkling blue ribbon of water that must be
the flume. In the distance is a wide crater. The sounds and smells of
the park seem distant, and time feels suspended for a moment." CR>)
	       (<EQUAL? ,RIDE-COUNTER 3>
		<TELL
"The breath is swept from your lungs as the car begins diving,
seemingly straight downward. You rise from the seat as the ground
rushes closer! At the last moment, the car swings upward, and your
stomach settles in your ankles." CR>)
	       (<EQUAL? ,RIDE-COUNTER 4>
		<TELL
"The car zips through a series of wild turns and sharp drops. Wooden
roller coaster supports whiz past, inches from your head!" CR>)
	       (<EQUAL? ,RIDE-COUNTER 5>
		<TELL
"This section of track is shaped like a corkscrew, and as the car hurtles
forward it turns upside down almost every second. It is impossible to tell
up from down, as the ground seems to spin around you." CR>)
	       (<EQUAL? ,RIDE-COUNTER 6>
		<TELL
"The car shoots into a rapid climb, which gets progressively slower and
steeper. Your heart beats wildly as the track begins to swing back above you,
and you realize that you are entering a giant loop!" CR>)
	       (<EQUAL? ,RIDE-COUNTER 7>
		<TELL
"As you reach the highest point of the loop, you hang completely upside-down
for a brief moment. The blood rushes to your head as the ground suspended
\"above\" you like a canopy. Then, you hurtle down the far side of the loop
with breakneck speed!" CR>)
	       (<EQUAL? ,RIDE-COUNTER 8>
		<TELL
"The roller coaster speeds out of the loop and into a tunnel">
		<COND (<OR ,LIT ,BLORTED>
		       <TELL
", which seems to run through the middle of a haunted house! Wispy ghosts and
ghoulish skeletons brush past you">)
		      (T
		       <TELL
". You shiver as horrible slimy things brush across your face">)>
		<TELL "." CR>)
	       (<EQUAL? ,RIDE-COUNTER 9>
		<END-RIDE>
		<DISABLE <INT I-ROLLER-COASTER-TRIP>>
		<TELL
"The car zooms out into daylight, and glides to a stop at the
boarding platform." CR>)>>

<ROOM ARCADE
      (IN ROOMS)
      (DESC "Arcade")
      (LDESC
"This is a huge tent filled with hectic noise, blinking lights, and the
smell of frying food. Near the exit is a game booth lined with prizes.
The concept of the game seems to be bashing cute little mechanical bunnies
with a rubber ball as they hop around a little artificial meadow.")
      (NORTH PER ARCADE-EXIT-F)
      (FLAGS RLANDBIT ONBIT INSIDEBIT)
      (GLOBAL BOZBARLAND)
      (PSEUDO "MIDWAY" MIDWAY-PSEUDO "BOOTH" BOOTH-PSEUDO)
      (ACTION ARCADE-F)>

<GLOBAL HAWKER-SUBDUED <>>

<ROUTINE ARCADE-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <NOT ,HAWKER-SUBDUED>
		     <IN? ,BALL ,HAWKER>>
		<TELL
"\"C'mon, pal!\" cries the hawker from the game booth. \"Try your luck!\"
He holds the ball out toward you." CR>)>>

<ROUTINE ARCADE-EXIT-F ()
	 <COND (<HELD? ,BALL>
		<TELL
"The hawker yells after you, \"Hey buddy, come back with that ball!\"" CR CR>)>
	 ,WEST-END-OF-MIDWAY>

<ROUTINE BOOTH-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<TELL "The hawker pushes you away." CR>)>>

<OBJECT HAWKER
	(IN ARCADE)
	(DESC "hawker")
	(LDESC
"A hawker stands within the booth, studying you through half-closed eyes.")
	(SYNONYM HAWKER)
	(FLAGS ACTORBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION HAWKER-F)>

<ROUTINE HAWKER-F ()
	 <COND (<EQUAL? ,HAWKER ,WINNER>
		<COND (<AND <EQUAL? ,PRSO ,BALL>
			    <EQUAL? ,PRSI ,ME>
			    <VERB? GIVE>>
		       <SETG WINNER ,PROTAGONIST>
		       <PERFORM ,V?TAKE ,BALL>
		       <RTRUE>)
		      (T
		       <TELL "\"No time to gab, kid.">
		       <COND (<NOT ,HAWKER-SUBDUED>
			      <TELL
" C'mon and give it a try. One hit wins!">)>
		       <TELL "\"" CR>
		       <STOP>)>)
	       (<VERB? YOMIN>
		<TELL
"The hawker is thinking about finding a good stogie, whatever that is." CR>)
	       (<VERB? AIMFIZ>
		<JIGS-UP
"You appear in an amusement park game booth. The point of the game is to
pierce balloons with darts. Speaking of points, you are suddenly pierced
by 37 flying darts.">)>>

<OBJECT BALL
	 (IN HAWKER)
	 (DESC "rubber ball")
	 (SYNONYM BALL)
	 (ADJECTIVE RUBBER)
	 (FLAGS TAKEBIT NDESCBIT TRYTAKEBIT)
	 (ACTION BALL-F)>

<ROUTINE BALL-F ()
	 <COND (<VERB? TAKE>
		<FCLEAR ,BALL ,NDESCBIT>
		<FCLEAR ,BALL ,TRYTAKEBIT>
		<RFALSE>)
	       (<AND <VERB? ATTACK>
		     <EQUAL? ,PRSO ,RABBITS>>
		<PERFORM ,V?THROW ,BALL ,RABBITS>
		<RTRUE>)
	       (<AND <VERB? THROW>
		     <EQUAL? ,PRSI ,RABBITS>
		     <HELD? ,BALL>>
		<COND (,FOOBLED
		       <MOVE ,MALYON-SCROLL ,PROTAGONIST>
		       <SETG SCORE <+ ,SCORE 10>>
		       <SETG HAWKER-SUBDUED T>
		       <MOVE ,BALL ,DIAL>
		       <TELL
"A tremendous pitch sends a bunny spinning. \"What an arm, kid, what an
arm!\" cries the hawker. He hands you a glittering scroll from the shelf
of prizes. \"Here's your prize, now scram.\"" CR>)
		      (T
		       <MOVE ,BALL ,HAWKER>
		       <FSET ,BALL ,NDESCBIT>
		       <FSET ,BALL ,TRYTAKEBIT>
		       <TELL <PICK-ONE ,MISSES> " This game is harder
than it looks. The hawker, leering, retrieves the ball." CR>)>)>>

<GLOBAL MISSES
	<PLTABLE
	 "You miss the rabbit by a mile!"
	 "Your throw is way off!"
	 "The rabbit hops obliviously as your throw sails far off target!">>

<OBJECT RABBITS
	(IN ARCADE)
	(DESC "hopping bunny")
	(SYNONYM BUNNY BUNNIE RABBIT)
	(ADJECTIVE HOPPIN CUTE MECHAN)
	(FLAGS NDESCBIT)
	(ACTION RABBITS-F)>

<ROUTINE RABBITS-F ()
	 <COND (<VERB? MALYON>
		<TELL
"The bunnies hop away and the startled hawker scrambles after them. He
returns a moment later, holding the again inanimate bunnies, and gives
you a nasty glare." CR>)>>

<OBJECT MALYON-SCROLL
	(IN DIAL)
	(DESC "glittering scroll")
	(SYNONYM SCROLL)
	(ADJECTIVE GLITTE)
	(FLAGS READBIT SCROLLBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>	

<OBJECT MALYON-SPELL
	(IN MALYON-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE MALYON)
	(DESC "malyon spell")
	(TEXT "bring life to inanimate objects")
	(COUNT 0)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT TOUCHBIT)
	(ACTION SPELL-F)>

<ROOM CASINO
      (IN ROOMS)
      (DESC "Casino")
      (LDESC
"This is a large, plush room, slightly neglected.")
      (EAST TO WEST-END-OF-MIDWAY)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL BOZBARLAND)
      (PSEUDO "LEVER" LEVER-PSEUDO "MIDWAY" MIDWAY-PSEUDO)
      (ACTION CASINO-F)>

<ROUTINE CASINO-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     ,JACKPOT-DUMPED>
		<SETG JACKPOT-DUMPED <>>
		<TELL
"You enter just as a group of casino nymphs finish cleaning up the last
of the zorkmid coins." CR CR>)>>

<OBJECT SLOT-MACHINE
	(IN CASINO)
	(DESC "odd machine")
	(LDESC
"Standing on one side of the room is an odd machine, with a
three-section display and a large lever on the side.")
	(SYNONYM MACHIN BANDIT DISPLA)
	(ADJECTIVE ODD ONE- ARMED THREE SECTIO)
	(FLAGS VOWELBIT)>

<GLOBAL JACKPOT-DUMPED <>>

<GLOBAL SLOT-MACHINE-BROKEN <>>

<ROUTINE LEVER-PSEUDO ("AUX" A B C)
	 <COND (<VERB? MOVE PUSH>
		<COND (,FWEEPED
		       <BATTY>)
		      (,SLOT-MACHINE-BROKEN
		       <TELL
"The machine rattles loudly and makes a few feeble pings." CR>)
		      (T
		       <COND (<PROB 25>
			      <SET A <GET ,SLOT-MACHINE-TABLE 1>>)
			     (<PROB 33>
			      <SET A <GET ,SLOT-MACHINE-TABLE 2>>)
			     (<PROB 50>
			      <SET A <GET ,SLOT-MACHINE-TABLE 3>>)
			     (T
			      <SET A <GET ,SLOT-MACHINE-TABLE 4>>)>
		       <COND (<PROB 25>
			      <SET B <GET ,SLOT-MACHINE-TABLE 1>>)
			     (<PROB 33>
			      <SET B <GET ,SLOT-MACHINE-TABLE 2>>)
			     (<PROB 50>
			      <SET B <GET ,SLOT-MACHINE-TABLE 3>>)
			     (T
			      <SET B <GET ,SLOT-MACHINE-TABLE 4>>)>
		       <COND (<PROB 25>
			      <SET C <GET ,SLOT-MACHINE-TABLE 1>>)
			     (<PROB 33>
			      <SET C <GET ,SLOT-MACHINE-TABLE 2>>)
			     (<PROB 50>
			      <SET C <GET ,SLOT-MACHINE-TABLE 3>>)
			     (T
			      <SET C <GET ,SLOT-MACHINE-TABLE 4>>)>
		       <TELL
"Ping!|
A " .A " appears in the first section of the display.|
Ping!|
A " .B " appears in the second section of the display.|
Ping!|
A " .C " appears in the third section of the display." CR>
		       <COND (<AND <EQUAL? .A .B>
				   <EQUAL? .A .C>>
			      <COND (<EQUAL? .A <GET ,SLOT-MACHINE-TABLE 1>>
				     <SETG JACKPOT-DUMPED T>
				     <JIGS-UP
"Ping! Ping! Ping! Ping! Ping! Ping!|
An unbelievable torrent of zorkmid coins pours out of the machine -- far
more than the machine could possibly contain! You are buried and crushed
under the huge mass of coins.">)
				    (T
				     <MOVE ,ZORKMID ,HERE>
				     <SETG SLOT-MACHINE-BROKEN T>
				     <TELL
"Ping! Ping! Ping!|
A zorkmid coin drops out of the machine and lands at your feet." CR>)>)
			     (T
			      <RTRUE>)>)>)>>

<GLOBAL SLOT-MACHINE-TABLE
	<PTABLE
	 0
	 "pot of gold"
	 "clove of garlic"
	 "noisome stew"
	 "hot pepper sandwich">>
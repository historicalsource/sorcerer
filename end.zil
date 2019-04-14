"END for
			    SORCERER
       (c) Copyright 1984 by Infocom, Inc.  All Rights Reserved"

<ROOM COVE
      (IN ROOMS)
      (DESC "Lagoon Shore")
      (LDESC
"This is a narrow beach between a small cove to the east and tall
cliffs to the west. The shore curves to the southeast and northeast.
A metal chute leads up into the cliff.")
      (NORTH "There's a tall cliff there.")
      (NE TO OCEAN-NORTH)
      (EAST TO LAGOON)
      (SE TO OCEAN-SOUTH)
      (SOUTH "There's a tall cliff there.")
      (SW "There's a tall cliff there.")
      (WEST "There's a tall cliff there.")
      (NW "There's a tall cliff there.")
      (IN TO LAGOON)
      (UP PER CHUTE-ENTER-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL LOWER-CHUTE LAGOON-OBJECT WATER BEACH)
      (PSEUDO "CLIFF" CLIFF-PSEUDO "CLIFFS" CLIFF-PSEUDO)
      (ACTION COVE-F)> 

<GLOBAL POOFED <>>

<ROUTINE COVE-F (RARG "AUX" (X <>))
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,COVE ,TOUCHBIT>>>
		<COND (,BOOK-BELONGS-IN-LAGOON
		       <MOVE ,SPELL-BOOK ,LAGOON-FLOOR>)>
		<PUT ,VEZZAS 6 0>
		<SETG SCORE <+ ,SCORE 20>>
		<DISABLE <INT I-SUFFOCATE>>
		<DISABLE <INT I-YOUNGER-SELF>>
		<DISABLE <INT I-OLDER-SELF>>
		<COND (<AND ,GOLMACKED
			    <NOT ,COMBO-REVEALED>>		       
		       <POOF>)
		      (<NOT ,GOLMACKED>
		       <COND (<HELD? ,ROPE>
			      <MOVE ,ROPE ,DIAL>
			      <SET X T>)>
		       <COND (<HELD? ,BEAM>
			      <MOVE ,BEAM ,DIAL>
			      <SET X T>)>
		       <COND (<HELD? ,VARDIK-SCROLL>
			      <MOVE ,VARDIK-SCROLL ,DIAL>
			      <SET X T>)>
		       <COND (<HELD? ,GOLMAC-SCROLL>
			      <MOVE ,GOLMAC-SCROLL ,DIAL>
			      <SET X T>)>
		       <COND (.X
			      <TELL
"As you slide down the chute, some of your possessions suddenly vanish! ">)>)>
		<TELL
"You fly out of the chute and land just at the edge of some water..." CR CR>)>>

<ROUTINE POOF ()
	 <SETG POOFED T>
	 <TELL
"Suddenly, without the slightest fanfare, you cease to exist!" CR>
	 <FINISH>>

<ROOM OCEAN-NORTH
      (IN ROOMS)
      (SYNONYM DAM FCD)
      (ADJECTIVE FLOOD CONTRO)
      (DESC "Ocean Shore North")
      (NORTH TO MOUTH-OF-RIVER)
      (NE "Entering the ocean is certain death.")
      (EAST "Entering the ocean is certain death.")
      (SE "Entering the ocean is certain death.")
      (SOUTH TO LAGOON)
      (SW TO COVE)
      (WEST "There's a tall cliff there.")
      (NW "There's a tall cliff there.")
      (IN TO LAGOON)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "CLIFF" CLIFF-PSEUDO "CLIFFS" CLIFF-PSEUDO)
      (GLOBAL LAGOON-OBJECT OCEAN BEACH WATER)
      (ACTION OCEAN-SHORE-F)>

<ROOM OCEAN-SOUTH
      (IN ROOMS)
      (SYNONYM MUSEUM)
      (ADJECTIVE ROYAL)
      (DESC "Ocean Shore South")
      (NORTH TO LAGOON)
      (NE "Entering the ocean is certain death.")
      (EAST "Entering the ocean is certain death.")
      (SE "Entering the ocean is certain death.")
      (SOUTH "There's a tall cliff there.")
      (SW "There's a tall cliff there.")
      (WEST "There's a tall cliff there.")
      (NW TO COVE)
      (IN TO LAGOON)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "CLIFF" CLIFF-PSEUDO "CLIFFS" CLIFF-PSEUDO)
      (GLOBAL LAGOON-OBJECT OCEAN WATER BEACH)
      (ACTION OCEAN-SHORE-F)>

<ROUTINE OCEAN-SHORE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are ">
		<COND (,FLYING
		       <TELL "floating above">)
		      (T
		       <TELL "standing on">)>
		<TELL
" the western shore of the mighty Flathead Ocean. According to legends
you read at the University, the eastern shore of this ocean is a strange
land of magical beings and priceless treasures. ">
		<COND (<EQUAL? ,HERE ,OCEAN-NORTH>
		       <TELL
"You could go north along the shore; the edge of a small cove lies to
the southwest.">)
		      (T
		       <TELL
"The beach to the south is blocked by a tall cliff; a lagoon shore
lies to the northwest.">)>
		<CRLF>)>>

<OBJECT BEACH
	(IN LOCAL-GLOBALS)
	(DESC "beach")
	(SYNONYM BEACH SHORE SAND)
	(ADJECTIVE CURVED SANDY NARROW)
	(FLAGS NDESCBIT)>

<OBJECT OCEAN
	(IN LOCAL-GLOBALS)
	(DESC "ocean")
	(SYNONYM OCEAN WATERS)
        (ADJECTIVE MIGHTY FLATHE TURBUL)
	(FLAGS VOWELBIT NDESCBIT)
	(ACTION OCEAN-F)>

<ROUTINE OCEAN-F ("AUX" (X 0))
	 <COND (<EQUAL? ,HERE ,GUN-EMPLACEMENT ,TURRET ,TOP-OF-FALLS>
		<TELL "The ocean lies far below you." CR>)
	       (<VERB? PULVER>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,V?PULVER ,LAGOON-OBJECT>
		<RTRUE>)
	       (<VERB? DRINK DRINK-FROM>
		<PERFORM ,V?DRINK ,WATER>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL "It streches east as far as the eye can see." CR>)
	       (<VERB? RESEARCH>
		<TELL
"The Flathead Ocean, called the Great Sea by the ancients, has a very
unusual feature -- its western shore basks in the sunlight while its
eastern shore lies far underground." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,OCEAN ,PRSI>>
		<MOVE ,PRSO ,DIAL>
		<SPLASH>)
	       (<VERB? THROUGH>
		<JIGS-UP "Certain death.">)>>

<ROUTINE CLIFF-PSEUDO ()
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<COND (,FLYING
		       <TELL "The cliff is too high to fly over." CR>)
		      (T
		       <TELL "The cliff is unclimbable." CR>)>)>>

<OBJECT LAGOON-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "lagoon")
	(SYNONYM LAGOON INLET COVE)
	(ADJECTIVE SMALL CALM)
	(FLAGS NDESCBIT)
	(ACTION LAGOON-OBJECT-F)>

<ROUTINE LAGOON-OBJECT-F ()
	 <COND (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,LAGOON ,LAGOON-FLOOR>
		       <LOOK-AROUND-YOU>)
		      (T
		       <GOTO ,LAGOON>)>)
	       (<AND <VERB? PUT>
		     <NOT <EQUAL? ,HERE ,LAGOON-FLOOR>>
		     <EQUAL? ,PRSI ,LAGOON-OBJECT>>
		<MOVE ,PRSO ,LAGOON-FLOOR>
		<COND (<OR <FSET? ,PRSO ,SCROLLBIT>
			   <EQUAL? ,PRSO ,SPELL-BOOK>>
		       <FSET ,PRSO ,MUNGBIT>)>
		<SPLASH>)
	       (<VERB? EXAMINE>
		<TELL "The water looks calm and hospitable." CR>)
	       (<VERB? DRINK DRINK-FROM>
		<PERFORM ,V?DRINK ,WATER>
		<RTRUE>)
	       (<VERB? PULVER>
		<TELL
"The water level seems to drop an inch or two, for a moment." CR>)>>

<ROOM LAGOON
      (IN ROOMS)
      (DESC "Surface of Lagoon")
      (NORTH TO OCEAN-NORTH)
      (OUT TO COVE)
      (NW TO COVE)
      (WEST TO COVE)
      (SW TO COVE)
      (SOUTH TO OCEAN-SOUTH)
      (SE "Entering the ocean is certain death.")
      (EAST "Entering the ocean is certain death.")
      (NE "Entering the ocean is certain death.")
      (DOWN PER LAGOON-FLOOR-ENTER-F)
      (FLAGS ONBIT)
      (GLOBAL LAGOON-OBJECT OCEAN WATER)
      (PSEUDO "SAND" SAND-PSEUDO)
      (ACTION LAGOON-F)>

<ROUTINE LAGOON-F (RARG "AUX" X)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<SET X <FIRST? ,PROTAGONIST>>
		<REPEAT ()
		        <COND (.X
			       <COND (<OR <FSET? .X ,SCROLLBIT>
					  <EQUAL? .X ,SPELL-BOOK>>
				      <FSET .X ,MUNGBIT>)>
			       <SET X <NEXT? .X>>)
		              (T
			       <RETURN>)>>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are ">
		<COND (,FLYING
		       <TELL "flying over">)
		      (T
		       <TELL "swimming on">)>
		<TELL
" the surface of a calm lagoon, whose sandy floor is visible below.
A curved beach surrounds this inlet on its western side." CR>)>>

<ROUTINE LAGOON-FLOOR-ENTER-F ()
	 <COND (,FLYING
		<WHILE-FLYING>
		<RFALSE>)
	       (T
		,LAGOON-FLOOR)>>

<ROUTINE SAND-PSEUDO ()
	 <COND (<EQUAL? ,PSEUDO-OBJECT ,PRSO>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,GROUND ,PRSI>
		<RTRUE>)
	       (T
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,PRSO ,GROUND>
		<RTRUE>)>>  

<ROOM LAGOON-FLOOR
      (IN ROOMS)
      (DESC "Lagoon Floor")
      (LDESC
"This is the floor of a cove off the turbulent ocean to the east.
The ground slopes upward to the north, west, and south. Light filters
down from the surface of the water.")
      (NORTH TO OCEAN-NORTH)
      (NW TO COVE)
      (WEST TO COVE)
      (SW TO COVE)
      (SOUTH TO OCEAN-SOUTH)
      (SE "Entering the ocean is certain death.")
      (EAST "Entering the ocean is certain death.")
      (NE "Entering the ocean is certain death.")
      (UP TO LAGOON)
      (FLAGS ONBIT)
      (GLOBAL LAGOON-OBJECT OCEAN WATER)
      (PSEUDO "CORAL" CORAL-PSEUDO "SAND" SAND-PSEUDO)
      (ACTION LAGOON-FLOOR-F)>

<GLOBAL UNDERWATER-COUNTER 0>

<ROUTINE LAGOON-FLOOR-F (RARG)
      <COND (<EQUAL? .RARG ,M-ENTER>
	     <ENABLE <QUEUE I-DROWN -1>>
	     <RFALSE>)>>

<ROUTINE I-DROWN ()
	 <COND (<EQUAL? ,HERE ,LAGOON-FLOOR>
		<COND (,VILSTUED
		       <RFALSE>)>
		<SETG UNDERWATER-COUNTER <+ ,UNDERWATER-COUNTER 1>>
	        <COND (<EQUAL? ,UNDERWATER-COUNTER 3>
		       <TELL CR
"You won't be able to hold your breath much longer." CR>)
		      (<EQUAL? ,UNDERWATER-COUNTER 4>
		       <TELL CR "Better get some fresh air soon!" CR>)
		      (<EQUAL? ,UNDERWATER-COUNTER 5>
		       <SETG UNDERWATER-COUNTER 0>
		       <CRLF>
		       <JIGS-UP "You run out of air and drown.">)
		      (T
		       <RFALSE>)>)
	       (T
		<SETG UNDERWATER-COUNTER 0>
		<DISABLE <INT I-DROWN>>
		<RFALSE>)>>

<ROUTINE CORAL-PSEUDO ()
	 <COND (<AND <VERB? EXAMINE>
		     <IN? ,HERE ,SPENSEWEEDS>>
		<TELL "The coral is covered by swaying spenseweeds." CR>)>>

<OBJECT SPENSEWEEDS
	(IN LAGOON-FLOOR)
	(DESC "spenseweeds")
	(LDESC
"Nestled among some coral is a clump of stunningly beautiful spenseweeds,
waving slowly in the currents of the lagoon.")
	(SYNONYM CLUMP SPENSE WEEDS WEED)
	(ADJECTIVE SEA STUNNI BEAUTI)
	(FLAGS NARTICLEBIT)
	(ACTION SPENSEWEEDS-F)>

<ROUTINE SPENSEWEEDS-F ()
	 <COND (<VERB? MEEF>
		<MOVE ,SPENSEWEEDS ,DIAL>
		<MOVE ,CRATE ,HERE>
		<THIS-IS-IT ,CRATE>
		<TELL
"The spenseweeds wilt away, revealing a wooden crate labelled with
black lettering." CR>)
	       (<VERB? LOOK-UNDER>
		<TELL
"That's difficult -- they're well rooted in the coral." CR>)>>

<OBJECT CRATE
	(IN DIAL)
	(DESC "wooden crate")
	(SYNONYM LETTER CRATE LABEL)
	(ADJECTIVE WOOD WOODEN BLACK STENCI)
	(SIZE 45)
	(CAPACITY 40)
	(FLAGS TAKEBIT CONTBIT READBIT SEARCHBIT)
	(ACTION CRATE-F)>

<ROUTINE CRATE-F ()
	 <COND (<AND <VERB? OPEN REZROV>
		     <NOT ,CRATE-POINT>>
		<SETG CRATE-POINT T>
		<SETG SCORE <+ ,SCORE 15>>
		<RFALSE>)
	       (<VERB? READ>
                <FIXED-FONT-ON>
		<TELL
"Stencilled diagonally across the crate:|
|
    GRUE PROTECTION KIT|
|
Below, in much smaller letters:|
|
    FROM:|
    Frobozz Magic Grue Accessories Co.|
|
    TO:|
    Aragain Brothers Circus|
    Attn: Grue Trainer" CR>
		<FIXED-FONT-OFF>)>>

<GLOBAL CRATE-POINT <>>

<OBJECT GRUE-SUIT
	(IN CRATE)
	(DESC "grue suit")
	(SYNONYM SUIT)
	(ADJECTIVE GRUE)
	(FLAGS WEARBIT TAKEBIT)
	(SIZE 15)>

<OBJECT BRASS-LANTERN
	(IN CRATE)
	(DESC "brass lantern")
	(SYNONYM LANTERN LAMP)
	(ADJECTIVE BRASS BATTER POWERE)
	(FLAGS TAKEBIT LIGHTBIT)
	(SIZE 15)
	(ACTION BRASS-LANTERN-F)>

<ROUTINE BRASS-LANTERN-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It is a battery-powered lantern like those used by adventurers
and explorers. It is currently ">
		<COND (<FSET? ,BRASS-LANTERN ,ONBIT>
		       <TELL "on">)
		      (T
		       <TELL "off">)>
		<TELL "." CR>)>>		       

<OBJECT GRUE-REPELLENT
	(IN CRATE)
	(SYNONYM REPELLENT CAN)
	(ADJECTIVE GRUE MAGIC)
	(DESC "can of grue repellent")
	(FLAGS TAKEBIT READBIT)
	(ACTION GRUE-REPELLENT-F)
	(TEXT
"|
\"!!! FROBOZZ MAGIC GRUE REPELLENT !!!|
|
Instructions for use: Apply liberally to creature to be protected.
Duration of effect is unpredictable. Use only in place of death!|
|
(No warranty expressed or implied)\"")>

<ROUTINE GRUE-REPELLENT-F ()
	 <COND (<VERB? SHAKE>
		<COND (,SPRAY-USED?
		       <TELL "The can seems empty." CR>)
		      (T
		       <TELL "There is a sloshing sound from inside." CR>)>)
	       (<AND <VERB? SPRAY PUT-ON>
		     <EQUAL? ,PRSO ,GRUE-REPELLENT>>
		<COND (,SPRAY-USED?
		       <TELL "The repellent is all gone." CR>)
		      (<NOT ,PRSI>
		       <SETG SPRAY-USED? T>
		       <TELL
"The spray stinks amazingly for a few moments, then drifts away." CR>)
		      (T
		       <COND (<EQUAL? ,PRSI ,ME>
			      <ENABLE <QUEUE I-SPRAY 5>>
			      <SETG SPRAYED? T>)>
		       <SETG SPRAY-USED? T>
		       <TELL
"The spray smells like a mixture of old socks and burning rubber. If
I were a grue I'd sure stay clear!" CR>)>)>>

<GLOBAL SPRAY-USED? <>>

<GLOBAL SPRAYED? <>>

<ROUTINE I-SPRAY ()
	 <SETG SPRAYED? <>>
	 <TELL CR "That horrible smell is much less pungent now." CR>>

<ROOM MOUTH-OF-RIVER
      (IN ROOMS)
      (DESC "Mouth of River")
      (NORTH "The river is too wide to cross.")
      (NE "Entering the ocean is certain death.")
      (EAST "Entering the ocean is certain death.")
      (SE "Entering the ocean is certain death.")
      (SOUTH TO OCEAN-NORTH)
      (SW "There's a tall cliff there.")
      (WEST PER VINES-EXIT-F)
      (NW "There's a tall cliff there.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WATER OCEAN RIVER FORT CAVE WATERFALL)
      (PSEUDO "CLIFF" CLIFF-PSEUDO "CLIFFS" CLIFF-PSEUDO)
      (ACTION MOUTH-OF-RIVER-F)>

<ROUTINE MOUTH-OF-RIVER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"A mighty river spills into the ocean here. Looking up the river valley,
you see a tall waterfall. Atop a cliff, high above you, is the rampart
of a fortress. A cave entrance ">
		<COND (<IN? ,VINES ,HERE>
		       <TELL
"at the base of the cliff to the west is blocked by writhing green vines">)
		      (T
		       <TELL "lies to the west">)>
		<TELL "." CR>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <IN? ,VINES ,HERE>
		     <PROB 15>>
		<CRLF>
		<TELL
"Suddenly you realize that, without really thinking about it, you were ">
		<COND (,FLYING
		       <TELL "flying">)
		      (T
		       <TELL "walking">)>
		<TELL
" toward the wriggling vines. As you stop, a feeling of annoyance
seems to radiate from the plants." CR>)>>

<OBJECT VINES
	(IN MOUTH-OF-RIVER)
	(DESC "mass of wriggling vines")
	(SYNONYM MASS VINES VINE PLANTS)
	(ADJECTIVE WRIGLI WRITHI GREEN)
	(FLAGS NDESCBIT)
	(ACTION VINES-F)>

<ROUTINE VINES-F ()
	 <COND (<VERB? MEEF>
		<MOVE ,VINES ,DIAL>
		<TELL
"You can almost feel a wave of pain from the vines as they shrivel away." CR>)
	       (<VERB? ATTACK KILL>
		<JIGS-UP
"Your attack is somewhat quixotic as the vines wrap around and tear
you to pieces.">)
	       (<VERB? THROUGH KICK BITE TAKE CLIMB-UP CLIMB-FOO PUSH MOVE RUB>
		<DO-WALK ,P?WEST>)>>

<ROUTINE VINES-EXIT-F ()
	 <COND (<IN? ,VINES ,HERE>
		<JIGS-UP
"The vines encircle you and tear you limb from limb.">
		<RFALSE>)
	       (T
		,GRUE-LAIR)>>

<ROOM GRUE-LAIR
      (IN ROOMS)
      (DESC "Grue Lair")
      (LDESC
"This is a low, shadowy cave leading east to west. The rocky walls
are scarred with deep claw marks.")
      (EAST TO MOUTH-OF-RIVER)
      (WEST TO MAMMOTH-CAVERN)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL CAVE)
      (ACTION GRUE-LAIR-F)>

<ROUTINE GRUE-LAIR-F (RARG)
	 <COND (<AND <NOT ,SPRAYED?>
		     <EQUAL? .RARG ,M-END>
		     <NOT <IN? ,GRUE-SUIT ,PROTAGONIST>>>
		<COND (<OR ,LIT ,BLORTED>
		       <JIGS-UP
"The grues lurk toward you! Your last sight is a hundred slavering fangs.">)
		      (T
		       <JIGS-UP
"Suddenly, you are set upon by countless slavering fangs!">)>)>>

<OBJECT MUTATED-GRUES
	(IN GRUE-LAIR)
	(DESC "pack of mutated grues")
	(SYNONYM PACK GRUES GRUE)
	(ADJECTIVE MUTATE)
	(DESCFCN MUTATED-GRUES-DESCFCN)
	(ACTION MUTATED-GRUES-F)>

<ROUTINE MUTATED-GRUES-F ()
	 <COND (<VERB? FROTZ>
		<TELL
"One of the grues gives off a flash of light but, strangely, it doesn't seem
to notice or care." CR>)
	       (<VERB? RESEARCH>
		<PERFORM ,V?RESEARCH ,GRUE>
		<RTRUE>)>>

<ROUTINE MUTATED-GRUES-DESCFCN (RARG)
	 <COND (<OR ,LIT ,BLORTED>
		<COND (,SPRAYED?
		       <LIT-MESSAGE>
		       <TELL
"They stagger about the room, covering their noses and making horrid
gurgling noises." CR>)
		      (<IN? ,GRUE-SUIT ,PROTAGONIST>
		       <LIT-MESSAGE>
		       <TELL
"They seem to be ignoring you, aside from a few suspicious gurgles
in your direction." CR>)
		      (T
		       <LIT-MESSAGE>
		       <TELL
"Baring tremendous fangs, they form a circle around you..." CR>)>)
	       (T
		<TELL
"There are terrifying gurgling noises from the darkness!" CR>)>>

<ROUTINE LIT-MESSAGE ()
	 <TELL "A pack of grues fills the room! ">
	 <COND (,LIT
		<TELL
"The grues, contrary to all conventional wisdom, aren't bothered by your
light in the least. They must be mutated grues, no longer fearing light! ">)>>

<ROOM MAMMOTH-CAVERN
      (IN ROOMS)
      (DESC "Mammoth Cavern")
      (LDESC
"This cavern is of extraordinary size, but nevertheless crowded with
powerful-looking machinery. You recognize a breeder for producing
millions of the mutated grues you just passed. Other devices seem
designed to aid the forces of evil while sapping magic powers of
Enchanters everywhere.|
|
At the far end of the cavern are three closed doors: a black marble door
leading to the northwest, a shiny silver door heading due west, and
a door of bleached white wood to the southwest.")
      (EAST TO GRUE-LAIR)
      (NW TO CHAMBER-OF-LIVING-DEATH IF BLACK-DOOR IS OPEN)
      (WEST TO HALL-OF-ETERNAL-PAIN IF SILVER-DOOR IS OPEN)
      (SW TO BELBOZ-HIDEOUT IF WHITE-DOOR IS OPEN)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL CAVE)
      (ACTION MAMMOTH-CAVERN-F)>

<ROUTINE MAMMOTH-CAVERN-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<SETG SCORE <+ ,SCORE ,CAVERN-POINT>>
		<SETG CAVERN-POINT 0>
		<PUT ,VEZZAS 7 0>)>>

<GLOBAL CAVERN-POINT 20>

<OBJECT MACHINERY
	(IN MAMMOTH-CAVERN)
	(DESC "diabolic machinery")
	(SYNONYM MACHIN DEVICE BREEDER PLAQUE)
	(ADJECTIVE DIABOL EVIL POWERF TINY)
	(FLAGS NDESCBIT)
	(ACTION MACHINERY-F)>

<ROUTINE MACHINERY-F ()
	 <COND (<VERB? MUNG LAMP-ON>
		<JIGS-UP
"A field of energy leaps forth, reducing you to a pile of smoldering ash.">)
	       (<VERB? EXAMINE READ>
		<TELL
"You notice, on one machine, a tiny plaque which reads:|
|
FROBOZZ MAGIC MUTATED GRUE BREEDER CO." CR>)>>

<ROOM CHAMBER-OF-LIVING-DEATH
      (IN ROOMS)
      (DESC "Chamber of Living Death")
      (LDESC
"The very walls of this room seem to soak up all light, so it seems
as though you're floating in the center of an infinite void.")
      (FLAGS RLANDBIT ONBIT INSIDEBIT)
      (GLOBAL CAVE)
      (PSEUDO "PARASI" PARASITES-PSEUDO)
      (ACTION CHAMBER-OF-LIVING-DEATH-F)>

<ROUTINE CHAMBER-OF-LIVING-DEATH-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <NOT <VERB? QUIT SAVE VERSION>>
		     <NOT <VERB? RESTORE RESTART ;AGAIN>>
		     <NOT <VERB? BRIEF VERBOSE SUPER-BRIEF>>
		     <NOT <VERB? SCRIPT UNSCRIPT>>>
		<AGONY>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-END>
		<TELL
"Hideous parasites descend upon you and tear the flesh from your bones,
gnaw the eyes from your sockets, and feast upon your very brain tissue.
Amazingly, you do not die, and your body regenerates itself as you await
the next attack..." CR>)>>

<ROUTINE PARASITES-PSEUDO ()
	 <RFALSE>>

<ROOM HALL-OF-ETERNAL-PAIN
      (IN ROOMS)
      (DESC "Hall of Eternal Pain")
      (LDESC
"This room is filled with blinding light that stabs at your eyes.")
      (FLAGS RLANDBIT ONBIT INSIDEBIT)
      (GLOBAL CAVE)
      (PSEUDO "FORCE" FORCE-PSEUDO "FORCES" FORCE-PSEUDO)
      (ACTION HALL-OF-ETERNAL-DEATH-F)>

<ROUTINE HALL-OF-ETERNAL-DEATH-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-BEG>
		     <NOT <VERB? QUIT SAVE VERSION>>
		     <NOT <VERB? RESTORE RESTART ;AGAIN>>
		     <NOT <VERB? BRIEF VERBOSE SUPER-BRIEF>>
		     <NOT <VERB? SCRIPT UNSCRIPT>>>
		<AGONY>
		<RTRUE>)
	       (<EQUAL? .RARG ,M-END>
		<TELL
"Disembodied forces suck the very thoughts from your mind, savoring
each moment and growing stronger. Every second is an agonizing torment,
as though thousands of raging fires were exploding in your skull,
filling you with a pain greater than you could ever imagine." CR>)>>

<ROUTINE FORCE-PSEUDO ()
	 <RFALSE>>

<ROUTINE AGONY ()
	<TELL
"Your agony is too great to concentrate on such an action." CR>>

<ROOM BELBOZ-HIDEOUT
      (IN ROOMS)
      (SYNONYM JUNGLE MIZNIA)
      (DESC "Belboz's Hideout")
      (LDESC
"An acrid stench fills this small room, which is obviously a
control center for the evil experiments in the cavern outside.")
      (EAST "An invisible force stops you.")
      (FLAGS RLANDBIT INSIDEBIT ONBIT)
      (GLOBAL CAVE)>

<OBJECT KNIFE
	(IN BELBOZ-HIDEOUT)
	(DESC "diamond-studded knife")
	(FDESC
"Hanging on the wall is a heavy dagger, its handle encrusted with diamonds.")
	(SYNONYM KNIFE DAGGER HANDLE)
	(ADJECTIVE HEAVY DIAMON STUDDE ENCRUS)
	(FLAGS TAKEBIT WEAPONBIT)
	(SIZE 10)>

<OBJECT BLACK-DOOR
	(IN MAMMOTH-CAVERN)
	(DESC "black marble door")
	(SYNONYM DOOR DOORS)
	(ADJECTIVE BLACK MARBLE)
	(FLAGS DOORBIT NDESCBIT)
	(ACTION BLACK-DOOR-F)>

<ROUTINE BLACK-DOOR-F ()
	 <COND (<VERB? OPEN REZROV>
		<TELL
"As the door opens, hundreds of slime-covered tentacles stream
out and drag you across the threshold..." CR CR>
		<ROB ,PROTAGONIST>
		<DISABLE <INT I-TIRED>>
		<DISABLE <INT I-THIRST>>
		<DISABLE <INT I-HUNGER>>
		<WEAR-OFF-SPELLS>
		<GOTO ,CHAMBER-OF-LIVING-DEATH>)>>

<OBJECT SILVER-DOOR
	(IN MAMMOTH-CAVERN)
	(DESC "shiny silver door")
	(SYNONYM DOOR DOORS)
	(ADJECTIVE SHINY SILVER)
	(FLAGS DOORBIT NDESCBIT)
	(ACTION SILVER-DOOR-F)>

<ROUTINE SILVER-DOOR-F ()
	 <COND (<VERB? OPEN REZROV>
		<TELL
"The door blows open, knocking you to the ground. You are pulled
through the open doorway by an unseen force..." CR CR>
		<ROB ,PROTAGONIST>
		<DISABLE <INT I-TIRED>>
		<DISABLE <INT I-HUNGER>>
		<DISABLE <INT I-THIRST>>
		<WEAR-OFF-SPELLS>
		<GOTO ,HALL-OF-ETERNAL-PAIN>)>>

<OBJECT WHITE-DOOR
	(IN MAMMOTH-CAVERN)
	(DESC "white wooden door")
	(SYNONYM DOOR DOORS)
	(ADJECTIVE WHITE WOODEN BLEACH WOOD)
	(FLAGS DOORBIT NDESCBIT)
	(ACTION WHITE-DOOR-F)>

<GLOBAL WHITE-DOOR-SCORE 20>

<ROUTINE WHITE-DOOR-F ()
	 <COND (<VERB? OPEN REZROV>
		<COND (<EQUAL? ,HERE ,BELBOZ-HIDEOUT>
		       <DO-WALK ,P?EAST>
		       <RTRUE>)>
		<SETG SCORE <+ ,SCORE ,WHITE-DOOR-SCORE>>
		<SETG WHITE-DOOR-SCORE 0>
		<TELL
"The door creaks slowly open. Within, you see someone lying as though
asleep. You feel yourself drawn into the room..." CR CR>
		<ENABLE <QUEUE I-BELBOZ-AWAKES 8>>
		<GOTO ,BELBOZ-HIDEOUT>)>>

<GLOBAL VARDIKED <>>

<ROUTINE I-UNVARDIK ()
	 <SETG VARDIKED <>>
	 <TELL CR
"Your head feels numb for a moment, and your mind feels suddenly open and
unprotected." CR>>

<GLOBAL BELBOZ-DEAD <>>

<GLOBAL BELBOZ-GASPARED <>>

<ROUTINE KILL-BELBOZ ()
	 <COND (,BELBOZ-GASPARED
		<SETG BELBOZ-GASPARED <>>
		<TELL
"As you stab Belboz, an apparition rises from his body. Floating above him
like a cloud of fog, it howls with laughter. A moment later, gaspar begins
to heal the wounds, and the spirit flows back into the body." CR>
		<CRLF>
		<I-BELBOZ-AWAKES>)
	       (T
		<TELL
"You stab the knife time and again into Belboz, who writhes in pain,
eyes bulging outward. Sickened and dizzy, you stagger back." CR CR>
	        <SETG BELBOZ-DEAD T>
	        <SWANZO-BELBOZ>)>>

<ROUTINE SWANZO-BELBOZ ()
	 <TELL "A wispy translucent shape rises from the ">
	 <COND (,BELBOZ-DEAD
		<TELL "corpse">)
	       (T
		<TELL "body">)>
	 <TELL
" of Belboz. It speaks in a voice so deep that your whole body seems to
hear it. \"Foolish Charlatan! I am forced to flee that weak, old body -- I
shall take your own, instead! Already I have sucked all knowledge, all
secrets from that ancient Enchanter. Now begins an epoch of evil transcending
even your worst nightmares; a reign of terror that will last a thousand
thousand years!\" The shape blows toward you on a cold wind." CR CR>
	 <COND (,VARDIKED
		<TELL
"Jeearr surrounds you like a cloud and begins to contract. Suddenly, it
strikes your invisible protection and recoils as if burned. \"No!\" it
cries. \"Such a guileless Enchanter developing a mind shield?\" The cloud
is thinner, the voice fainter. \"It cannot be! I cannot survive ... without
a host.\" The demon roils in agony, then thins and dissipates. There is a
final scream of pain, then silence." CR CR>
		<COND (,BELBOZ-DEAD
		       <TELL
"Jeearr is vanquished; the kingdom is saved. But you - you are stranded in
a land unknown, and your closest friend, the greatest Enchanter of his
age, lies dead by your own hand. Kneeling by his blood-soaked corpse, you
beg for another chance..." CR>
		       <FINISH>)
		      (T
		       <TELL
"Belboz moans softly, and begins stirring. He sees you and rises, instantly
alert. After posing a few well-chosen questions, he casts a brief but
unfamiliar spell.|
|
An instant later, ">
		       <COND (<IN? ,GRUE-SUIT ,PROTAGONIST>
			      <TELL "your grue suit has vanished and ">)>
		       <TELL
"you are standing in the Chamber of the Circle. The Circle of Enchanters
is assembled. Belboz speaks. \"Once again, this young Enchanter has done
a matchless service to the Guild and to the entire kingdom, displaying
resourcefulness and imagination worthy of the greatest of Enchanters. I
grow old, and must soon step down as Head of the Circle. But let it be
known that a successor has been found.\"" CR CR>
		       <SETG SCORE <+ ,SCORE 25>>
		       <SETG HERE ,CHAMBER-OF-THE-CIRCLE>
		       <V-SCORE>
		       <USL>
		       <TELL CR
"Here ends the second chapter of the Enchanter saga, in which,
by virtue of your skills, you have been appointed as the next
leader of the Circle of Enchanters. The final adventure awaits
you as the Enchanter series concludes." CR>
		       <COND (<NOT <IN? ,MORGIA-PLANT ,BELBOZ-QUARTERS>>
			      <TELL CR
"You hear a distant bellow. \"What happened to my morgia plant?\"" CR>)>
		       <FINISH T>)>)
	       (T
		<TELL
"You feel an overwhelming sense of oppression as the demon seizes control
of your mind and body. The monster reaches into the recesses of your mind,
adding your hard-earned magic powers to its own. As it settles comfortably
into your skull, the demon grants you a vision of the future. You see the
enslaved people of the land toiling to erect great idols to Jeearr. Parents
offer up their own children upon these altars, as the rivers of the land fill
with blood. And YOU embody Jeearr; you are cursed by ten thousand generations
of victims; your face adorns the idols. And worst of all, you remain awake
and aware, a witness to horror, never sleeping, and never, ever to escape." CR>
		<SETG SCORE -99>
		<FINISH>)>>

<ROUTINE I-BELBOZ-AWAKES ()
	 <COND (<NOT <EQUAL? ,HERE ,BELBOZ-HIDEOUT>>
		<RFALSE>)>
	 <TELL CR
"Suddenly, Belboz's eyes flicker and he leaps to his feet. His face is
unrecognizable, a twisted mask of hatred. \"Meddlesome Enchanter! I should
have killed you all before I left! But better late than never...\" Lightning
bolts flash toward you from his fingers, but rather than dying, you find
yourself in the..." CR CR>
	 <ROB ,PROTAGONIST>
	 <DISABLE <INT I-TIRED>>
	 <DISABLE <INT I-THIRST>>
	 <DISABLE <INT I-HUNGER>>
	 <WEAR-OFF-SPELLS>
	 <GOTO ,HALL-OF-ETERNAL-PAIN>>
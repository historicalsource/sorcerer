"BELBOZ for
			    SORCERER
       (c) Copyright 1984 by Infocom Inc.  All Rights Reserved."

<ROUTINE I-WAKE-UP ()
	 <JIGS-UP
"|
Suddenly, seemingly from nowhere, a bolt of lightning strikes
you in the center of your chest...">>

<OBJECT TREE
	(IN LOCAL-GLOBALS)
	(DESC "gnarled tree")
	(SYNONYM TREE BRANCH)
	(ADJECTIVE LARGE GNARLE OLD TWISTE)
	(FLAGS NDESCBIT)
	(ACTION TREE-F)>

<ROUTINE TREE-F ()
	 <COND (<VERB? CLIMB-FOO CLIMB-UP>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)
	       (<VERB? LOOK-UNDER>
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)
	       (<VERB? MEEF>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,V?MEEF ,FOREST>
		<RTRUE>)>>

<ROOM TWISTED-FOREST
      (IN ROOMS)
      (DESC "Twisted Forest")
      (LDESC
"You are on a path through a blighted forest. The trees are sickly,
and there is no undergrowth at all. One tree here looks climbable.
The path, which ends here, continues to the northeast.")
      (UP TO TREE-BRANCH)
      (NE TO FOREST-EDGE)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL ROAD FOREST TREE)>

<OBJECT HELLHOUND
	(IN TWISTED-FOREST)
	(DESC "hellhound")
	(SYNONYM HELLHO HOUND DOG)
	(ADJECTIVE HELL)
	(FLAGS NDESCBIT)
	(ACTION HELLHOUND-F)>

<ROUTINE HELLHOUND-F ()
	 <COND (<VERB? RESEARCH>
		<PERFORM ,V?RESEARCH ,LOBBY>
		<RTRUE>)>>

<GLOBAL HELLHOUND-WARNING <>>

<ROUTINE I-HELLHOUND ()
	 <COND (<EQUAL? ,HERE ,TWISTED-FOREST>
		<COND (,HELLHOUND-WARNING
		       <JIGS-UP
"|
The hellhound reaches you and tears you apart with its powerful teeth.">)
		      (T
		       <SETG HELLHOUND-WARNING T>
		       <TELL CR
"A hellhound is racing straight toward you, its open jaws displaying
rows of razor-sharp teeth." CR>)>)
	       (<EQUAL? ,HERE ,TREE-BRANCH>
		<TELL
"The hellhound leaps madly about the base of the tree, gnashing its jaws." CR>)
	       (T
		<MOVE ,HELLHOUND ,DIAL>
		<DISABLE <INT I-HELLHOUND>>
		<TELL
"The hellhound stops at the edge of the forest and bellows. After a moment,
it turns and slinks into the trees." CR>)>>

<ROOM TREE-BRANCH
      (IN ROOMS)
      (DESC "Tree Branch")
      (DOWN TO TWISTED-FOREST)
      (UP PER TREE-UP-F)
      (FLAGS NONLANDBIT ONBIT)
      (GLOBAL FOREST TREE)
      (ACTION TREE-BRANCH-F)>

<ROUTINE TREE-BRANCH-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are ">
		<COND (,FLYING
		       <TELL "flying near">)
		      (T
		       <TELL "on">)>
		<TELL
" a large gnarled branch of an old and twisted tree." CR>)
	       (<EQUAL? .RARG ,M-ENTER>
		<ENABLE <QUEUE I-BOA -1>>
		<RFALSE>)>>

<ROUTINE TREE-UP-F ()
	 <TELL "You can't ">
	 <COND (,FLYING
		<TELL "fly">)
	       (T
		<TELL "climb">)>
	 <TELL " any higher." CR>
	 <RFALSE>>

<OBJECT BOA
	(IN TREE-BRANCH)
	(DESC "boa constrictor")
	(SYNONYM BOA CONSTR SNAKE)
	(ADJECTIVE GIANT BOA)
	(FLAGS NDESCBIT)
	(ACTION BOA-F)>

<ROUTINE BOA-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Your average giant carnivorous snake -- except that this one has
three heads and an appetite to match." CR>)>>

<GLOBAL BOA-WARNING <>>

<ROUTINE I-BOA ()
	 <COND (<EQUAL? ,HERE ,TREE-BRANCH>
		<COND (,FLYING
		       <RFALSE>)
		      (,BOA-WARNING
		       <JIGS-UP
"|
The snake begins wrapping itself around your torso, squeezing
the life out of you...">)
		      (T
		       <SETG BOA-WARNING T>
		       <TELL CR
"A giant boa constrictor is slithering along the branch toward you!" CR>)>)
	       (T
		<SETG BOA-WARNING <>>
		<DISABLE <INT I-BOA>>
		<RFALSE>)>>

<ROOM FOREST-EDGE
      (IN ROOMS)
      (SYNONYM MOUNTA)
      (ADJECTIVE LONELY)
      (DESC "Forest Edge")
      (LDESC
"To the west, a path enters the blighted woods, which stretch out of sight.
A signpost stands beside another path leading north, and to the east is a
wide meadow. At the base of the signpost is a slimy hole leading down.")
      (WEST TO TWISTED-FOREST)
      (NORTH TO MINE-FIELD)
      (DOWN TO SNAKE-PIT)
      (EAST TO MEADOW)
      (SOUTH "A tall fence blocks your way.")
      (PSEUDO "FENCE" FENCE-PSEUDO)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL HOLE ROAD FOREST MEADOW)>

<ROUTINE FENCE-PSEUDO ()
	 <COND (<VERB? CLIMB-OVER CLIMB-FOO LEAP>
		<TELL "It's too tall." CR>)>>

<OBJECT SIGNPOST
	(IN FOREST-EDGE)
	(DESC "signpost")
	(SYNONYM SIGNPO POST SIGN)
	(ADJECTIVE SIGN)
	(FLAGS READBIT NDESCBIT)
	(ACTION SIGNPOST-F)>

<ROUTINE SIGNPOST-F ()
	 <COND (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL
"|
\"  *** !!! >>> WARNING <<< !!! ***|
     This path is protected by a|
          Magic Mine Field|
          installed by the|
   Frobozz Magic Mine Field Company" CR>
		<FIXED-FONT-OFF>)>>

<ROOM MINE-FIELD
      (IN ROOMS)
      (DESC "Mine Field")
      (LDESC
"This is a flat and featureless dirt path leading north and south.")
      (SOUTH PER MINE-FIELD-EXIT-F)
      (NORTH PER MINE-FIELD-EXIT-F)
      (EAST "A tall fence blocks your way.")
      (WEST "The forest is too dense to enter here.")
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL FOREST)
      (PSEUDO "FENCE" FENCE-PSEUDO)>

<ROUTINE MINE-FIELD-EXIT-F ()
	 <COND (<AND <EQUAL? ,PRSO ,P?SOUTH>
		     <PROB 50>>
		,FOREST-EDGE)
	       (T
		<COND (,FLYING
		       <TELL
"Unfortunately, one of the properties of magic mine fields is their
ability to blow you up even if you're floating above them. ">)>
		<JIGS-UP "Kaboom!!!...">
		<RFALSE>)>>

<ROOM SNAKE-PIT
      (IN ROOMS)
      (DESC "Snake Pit")
      (LDESC
"You have entered a shadowy pit full of nooks and crannies. From every
direction you hear the hissing of vipers and the irregular clicking of
giant beetles. Light spills down from above, and a small crack leads
further downward into darkness.")
      (UP TO FOREST-EDGE)
      (OUT TO FOREST-EDGE)
      (DOWN TO SLIMY-ROOM)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "PIT" SNAKE-PIT-PSEUDO "CRACK" CRACK-PSEUDO)
      (ACTION SNAKE-PIT-F)>

<ROUTINE SNAKE-PIT-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<LOOK-AROUND-YOU>)>>

<ROUTINE CRACK-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<DO-WALK ,P?DOWN>)>>

<OBJECT VIPERS
	(IN SNAKE-PIT)
	(DESC "group of unseen creatures")
	(SYNONYM SNAKE SNAKES BEETLE CREATU)
	(ADJECTIVE GIANT VIPER VIPERS UNSEEN GROUP)
	(FLAGS NDESCBIT)> 

<ROUTINE SNAKE-PIT-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<ENABLE <QUEUE I-SNAKE-PIT <+ 1 <RANDOM 3>>>>
		<RFALSE>)>>

<ROUTINE I-SNAKE-PIT ()
	 <COND (<EQUAL? ,HERE ,SNAKE-PIT>
		<JIGS-UP
"|
Suddenly, the pit comes alive as dozens of vipers strike and thousands
of giant beetles pour from their hiding places.">)
	       (T
		<DISABLE <INT I-SNAKE-PIT>>)>>

<ROOM SLIMY-ROOM
      (IN ROOMS)
      (SYNONYM KRILL)
      (ADJECTIVE EVIL WARLOC)
      (DESC "Slimy Room")
      (LDESC
"This is a moist room whose walls are thick with moss and lichens. A
small hole leads up and a rocky passage leads south.")
      (UP TO SNAKE-PIT)
      (SOUTH TO CRATER)
      (DOWN TO CRATER)
      (FLAGS INSIDEBIT RLANDBIT)
      (GLOBAL HOLE)
      (PSEUDO "CRATER" CRATER-PSEUDO)>

<OBJECT MOSS
	(IN SLIMY-ROOM)
	(DESC "moss and lichens")
	(SYNONYM MOSS LICHEN SLIME)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION MOSS-F)>

<ROUTINE MOSS-F ()
	 <COND (<VERB? MEEF>
		<TELL
"A few patches of the moss and lichens become brown and dry." CR>)
	       (<VERB? EAT>
		<JIGS-UP "Uh, oh. They taste poisonous.">)>>

<ROOM MEADOW
      (IN ROOMS)
      (DESC "Meadow")
      (NORTH TO RIVER-BANK)
      (NE TO RIVER-BANK)
      (EAST TO DRAWBRIDGE)
      (WEST TO FOREST-EDGE)
      (SOUTH "A tall fence blocks your way.")
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "FENCE" FENCE-PSEUDO "TURRET" TURRET-PSEUDO)
      (GLOBAL MEADOW-OBJECT CASTLE)
      (ACTION MEADOW-F)>

<ROUTINE MEADOW-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<ENABLE <QUEUE I-LOCUSTS -1>>
		<RFALSE>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are in the center of a ">
		<COND (<IN? ,MEADOW-OBJECT ,HERE>
		       <TELL "rolling meadow of tall grass">)
		      (T
		       <TELL "barren field">)>
		<TELL
". To the east is the turret of a ruined castle, and from the northeast
comes the sound of rushing water." CR>)>>

<OBJECT MEADOW-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "meadow")
	(SYNONYM MEADOW GRASS FIELD)
	(ADJECTIVE TALL ROLLIN WIDE)
	(FLAGS NDESCBIT)
	(ACTION MEADOW-OBJECT-F)>

<ROUTINE MEADOW-OBJECT-F ()
	 <COND (<AND <NOT <EQUAL? ,HERE ,MEADOW>>
		     <VERB? RUB MEEF>>
		<TELL "The meadow is too far away." CR>)
	       (<VERB? MEEF>
		<MOVE ,MEADOW-OBJECT ,DIAL>
		<TELL "The grass vanishes as far as the eye can see." CR>)>>

<OBJECT PLAGUE-OF-LOCUSTS
	(IN MEADOW)
	(DESC "plague of locusts")
	(SYNONYM PLAGUE SWARM LOCUSTS)
	(ADJECTIVE BLOOD SUCKIN)
	(FLAGS NDESCBIT)
	(ACTION PLAGUE-OF-LOCUSTS-F)>

<ROUTINE PLAGUE-OF-LOCUSTS-F ()
	 <COND (<VERB? LOOK-UNDER>
		<PERFORM ,V?EXAMINE ,MEADOW-OBJECT>
		<RTRUE>)>>

<GLOBAL LOCUST-WARNING 0>

<ROUTINE I-LOCUSTS ()
	 <COND (<NOT <EQUAL? ,HERE ,MEADOW>>
		<DISABLE <INT I-LOCUSTS>>
		<SETG LOCUST-WARNING 0>
		<RFALSE>)
	       (<EQUAL? ,LOCUST-WARNING 0>
		<SETG LOCUST-WARNING <+ ,LOCUST-WARNING 1>>
		<TELL CR
"A swarm of bloodsucking locusts appears on the horizon." CR>)
	       (<EQUAL? ,LOCUST-WARNING 1>
		<SETG LOCUST-WARNING <+ ,LOCUST-WARNING 1>>
		<TELL CR
"The locusts are much closer now, blotting out the sun like
a black storm cloud." CR>)
	       (T
		<SETG LOCUST-WARNING 0>
		<JIGS-UP
"|
The locusts swarm over you and pick you clean to the bones.">)>>

<ROOM RIVER-BANK
      (IN ROOMS)
      (DESC "River Bank")
      (SOUTH TO MEADOW)
      (SW TO MEADOW)
      (NORTH PER RIVER-ENTER-F)
      (EAST PER RIVER-ENTER-F)
      (NE PER RIVER-ENTER-F)
      (DOWN PER RIVER-ENTER-F)
      (NW "Undergrowth prevents travel along the bank.")
      (SE TO FORT-ENTRANCE)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WATER RIVER MEADOW-OBJECT BANKS RIVER-BED-OBJECT)
      (PSEUDO "ROCK" ROCK-PSEUDO "ROCKS" ROCK-PSEUDO)
      (ACTION RIVER-BANK-F)>

<GLOBAL BANK-COUNTER 0>

<ROUTINE RIVER-BANK-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are on a muddy bank ">
		<COND (,RIVER-EVAPORATED
		       <TELL "above a dried-up river bed">)
		      (T
		       <TELL
"of a fast-moving river, full of sharp rocks and foaming rapids,
flowing to the southwest. The ground is soft and eroded, and
continually threatens to dump you into the turbulent waters">)>
		<TELL
". A field lies to the southwest, and a trail leads southeast
along the bank." CR>)
	       (<EQUAL? .RARG ,M-END>
		<COND (<L? ,BANK-COUNTER 3>
		       <SETG BANK-COUNTER <+ ,BANK-COUNTER 1>>
		       <RFALSE>)
	              (T
		       <COND (<AND <NOT ,RIVER-EVAPORATED>
				   <NOT ,FLYING>
		                   <PROB 75>>
		              <JIGS-UP
"Oops! A section of the bank gives way and you tumble into
the river. The current dashes you against the rocks.">)>)>)>>

<ROUTINE ROCK-PSEUDO ()
	 <COND (<VERB? CROSS>
		<TELL <PICK-ONE ,YUKS> CR>)>>

<GLOBAL RIVER-EVAPORATED <>>

<ROUTINE RIVER-ENTER-F ()
	 <COND (,RIVER-EVAPORATED
		,RIVER-BED)
	       (,FLYING
		<JIGS-UP
"You fly across the river's surface. Suddenly, a downdraft plunges
you into the swirling rapids!">
		<RFALSE>)
	       (T
		<TELL "You'd never survive the rapids." CR>
		<RFALSE>)>>

<OBJECT RIVER
	(IN LOCAL-GLOBALS)
	(DESC "river")
	(SYNONYM RIVER WATERS RAPIDS)
	(ADJECTIVE MIGHTY FAST- MOVING TURBUL FOAMIN)
	(FLAGS NDESCBIT)
	(ACTION RIVER-F)>	

<ROUTINE RIVER-F ()
	 <COND (<EQUAL? ,HERE ,GUN-EMPLACEMENT ,TURRET>
		<TELL "The river lies far below." CR>)
	       (,RIVER-EVAPORATED
		<TELL "River? What river?" CR>)
	       (<VERB? DRINK DRINK-FROM>
		<PERFORM ,V?DRINK ,WATER>
		<RTRUE>)
	       (<VERB? PULVER>
		<COND (<EQUAL? ,HERE ,RIVER-BANK>
		       <SETG RIVER-EVAPORATED T>
		       <ENABLE <QUEUE I-TRICKLE 3>>
		       <TELL
"The river dries up, leaving only a few puddles between the rocks! It's
now safe to climb down into the river bed." CR>)
		      (T
		       <TELL
"The water level drops several feet, but quickly surges back." CR>)>)
	       (<VERB? EXAMINE>
		<TELL "The river flows quickly by below you." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,RIVER ,PRSI>>
		<MOVE ,PRSO ,DIAL>
		<SPLASH>)
	       (<VERB? THROUGH>
		<DO-WALK ,P?NORTH>)>>

<ROUTINE I-TRICKLE ()
	 <ENABLE <QUEUE I-FLOOD 2>>
	 <COND (<OR <EQUAL? ,HERE ,RIVER-BANK ,RIVER-BED>
		    <EQUAL? ,HERE ,STAGNANT-POOL ,TOP-OF-FALLS>>
		<TELL CR
"A trickle of water begins flowing down the center of the river bed." CR>)>>

<ROUTINE I-FLOOD ()
	 <SETG RIVER-EVAPORATED <>>
	 <FLOOD-LOOP ,RIVER-BED>
	 <FLOOD-LOOP ,STAGNANT-POOL>
	 <FLOOD-LOOP ,TOP-OF-FALLS>
	 <CRLF>
	 <COND (<EQUAL? ,HERE ,STAGNANT-POOL ,RIVER-BED ,TOP-OF-FALLS>
		<JIGS-UP
"A wall of water comes rushing down the river bed! You are smashed into
jelly against the rocks.">)
	       (<EQUAL? ,HERE ,RIVER-BANK>
		<TELL
"A wall of water rushes down the river bed as the river returns with
a vengeance." CR>)
	       (<EQUAL? ,HERE ,HIDDEN-CAVE>
		<TELL
"There is a roar of water from outside the cave. The lower part
of the cave, near the mouth, fills with a pool of swirling water!" CR>)>>

<ROUTINE FLOOD-LOOP (LOC "AUX" X N)
	 <SET X <FIRST? .LOC>>
	 <COND (<NOT .X>
		<RTRUE>)>	 
	 <REPEAT ()
		 <SET N <NEXT? .X>>
		 <COND (<NOT <EQUAL? .X ,PROTAGONIST>>
			<MOVE .X ,DIAL>)>
		 <COND (<NOT .N>
			<RETURN>)
		       (T
			<SET X .N>)>>>

<OBJECT UNDERGROWTH
	(IN RIVER-BANK)
	(DESC "undergrowth")
	(SYNONYM UNDERG)
	(FLAGS NDESCBIT VOWELBIT NARTICLEBIT)
	(ACTION UNDERGROWTH-F)>

<ROUTINE UNDERGROWTH-F ()
	 <COND (<VERB? MEEF>
		<TELL
"The nearest part of the undergrowth withers away ... revealing
more undergrowth." CR>)>>

<OBJECT BANKS
	(IN LOCAL-GLOBALS)
	(DESC "river bank")
	(SYNONYM BANK BANKS)
	(ADJECTIVE RIVER MUDDY TALL STEEP HIGH)
	(FLAGS NDESCBIT)
	(ACTION BANKS-F)>

<ROUTINE BANKS-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-DOWN CLIMB-FOO>
		<V-WALK-AROUND>)>>

<OBJECT RIVER-BED-OBJECT
	(IN LOCAL-GLOBALS)
	(DESC "river bed")
	(SYNONYM BED)
	(ADJECTIVE RIVER)
	(FLAGS NDESCBIT)
	(ACTION RIVER-BED-OBJECT-F)>

<ROUTINE RIVER-BED-OBJECT-F ()
	 <COND (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,RIVER-BANK>
		       <DO-WALK ,P?DOWN>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? DROP EXIT>
		<COND (<EQUAL? ,HERE ,RIVER-BANK>
		       <LOOK-AROUND-YOU>)
		      (T
		       <DO-WALK ,P?UP>)>)>>	

<ROOM RIVER-BED
      (IN ROOMS)
      (SYNONYM SERVAN GUILD)
      (ADJECTIVE SERVAN)
      (DESC "River Bed")
      (LDESC
"You are on the bed of an evaporated river. Fish splash helplessly in
tiny puddles. The bed leads northwest and southeast. A climb up the
southwest bank is possible. To the northeast is a dark cave, hollowed
out by years of rushing water.")
      (UP TO RIVER-BANK)
      (SW TO RIVER-BANK)
      (NE TO HIDDEN-CAVE)
      (SE TO TOP-OF-FALLS)
      (NW TO STAGNANT-POOL)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "PUDDLE" PUDDLE-PSEUDO "FISH" FISH-PSEUDO)
      (GLOBAL WATER CAVE BANKS RIVER-BED-OBJECT)
      (ACTION RIVER-BED-F)>

<ROUTINE RIVER-BED-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<PUT ,VEZZAS 1 0>
		<RFALSE>)>>

<ROUTINE PUDDLE-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<TELL "The puddles are very shallow." CR>)
	       (<VERB? PULVER>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,V?PULVER ,WATER>
		<RTRUE>)>>

<ROUTINE FISH-PSEUDO ()
	 <COND (<VERB? TAKE>
		<TELL "They squirm from your grasp." CR>)>>

<ROOM STAGNANT-POOL
      (IN ROOMS)
      (SYNONYM TUMPER)
      (ADJECTIVE GABBER)
      (DESC "Near Stagnant Pool")
      (LDESC
"The river bed to the northwest is a pool covered with algae and other
scum. The bed to the southeast is slightly drier. The banks are too tall
and steep to climb here.")
      (NW PER TENTACLE-DEATH)
      (SE TO RIVER-BED)
      (UP PER RIVER-EXIT-F)
      (NE PER RIVER-EXIT-F)
      (SW PER RIVER-EXIT-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WATER BANKS RIVER-BED-OBJECT)>

<ROUTINE TENTACLE-DEATH ()
	 <COND (,FLYING
		<TELL "You fly over the surface of the pool.">)
	       (T
		<TELL "You wade into the stagnant pool.">)>
	 <JIGS-UP
" Suddenly, powerful tentacles lash out and drag you under the surface.">
	 <RFALSE>>

<ROOM TOP-OF-FALLS
	 (IN ROOMS)
	 (SYNONYM BORPHE)
	 (DESC "Top of Falls")
	 (LDESC
"The river bed ends here at a steep cliff, where the river once plunged
over a waterfall. Below the falls, in the distance, is a large sea,
covered with haze. The bed continues northwest, but the banks here are
unclimbable. Atop the southwestern bank stands a proud fortress.")
	 (UP PER RIVER-EXIT-F)
	 (NE PER RIVER-EXIT-F)
	 (SW PER RIVER-EXIT-F)
	 (SE PER WATERFALL-EXIT-F)
	 (DOWN PER WATERFALL-EXIT-F)
	 (NW TO RIVER-BED)
	 (FLAGS ONBIT RLANDBIT)
	 (GLOBAL WATER FORT BANKS OCEAN WATERFALL RIVER-BED-OBJECT)
	 (PSEUDO "CLIFF" TOP-OF-CLIFF-PSEUDO "HAZE" HAZE-PSEUDO)>

<ROUTINE RIVER-EXIT-F ()
	 <TELL "The banks are too ">
	 <COND (,FLYING
		<TELL "high to fly over." CR>)
	       (T
		<TELL "steep to climb." CR>)>
	 <RFALSE>>

<ROUTINE WATERFALL-EXIT-F ()
	 <COND (,FLYING
		<TELL
"That would be foolhardy, as flying spells are of limited duration." CR>)
	       (T
		<TELL "That would involve quite a plunge." CR>)>
	 <RFALSE>>

<ROUTINE TOP-OF-CLIFF-PSEUDO ()
	 <COND (<VERB? CLIMB-DOWN>
		<TELL "Impossible." CR>)
	       (<VERB? LEAP>
		<JIGS-UP "Brilliant move.">)>>

<ROUTINE HAZE-PSEUDO ()
	 <COND (<VERB? RUB>
		<TELL "From here?" CR>)>>

<OBJECT WATERFALL
	(IN LOCAL-GLOBALS)
	(DESC "waterfall")
	(SYNONYM WATERF FALL FALLS)
	(ADJECTIVE WATER TALL)
	(FLAGS NDESCBIT)
	(ACTION WATERFALL-F)>

<ROUTINE WATERFALL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It's no Aragain Falls, but it's pretty impressive." CR>)
	       (<AND <VERB? LEAP>
		     <EQUAL? ,HERE ,TOP-OF-FALLS>>
		<SETG PRSO <>>
		<PERFORM ,V?LEAP>
		<RTRUE>)
	       (<AND <EQUAL? ,HERE ,MOUTH-OF-RIVER ,TURRET>
		     <VERB? LEAP RUB SMELL LISTEN>>
		<TELL "From here?" CR>)>>

<ROOM HIDDEN-CAVE
      (IN ROOMS)
      (DESC "Hidden Cave")
      (SW TO RIVER-BED IF RIVER-EVAPORATED ELSE
       "Entering that swirling, turbulent pool looks very dangerous.")
      (OUT TO RIVER-BED IF RIVER-EVAPORATED ELSE
       "Entering that swirling, turbulent pool looks very dangerous.")
      (DOWN TO PIT-OF-BONES)
      (FLAGS INSIDEBIT RLANDBIT)
      (GLOBAL WATER CAVE HOLE)
      (ACTION HIDDEN-CAVE-F)>      

<ROUTINE HIDDEN-CAVE-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,HIDDEN-CAVE ,TOUCHBIT>>>
		<SETG SCORE <+ ,SCORE 20>>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"This is a hollow area under the northeast bank of the river. The floor
rises away from the mouth of the cave, which is at its southwest end. ">
		<COND (<NOT ,RIVER-EVAPORATED>
		       <TELL
"The mouth is filled with a pool of swirling water. ">)>
		<TELL
"A dark hole leads downward at the far end of the cave." CR>)>>

<OBJECT BAT-GUANO
	(IN HIDDEN-CAVE)
	(DESC "pile of bat guano")
	(SYNONYM PILE GUANO SHIT)
	(ADJECTIVE BAT FECES TURDS DUNG)
	(FLAGS TRYTAKEBIT TAKEBIT NDESCBIT)
	(SIZE 10)
	(ACTION BAT-GUANO-F)>

<ROUTINE BAT-GUANO-F ()
	 <COND (<AND <VERB? TAKE>
		     <NOT <FSET? ,FWEEP-SCROLL ,TOUCHBIT>>>
		<FSET ,FWEEP-SCROLL ,TOUCHBIT>
		<FSET ,BAT-GUANO ,TOUCHBIT>
		<FCLEAR ,BAT-GUANO ,TRYTAKEBIT>
		<FCLEAR ,BAT-GUANO ,NDESCBIT>
		<MOVE ,BAT-GUANO ,PROTAGONIST>
		<TELL
"As you take the guano, the soiled scroll falls to the ground." CR>)>>

<OBJECT BLORT-VIAL
	(IN HIDDEN-CAVE)
	(DESC "amber vial")
	(SYNONYM VIAL VIALS LABEL)
	(ADJECTIVE AMBER BLORT)
	(FLAGS CONTBIT READBIT TRYTAKEBIT TAKEBIT VOWELBIT VIALBIT SEARCHBIT)
	(SIZE 3)
	(CAPACITY 1)
	(ACTION BLORT-VIAL-F)>

<ROUTINE BLORT-VIAL-F ()
	 <COND (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL
"|
        \"BLORT POTION|
(ability to see in dark places)\"" CR>
		<FIXED-FONT-OFF>)>>

<OBJECT BLORT-POTION
	(IN BLORT-VIAL)
	(DESC "amber potion")
	(SYNONYM POTION)
	(ADJECTIVE AMBER BLORT)
	(FLAGS NARTICLEBIT VOWELBIT)
	(ACTION BLORT-POTION-F)>

<ROUTINE BLORT-POTION-F ()
	 <COND (<AND <VERB? EAT DRINK>
		     <NOT <HELD? ,BLORT-VIAL>>>
		<POTION-POUR ,BLORT-VIAL>)
	       (<VERB? RESEARCH>
		<READ-ABOUT-POTIONS 1>)
	       (<VERB? EAT DRINK>
		<MOVE ,BLORT-POTION ,DIAL>
		<COND (,UNDER-INFLUENCE
		       <TWO-POTIONS>
		       <RTRUE>)>
		<ENABLE <QUEUE I-UNBLORT 24>>
		<SETG BLORTED T>
		<SETG UNDER-INFLUENCE ,BLORT-POTION>
		<TELL
"The amber potion tasted like chives, and made your eyes tingle." CR>)
	       (<VERB? DROP>
		<PERFORM ,V?POUR ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <VERB? POUR>
		     <EQUAL? ,PRSO ,BLORT-POTION>>
		<POTION-POUR ,BLORT-VIAL>)>>

<GLOBAL BLORTED <>>

<ROUTINE I-UNBLORT ()
	 <SETG BLORTED <>>
	 <COND (<EQUAL? ,UNDER-INFLUENCE ,BLORT-POTION>
		<SETG UNDER-INFLUENCE <>>)>
	 <TELL CR "Your eyes tingle for a moment.">
	 <COND (<NOT ,LIT>
		<TELL " You can no longer see anything around you!">)>
	 <CRLF>>

<OBJECT FWEEP-SCROLL
	(IN HIDDEN-CAVE)
	(DESC "soiled scroll")
	(FDESC
"Lying in the corner, in a pile of bat guano, is a scroll.")
	(SYNONYM SCROLL)
	(ADJECTIVE SOILED)
	(FLAGS READBIT SCROLLBIT TRYTAKEBIT TAKEBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>	

<OBJECT FWEEP-SPELL
	(IN FWEEP-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE FWEEP)
	(DESC "fweep spell")
	(TEXT "turn caster into a bat")
	(COUNT 0)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)
	(ACTION SPELL-F)>

<GLOBAL FWEEPED <>>

<ROUTINE I-UNFWEEP ()
	 <SETG FWEEPED <>>
	 <SETG FLYING <>>
	 <TELL CR
"After a moment of futilely flapping your arms, you realize that
the fweep spell has worn off. ">
	 <COND (<AND <EQUAL? ,HERE ,GLASS-MAZE>
		     <NO-FLOOR?>>
		<JIGS-UP
"Unfortunately, this room of the maze has no floor.">)
	       (<EQUAL? ,HERE ,TREE-BRANCH>
		<SETTLE-ONTO-BRANCH>)
	       (<EQUAL? ,HERE ,LAGOON>
		<SPLASH-INTO-WATER>)
	       (T
		<TELL
"You fall several feet to the ground." CR>)>
	 <COND (<G? ,AWAKE 8>
                <I-TIRED>)>>

;"FORT-ENTRANCE and beyond is in FORT.ZIL"

<ROOM DRAWBRIDGE
      (IN ROOMS)
      (DESC "Drawbridge")
      (EAST TO RUINS)
      (WEST TO MEADOW)
      (DOWN PER DRAWBRIDGE-EXIT-F)
      (FLAGS RLANDBIT ONBIT)
      (GLOBAL WATER CASTLE MEADOW-OBJECT)
      (ACTION DRAWBRIDGE-F)>

<GLOBAL DRAWBRIDGE-MOVE <>>

<ROUTINE DRAWBRIDGE-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <NOT ,FLYING>>
		<COND (,DRAWBRIDGE-MOVE
		       <COND (<PROB 40>
			      <TELL
"With a scream of splintering wood, part of the drawbridge collapses and spills
you into the moat. ">
			      <DO-WALK ,P?DOWN>)
			     (T
			      <TELL "The bridge continues to creak." CR>)>)
		      (T
		       <SETG DRAWBRIDGE-MOVE T>
		       <RFALSE>)>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are ">
		<COND (,FLYING
		       <TELL "floating over">)
		      (T
		       <TELL "standing on">)>
		<TELL
" the drawbridge of a ruined castle which lies to your east. The wood
of the bridge looks severely rotted">
		<COND (,FLYING
		       <TELL ". The moat is">)
		      (T
		       <TELL
" and creaks ominously beneath you. The moat, although an easy dive
from here, looks dangerous,">)>
		<TELL 
" full of sinister shapes beneath the surface of the water. To
the west is a wide field." CR>)>>

<ROUTINE DRAWBRIDGE-EXIT-F ()
	 <JIGS-UP "You are immediately set upon by alligators and piranhas.">
	 <RFALSE>>

<OBJECT MOAT
	(IN DRAWBRIDGE)
	(DESC "moat")
	(SYNONYM MOAT)
	(FLAGS NDESCBIT)
	(ACTION MOAT-F)>

<ROUTINE MOAT-F ()
	 <COND (<VERB? PULVER>
		<TELL
"The moat dries up, leaving vicious-looking creatures flopping around
in puddles. Immediately, the castle's automatic moat-filler turns on,
and refills the moat." CR>)
	       (<VERB? DRINK DRINK-FROM>
		<PERFORM ,V?DRINK ,WATER>
		<RTRUE>)
	       (<VERB? EXAMINE>
		<TELL
"The water is murky, and lily pads cover most of the surface. Dark
shapes swim about below the surface." CR>)
	       (<VERB? LEAP THROUGH>
		<DO-WALK ,P?DOWN>)>>

<OBJECT BRIDGE
	(IN DRAWBRIDGE)
	(DESC "wooden drawbridge")
	(SYNONYM BRIDGE DRAWBR)
	(ADJECTIVE ROTTED WOODEN DRAW)
	(FLAGS NDESCBIT)
	(ACTION BRIDGE-F)>

<ROUTINE BRIDGE-F ()
	 <COND (<VERB? LOOK-UNDER>
		<PERFORM ,V?EXAMINE ,MOAT>
		<RTRUE>)
	       (<VERB? LISTEN>
		<TELL "Creak, creak." CR>)>>

<ROOM RUINS
      (IN ROOMS)
      (SYNONYM FANNUC)
      (ADJECTIVE DOUBLE)
      (DESC "Ruins")
      (LDESC
"You are amongst the ruins of an ancient castle. A winding stairway leads
up to a crumbling turret, and a dark passage leads downward. A path heads
through the rubble to the west.")
      (WEST TO DRAWBRIDGE)
      (UP TO TURRET)
      (DOWN TO DUNGEON)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "TURRET" TURRET-PSEUDO)
      (GLOBAL STAIRS CASTLE)>

<ROOM TURRET
      (IN ROOMS)
      (SYNONYM MAILMA MESSEN GUILD)
      (ADJECTIVE MESSEN)
      (DESC "Turret")
      (LDESC
"This is the only turret of the castle still standing. It affords a
marvelous view of a meadow to the west, and beyond that a twisted forest.
To the north is a mighty fortress which stands atop a cliff where a
turbulent river pours into an ocean. The ocean stretches out of sight
to the east. A spiralling staircase leads downward.")
      (DOWN TO RUINS)
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "TURRET" TURRET-PSEUDO)
      (GLOBAL FORT OCEAN RIVER MEADOW-OBJECT STAIRS FOREST CASTLE WATERFALL)>

<ROUTINE TURRET-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,RUINS>
		       <DO-WALK ,P?UP>)
		      (<EQUAL? ,HERE ,MEADOW>
		       <CANT-ENTER ,IT>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? DROP EXIT>
		<COND (<EQUAL? ,HERE ,TURRET>
		       <DO-WALK ,P?DOWN>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<AND <VERB? LEAP>
		     <EQUAL? ,HERE ,TURRET>>
		<SETG PRSO <>>
		<PERFORM ,V?LEAP>
		<RTRUE>)>>

<ROOM TORTURE-CHAMBER
      (IN ROOMS)
      (DESC "Torture Chamber")
      (LDESC
"This is a large and well-equipped torture chamber. These were very
popular in castles of several centuries ago, but are somewhat out
of fashion now. There are exits to the west and north.")
      (WEST TO DUNGEON)
      (NORTH TO PIT-OF-BONES)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL CASTLE)>

<OBJECT TORTURE-DEVICES
	(IN TORTURE-CHAMBER)
	(DESC "torture devices")
	(SYNONYM DEVICE RACK PIT PENDUL)
	(ADJECTIVE TORTUR)
	(FLAGS NDESCBIT)
	(ACTION TORTURE-DEVICES-F)>

<ROUTINE TORTURE-DEVICES-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"All the usual torture devices are here, all quite mean and
deadly looking." CR>)>>

<OBJECT FLAXO-VIAL
	(IN TORTURE-CHAMBER)
	(DESC "indigo vial")
	(FDESC
"Sitting near one of the torture devices is an indigo vial, labelled
in tiny letters.")
	(SYNONYM VIAL VIALS LETTER LABEL)
	(ADJECTIVE INDIGO FLAXO TINY)
	(FLAGS CONTBIT READBIT TAKEBIT VOWELBIT VIALBIT SEARCHBIT)
	(SIZE 3)
	(CAPACITY 1)
	(ACTION FLAXO-VIAL-F)>

<ROUTINE FLAXO-VIAL-F ()
	 <COND (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL
"|
   \"FLAXO POTION|
(exquisite torture)\"" CR>
		<FIXED-FONT-OFF>)>>

<OBJECT FLAXO-POTION
	(IN FLAXO-VIAL)
	(DESC "indigo potion")
	(SYNONYM POTION)
	(ADJECTIVE FLAXO INDIGO)
	(FLAGS NARTICLEBIT VOWELBIT)
	(ACTION FLAXO-POTION-F)>

<ROUTINE FLAXO-POTION-F ()
	 <COND (<AND <VERB? EAT DRINK>
		     <NOT <HELD? ,FLAXO-VIAL>>>
		<POTION-POUR ,FLAXO-VIAL>)
	       (<VERB? RESEARCH>
		<READ-ABOUT-POTIONS 2>)
	       (<VERB? EAT DRINK>
		<MOVE ,FLAXO-POTION ,DIAL>
		<TELL
"The potion tastes like a combination of anchovies, prune juice, and
garlic powder. As you finish swallowing the potion, a well-muscled troll
saunters in">
		<COND (<EQUAL? ,HERE ,TORTURE-CHAMBER>
		       <TELL " and straps you to a torture device">)>
		<TELL
". He whacks your head with a wooden two-by-four, grunting \"You are
playing Sorcerer. It was written by S. Eric Meretzky. You will have
fun and enjoy yourself.\" He repeats this action 999 more times, then
vanishes without a trace." CR>)
	       (<VERB? DROP>
		<PERFORM ,V?POUR ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <VERB? POUR>
		     <EQUAL? ,PRSO ,FLAXO-POTION>>
		<POTION-POUR ,FLAXO-VIAL>)>>

<ROOM DUNGEON
      (IN ROOMS)
      (SYNONYM TRAVEL)
      (ADJECTIVE TEMPOR TIME)
      (DESC "Dungeon")
      (LDESC
"This is the dark and dank dungeon of the ruined castle. There's probably
a torture chamber nearby. You can go east, northeast, or upward. A small
opening leads down as well.")
      (EAST TO TORTURE-CHAMBER)
      (UP TO RUINS)
      (NE TO PIT-OF-BONES)
      (DOWN TO HIGHWAY)
      (FLAGS INSIDEBIT RLANDBIT)
      (GLOBAL HOLE CASTLE)>

<ROOM PIT-OF-BONES
      (IN ROOMS)
      (DESC "Pit of Bones")
      (LDESC
"In the center of the room is a deep pit filled with countless bones, an
indication of the brutality of dungeon life. There are exits south and
southwest. High above you is a small opening in the ceiling.")
      (UP PER PIT-OF-BONES-EXIT-F)
      (SOUTH TO TORTURE-CHAMBER)
      (SW TO DUNGEON)
      (DOWN "Do you really want to add your bones to the others in the pit?")
      (FLAGS INSIDEBIT RLANDBIT)
      (GLOBAL HOLE CASTLE CAVE)
      (PSEUDO "BONES" BONES-PSEUDO "PIT" PIT-PSEUDO)>

<ROUTINE PIT-OF-BONES-EXIT-F ()
	 <COND (,FLYING
		<TELL "You can't fly high enough to reach the hole." CR>)
	       (T
		<TELL "The hole is too high to reach." CR>)>
	 <RFALSE>>

<ROUTINE BONES-PSEUDO ()
	 <COND (<VERB? TAKE SEARCH DIG>
		<TELL "They're at the bottom of the pit." CR>)
	       (<VERB? MALYON>
		<JIGS-UP "The results are too hideous to describe.">)>>

<ROUTINE PIT-PSEUDO ()
	 <COND (<VERB? LEAP THROUGH>
		<DO-WALK ,P?DOWN>)
	       (<VERB? LOOK-INSIDE>
		<TELL "Bones. Lots of bones." CR>)>>

<ROOM HIGHWAY
      (IN ROOMS)
      (SYNONYM GUILD CIRCLE ENCHAN)
      (ADJECTIVE ENCHAN)
      (DESC "Highway")
      (LDESC
"This is a wide road winding away to the east and west, perhaps a relic
of the Great Underground Empire you read about in history class. A passage
leads up to the north.")
      (UP TO DUNGEON)
      (NORTH TO DUNGEON)
      (EAST TO TOLL-GATE)
      (WEST TO BEND)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL ROAD)>

<ROOM TOLL-GATE
      (IN ROOMS)
      (DESC "Toll Gate")
      (LDESC
"You have reached a toll gate which spans the highway.")
      (WEST TO HIGHWAY)
      (EAST PER TOLL-GATE-CROSSING-F)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL ROAD)>

<ROUTINE TOLL-GATE-CROSSING-F ()
	 <COND (<FSET? ,GATE ,OPENBIT>
		,OUTSIDE-STORE)
	       (,FLYING
		<PERFORM ,V?CLIMB-OVER ,GATE>
		<RFALSE>)
	       (T
		<TELL "A sturdy toll gate blocks the highway." CR>
		<RFALSE>)>>

<OBJECT GATE
	(IN TOLL-GATE)
	(DESC "toll gate")
	(SYNONYM GATE)
	(ADJECTIVE TOLL STURDY)
	(FLAGS NDESCBIT DOORBIT)
	(ACTION GATE-F)>

<ROUTINE GATE-F ()
	 <COND (<VERB? OPEN CLOSE>
		<COND (<OPEN-CLOSE>
		       <RTRUE>)
		      (T
		       <TELL "Only the gnome can do that." CR>)>)
	       (<VERB? REZROV>
		<COND (<FSET? ,GATE ,OPENBIT>
		       <RFALSE>)
		      (,GNOME-SLEEPING
		       <SETG GNOME-SLEEPING <>>
		       <ENABLE <QUEUE I-GNOME 2>>
		       <TELL
"The gate flies open, waking the gnome, who leaps up and slams it closed
again. \"Hey! This is a toll gate! Nobody gets through here without paying
the one zorkmid toll. Not nobody, not no how.\""CR>)
		      (T
		       <SETG GNOME-SLEEPING T>
		       <JIGS-UP
"The gate flies open, but the gnome immediately slams it shut again.
\"Trying to gate crash, huh? We have an answer for scofflaws like you.
Hey, Tholl!\" A troll lumbers out of the toll booth. \"This is Tholl
the Toll Troll. Tholl, remove this cheat.\" Tholl approaches and
slices you neatly in half with his axe.">)>) 
	       (<VERB? CLIMB-OVER CLIMB-FOO>
		<TELL
"The gate extends to the roof of the tunnel, and there are pointed
nasties all over it." CR>)>>

<OBJECT BOOTH
	(IN TOLL-GATE)
	(DESC "toll booth")
	(SYNONYM BOOTH)
	(ADJECTIVE TOLL)
	(FLAGS NDESCBIT)
	(ACTION BOOTH-F)>

<ROUTINE BOOTH-F ()
	 <COND (<VERB? THROUGH>
		<COND (<FSET? ,GATE ,OPENBIT>
		       <JIGS-UP
"As you enter, you stumble over a sleeping troll. With stunning reflexes,
he grabs a battle axe and minces you.">)
		      (T
		       <TELL
"The booth is on the other side of the toll gate." CR>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<FSET? ,GATE ,OPENBIT>
		       <TELL "It's dark inside the toll booth." CR>)
		      (T
		       <PERFORM ,V?THROUGH ,BOOTH>
		       <RTRUE>)>)>>

<OBJECT GNOME
	(IN TOLL-GATE)
	(DESC "gnome")
	(SYNONYM GNOME BEARD POCKET)
	(ADJECTIVE FAT OLD LONG WHITE GNOME)
	(FLAGS ACTORBIT)
	(DESCFCN GNOME-DESCFCN)
	(ACTION GNOME-F)>

<GLOBAL GNOME-SLEEPING T>

<ROUTINE GNOME-DESCFCN (RARG)
	 <COND (,GNOME-SLEEPING
		<TELL
"A fat old gnome with a long white beard is sleeping soundly just outside
the toll booth. His loud snores echo around the caverns." CR>)
	       (T
		<TELL
"A chubby gnome stands behind the toll gate, grinning broadly." CR>)>>

<ROUTINE GNOME-F ()
	 <COND (<EQUAL? ,GNOME ,WINNER>
		<COND (,GNOME-SLEEPING
		       <POOR-LISTENERS>
		       <STOP>)
		      (<AND <VERB? OPEN>
			    <EQUAL? ,PRSO ,GATE>>
		       <TELL
"\"You'll have to pay the toll first,\" explains the gnome cheerfully,
\"and the toll is one zorkmid.\"" CR>)
		      (T
		       <TELL
"\"Conversing with customers is disallowed by union rules.\"" CR>
		       <STOP>)>)
	       (<AND <VERB? SHAKE KICK>
		     ,GNOME-SLEEPING>
		<PERFORM ,V?ALARM ,GNOME>
		<RTRUE>)
	       (<AND <VERB? LISTEN>
		     ,GNOME-SLEEPING>
		<TELL "The gnome snores loudly." CR>)
	       (<VERB? ALARM>
		<COND (<NOT ,GNOME-SLEEPING>
		       <TELL "He's awake!" CR>)
		      (<FSET? ,GATE ,OPENBIT>
		       <TELL
"The gnome opens one eye and looks at you. \"You again! Just go through.
Let me sleep.\" He begins snoring again." CR>)
		      (,GNOME-ANNOYED
		       <JIGS-UP
"\"You again! You've interrupted my nap for the last time! THOLL!!\" A
huge troll lumbers out of the toll booth and tears you into itsy-bitsy
pieces.">)
		      (T
		       <SETG GNOME-SLEEPING <>>
		       <ENABLE <QUEUE I-GNOME 2>>
		       <TELL
"The gnome stirs a bit and opens one eye, which wanders around until it
notices you. He jumps to his feet. \"One zorkmid, please,\" he yells
with a smile." CR>)>)
	       (<AND <VERB? GIVE ASK-ABOUT ASK-FOR>
		     ,GNOME-SLEEPING>
		<TELL "The gnome is asleep, remember?" CR>)
	       (<AND <FSET? ,GATE ,OPENBIT>
		     <VERB? SEARCH LOOK-INSIDE PICK>
		     <NOT ,COIN-STOLEN>
		     <NOT ,FWEEPED>>
		<SETG COIN-STOLEN T>
		<MOVE ,ZORKMID ,PROTAGONIST>
		<TELL
"You carefully search the sleeping gnome, and take the zorkmid coin you
find in his pocket!" CR>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSO ,ZORKMID>>
		<COND (<FSET? ,ZORKMID ,ONBIT>
		       <GNOME-REFUSES>
		       <RTRUE>)>
		<FSET ,GATE ,OPENBIT>
		<SETG GNOME-SLEEPING T>
		<MOVE ,ZORKMID ,DIAL>
		<DISABLE <INT I-GNOME>>
		<SETG SCORE <+ ,SCORE 20>>
		<TELL
"The gnome pockets the coin and opens the gate. Before you can take a
step the gnome falls asleep again." CR>)
	       (<VERB? YOMIN>
		<COND (,GNOME-SLEEPING
		       <TELL
"The thoughts of the sleeping gnome are focused on certain activities
involving female gnomes. Embarrassed, you withdraw." CR>)
		      (T
		       <TELL
"The thoughts of the gnome seem evenly divided between getting money from
you and getting back to sleep." CR>)>)>>

<GLOBAL COIN-STOLEN <>>

<ROUTINE GNOME-REFUSES ()
	 <TELL
"The gnome refuses, saying \"That coin is giving off light, and is
therefore not legal tender.\"" CR>>

<GLOBAL PATIENCE-COUNTER 0>

<GLOBAL GNOME-ANNOYED <>>

<ROUTINE I-GNOME ()
	 <ENABLE <QUEUE I-GNOME -1>>
	 <COND (<EQUAL? ,HERE ,TOLL-GATE>
		<SETG PATIENCE-COUNTER <+ ,PATIENCE-COUNTER 1>>
		<COND (<EQUAL? ,PATIENCE-COUNTER 5>
		       <SETG GNOME-SLEEPING T>
		       <DISABLE <INT I-GNOME>>
		       <SETG GNOME-ANNOYED T>
		       <TELL CR
"\"Thanks for nothing, chum,\" growls the gnome as he resumes his nap." CR>)
		      (T
		       <TELL CR
"\"Well?\" asks the gnome, tapping impatiently. \"You've interrupted
my nap. Are you going to pay the toll, or not?\"" CR>)>)
	       (T
		<SETG GNOME-SLEEPING T>
                <SETG PATIENCE-COUNTER 3>
		<DISABLE <INT I-GNOME>>
		<RFALSE>)>>

<ROOM OUTSIDE-STORE
      (IN ROOMS)
      (DESC "Outside Store")
      (LDESC
"A store lies to the south from this section of the east-west road. There is
a sign over the entrance.")
      (SOUTH TO STORE)
      (IN TO STORE)
      (WEST TO TOLL-GATE)
      (EAST TO END-OF-HIGHWAY)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL ROAD)
      (PSEUDO "SIGN" SIGN-PSEUDO "STORE" STORE-PSEUDO)>

<ROUTINE SIGN-PSEUDO ()
	 <COND (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL
"|
\"ZEKE'S APPLIANCE STORE|
|
 Official outlet for all|
Frobozz Magic Appliances\"" CR>
		<FIXED-FONT-OFF>)>>

<ROUTINE STORE-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,STORE>
		       <LOOK-AROUND-YOU>)
		      (T
		       <DO-WALK ,P?SOUTH>)>)
	       (<VERB? EXIT DROP>
		<COND (<EQUAL? ,HERE ,STORE>
		       <DO-WALK ,P?NORTH>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,STORE>
		       <LOOK-AROUND-YOU>)
		      (T
		       <MAKE-OUT>)>)>>

<ROOM STORE
      (IN ROOMS)
      (SYNONYM GNOMES)
      (DESC "Store")
      (LDESC
"This is an appliance store, apparently abandoned. The entrance
lies to the north.")
      (NORTH TO OUTSIDE-STORE)
      (OUT TO OUTSIDE-STORE)
      (FLAGS INSIDEBIT RLANDBIT)
      (PSEUDO "STORE" STORE-PSEUDO)>

<OBJECT WAXER
	(IN STORE)
	(DESC "floor waxer")
	(SYNONYM WAXER APPLIA)
	(ADJECTIVE FLOOR)
	(FLAGS TAKEBIT)
	(SIZE 50)
	(ACTION WAXER-F)>

<ROUTINE WAXER-F ()
	 <COND (<VERB? LAMP-ON>
		<COND (<HELD? ,WAXER>
		       <TELL "Better put it down, first." CR>)
		      (,FWEEPED
		       <BATTY>)
		      (<EQUAL? ,HERE ,LAGOON ,LAGOON-FLOOR>
		       <JIGS-UP
"The waxer short circuits in the water, electrocuting you and
several nearby fishies.">)
		      (<EQUAL? ,HERE ,MINE-FIELD>
		       <SETG FLYING <>>
		       <MOVE ,WAXER ,DIAL>
		       <DO-WALK ,P?NORTH>)
		      (T
		       <TELL "The waxer whirrs about the ">
		       <COND (<FSET? <LOC ,PROTAGONIST> ,VEHBIT>
			      <TELL "vehicle">)
			     (T
			      <TELL "room">)>
		       <TELL " for a minute, polishing the floor." CR>)>)
	       (<VERB? LAMP-OFF>
		<TELL "It is." CR>)>> 

;"END OF HIGHWAY and beyond is in MAZE.ZIL"

<ROOM BEND
      (IN ROOMS)
      (SYNONYM DESERT)
      (ADJECTIVE KOVALL)
      (DESC "Bend")
      (LDESC
"The road curves here, heading east and southwest.")
      (EAST TO HIGHWAY)
      (SW TO EDGE-OF-CRATER)
      (FLAGS INSIDEBIT RLANDBIT)
      (GLOBAL ROAD)>

<ROOM EDGE-OF-CRATER
      (IN ROOMS)
      (DESC "Edge of Crater")
      (LDESC
"You are at the northeastern rim of a gigantic crater, the result of
some ancient explosion. A wide underground highway, which ends
at the crater's edge, leads northeast.")
      (NE TO BEND)
      (SW TO CRATER)
      (DOWN TO CRATER)
      (FLAGS INSIDEBIT RLANDBIT)
      (GLOBAL ROAD)
      (PSEUDO "CRATER" CRATER-PSEUDO)>

<ROOM CRATER
      (IN ROOMS)
      (SYNONYM SEA)
      (ADJECTIVE OCEAN)
      (DESC "Crater")
      (NE TO EDGE-OF-CRATER)
      (SOUTH TO WINDING-TUNNEL)
      (WEST TO EDGE-OF-CHASM)
      (NORTH TO SLIMY-ROOM)
      (EAST PER CRATER-EXIT-F)
      (NW PER CRATER-EXIT-F)
      (SW PER CRATER-EXIT-F)
      (SE PER CRATER-EXIT-F)
      (OUT PER CRATER-OUT-F)
      (FLAGS INSIDEBIT RLANDBIT)
      (PSEUDO "CRATER" CRATER-PSEUDO)
      (ACTION CRATER-F)>

<ROUTINE CRATER-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL "You are ">
		<COND (,FLYING
		       <TELL "floating near">)
		      (T
		       <TELL "standing in">)>
		<TELL
" the center of an enormous crater, strewn with debris.
Several points around the perimeter look climbable." CR>)>>

<ROUTINE CRATER-OUT-F ()
	 <V-WALK-AROUND>
	 <RFALSE>>

<ROUTINE CRATER-EXIT-F ()
	 <COND (,FLYING
		<TELL
"As you try to fly over the rim here, a heavy gust of wind blows
you back." CR>
		<RFALSE>)
	       (T
		<TELL
"You attempt to climb the rim here, but the rubble is loose and you
slide back down." CR>
		<RFALSE>)>>

<ROUTINE CRATER-PSEUDO ()
	 <COND (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,CRATER>
		       <TELL "Where do you think you are?" CR>)
		      (<EQUAL? ,HERE ,EDGE-OF-CRATER>
		       <DO-WALK ,P?SW>)
		      (<EQUAL? ,HERE ,EDGE-OF-CHASM>
		       <DO-WALK ,P?EAST>)
		      (<EQUAL? ,HERE ,SLIMY-ROOM>
		       <DO-WALK ,P?SOUTH>)
		      (T
		       <DO-WALK ,P?NORTH>)>)
	       (<VERB? CLIMB-FOO>
		<V-WALK-AROUND>)
	       (<VERB? LEAVE EXIT DISEMBARK>
		<COND (<EQUAL? ,HERE ,CRATER>
		       <DO-WALK ,P?UP>)
		      (T
		       <LOOK-AROUND-YOU>)>)>>

<ROOM EDGE-OF-CHASM
      (IN ROOMS)
      (SYNONYM VILLAG ACCARD)
      (DESC "Edge of Chasm")
      (LDESC
"This is a strip of land to the east of a gaping chasm. You might try
jumping across, but I'd advise against it. A wide crater lies to the east.")
      (EAST TO CRATER)
      (WEST PER CHASM-EXIT-F)
      (FLAGS INSIDEBIT RLANDBIT)
      (PSEUDO "CHASM" CHASM-PSEUDO "CRATER" CRATER-PSEUDO)>

<ROUTINE CHASM-EXIT-F ()
	 <COND (,FLYING
		<TELL "You fly easily across the chasm..." CR CR>
		<COND (<EQUAL? ,HERE ,BARE-PASSAGE>
		       ,EDGE-OF-CHASM)
		      (T
		       ,BARE-PASSAGE)>)
	       (T
		<TELL
"If you really want to jump across the chasm, just say so." CR>
		<RFALSE>)>>

<ROOM BARE-PASSAGE
      (IN ROOMS)
      (SYNONYM AMATHR)
      (DESC "Bare Passage")
      (LDESC
"This is a featureless tunnel, narrowing to the west. To the east is
a deep gorge, probably too wide to jump across.")
      (WEST TO ELBOW-ROOM)
      (EAST PER CHASM-EXIT-F)
      (FLAGS INSIDEBIT RLANDBIT)
      (PSEUDO "CHASM" CHASM-PSEUDO "GORGE" CHASM-PSEUDO)>

<ROUTINE CHASM-PSEUDO ()
	 <COND (<VERB? LEAP>
		<COND (<PROB 75>
		       <JIGS-UP "Too bad. Didn't quite make it.">)
		      (T
		       <COND (<EQUAL? ,HERE ,EDGE-OF-CHASM>
			      <GOTO ,BARE-PASSAGE>)
			     (T
			      <GOTO ,EDGE-OF-CHASM>)>)>)>> 

<ROOM ELBOW-ROOM
      (IN ROOMS)
      (SYNONYM NYMPH NYMPHS)
      (DESC "Elbow Room")
      (LDESC
"The tunnel turns a corner here. You could go either north or east.")
      (NORTH TO TREE-ROOM)
      (EAST TO BARE-PASSAGE)
      (FLAGS INSIDEBIT RLANDBIT)>

<ROOM TREE-ROOM
      (IN ROOMS)
      (SYNONYM GURTH MITHIC)
      (DESC "Tree Room")
      (LDESC
"This is a tall room flooded with light from an unseen source. The only exit
is south.")
      (SOUTH TO ELBOW-ROOM)
      (FLAGS INSIDEBIT RLANDBIT ONBIT)
      (ACTION TREE-ROOM-F)>

<ROUTINE TREE-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<PUT ,VEZZAS 3 0>
		<RFALSE>)>>

<OBJECT ZORKMID-TREE
	(IN TREE-ROOM)
	(DESC "zorkmid tree")
	(LDESC
"Growing in the center of the room is a tree, thick with foliage. As
though to disprove the ancient adage, every branch, bow, and twig has
a zorkmid coin growing on it.")
	(SYNONYM TREE BRANCH BOW TWIG)
	(ADJECTIVE ZORKMID)
	(ACTION ZORKMID-TREE-F)>

<ROUTINE ZORKMID-TREE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"It is laden with zorkmids, glinting in the light." CR>)
	       (<VERB? REZROV>
		<V-SWANZO>)
	       (<VERB? CLIMB-FOO CLIMB-UP>
		<TELL "The branches don't look sturdy enough." CR>)>>

<OBJECT ZORKMID
	(IN TREE-ROOM)
	(DESC "zorkmid coin")
	(SYNONYM ZORKMID COIN COINS TOLL)
	(ADJECTIVE ZORKMID)
	(SIZE 3)
	(FLAGS TAKEBIT TRYTAKEBIT NDESCBIT)
	(ACTION ZORKMID-F)>

<ROUTINE ZORKMID-F ()
	 <COND (<AND <VERB? PICK>
		     <FSET? ,PRSO ,TRYTAKEBIT>
		     <EQUAL? ,ZORKMID ,PRSO>>
		<PERFORM ,V?TAKE ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <FSET? ,PRSO ,TRYTAKEBIT>>
		<FCLEAR ,PRSO ,TRYTAKEBIT>
		<FCLEAR ,PRSO ,NDESCBIT>
		<MOVE ,ZORKMID-TREE ,DIAL>
		<MOVE ,ZORKMID ,PROTAGONIST>
		<SETG SCORE <+ ,SCORE 15>>
		<TELL
"As you pluck the first zorkmid, the tree shimmers and vanishes!
(I guess it was just an illusion.) You are left holding a solitary
zorkmid coin." CR>)
	       (<AND <VERB? COUNT EXAMINE>
		     <IN? ,ZORKMID-TREE ,HERE>>
		<TELL
"There are countless coins, hanging from every branch of the tree." CR>)
	       (<VERB? EXAMINE>
		<TELL
"The coin pictures a man with an incredibly flat head, wearing a
gaudy crown." CR>)
	       (<VERB? BITE>
		<TELL "Yep, it's real." CR>)
	       (<VERB? RESEARCH>
		<TELL
"An article in the monetary section explains that the zorkmid was the
unit of currency of the Great Underground Empire, and is still used in
most parts of the kingdom today. A picture of a zorkmid coin is included. ">
		<PERFORM ,V?EXAMINE ,ZORKMID>
		<RTRUE>)>>

<ROOM WINDING-TUNNEL
      (IN ROOMS)
      (SYNONYM INFOCO FIBBSB MAGICL SOFTSP)
      (DESC "Winding Tunnel")
      (LDESC
"This is a meandering north-south tunnel. A side passage leads
to the southwest.")
      (NORTH TO CRATER)
      (SOUTH TO HALL-OF-CARVINGS)
      (SW TO PARK-ENTRANCE)
      (FLAGS RLANDBIT INSIDEBIT)
      (PSEUDO "CRATER" CRATER-PSEUDO)>

;"PARK-ENTRANCE and beyond is in PARK.ZIL"

<ROOM HALL-OF-CARVINGS
      (IN ROOMS)
      (DESC "Hall of Carvings")
      (NORTH TO WINDING-TUNNEL)
      (SOUTH TO SOOTY-ROOM IF DRAGON-MOVED)
      (FLAGS RLANDBIT INSIDEBIT)
      (ACTION HALL-OF-CARVINGS-F)>

<ROUTINE HALL-OF-CARVINGS-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You have entered a large room whose walls are covered with intricate
carvings. ">
		<COND (,DRAGON-MOVED
		       <TELL
"A passage has been recently opened to the south, and is only partially
blocked by a huge stone dragon, poised in the midst of an attack.">)
		       (T
			<TELL
"The largest and most striking carving, on the southern wall, is
of a huge sleeping dragon!">)>
		<TELL " A winding tunnel leads north." CR>)>>

<GLOBAL DRAGON-MOVED <>>

<GLOBAL MALYON-YONKED <>>

<OBJECT DRAGON
	(IN HALL-OF-CARVINGS)
	(DESC "carving of a dragon")
	(SYNONYM CARVIN DRAGON)
	(ADJECTIVE HUGE STONE SLEEPI LARGES MOST STRIKI INTRIC)
	(FLAGS NDESCBIT VOWELBIT)
	(ACTION DRAGON-F)>

<ROUTINE DRAGON-F ()
	 <COND (<VERB? MALYON>
		<COND (,MALYON-YONKED
		       <COND (,DRAGON-MOVED
			      <JIGS-UP
"The dragon comes to life again! He spews a tremendous gout of
flame right at you!">)
			     (T
			      <SETG DRAGON-MOVED T>
			      <TELL
"The dragon is suddenly imbued with life and begins to move. It shakes
itself loose from the wall, which crumbles down upon the dragon, revealing
a southward passage! The dragon howls with pain and anger. Spotting you,
the dragon rears back its head, smoke billowing from its nostrils. Then,
just as it seems that you will be barbecued, the dragon reverts to
stone!" CR>)>)
		      (T
		       <TELL
"The dragon seems to shiver for a moment, but that is all." CR>)>)>>

;"SOOTY-ROOM and beyond is in COAL.ZIL"
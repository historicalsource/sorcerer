"FORT.ZIL for
				SORCERER
	(c) Copyright 1984  Infocom, Inc.  All Rights Reserved"

<OBJECT FORT
	(IN LOCAL-GLOBALS)
	(DESC "fort")
	(SYNONYM FORT GRIFFS RAMPAR FORTRE)
	(ADJECTIVE FORT PROUD MIGHTY)
	(FLAGS NDESCBIT)
	(ACTION FORT-F)>

<ROUTINE FORT-F ()
	 <COND (<VERB? THROUGH>
		<COND (<OR <EQUAL? ,HERE ,PARADE-GROUND ,GUN-EMPLACEMENT>
			   <EQUAL? ,HERE ,BARRACKS ,ARMORY>>
		       <LOOK-AROUND-YOU>)
		      (<EQUAL? ,HERE ,FORT-ENTRANCE>
		       <DO-WALK ,P?EAST>)
		      (T
		       <CANT-ENTER ,FORT>)>)
	       (<VERB? DROP EXIT>
		<COND (<EQUAL? ,HERE ,PARADE-GROUND>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,HERE ,GUN-EMPLACEMENT ,BARRACKS ,ARMORY>
		       <CANT-ENTER ,FORT T>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? RESEARCH>
		<TELL
"Fort Griffspotter once guarded the lands near Egreth Castle from
attack by sea." CR>)>>

<ROOM FORT-ENTRANCE
      (IN ROOMS)
      (DESC "Fort Entrance")
      (LDESC
"You are at the entrance to Fort Griffspotter, which lies to the east.
A trail leads along the river bank to the northwest.")
      (EAST TO PARADE-GROUND)
      (NW TO RIVER-BANK)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL FORT ROAD BANKS)>

<ROOM PARADE-GROUND
      (IN ROOMS)
      (DESC "Parade Ground")
      (LDESC
"You are at the center of a level field inside the fort. Entrances to
rooms around the perimeter lie in several directions.")
      (WEST TO FORT-ENTRANCE)
      (SOUTH TO ARMORY)
      (EAST TO GUN-EMPLACEMENT)
      (NORTH TO BARRACKS)
      (UP "If you want to climb the flagpole, just say so.")
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "ROPE" ROPE-PSEUDO)
      (GLOBAL FORT)
      (ACTION PARADE-GROUND-F)>

<ROUTINE PARADE-GROUND-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<PUT ,VEZZAS 2 0>
		<RFALSE>)
	       (<AND <EQUAL? .RARG ,M-END>
		     ,SLEEPING>
	        <DISABLE <INT I-WAKE-UP>>
		<I-WAKE-UP>)>>

<ROUTINE ROPE-PSEUDO ()
	 <COND (<VERB? MOVE>
		<PERFORM ,V?LOWER ,FLAG>
		<RTRUE>)
	       (<VERB? TAKE>
		<TELL
"The rope is attached to the pole and can't possibly be removed." CR>)>>

<OBJECT FLAG-POLE
	(IN PARADE-GROUND)
	(DESC "flagpole")
	(SYNONYM POLE FLAGPO)
	(ADJECTIVE FLAG)
	(FLAGS NDESCBIT)
	(ACTION FLAG-POLE-F)>

<ROUTINE FLAG-POLE-F ()
	 <COND (<VERB? CLIMB-ON CLIMB-FOO CLIMB-UP>
		<TELL
"That sort of thing went out of fashion years ago." CR>)
	       (<VERB? EXAMINE>
		<TELL "A rope runs up the side of the pole." CR>)>>

<OBJECT FLAG
	(IN PARADE-GROUND)
	(DESC "flag of Quendor")
	(SYNONYM FLAG)
	(ADJECTIVE TATTER BROWN GOLD)
	(FLAGS TAKEBIT TRYTAKEBIT)
	(SIZE 8)
	(DESCFCN FLAG-DESCFCN)
	(ACTION FLAG-F)>

<GLOBAL FLAG-RAISED T>

<GLOBAL FOOBLE-FOUND <>>

<ROUTINE FLAG-DESCFCN (RARG)
	 <COND (,FLAG-RAISED
		<TELL
"A tattered flag, apparently that of ancient Quendor, still flies atop
a mighty flagpole in the center of the field." CR>)
	       (T
		<TELL
"A flag displaying the brown and gold of ancient Quendor is lying here." CR>)>>

<ROUTINE FLAG-F ()
	 <COND (<VERB? FLY>
		<PERFORM ,V?RAISE ,FLAG>
		<RTRUE>)>
	 <COND (,FLAG-RAISED
		<COND (<VERB? RAISE>
		       <TELL "It's already at the top of the pole." CR>)
		      (<VERB? LOWER>
		       <SETG FLAG-RAISED <>>
		       <FCLEAR ,FLAG ,TRYTAKEBIT>
		       <FCLEAR ,FLAG-POLE ,NDESCBIT>
		       <TELL "The flag is lowered to the ground." CR>)
		      (<VERB? EXAMINE>
		       <TELL
"You can't see it very well from here -- the flagpole is very tall." CR>)
		      (<VERB? SHAKE WAVE TAKE MOVE RUB EAT DRINK LOOK-INSIDE>
		       <TELL "The flag is ">
		       <COND (,FLYING
			      <TELL "still ">)>
		       <TELL
"way above you at the top of the flagpole!" CR>)
		      (<VERB? LOOK-UNDER>
		       <PERFORM ,V?EXAMINE ,FLAG-POLE>
		       <RTRUE>)>)
	       (T
		<COND (<VERB? RAISE>
		       <COND (<EQUAL? ,HERE ,PARADE-GROUND>
			      <FSET ,FLAG ,TRYTAKEBIT>
			      <MOVE ,FLAG ,HERE>
			      <FSET ,FLAG-POLE ,NDESCBIT>
			      <SETG FLAG-RAISED T>
			      <TELL
"The flag is raised to the top of the pole." CR>)
			     (T
			      <TELL "There's no flagpole in sight." CR>)>)
		      (<VERB? LOWER>
		       <TELL "You've already done that." CR>)
		      (<VERB? WAVE>
		       <TELL "How patriotic!" CR>)
		      (<VERB? WEAR>
		       <TELL "Who do you think you are, Abbie Hoffman?" CR>)
		      (<AND <VERB? EXAMINE LOOK-INSIDE SHAKE RUB SEARCH>
			    <NOT ,FOOBLE-FOUND>>
		       <SETG FOOBLE-FOUND T>
		       <MOVE ,FOOBLE-VIAL ,HERE>
		       <THIS-IS-IT ,FOOBLE-VIAL>
		       <TELL
"As you fiddle with the flag, an aqua vial drops from a hidden pocket
and falls to the ground." CR>)
		      (<VERB? EXAMINE>
		       <TELL
"The tattered flag displays the brown and gold of ancient Quendor." CR>)>)>>

<OBJECT FOOBLE-VIAL
	(IN DIAL)
	(DESC "aqua vial")
	(SYNONYM VIAL VIALS LABEL)
	(ADJECTIVE AQUA FOOBLE)
	(FLAGS CONTBIT READBIT TAKEBIT VOWELBIT VIALBIT SEARCHBIT)
	(SIZE 3)
	(CAPACITY 1)
	(ACTION FOOBLE-VIAL-F)>

<ROUTINE FOOBLE-VIAL-F ()
	 <COND (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL
"|
        \"FOOBLE POTION|
(increase muscular coordination)\"" CR>
		<FIXED-FONT-OFF>)>>

<OBJECT FOOBLE-POTION
	(IN FOOBLE-VIAL)
	(DESC "aqua potion")
	(SYNONYM POTION)
	(ADJECTIVE AQUA FOOBLE)
	(FLAGS NARTICLEBIT VOWELBIT)
	(ACTION FOOBLE-POTION-F)>

<ROUTINE FOOBLE-POTION-F ()
	 <COND (<AND <VERB? EAT DRINK>
		     <NOT <HELD? ,FOOBLE-VIAL>>>
		<POTION-POUR ,FOOBLE-VIAL>)
	       (<VERB? RESEARCH>
		<READ-ABOUT-POTIONS 2>)
	       (<VERB? EAT DRINK>
		<MOVE ,FOOBLE-POTION ,DIAL>
		<COND (,UNDER-INFLUENCE
		       <TWO-POTIONS>
		       <RTRUE>)>
		<SETG UNDER-INFLUENCE ,FOOBLE-POTION>
		<ENABLE <QUEUE I-UNFOOBLE 17>>
		<SETG FOOBLED T>
		<TELL
"The aqua potion tasted like lime jelly, and sent vibrations through
your muscles." CR>)
	       (<VERB? DROP>
		<PERFORM ,V?POUR ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <VERB? POUR>
		     <EQUAL? ,PRSO ,FOOBLE-POTION>>
		<POTION-POUR ,FOOBLE-VIAL>)>>

<GLOBAL FOOBLED <>>

<ROUTINE I-UNFOOBLE ()
	 <SETG FOOBLED <>>
	 <COND (<EQUAL? ,UNDER-INFLUENCE ,FOOBLE-POTION>
		<SETG UNDER-INFLUENCE <>>)>
	 <TELL CR "Your muscles feel limp for a moment." CR>>

<ROOM ARMORY
      (IN ROOMS)
      (DESC "Armory")
      (LDESC
"Once the armory for the fort, this room has been picked clean by
vandals and soldiers of fortune. Exit north or northeast.")
      (NORTH TO PARADE-GROUND)
      (NE TO GUN-EMPLACEMENT)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL FORT)>

<ROOM BARRACKS
      (IN ROOMS)
      (DESC "Barracks")
      (LDESC
"This was a barracks for the battalion stationed in this fort. You
could leave to the south, or to the southeast.")
      (SOUTH TO PARADE-GROUND)
      (SE TO GUN-EMPLACEMENT)
      (FLAGS RLANDBIT INSIDEBIT)
      (PSEUDO "BARRAC" BARRACKS-PSEUDO)
      (GLOBAL FORT)>

<ROUTINE BARRACKS-PSEUDO ()
	 <SETG PERFORMING-SPELL T>
	 <PERFORM ,PRSA ,GLOBAL-ROOM ,PRSI>
	 <RTRUE>>

<ROOM GUN-EMPLACEMENT
      (IN ROOMS)
      (DESC "Gun Emplacement")
      (LDESC
"This is a battlement with a view of a river to the north and an ocean to
the east. Openings northwest, west, and southwest lead to other parts of
the fort.")
      (WEST TO PARADE-GROUND)
      (NW TO BARRACKS)
      (SW TO ARMORY)
      (NORTH PER EMPLACEMENT-EXIT-F)
      (EAST PER EMPLACEMENT-EXIT-F)
      (FLAGS ONBIT RLANDBIT)
      (GLOBAL RIVER OCEAN FORT)>      

<ROUTINE EMPLACEMENT-EXIT-F ()
	 <COND (,FLYING
		<TELL "The updrafts from the ">
		<COND (<EQUAL? ,PRSO ,P?NORTH>
		       <TELL "river">)
		      (T
		       <TELL "ocean">)>)
	       (T
		<TELL "The plunge">)>
	 <TELL " would kill you." CR>
	 <RFALSE>>

<OBJECT CANNON
	(IN GUN-EMPLACEMENT)
	(DESC "cannon")
	(LDESC
"A magnificent cast-iron cannon stands atop the battlement. Its wide,
shallow barrel points toward the ocean, as though daring enemy ships
to approach.")
	(SYNONYM CANNON BARREL)
	(ADJECTIVE MAGNIF CAST-IRON CAST IRON WIDE SHALLO)
	(FLAGS CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 80)
	(ACTION CANNON-F)>

<ROUTINE CANNON-F ()
	 <COND (<VERB? SHOOT LAMP-ON>
		<TELL "This cannon probably hasn't worked for centuries!" CR>)
	       (<VERB? CLOSE>
		<V-DEFLATE>)
	       (<AND <VERB? REACH-IN SEARCH>
		     <FSET? ,YIPPLES ,INVISIBLE>>
		<SETG BITTEN T>
		<ENABLE <QUEUE I-BITE-HEAL 20>>
		<TELL "Something bites your hand!" CR>)
	       (<AND <VERB? LOOK-INSIDE>
		     <FSET? ,YIPPLES ,INVISIBLE>>
		<FCLEAR ,YIPPLES ,INVISIBLE>
		<TELL
"Lying at the bottom of the barrel is a pile of identical scrolls!" CR>)
	       (<VERB? EXAMINE>
		<TELL
"The barrel is wide enough to hold the hugest of cannonballs, but it
isn't very deep." CR>)
	       (<AND <VERB? REACH-IN SEARCH>
		     <IN? ,YIPPLES ,CANNON>>
		<PERFORM ,V?TAKE ,YIPPLES>
		<RTRUE>)
	       (<AND <VERB? PUT>
		     <IN? ,YIPPLES ,CANNON>
		     <EQUAL? ,BAT-GUANO ,PRSO>>
		<MOVE ,YIPPLES ,DIAL>
		<MOVE ,YONK-SCROLL ,CANNON>
		<THIS-IS-IT ,YONK-SCROLL>
		<MOVE ,BAT-GUANO ,CANNON>
		<TELL
"When you drop the guano into the barrel, ">
		<COND (<FSET? ,YIPPLES ,INVISIBLE>
		       <TELL
"dozens of scrolls pour out and literally run off">)
		      (T
		       <TELL
"the scrolls sprout feet and spill out of the cannon, dashing away">)>
		<TELL " in every direction! A single ordinary scroll
is left sitting at the bottom of the barrel." CR>
		<FCLEAR ,YIPPLES ,INVISIBLE>)
	       (<AND <VERB? THROUGH>
		     ,FWEEPED>
		<TELL "Your wingspan is too large." CR>)>>

<OBJECT YIPPLES
	(IN CANNON)
	(DESC "pile of identical scrolls")
	(SYNONYM PILE SCROLL)
	(ADJECTIVE IDENTI)
	(FLAGS INVISIBLE TRYTAKEBIT)
	(ACTION YIPPLES-F)>

<ROUTINE YIPPLES-F ()
	 <COND (<VERB? TAKE>
		<SETG BITTEN T>
		<ENABLE <QUEUE I-BITE-HEAL 20>>
		<TELL
"As you reach into the cannon, something bites you painfully on the hand!" CR>)
	       (<VERB? EXAMINE>
		<TELL "Every scroll is virtually identical." CR>)>>

<GLOBAL BITTEN <>>

<ROUTINE I-BITE-HEAL ()
	 <SETG BITTEN <>>
	 <RFALSE>>

<OBJECT YONK-SCROLL
	(IN DIAL)
	(DESC "ordinary scroll")
	(SYNONYM SCROLL)
	(ADJECTIVE SINGLE ORDINA)
	(FLAGS READBIT SCROLLBIT TAKEBIT CONTBIT TRANSBIT VOWELBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>	

<OBJECT YONK-SPELL
	(IN YONK-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE YONK)
	(DESC "yonk spell")
	(TEXT "augment the power of certain spells")
	(COUNT 0)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)
	(ACTION SPELL-F)>
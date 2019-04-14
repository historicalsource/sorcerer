"GLOBALS for
			    SORCERER
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

<DIRECTIONS ;"Do not change the order of the first eight
	      without consulting MARC!"
 	    NORTH NE EAST SE SOUTH SW WEST NW UP DOWN IN OUT>

<GLOBAL HERE <>>

<GLOBAL LOAD-ALLOWED 100>

<GLOBAL LOAD-MAX 100>

<GLOBAL LIT T>

<GLOBAL MOVES 0>

<GLOBAL SCORE 0>

<GLOBAL INDENTS
	<PTABLE ""
	       "  "
	       "    "
	       "      "
	       "        "
	       "          ">>

;"global objects and associated routines"

<OBJECT GLOBAL-OBJECTS
	(FLAGS MUNGBIT INVISIBLE TOUCHBIT SURFACEBIT TRYTAKEBIT OPENBIT
	       SEARCHBIT TRANSBIT WEARBIT VOWELBIT ONBIT RLANDBIT)>

<OBJECT LOCAL-GLOBALS
	(IN GLOBAL-OBJECTS)
	(SYNONYM ZZMGCK)
	(DESCFCN 0)
        (GLOBAL GLOBAL-OBJECTS)
	(ADVFCN 0)
	(FDESC "F")
	(LDESC "F")
	(PSEUDO "FOOBAR" V-WALK)
	(CONTFCN 0)
	(SIZE 0)
	(CAPACITY 0)>
;"Yes, this synonym for LOCAL-GLOBALS needs to exist... sigh"

<OBJECT ROOMS
	(IN TO ROOMS)>

<OBJECT INTNUM
	(IN GLOBAL-OBJECTS)
	(SYNONYM INTNUM)
	(DESC "number")>

<OBJECT PSEUDO-OBJECT
	(DESC "pseudo")
	(ACTION ME-F)>

<OBJECT IT
	(IN GLOBAL-OBJECTS)
	(SYNONYM IT THAT HER HIM)
	(DESC "it")
	(FLAGS VOWELBIT NARTICLEBIT NDESCBIT TOUCHBIT)>

<OBJECT NOT-HERE-OBJECT
	(DESC "something")
	(FLAGS NARTICLEBIT)
	(ACTION NOT-HERE-OBJECT-F)>

<ROUTINE NOT-HERE-OBJECT-F ("AUX" TBL (PRSO? T) OBJ (X <>))
	 ;"This COND is game independent (except the TELL)"
	 <COND (<AND <EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		     <EQUAL? ,PRSI ,NOT-HERE-OBJECT>>
		<TELL "Those things aren't here!" CR>
		<RTRUE>)
	       (<EQUAL? ,PRSO ,NOT-HERE-OBJECT>
		<SET TBL ,P-PRSO>)
	       (T
		<SET TBL ,P-PRSI>
		<SET PRSO? <>>)>
	 <COND (.PRSO?
		<COND (<OR <EQUAL? ,PRSA ,V?FIND ,V?FOLLOW ,V?AIMFIZ>
			   <EQUAL? ,PRSA ,V?WHAT ,V?WHERE ,V?WHO>
			   <EQUAL? ,PRSA ,V?WAIT-FOR ,V?SEND ,V?WALK-TO>
			   <EQUAL? ,PRSA ,V?RESEARCH>>
		       <SET X T>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)
	       (T
		<COND (<OR <AND <EQUAL? ,PRSA ,V?AIMFIZ-TO>
				<EQUAL? ,PRSO ,ME>>			   
			   <AND <EQUAL? ,PRSA ,V?CAST>
			        <EQUAL? ,PRSO ,AIMFIZ-SPELL>>>
		       <SET X T>
		       <COND (<SET OBJ <FIND-NOT-HERE .TBL .PRSO?>>
			      <COND (<NOT <EQUAL? .OBJ ,NOT-HERE-OBJECT>>
				     <RTRUE>)>)
			     (T
			      <RFALSE>)>)>)>
	 ;"Here is the default 'cant see any' printer"
	 <COND (.X
		<TELL "You'll have to be more specific, I'm afraid." CR>)
	       (<EQUAL? ,WINNER ,PROTAGONIST>
		<TELL "You can't see">
		<COND (<OR <EQUAL? ,P-XNAM ,W?BELBOZ ,W?HELIST ,W?KRILL>
			   <EQUAL? ,P-XNAM ,W?FROBAR ,W?JEEARR ,W?FLATHE>
			   <EQUAL? ,P-XNAM ,W?DUNCAN ,W?ENTHAR ,W?THOLL>
			   <EQUAL? ,P-XNAM ,W?GURTH ,W?MIZNIA ,W?ACCARD>
		           <EQUAL? ,P-XNAM ,W?BORPHE ,W?ANTHAR ,W?MITHIC>
		           <EQUAL? ,P-XNAM ,W?GALEPA ,W?MAREIL ,W?THRIFF>
			   <EQUAL? ,P-XNAM ,W?ORKAN ,W?BARBEL ,W?CHEVAU>>
		       T)
		      (T
		       <TELL " any">)> 
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!" CR>)
	       (T
		<TELL "Looking confused,">
		<ARTICLE ,WINNER T>
		<TELL " says, \"I don't see any">
		<NOT-HERE-PRINT .PRSO?>
		<TELL " here!\"" CR>)>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RTRUE>>

<ROUTINE FIND-NOT-HERE (TBL PRSO? "AUX" M-F OBJ)
	;"Here is where special-case code goes. <MOBY-FIND .TBL> returns
	   number of matches. If 1, then P-MOBY-FOUND is it. One may treat
	   the 0 and >1 cases alike or different. It doesn't matter. Always
	   return RFALSE (not handled) if you have resolved the problem."
	<SET M-F <MOBY-FIND .TBL>>
	;<COND (,DEBUG
	       <TELL "[Found " N .M-F " obj]" CR>)>
	;<COND (<AND <G? .M-F 1>
		    <SET OBJ <GETP <1 .TBL> ,P?GLOBAL>>>
	       <SET M-F 1>
	       <SETG P-MOBY-FOUND .OBJ>)>
	<COND (<==? 1 .M-F>
	       ;<COND (,DEBUG <TELL "[Namely: " D ,P-MOBY-FOUND "]" CR>)>
	       <COND (.PRSO?
		      <SETG PRSO ,P-MOBY-FOUND>)
		     (T
		      <SETG PRSI ,P-MOBY-FOUND>)>
	       <RFALSE>)
	      (<NOT .PRSO?>
	       <TELL "You wouldn't find any">
	       <NOT-HERE-PRINT .PRSO?>
	       <TELL " there." CR>
	       <RTRUE>)
	      (T ,NOT-HERE-OBJECT)>>

;<ROUTINE GLOBAL-NOT-HERE-PRINT (OBJ)
	 ;<COND (,P-MULT <SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>)>
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <TELL "You can't see any ">
	 <COND (<EQUAL? .OBJ ,PRSO> <PRSO-PRINT>)
	       (T <PRSI-PRINT>)>
	 <TELL " here." CR>>

<ROUTINE NOT-HERE-PRINT (PRSO?)
	 <COND (<EQUAL? ,P-XNAM ,W?BELBOZ>
		<TELL " Belboz">)
	       (<EQUAL? ,P-XNAM ,W?THOLL>
		<TELL " Tholl">)
	       (<OR <EQUAL? ,P-XNAM ,W?GURTH ,W?MIZNIA ,W?ACCARD>
		    <EQUAL? ,P-XNAM ,W?BORPHE ,W?ANTHAR ,W?MITHIC>
		    <EQUAL? ,P-XNAM ,W?GALEPA ,W?MAREIL ,W?THRIFF>>
		<TELL " that place">)
	       (<OR <EQUAL? ,P-XNAM ,W?HELIST ,W?FROBAR ,W?ORKAN>
		    <EQUAL? ,P-XNAM ,W?BARBEL ,W?CHEVAU>>
		<TELL " that person">)
	       (<EQUAL? ,P-XNAM ,W?JEEARR>
		<TELL " Jeearr">)
	       (<EQUAL? ,P-XNAM ,W?KRILL>
		<TELL " Krill">)
	       (<EQUAL? ,P-XNAM ,W?FLATHE>
		<TELL " Flathead">)
	       (<EQUAL? ,P-XNAM ,W?DUNCAN ,W?ENTHAR>
		<TELL " that King">)
	       (,P-OFLAG
	        <COND (,P-XADJ <TELL " "> <PRINTB ,P-XADJN>)>
	        <COND (,P-XNAM <TELL " "> <PRINTB ,P-XNAM>)>)
               (.PRSO?
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC1> <GET ,P-ITBL ,P-NC1L> <>>)
               (T
	        <BUFFER-PRINT <GET ,P-ITBL ,P-NC2> <GET ,P-ITBL ,P-NC2L> <>>)>>

<OBJECT DEBRIS
	(IN GLOBAL-OBJECTS)
	(DESC "dust and debris")
	(SYNONYM RUBBLE DEBRIS CAVE-IN DUST)
	(FLAGS NARTICLEBIT)>

<OBJECT GROUND
	(IN GLOBAL-OBJECTS)
	(SYNONYM FLOOR GROUND PLATEAU FIELD)
	(ADJECTIVE STONE SANDY TINY OUTDOO LEVEL)
	(DESC "ground")
	(ACTION GROUND-F)>

<ROUTINE GROUND-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-ON CLIMB-FOO BOARD>
		<V-SIT>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,LAGOON>>
		<TELL "Through the water you can see sandy ground below." CR>)
	       (<AND <VERB? LOOK-UNDER LOOK-INSIDE EXAMINE>
		     <EQUAL? ,HERE ,GLASS-MAZE>>
		<PERFORM ,V?EXAMINE ,MAZE>
		<RTRUE>)
	       (<VERB? LOOK-UNDER>
		<TELL "You've never mastered an X-ray vision spell." CR>)>>

<OBJECT ROAD
	(IN LOCAL-GLOBALS)
	(DESC "road")
	(SYNONYM HIGHWAY ROAD TRAIL PATH)
	(ADJECTIVE DIRT FEATUR WIDE CURVED MAIN UNDERG)
	(FLAGS NDESCBIT)
	(ACTION ROAD-F)>

<ROUTINE ROAD-F ()
	 <COND (<VERB? FOLLOW>
		<V-WALK-AROUND>)>>

<OBJECT CORRIDOR
	(IN GLOBAL-OBJECTS)
	(DESC "passage")
	(SYNONYM PASSAG CORRID HALLWA TUNNEL)
	(ADJECTIVE ROCKY WINDIN LONG DARK MEANDE)
	(ACTION CORRIDOR-F)>

<ROUTINE CORRIDOR-F ()
	 <COND (<VERB? THROUGH WALK-TO>
		<V-WALK-AROUND>)>>

<OBJECT WALLS
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "wall")
	(SYNONYM WALL WALLS)
	(ACTION WALLS-F)>

<ROUTINE WALLS-F ()
	 <COND (<AND <VERB? READ>
		     <EQUAL? ,HERE ,CHAMBER-OF-THE-CIRCLE>>
		<PERFORM ,V?READ ,TENETS>
		<RTRUE>)
	       (<AND <VERB? EXAMINE>
		     <EQUAL? ,HERE ,HALL-OF-CARVINGS>
		     <NOT ,DRAGON-MOVED>>
		<TELL "A dragon carving adorns the far wall." CR>)
	       (<AND <EQUAL? ,HERE ,SLIMY-ROOM>
		     <VERB? EXAMINE>>
		<TELL "The walls are covered with moss and stuff." CR>)
	       (<AND <EQUAL? ,HERE ,GLASS-MAZE>
		     <VERB? EXAMINE LOOK-INSIDE>>
		<PERFORM ,V?EXAMINE ,MAZE>
		<RTRUE>)>>

<OBJECT CEILING
	(IN GLOBAL-OBJECTS)
	(FLAGS NDESCBIT TOUCHBIT)
	(DESC "ceiling")
	(SYNONYM CEILIN ROOF DOME)
	(ADJECTIVE HIGH DOMED)
	(ACTION CEILING-F)>

<ROUTINE CEILING-F ()
	 <COND (<VERB? EXAMINE>
		<COND (<EQUAL? ,HERE ,SLANTED-ROOM>
		       <TELL
"The ceiling is slanted, making the room trapezoidal in shape." CR>)
		      (<EQUAL? ,HERE ,PIT-OF-BONES>
		       <TELL "There's an opening in the ceiling." CR>)
		      (<EQUAL? ,HERE ,CHAMBER-OF-THE-CIRCLE>
		       <TELL
"Other than its shape, there's nothing of interest." CR>)>)
	       (<AND <EQUAL? ,HERE ,GLASS-MAZE>
		     <VERB? EXAMINE LOOK-INSIDE>>
		<PERFORM ,V?EXAMINE ,MAZE>
		<RTRUE>)
	       (<VERB? LOOK-UNDER>
		<PERFORM ,V?LOOK>
		<RTRUE>)>>

<OBJECT STAIRS
	(IN LOCAL-OBJECTS)
	(DESC "stairs")
	(SYNONYM STAIR STAIRS STAIRW STAIRC)
	(ADJECTIVE MARBLE WIDE NARROW STEEP WINDIN SPIRAL)
	(FLAGS NARTICLEBIT NDESCBIT CLIMBBIT)
	(ACTION STAIRS-F)>

<ROUTINE STAIRS-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<DO-WALK ,P?UP>)
	       (<VERB? CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)>>

<OBJECT HANDS
	(IN GLOBAL-OBJECTS)
	(SYNONYM HANDS)
	(ADJECTIVE BARE)
	(DESC "your hand")
	(FLAGS NDESCBIT TOOLBIT TOUCHBIT NARTICLEBIT)>

<OBJECT PROTAGONIST
	(SYNONYM PROTAG)
	(DESC "protagonist")
	(FLAGS NDESCBIT INVISIBLE)
	(ACTION 0)>

<OBJECT BAT
	(IN GLOBAL-OBJECTS)
	(DESC "yourself")
	(SYNONYM BAT)
	(ADJECTIVE LARGE)
	(FLAGS ACTORBIT TOUCHBIT NARTICLEBIT)
	(ACTION BAT-F)>

<ROUTINE BAT-F ()
	 <COND (,FWEEPED
		<COND (<EQUAL? ,PRSO ,BAT>
		       <SETG PERFORMING-SPELL T>
		       <PERFORM ,PRSA ,ME ,PRSI>
		       <RTRUE>)
		      (T
		       <SETG PERFORMING-SPELL T>
		       <PERFORM ,PRSA ,PRSO ,ME>
		       <RTRUE>)>)
	       (<NOT <VERB? RESEARCH>>
		<YOU-CANT-SEE-ANY "bat">)
	       (T
		<TELL "The entry about bats is long and uninteresting." CR>)>>

<OBJECT ME
	(IN GLOBAL-OBJECTS)
	(SYNONYM ME MYSELF SELF ENCHAN)
	(DESC "yourself")
	(FLAGS ACTORBIT TOUCHBIT NARTICLEBIT)
	(ACTION ME-F)> 
	
<ROUTINE ME-F ("AUX" OLIT) 
	 <COND (<VERB? TELL>
		<TELL
"Talking to yourself is said to be a sign of impending mental collapse." CR>
		<STOP>)
	       (<VERB? LISTEN>
		<TELL "Yes?" CR>)
	       (<VERB? ALARM>
		<COND (,SLEEPING
		       <TELL
"As you wake up, Frobar sticks his head in the door and invites you
shopping. When you return late that evening, you find the Guild Hall
sacked, and many fellow Enchanters slaughtered. Servants of evil, teeth
smeared with blood, fall upon you as well. A menacing voice echoes about
the room. \"Pathetic Enchanters ... Who can save you now?\"|
|
Some days it just doesn't pay to wake up.">
		       <FINISH>)
		      (T
		       <TELL "You are obviously awake already." CR>)>)
	       (<VERB? RESEARCH>
		<TELL
"You find several sentences mentioning your heroic defeat of the
warlock Krill." CR>)
	       (<VERB? AIMFIZ>
		<TELL "You are suddenly ">
		<COND (,FLYING
		       <TELL "floating">)
		      (T
		       <TELL "standing">)>
		<TELL " right next to your former location! Wow!!" CR>)
	       (<VERB? VARDIK>
		<SETG VARDIKED T>
		<ENABLE <QUEUE I-UNVARDIK 12>>
		<TELL
"A feeling of warmth and protection fills your mind." CR>)
	       (<VERB? YOMIN>
		<TELL
"You sense a mind concentrating on casting the yomin spell." CR>) 
	       (<VERB? GASPAR>
		<SETG RESURRECTION-ROOM ,HERE>
		<TELL "A sense of peace of mind passes over you." CR>)
	       (<VERB? GOLMAC>
		<COND (,GOLMACKED
		       <POOF>)>
		<SETG GOLMACKED T>
		<FCLEAR ,KEROSENE-LAMP ,OPENBIT>
		<MOVE ,VARDIK-SCROLL ,KEROSENE-LAMP>
		<MOVE ,GOLMAC-SCROLL ,SLANTED-ROOM>
		<FCLEAR ,GOLMAC-SCROLL ,ONBIT>
		<MOVE ,ROPE ,SHAFT-BOTTOM>
		<MOVE ,BEAM ,COAL-MINE-1>
		<SETG ROPE-PLACED <>>
		<SETG ROPE-TO-BEAM <>>
		<SETG CURRENT-SETTING 0>
		<FCLEAR ,ROPE ,TOUCHBIT>
		<FCLEAR ,DIAL-DOOR ,OPENBIT>
		<SETG DIAL-OPEN <>>
		<TELL
"You are surrounded by a puff of smoke, and feel disoriented for a
moment. When the smoke clears, nothing seems to have changed">
		<COND (<EQUAL? ,HERE ,SLANTED-ROOM>
		       <TELL ", except that the kerosene lamp is now closed">)>
		<TELL "." CR>)
	       (<AND <VERB? LOWER-INTO>
		     <EQUAL? ,PRSI ,LOWER-CHUTE ,UPPER-CHUTE>>
		<DO-WALK ,P?DOWN>)
	       (<VERB? EXAMINE>
		<COND (,FWEEPED
		       <TELL
"You're batty! (And a rather large one, at that.)" CR>)
		      (<FSET? ,PROTAGONIST ,ONBIT>
		       <TELL
"You seem to have been frotzed." CR>)>)
	       (<AND <VERB? FROTZ>
		     <NOT <FSET? ,PROTAGONIST ,ONBIT>>>
		<COND (,SLEEPING 
		       <V-SWANZO>)
		      (T
		       <SET OLIT ,LIT>
		       <SETG ALWAYS-LIT T>
		       <FSET ,ME ,ONBIT>
		       <FSET ,PROTAGONIST ,ONBIT>
		       <FSET ,YOUNGER-SELF ,ONBIT>
		       <TELL
"You are bathed in a sickly yellow light, bright enough to read by." CR>
		       <SETG LIT <LIT? ,HERE>>
		       <COND (<AND <NOT .OLIT> ,LIT>
		              <CRLF>
			      <V-LOOK>)>
		       <RTRUE>)>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSI ,ME>>
		<COND (<HELD? ,PRSO>
		       <TELL "You already have it." CR>)
		      (T
		       <PERFORM ,V?TAKE ,PRSO>
		       <RTRUE>)>)
	       (<VERB? KILL MUNG ATTACK>
		<JIGS-UP "Done.">)
	       (<VERB? FIND>
		<TELL "You're right here!" CR>)>>

<OBJECT GRUE
	(IN GLOBAL-OBJECTS)
	(SYNONYM GRUE)
	(ADJECTIVE LURKIN SINIST HUNGRY SILENT LEGEND)
	(DESC "lurking grue")
	(ACTION GRUE-F)>

<ROUTINE GRUE-F ()
    <COND (<EQUAL? ,HERE ,GRUE-LAIR>
	   <THIS-IS-IT ,MUTATED-GRUES>)>
    <COND (<VERB? EXAMINE RUB RAISE LOWER KICK TAKE LOOK-UNDER>
	   <TELL "You can't see any grue here (thankfully)." CR>)
	  (<VERB? WHERE>
	   <TELL
"There is no grue here, but I'm sure there is at least one lurking
in the darkness nearby. I'd stay near a light source if I were you!" CR>)
	  (<VERB? LISTEN>
	   <TELL
"It makes no sound but is always lurking in the darkness nearby." CR>)
	  (<VERB? FROTZ>
	   <COND (<EQUAL? ,HERE ,GRUE-LAIR>		  
		  <TELL "There is a flash of light from nearby!" CR>
		  <COND (<NOT ,LIT>
			 <SETG LIT T>
			 <V-LOOK>)>
		  <FSET ,HERE ,ONBIT>)
		 (,LIT
		  <TELL "There aren't any grues here -- it's light!" CR>)
		 (T
		  <TELL
"There's a flash of light nearby, and you glimpse a horrible, multi-fanged
creature, a look of sheer terror on its face. It charges away, gurgling in
agony, tearing at its glowing fur." CR>)>)
	  (<VERB? RESEARCH>
	   <PERFORM ,V?RESEARCH ,LOBBY>
	   <RTRUE>)>>

<OBJECT WATER
	(IN LOCAL-GLOBALS)
	(SYNONYM WATER TRICKLE POOL)
	(ADJECTIVE SWIRLI TURBUL STAGNA)
	(DESC "water")
	(FLAGS NARTICLEBIT)
	(ACTION WATER-F)> 

<ROUTINE WATER-F ()
	 <COND (<VERB? DRINK DRINK-FROM>
	        <TELL "It's dangerous to drink untested water!" CR>)
	       (<VERB? LOOK-INSIDE>
		<MAKE-OUT>)
	       (<AND <VERB? FILL>
		     <FSET? ,PRSO ,VIALBIT>>
		<TELL
"A vial nymph appears to warn that water can destroy the delicate magic
properties of potion vials. It wags a finger at you before vanishing." CR>)
	       (<AND <EQUAL? ,WATER ,PRSI>
		     <NOT <EQUAL? ,HERE ,STAGNANT-POOL ,HIDDEN-CAVE>>>
		<WATER-IS-PRSI>)
	       (<EQUAL? ,HERE ,COVE ,LAGOON ,LAGOON-FLOOR>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,LAGOON-OBJECT ,PRSI>
		<RTRUE>)
	       (<EQUAL? ,HERE ,OCEAN-NORTH ,OCEAN-SOUTH ,MOUTH-OF-RIVER>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,OCEAN ,PRSI>
		<RTRUE>)
	       (<EQUAL? ,HERE ,DRAWBRIDGE>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,MOAT ,PRSI>
		<RTRUE>)
	       (<EQUAL? ,HERE ,RIVER-BANK>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,RIVER ,PRSI>
		<RTRUE>)
	       (<EQUAL? ,HERE ,FLUME>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,FLUME-OBJECT ,PRSI>
		<RTRUE>)
	       (<EQUAL? ,HERE ,STAGNANT-POOL>
		<COND (<VERB? THROUGH>
		       <DO-WALK ,P?NW>)
	              (<VERB? PULVER>
		       <JIGS-UP
"The pool evaporates, to the annoyance of a multi-tentacled denizen,
who proceeds to take out its anger on you.">)>)
	       (<EQUAL? ,HERE ,HIDDEN-CAVE>
		<COND (,RIVER-EVAPORATED
		       <YOU-CANT-SEE-ANY "water">)
		      (<VERB? PULVER>
		       <TELL
"The water recedes for a moment, then swirls back." CR>)
		      (<VERB? THROUGH>
		       <DO-WALK ,P?OUT>)>)
	       (<EQUAL? ,HERE ,RIVER-BED ,TOP-OF-FALLS ,STAGNANT-POOL>
		<TELL
"Hardly enough water here to get a good pulveration going." CR>)>>

<ROUTINE WATER-IS-PRSI ()
	 <COND (<EQUAL? ,HERE ,COVE ,LAGOON ,LAGOON-FLOOR>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,PRSO ,LAGOON-OBJECT>
		<RTRUE>)
	       (<EQUAL? ,HERE ,OCEAN-NORTH ,OCEAN-SOUTH ,MOUTH-OF-RIVER>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,PRSO ,OCEAN>
		<RTRUE>)
	       (<EQUAL? ,HERE ,DRAWBRIDGE>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,PRSO ,MOAT>
		<RTRUE>)
	       (<EQUAL? ,HERE ,RIVER-BANK>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,PRSO ,RIVER>
		<RTRUE>)
	       (<EQUAL? ,HERE ,FLUME>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,PRSO ,FLUME-OBJECT>
		<RTRUE>)>>

<OBJECT SKY
	(IN GLOBAL-OBJECTS)
	(DESC "sky")
	(SYNONYM SKY STARS)
	(ACTION SKY-F)>

<ROUTINE SKY-F ("AUX" EL)
	 <COND (<VERB? EXAMINE>
		<COND (<FSET? ,HERE ,INSIDEBIT>
		       <TELL "That would be difficult from here." CR>)
		      (<EQUAL? ,HERE ,LAGOON-FLOOR>
		       <TELL "The sky is blurry but visible." CR>)>)>>

<OBJECT BELBOZ
	(IN BELBOZ-HIDEOUT)
	(DESC "Belboz")
	(LDESC
"Belboz is lying here, motionless but not asleep. He seems to be in
some sort of trance.")
	(SYNONYM BELBOZ NECROMANCER)
	(FLAGS ACTORBIT NARTICLEBIT)
	(ACTION BELBOZ-F)>

<ROUTINE BELBOZ-F ()
	 <COND (<VERB? TELL ASK-ABOUT ASK-FOR GIVE>
		<TELL "Belboz is in some sort of trance." CR>
		<STOP>)
	       (<VERB? WHO>
		<TELL
"Belboz, your friend and mentor, is the head of the Circle of Enchanters.
Recently, he has been acting oddly and seems to have been avoiding you." CR>)
	       (<VERB? ALARM>
		<DISABLE <INT I-BELBOZ-AWAKES>>
		<I-BELBOZ-AWAKES>)
	       (<VERB? RESEARCH>
		<TELL
"There is a small entry about Belboz, mentioning that he is the Guildmaster
of the Accardi Chapter of the Guild of Enchanters, and has served three terms
as kingdomwide Secretary of the Guild." CR>)
	       (<AND <VERB? WHERE FIND>
		     <NOT <IN? ,BELBOZ ,HERE>>>
		<TELL
"You last saw Belboz a few days ago. You can't begin to
guess where he is now." CR>)
	       (<VERB? GASPAR>
		<SETG BELBOZ-GASPARED T>
		<RFALSE>)
	       (<VERB? AIMFIZ>
		<AIMFIZ-BELBOZ-JEEARR>
		<GOTO ,TWISTED-FOREST>
		<SETG SCORE <+ ,SCORE 20>>
		<DISABLE <INT I-PARROT>>
		<ENABLE <QUEUE I-HELLHOUND -1>>)
	       (<VERB? YOMIN>
		<TELL
"You get a horrifying glimpse of a monstrous creature intertwined
throughout Belboz's mind. You concentrate, attempting to translate
this image into visual terms, and imagine a giant spider with millions of
legs, wrapped around and feasting upon the body and spirit of Belboz. The
image fades, and you stagger backwards." CR>)
	       (<AND <VERB? KILL>
		     <EQUAL? ,PRSI ,KNIFE>>
		<KILL-BELBOZ>)
	       (<VERB? SWANZO>
		<SWANZO-BELBOZ>)>>

<ROUTINE AIMFIZ-BELBOZ-JEEARR ()
	 <TELL
"After a momentary dizziness, you realize that your location has changed,
although " D ,PRSO " is not in sight..." CR CR>>

<OBJECT GLOBAL-ROOM
	(IN GLOBAL-OBJECTS)
	(DESC "room")
	(SYNONYM ROOM CHAMBER PLACE HALL)
	(ADJECTIVE AREA)
	(ACTION GLOBAL-ROOM-F)>

<ROUTINE GLOBAL-ROOM-F ()
	 <COND (<VERB? LOOK EXAMINE LOOK-INSIDE>
		<V-LOOK>
		<RTRUE>)
	       (<VERB? THROUGH DROP EXIT>
		<V-WALK-AROUND>)
	       (<VERB? WALK-AROUND>
		<TELL
"Walking around the room reveals nothing new. If you want to move elsewhere,
simply indicate the desired direction." CR>)>>

<OBJECT ARCHWAY
	(IN LOCAL-GLOBALS)
	(DESC "doorway")
	(SYNONYM ARCH ARCHWA DOORWA)
	(ADJECTIVE LARGE WIDE MARBLE DAZZLI GLASS BREATH)
	(FLAGS NDESCBIT VOWELBIT)
	(ACTION ARCHWAY-F)>

<ROUTINE ARCHWAY-F ()
	 <COND (<VERB? THROUGH CROSS>
		<V-WALK-AROUND>)
	       (<VERB? LOOK-INSIDE>
		<MAKE-OUT>)>>

<OBJECT HOLE
	(IN LOCAL-GLOBALS)
	(DESC "opening")
	(SYNONYM HOLE OPENIN WELL)
	(ADJECTIVE SMALL SLIMY DARK)
	(FLAGS NDESCBIT)
	(ACTION HOLE-F)>

<ROUTINE HOLE-F ()
	 <COND (<EQUAL? ,HERE ,HOLLOW>
		<SETG PERFORMING-SPELL T>
		<COND (<EQUAL? ,HOLE ,PRSO>
		       <SETG PERFORMING-SPELL T>
		       <PERFORM ,PRSA ,BRICK-STRUCTURE ,PRSI>
		       <RTRUE>)
		      (T
		       <SETG PERFORMING-SPELL T>
		       <PERFORM ,PRSA ,PRSO ,BRICK-STRUCTURE>
		       <RTRUE>)>)
	       (<VERB? THROUGH CLIMB-FOO CLIMB-UP CLIMB-DOWN>
		<COND (<EQUAL? ,HERE ,FOREST-EDGE>
		       <DO-WALK ,P?DOWN>)
		      (<EQUAL? ,HERE ,SLIMY-ROOM>
		       <DO-WALK ,P?UP>)
		      (<EQUAL? ,HERE ,HIDDEN-CAVE>
		       <DO-WALK ,P?DOWN>)
		      (<EQUAL? ,HERE ,PIT-OF-BONES>
		       <DO-WALK ,P?UP>)
		      (<EQUAL? ,HERE ,DUNGEON>
		       <DO-WALK ,P?DOWN>)
		      (<EQUAL? ,HERE ,LOBBY>
		       <V-WALK-AROUND>)>)
	       (<VERB? LOOK-INSIDE>
		<MAKE-OUT>)>>

<OBJECT FOREST
	(IN LOCAL-GLOBALS)
	(DESC "blighted forest")
	(SYNONYM FOREST WOODS TREES)
	(ADJECTIVE BLIGHT DENSE SICKLY TWISTE)
	(FLAGS NDESCBIT)
	(ACTION FOREST-F)>

<ROUTINE FOREST-F ()
	 <COND (<VERB? MEEF>
		<TELL
"You're too late -- this forest dried up eons ago." CR>)
	       (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,MINE-FIELD ,FOREST-EDGE>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,HERE ,TWISTED-FOREST ,TREE-BRANCH>
		       <LOOK-AROUND-YOU>)
		      (T
		       <CANT-ENTER ,FOREST>)>)>>

<OBJECT CASTLE
	(IN LOCAL-GLOBALS)
	(DESC "castle")
	(SYNONYM CASTLE EGRETH RUINS)
	(ADJECTIVE CASTLE EGRETH RUINED ANCIEN)
	(FLAGS NDESCBIT)
	(ACTION CASTLE-F)>

<ROUTINE CASTLE-F ()
	 <COND (<VERB? RESEARCH>
		<TELL "Egreth was the castle of King Duncanthrax." CR>)
	       (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,DRAWBRIDGE ,RUINS>
		       <DO-WALK ,P?EAST>)
		      (T
		       <LOOK-AROUND-YOU>)>)>>

<OBJECT CAVE
	(IN LOCAL-GLOBALS)
	(DESC "cave")
	(SYNONYM CAVE CAVERN)
	(ADJECTIVE MAMMOT HIDDEN DARK)
	(FLAGS NDESCBIT)
	(ACTION CAVE-F)>

<ROUTINE CAVE-F ()
	 <COND (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,MOUTH-OF-RIVER ,GRUE-LAIR>
		       <DO-WALK ,P?WEST>)
		      (<EQUAL? ,HERE ,RIVER-BED>
		       <DO-WALK ,P?NE>)
		      (<EQUAL? ,HERE ,PIT-OF-BONES>
		       <DO-WALK ,P?UP>)
		      (<EQUAL? ,HERE ,BELBOZ-HIDEOUT>
		       <DO-WALK ,P?EAST>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? LOOK-INSIDE>
		<MAKE-OUT>)>> 

<OBJECT HELISTAR
	(IN DIAL)
	(DESC "Helistar")
	(SYNONYM HELIST)
	(FLAGS ACTORBIT NARTICLEBIT)
	(ACTION HELISTAR-F)>

<OBJECT FROBAR
	(IN DIAL)
	(DESC "Frobar")
	(SYNONYM FROBAR)
	(FLAGS ACTORBIT NARTICLEBIT)
	(ACTION FROBAR-F)>

<ROUTINE HELISTAR-F ()
	 <COND (<VERB? WHO>
		<TELL
"Helistar is an old and powerful member of the Circle. Although a
skilled and experienced magic-user, she is humorless to the point of
being grim. Despite this personality flaw, Helistar is the most likely
candidate to become the next Guildmaster of the Circle." CR>)
	       (<VERB? WHERE>
		<TELL
"Helistar has gone on her annual two-week vacation. She usually goes
to the southlands, Gurth and Mithicus." CR>)
	       (<VERB? AIMFIZ>
		<AIMFIZ-LOSE>
		<TELL <PICK-ONE ,HELISTARISMS>>
	        <JIGS-UP ".">)>>

<GLOBAL HELISTARISMS
	<PLTABLE
"skydiving near the mountains of Gurth. Not having a parachute, your
descent is considerably faster"
"scuba diving in the Sea of Mithicus. Before you can drown, a ferocious
sea lion devours you"
"sharpening her bullfighting skills. The crowd cheers wildly as
the bull gores you with its horns">>

<ROUTINE FROBAR-F ()
	 <COND (<VERB? WHO>
		<TELL
"Frobar is the most loyal and hard-working member of the Guild. However,
he is somewhat dull and lacks imagination. It is doubtful that he would
ever succeed Belboz as head of the Circle." CR>)
	       (<VERB? WHERE>
		<TELL
"Perhaps he's gone into town to perform some errands." CR>) 
	       (<VERB? AIMFIZ>
		<AIMFIZ-LOSE>
		<TELL <PICK-ONE ,FROBARISMS>>
		<JIGS-UP ".">)>>

<GLOBAL FROBARISMS
	<PLTABLE
"shopping in the marketplace. A horse-drawn chariot runs you down, trampling
you beneath dozens of hooves"
"crossing the bridge over Razor Gorge between town and the Guild Hall.
Unfortunately, you didn't quite make the bridge, and plummet onto nasty
rocks below"
"praying in the town's temple. Angered by your sacrilegious violation of
the ceremony, the priests skewer you with several handy sacred ornaments">>

<ROUTINE AIMFIZ-LOSE ()
	 <TELL
"When you recover from a brief dizziness, you notice " D ,PRSO
" nearby, looking surprised to see you. A moment later, you realize
that " D ,PRSO " is ">>

<OBJECT IMPLEMENTOR
	(IN DIAL)
	(DESC "author")
	(SYNONYM IMPLEM MERETZ AUTHOR ORACLE)
	(ADJECTIVE STEVE STEVEN BEARDE)
	(FLAGS VOWELBIT ACTORBIT)
	(ACTION IMPLEMENTOR-F)>

<ROUTINE IMPLEMENTOR-F ()
	 <COND (<VERB? AIMFIZ>
		<JIGS-UP
"You appear on a road in a far-off province called Cambridge. As you begin
choking on the polluted air, a mugger stabs you in the back with a knife.
A moment later, a wild-eyed motorist plows over you.">)
	       (<VERB? RESEARCH>
		<TELL
"Possibly the largest entry in the volume, detailing the facts and the
myths about the man known as the Bearded Oracle of Yonkers." CR>)>>

<OBJECT JEEARR
	(IN BELBOZ-HIDEOUT)
	(DESC "Jeearr")
	(SYNONYM JEEARR DEMON FORCE SPIRIT)
	(ADJECTIVE EVIL POWERF)
	(FLAGS ACTORBIT NDESCBIT NARTICLEBIT)
	(ACTION JEEARR-F)>

<ROUTINE JEEARR-F ()
	 <COND (<VERB? RESEARCH>
		<TELL
"There's a long write-up in the mythology section. The evil force called
Jeearr once spread pestilence and terror across many lands. Only the
combined magic of many kings and wizards stopped him, even as he was
preparing his final assault. He was imprisoned in the void beyond our
world, his jailors warning future generations that his exile might not
be permanent." CR>)
	       (<VERB? SWANZO>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,BELBOZ>
		<RTRUE>)
	       (<VERB? AIMFIZ>
		<AIMFIZ-BELBOZ-JEEARR>
		<GOTO ,TWISTED-FOREST>
		<SETG SCORE <+ ,SCORE 20>>
		<DISABLE <INT I-PARROT>>
		<ENABLE <QUEUE I-HELLHOUND -1>>)>>

^\L

;"magic stuff"

;"---Summary of magic spells---

  --Word--	--English--
  AIMFIZ	transport yourself to someone's location
  FROTZ		cause an object to give off light
  FWEEP		turn caster into a bat
  GNUSTO	write a magic spell into your spell book
  GOLMAC	travel temporally
  IZYUK		fly like a bird
  MALYON	bring life to inanimate objects
  REZROV	open a closed or locked object
  SWANZO	exorcise an inhabiting presence
  VARDIK	shield a mind from an evil spirit
  PULVER	cause liquids to dry up
  MEEF		cause plants to wilt
  VEZZA		view the future
  GASPAR	resurrection
  YOMIN		mind probe
  YONK		augment the power of certain spells"

<OBJECT SPELL-BOOK
	(IN DIAL)
	(SYNONYM BOOK NOTES)
	(ADJECTIVE MY SPELL MARGIN)
	(DESC "spell book")
	(ACTION SPELL-BOOK-F)
	(FLAGS TOUCHBIT TAKEBIT READBIT CONTBIT OPENBIT)>

<ROUTINE SPELL-BOOK-F ("AUX" (F <FIRST? ,SPELL-BOOK>))
	 <COND (<VERB? EXAMINE>
		<TELL
"This is the spell book given to you by Belboz after your original book
was lost during your battle with Krill. ">
		<COND (<FSET? ,SPELL-BOOK ,MUNGBIT>
		       <BOOK-DAMP>)
		      (T
		       <TELL
"There are several spells written in the book, with marginal
notes about their effects and how to cast them." CR>)>)
	       (<VERB? OPEN CLOSE>
		<TELL
"Thanks to its magic properties, the spell book is always open to the
right place at the right time, but it is also always closed. This innovation
eliminates tedious leafing and hunting for spells in tight situations. Many
wizardly lives have been saved by this advance in magical technology." CR>)
	       (<VERB? READ LOOK-INSIDE>
		<COND (<FSET? ,SPELL-BOOK ,MUNGBIT>
		       <BOOK-DAMP>
		       <RTRUE>)
		      (<AND <NOT ,LIT>
			    <NOT ,BLORTED>>
		       <TELL
"Though it is dark, the magic writing of your spells casts enough light
that you can read them." CR>)>
		<TELL CR "My Spell Book" CR CR>
		<REPEAT ()
			<COND (<NOT .F> <RETURN>)>
			<TELL "The " D .F " (" <GETP .F ,P?TEXT> ")." CR>
			<SET F <NEXT? .F>>>)>>

<OBJECT GNUSTO-SPELL 
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE GNUSTO)
	(DESC "gnusto spell")
	(TEXT "write a magic spell into a spell book")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT FROTZ-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE FROTZ)
	(DESC "frotz spell")
	(TEXT "cause something to give off light")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>

<OBJECT REZROV-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE REZROV)
	(DESC "rezrov spell")
	(TEXT "open even locked or enchanted objects")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)>	

<OBJECT YOMIN-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE YOMIN)
	(DESC "yomin spell")
	(TEXT "mind probe")
	(COUNT 0)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)
	(ACTION SPELL-F)>

<OBJECT IZYUK-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE IZYUK)
	(DESC "izyuk spell")
	(TEXT "fly like a bird")
	(COUNT 0)
	(ACTION SPELL-F)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT VOWELBIT)>

<GLOBAL FLYING <>>

<ROUTINE I-FLY ()
	 <SETG FLYING <>>
	 <CRLF>
	 <COND (<AND <EQUAL? ,HERE ,GLASS-MAZE>
		     <NO-FLOOR?>>
		<JIGS-UP
"The izyuk spell wears off. Unfortunately, this room of
the maze has no floor.">)
	       (<EQUAL? ,HERE ,TREE-BRANCH>
		<SETTLE-ONTO-BRANCH>)
	       (<EQUAL? ,HERE ,LAGOON>
		<SPLASH-INTO-WATER>)
	       (T
		<TELL "You settle gently to the ground." CR>)>
	 <COND (<G? ,AWAKE 8>
                <I-TIRED>)>>

<OBJECT PULVER-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE PULVER)
	(DESC "pulver spell")
	(TEXT "cause liquids to become dry")
	(COUNT 0)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)
	(ACTION SPELL-F)>

<OBJECT VEZZA-SPELL
	(IN SPELL-BOOK)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE VEZZA)
	(DESC "vezza spell")
	(TEXT "view the future")
	(COUNT 0)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)
	(ACTION SPELL-F)>

<ROUTINE SCROLL-F ("AUX" SPELL)
	 <COND (<VERB? TAKE>
		<SET SPELL <FIRST? ,PRSO>>
		<FSET .SPELL ,TOUCHBIT>
		<FCLEAR ,PRSO ,TRYTAKEBIT>
		<COND (<AND <EQUAL? ,PRSO ,SWANZO-SCROLL>
			    <NOT ,MAZE-CROSSED>>
		       <FSET ,PRSO ,TOUCHBIT>
		       <SETG MAZE-CROSSED T>
		       <REARRANGE-MAZE-TABLE>
		       <MOVE ,PRSO ,PROTAGONIST>
		       <TELL
"As you take the scroll, a deep and evil laugh rumbles around the hollow.
You hear a sliding, grinding noise and turn just in time to catch a flicker
of light from within the glass maze, indicating that its transparent panels
have shifted around." CR>
		       <RTRUE>)
		      (<EQUAL? ,PRSO ,FWEEP-SCROLL>
		       <FCLEAR ,PRSO ,TRYTAKEBIT>
		       <FCLEAR ,BAT-GUANO ,NDESCBIT>)>
		<RFALSE>)
	       (<AND <NOT <FIRST? ,PRSO>>
		     <NOT <FIRST? ,PRSI>>>
		<TELL "Bug #72" CR>)
	       (<VERB? GNUSTO>
		<SET SPELL <FIRST? ,PRSO>>
		<PERFORM ,V?GNUSTO .SPELL>
		<RTRUE>)
	       (<VERB? EXAMINE READ>
		<COND (<FSET? ,PRSO ,MUNGBIT>
		       <TELL "The scroll is wet and the spell illegible." CR>
		       <RTRUE>)>
		<SET SPELL <FIRST? ,PRSO>>
		<TELL
"The scroll reads \"" D .SPELL ": " <GETP .SPELL ,P?TEXT> "\".">
		<COND (<EQUAL? .SPELL ,AIMFIZ-SPELL ,YONK-SPELL>
		       <TELL
" The spell seems very long and extremely complicated.">)>
		<CRLF>)>>

<ROUTINE SPELL-F ("AUX" MEM? (FORGET <>))
	 <COND (<VERB? RESEARCH>
		<TELL "A spell produced by " <PICK-ONE ,MANUFACTURERS> "." CR>)
	       (<VERB? READ>
		<COND (<AND <NOT <IN? ,PRSO ,SPELL-BOOK>>
			    <NOT <IN? <LOC ,PRSO> ,PROTAGONIST>>>
		       <TELL
"You can't do that without having the spell in your book or on
a scroll in your hand." CR>)
		      (<FSET? <LOC ,PRSO> ,MUNGBIT>
		       <PERFORM ,V?READ ,SPELL-BOOK>
		       <THIS-IS-IT ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL "The spell reads \"">
		       <TELL <GETP ,PRSO ,P?TEXT>>
		       <TELL "\"." CR>)>)
	       (<VERB? LEARN>
		<COND (<NOT <IN? ,PRSO ,SPELL-BOOK>>
		       <COND (<IN? <LOC ,PRSO> ,PROTAGONIST>
			      <TELL
"You haven't written that spell into your book yet. Until you do, you
can't memorize the spell." CR>)
			     (T
			      <V-LEARN>)>)		      
		      (<EQUAL? ,PRSO ,GNUSTO-SPELL ,FROTZ-SPELL ,REZROV-SPELL>
		       <TELL "You already know that spell by heart." CR>)
		      (<NOT <IN? ,SPELL-BOOK ,PROTAGONIST>>
		       <TELL
"You don't have your spell book. How do you expect to memorize a spell
without a spell book?" CR>)
		      (<AND <NOT ,LIT>
			   <NOT ,BLORTED>>
		       <TELL
"It will be hard to learn that spell in the dark." CR>)
		      (<FSET? ,SPELL-BOOK ,MUNGBIT>
		       <PERFORM ,V?READ ,SPELL-BOOK>
		       <THIS-IS-IT ,PRSO>
		       <RTRUE>)
		      (T
		       <SET MEM? <GETP ,PRSO ,P?COUNT>>
		       <COND (<0? ,SPELL-ROOM>
			      <COND (<EQUAL? ,SPELL-MAX 1>
				     <TELL
"You can't concentrate well enough to learn the spell." CR>
				     <RTRUE>)
				    (<EQUAL? .MEM? ,SPELL-MAX>
				     <TELL
"You try and try, but you just can't memorize those complex syllables again.
They slip playfully out of your memory as soon as you cram them in." CR>
				     <RTRUE>)
				    (T
				     <FORGET-SPELL ,PRSO>
				     <SET MEM? <+ .MEM? 1>>
				     <PUTP ,PRSO ,P?COUNT .MEM?>
				     <SET FORGET T>)>)
			     (T
			      <SETG SPELL-ROOM <- ,SPELL-ROOM 1>>
			      <SET MEM? <+ .MEM? 1>>
			      <PUTP ,PRSO ,P?COUNT .MEM?>)>
		       <TELL
"Using your best study habits, you learn the " D ,PRSO>
		       <COND (<G? .MEM? 1>
			      <TELL " yet another time">)>
		       <TELL "." CR>
		       <COND (.FORGET
			      <TELL
"You have so much buzzing around in your head, though, that it's
likely that something may have been forgotten in the shuffle." CR>)>
		       <RTRUE>)>)
	       (<AND <NOT <VISIBLE? ,PRSO>>
		     <NOT <VERB? CAST>>>
		<TELL "You can't see that spell here!" CR>)
	       (<VERB? TAKE DROP THROW>
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE FORGET-SPELL (SPL "AUX" NSPL F CNT TBL (NUM 0) (SP <>))
	 <SET F <FIRST? ,SPELL-BOOK>>
	 <SET TBL ,FORGET-TBL>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (<G? <SET CNT <GETP .F ,P?COUNT>> 0>
			<REPEAT ()
				<SET SP .F>
				<PUT .TBL 1 .F>
				<SET NUM <+ .NUM 1>>
				<SET TBL <REST .TBL 2>>
				<COND (<L? <SET CNT <- .CNT 1>> 1>
				       <RETURN>)>>)>
		 <SET F <NEXT? .F>>>
	 <COND (<AND <G? .NUM 0>
		     <EQUAL? <GETP .SP ,P?COUNT> .NUM>>
		<PUTP .SP ,P?COUNT <- .NUM 1>>
		<RTRUE>)>
	 <PUT ,FORGET-TBL 0 .NUM>
	 <COND (<0? .NUM> <RTRUE>)>
	 <REPEAT ()
		 <COND (<NOT <EQUAL? <SET NSPL
					  <PICK-ONE ,FORGET-TBL>>
				     .SPL>>
			<PUTP .NSPL ,P?COUNT <- <GETP .NSPL ,P?COUNT> 1>>
			<RTRUE>)>>>

<GLOBAL FORGET-TBL <LTABLE 0 0 0 0 0 0 0 0 0 0>>

<ROUTINE FORGET-ALL ("AUX" F)
	 <SETG SPELL-ROOM ,SPELL-MAX>
	 <SET F <FIRST? ,SPELL-BOOK>>
	 <REPEAT ()
		 <COND (<NOT .F> <RETURN>)
		       (ELSE
			<PUTP .F ,P?COUNT 0>
			<SET F <NEXT? .F>>)>>>

<ROUTINE WEAR-OFF-SPELLS ()
	 <SETG UNDER-INFLUENCE <>>
	 <SETG FLYING <>>
	 <SETG FWEEPED <>>
	 <SETG VARDIKED <>>
	 <SETG VILSTUED <>>
	 <SETG BLORTED <>>
	 <SETG FOOBLED <>>
	 <DISABLE <INT I-FLY>>
	 <DISABLE <INT I-UNFWEEP>>
	 <DISABLE <INT I-UNVARDIK>>
	 <DISABLE <INT I-BREATHE>>
	 <DISABLE <INT I-UNBLORT>>
	 <DISABLE <INT I-UNFOOBLE>>
	 <SETG GNOME-SLEEPING T>
	 <DISABLE <INT I-GNOME>>
	 <MOVE ,PARK-GNOME ,DIAL>
	 <DISABLE <INT I-PARK-GNOME>>>

;<ROUTINE PLURAL? (N)
	 <COND (<NOT <==? .N 1>>
		<TELL "s">)>>

<GLOBAL REAL-SPELL-MAX 4>
<GLOBAL SPELL-MAX 4>  ;"max spells memorizable"
<GLOBAL SPELL-ROOM 3> ;"number can memorize now"

<GLOBAL MANUFACTURERS
	<PLTABLE
	 "Borphee Infotaters Incorporated"
	 "SpellBound"
	 "SoftSpel"
	 "International Business Magic"
	 "Spell Shack"
	 "United Thaumaturgy"
	 "Smoothscroll Draughtsmen"
	 "Frobozz Magic Spell Company">>

^\L

;"generic potion stuff"

<ROUTINE READ-ABOUT-POTIONS (NUM "AUX" MAKER)
	 <SET MAKER <GET ,POTION-MAKERS .NUM>>
	 <TELL "A potion made by " .MAKER "." CR>>

<GLOBAL POTION-MAKERS
	<PTABLE
	 0
	 "Fibbsbozza"
	 "Magicland"
	 "Frobozz Magic Potion Company">>

<ROUTINE POTION-POUR (VIAL)
	 <COND (<NOT <HELD? .VIAL>>
		<THIS-IS-IT .VIAL>
		<TELL ,YNH>
		<ARTICLE .VIAL T>
		<TELL "." CR>
		<RTRUE>)>
	 <MOVE ,PRSO ,DIAL>
	 <TELL "The potion evaporates before it even reaches">
	 <COND (,PRSI
		<ARTICLE ,PRSI T>
		<TELL "." CR>)
	       (T
		<TELL " the ground." CR>)>>

<GLOBAL UNDER-INFLUENCE <>>

<ROUTINE TWO-POTIONS ()
	 <TELL
"Uh oh. The " D ,PRSO " seems to be having an unpleasant reaction with
the " D ,UNDER-INFLUENCE ". " <PICK-ONE ,POTION-REACTIONS>>
	 <JIGS-UP ".">>

<GLOBAL POTION-REACTIONS
	<PLTABLE
	 "You turn into a spot of moss"
	 "Your left ear turns into a carnivorous toad and devours your brain"
	 "Your entire body, starting from the toes and moving upward, turns
into gelatin"
	 "Certain parts of your anatomy, including your pulmonary artery and
adrenal gland, suddenly teleport seven feet to the west">>

^\L

;"sleep, hunger, etc."

<GLOBAL SLEEPING T>

<GLOBAL AWAKE -1>

<GLOBAL LAST-SLEPT 40> ;"move when you last woke-up, for purposed of V-TIME"

<OBJECT GLOBAL-SLEEP
	(IN GLOBAL-OBJECTS)
	(DESC "sleep")
	(SYNONYM SLEEP NAP SNOOZE WINKS)
	(ADJECTIVE FORTY)
	(FLAGS NARTICLEBIT)
	(ACTION GLOBAL-SLEEP-F)>

<ROUTINE GLOBAL-SLEEP-F ()
	 <COND (<VERB? WALK-TO TAKE>
                <COND (<IN? ,PROTAGONIST ,YOUR-QUARTERS>
		       <MOVE ,PROTAGONIST ,BED>)>
		<PERFORM ,V?SLEEP>
		<RTRUE>)
	       (<VERB? FIND>
		<TELL "Sleep anywhere." CR>)>>X

<ROUTINE I-TIRED ("AUX" (FORG <>))
	 <COND (<IN? ,PROTAGONIST ,BED>
		<TELL CR
"The bed is comfortable and you are becoming tired." CR>
		<SETG AWAKE <+ ,AWAKE 1>>
		<V-SLEEP T>
		<RFATAL>)>
	 <COND (<G? ,LOAD-ALLOWED 10>
		<SETG LOAD-ALLOWED <- ,LOAD-ALLOWED 10>>)>
	 <COND (<G? ,FUMBLE-NUMBER 1>
		<SETG FUMBLE-NUMBER <- ,FUMBLE-NUMBER 1>>)>
	 <COND (<G? ,SPELL-MAX 1>
		<SETG SPELL-MAX <- ,SPELL-MAX 1>>
		<COND (<NOT <EQUAL? ,SPELL-ROOM 0>>
		       <SETG SPELL-ROOM <- ,SPELL-ROOM 1>>)>
		<COND (<EQUAL? ,SPELL-ROOM 0>
		       <SET FORG T>)>)>
	 <ENABLE <QUEUE I-TIRED 8>>
	 <SETG AWAKE <+ ,AWAKE 1>>
	 <COND (<G? ,AWAKE 8>
		<COND (,FLYING
		       <ENABLE <QUEUE I-TIRED 14>>
		       <RFALSE>)>
		<TELL CR "You drop in your tracks from exhaustion." CR CR>
		<V-SLEEP>
		<RFATAL>)
	       (T
		<TELL CR "You are " <GET ,TIRED-TELL ,AWAKE>>
		<COND (.FORG
		       <TELL
" and the spells you've memorized are becoming confused">)>
		<TELL "." CR>)>>

<GLOBAL DREAMS
	<PLTABLE	 

"You dream of being pursued through a dank cavern. Something is behind
you, something horrible that you can't turn to face. It gets closer and
closer, and you can feel its hot breath on your neck."

"You dream of an idyllic scene in the country, a picnic of wood-sprites
and dryads."

"You dream of dancing penguins in formal dress. One has a particularly
nice tuxedo and a cane with a gold top."

"You dream of a river, slow and muddy. Great grey hippopotami sport there,
bellowing and splashing, and twitching their ears.">>

<GLOBAL HUNGER-LEVEL 0>

<GLOBAL THIRST-LEVEL 0>

<ROUTINE I-HUNGER ()
	 <COND (,BERZIOED
		<SETG HUNGER-LEVEL 0>
		<ENABLE <QUEUE I-HUNGER <+ 580 <RANDOM 80>>>>
		<RFALSE>)
	       (<EQUAL? ,HUNGER-LEVEL 6>
		<SETG THIRST-LEVEL 6>
		<I-THIRST>)
	       (T
		<ENABLE <QUEUE I-HUNGER 11>>
		<HUNGER-THIRST-WARNING ,HUNGER-LEVEL T>
		<SETG HUNGER-LEVEL <+ ,HUNGER-LEVEL 1>>)>>

<ROUTINE I-THIRST ()
	 <COND (,BERZIOED
		<SETG THIRST-LEVEL 0>
		<ENABLE <QUEUE I-THIRST <+ 540 <RANDOM 100>>>>
		<RFALSE>)
	       (<EQUAL? ,THIRST-LEVEL 6>
		<CRLF>
		<JIGS-UP "You pass out from lack of food and water." T>)
	       (T
		<ENABLE <QUEUE I-THIRST 9>>
		<HUNGER-THIRST-WARNING ,THIRST-LEVEL>		
		<SETG THIRST-LEVEL <+ ,THIRST-LEVEL 1>>)>>

<ROUTINE HUNGER-THIRST-WARNING (LEVEL "OPTIONAL" (HUNGRY <>))
	 <TELL CR "You are now " <GET ,HUNGER-THIRST-TABLE .LEVEL>>
	 <COND (.HUNGRY
		<TELL " hungry">)
	       (T
		<TELL " thirsty">)>
	 <TELL "." CR>>

<GLOBAL HUNGER-THIRST-TABLE
	<PTABLE
	 "a bit"
	 "somewhat"
	 "quite"
	 "very"
	 "extremely"
	 "incredibly"
	 "dangerously">>
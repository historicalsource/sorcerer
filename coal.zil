"COAL for
			    SORCERER
	(c) Copyright 1984 by Infocom Inc.  All Rights Reserved"

<OBJECT COAL
	(IN LOCAL-GLOBALS)
	(DESC "lumps of coal")
	(SYNONYM LUMPS COAL)
	(FLAGS NDESCBIT NARTICLEBIT)
	(ACTION COAL-F)>

<ROUTINE COAL-F ()
	 <COND (<VERB? TAKE>
		<TELL "Such menial tasks are best left to troglodytes." CR>)>>

<ROOM SOOTY-ROOM
      (IN ROOMS)
      (SYNONYM RIVER)
      (ADJECTIVE FRIGID)
      (DESC "Sooty Room")
      (LDESC
"The walls and ceiling of this room are covered with soot and held up by
timbers which don't look very sturdy. A winding tunnel leads north. From
the east comes a sulfurous odor.")
      (NORTH TO HALL-OF-CARVINGS)
      (EAST PER SOOTY-ROOM-EXIT-F)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL SOOT)
      (PSEUDO "TIMBER" TIMBER-PSEUDO)
      (ACTION SOOTY-ROOM-F)>

<ROUTINE SOOTY-ROOM-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <NOT <FSET? ,SOOTY-ROOM ,TOUCHBIT>>>
		<SETG SCORE <+ ,SCORE 20>>)>>

<ROUTINE SOOTY-ROOM-EXIT-F ()
	 <COND (<FSET? ,COAL-BIN-ROOM ,TOUCHBIT>
		<TELL
"That passage is now completely blocked by a cave-in." CR>
		<RFALSE>)
	       (T
		,COAL-BIN-ROOM)>>

<ROUTINE TIMBER-PSEUDO ()
	 <COND (<VERB? MOVE>
		<JIGS-UP "Part of the ceiling collapses onto you.">)>>

<ROOM COAL-BIN-ROOM
      (IN ROOMS)
      (DESC "Coal Bin Room")
      (LDESC
"This is obviously the heart of a large coal mine, illuminated by a
wall-mounted lamp. The bottom of a metal coal chute is visible at the
north end of the room. Another chute continues downward at the southern
end. A large coal bin is overflowing, and the floor is completely covered
with lumps of coal. A passage leads east, but a western passage is blocked
by rubble.")
      (UP PER CHUTE-ENTER-F)
      (NORTH PER CHUTE-ENTER-F)
      (DOWN TO COVE)
      (SOUTH TO COVE)
      (EAST TO DIAL-ROOM)
      (WEST PER SOOTY-ROOM-EXIT-F)
      (FLAGS RLANDBIT INSIDEBIT ONBIT)
      (GLOBAL UPPER-CHUTE LOWER-CHUTE COAL)
      (PSEUDO "LAMP" LAMP-PSEUDO)
      (ACTION COAL-BIN-ROOM-F)>

<ROUTINE COAL-BIN-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		       <SETG COMBO <RANDOM 873>>
		       <PUT ,VEZZAS 5 0>
		       <TELL
"There is a rumbling noise behind you as the ceiling of the tunnel collapses,
blocking your retreat! The air smells strongly of coal gas. ">
		       <COND (,VILSTUED
		              <ENABLE <QUEUE I-OLDER-SELF 2>>
			      <TELL "Good thing you took that vilstu potion">)
		             (T
		              <ENABLE <QUEUE I-SUFFOCATE 2>>
			      <TELL
"You won't survive long in this atmosphere">)>
		       <TELL "." CR CR>)
		      (,GOLMACKED
		       <ENABLE <QUEUE I-YOUNGER-SELF -1>>
		       <MOVE ,YOUNGER-SELF ,HERE>
		       <COND (,YOUNGER-HAS-SPELL-BOOK
			      <COND (<IN? ,SPELL-BOOK ,LAGOON-FLOOR>
				     <SETG BOOK-BELONGS-IN-LAGOON T>)>
			      <MOVE ,SPELL-BOOK ,YOUNGER-SELF>
			      <FSET ,SPELL-BOOK ,TRYTAKEBIT>)>
		       <SETG LIT <LIT? ,HERE>>)>)
	       (<AND <EQUAL? .RARG ,M-END>
		     <PROB 35>>
		<TELL CR
"A few lumps of coal spill from the coal chute." CR>)>> 

<GLOBAL YOUNGER-HAS-SPELL-BOOK <>>

<GLOBAL BOOK-BELONGS-IN-LAGOON <>>

<GLOBAL SUFFOCATE-WARNING <>>

<ROUTINE I-SUFFOCATE ()
	 <CRLF>
	 <COND (,SUFFOCATE-WARNING
		<JIGS-UP "Finally, the shortage of oxygen gets to you.">)
	       (T
		<SETG SUFFOCATE-WARNING T>
		<ENABLE <QUEUE I-SUFFOCATE 2>>
		<TELL "You are about to pass out from the bad air." CR>)>>

<OBJECT COAL-BIN
	(IN COAL-BIN-ROOM)
	(DESC "coal bin")
	(SYNONYM BIN)
	(ADJECTIVE LARGE COAL)
	(FLAGS NDESCBIT)
	(ACTION COAL-BIN-F)>

<ROUTINE COAL-BIN-F ()
	 <COND (<VERB? LOOK-INSIDE>
		<TELL "It's full of coal." CR>)
	       (<VERB? SEARCH DIG>
		<TELL "You find nothing of interest." CR>)>>

<OBJECT UPPER-CHUTE
	(IN LOCAL-GLOBALS)
	(DESC "upper coal chute")
	(SYNONYM CHUTE)
	(ADJECTIVE UPPER COAL METAL)
	(FLAGS VOWELBIT)
	(ACTION UPPER-CHUTE-F)>

<OBJECT LOWER-CHUTE
	(IN LOCAL-GLOBALS)
	(DESC "lower coal chute")
	(SYNONYM CHUTE)
	(ADJECTIVE LOWER COAL METAL)
	(ACTION LOWER-CHUTE-F)>

<ROUTINE UPPER-CHUTE-F ()
	 <COND (<VERB? THROUGH LEAP>
		<COND (<EQUAL? ,HERE ,TOP-OF-CHUTE ,SLANTED-ROOM>
		       <DO-WALK ,P?DOWN>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? CLIMB-UP CLIMB-FOO>
		<COND (<EQUAL? ,HERE ,TOP-OF-CHUTE>
		       <BOTTOM-TOP-OF-CHUTE T>)
		      (T
		       <DO-WALK ,P?UP>)>)
	       (<VERB? CLIMB-DOWN>
		<COND (<EQUAL? ,HERE ,COAL-BIN-ROOM>
		       <BOTTOM-TOP-OF-CHUTE>)
		      (T
		       <DO-WALK ,P?DOWN>)>)
	       (<AND <VERB? PUT LOWER-INTO>
		     <EQUAL? ,PRSI ,UPPER-CHUTE>>
		<COND (<EQUAL? ,HERE ,TOP-OF-CHUTE ,SLANTED-ROOM>
		       <COND (<AND <EQUAL? ,PRSO ,BEAM>
				   ,ROPE-TO-BEAM>
			      <MOVE ,ROPE ,COAL-BIN-ROOM>
			      <MOVE ,BEAM ,COAL-BIN-ROOM>
			      <SETG ROPE-PLACED <>>
			      <FCLEAR ,BEAM ,TRYTAKEBIT>
			      <FCLEAR ,ROPE ,TRYTAKEBIT>
			      <BEAM-AND-ROPE>)
			     (<AND <EQUAL? ,PRSO ,ROPE>
				   ,ROPE-TO-BEAM>
		              <COND (<DROP-BEAM-FIRST>
				     <RTRUE>)>
			      <SETG ROPE-PLACED T>
			      <FSET ,BEAM ,TRYTAKEBIT>
			      <FSET ,ROPE ,TRYTAKEBIT>
		              <MOVE ,ROPE ,HERE>
		              <ROPE-HANGS>)
		             (T
			      <COND (<L? <GETP ,PRSO ,P?SIZE> 20>
				     <MOVE ,PRSO ,DIAL>)
				    (T
				     <MOVE ,PRSO ,COAL-BIN-ROOM>)>
		              <DISAPPEARS-DOWN-CHUTE>)>)
		      (<EQUAL? ,HERE ,COAL-BIN-ROOM>
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?RESEARCH ,UPPER-CHUTE>
		<RTRUE>)>>

<ROUTINE LOWER-CHUTE-F ()
	 <COND (<VERB? CLIMB-UP CLIMB-FOO>
		<COND (<EQUAL? ,HERE ,COAL-BIN-ROOM>
		       <BOTTOM-TOP-OF-CHUTE T>)
		      (T
		       <DO-WALK ,P?UP>)>)
	       (<VERB? CLIMB-DOWN THROUGH LEAP>
		<COND (<EQUAL? ,HERE ,COVE>
		       <BOTTOM-TOP-OF-CHUTE>)
		      (T
		       <DO-WALK ,P?DOWN>)>)
	       (<AND <VERB? PUT LOWER-INTO>
		     <EQUAL? ,PRSI ,LOWER-CHUTE>>
		<COND (<EQUAL? ,HERE ,COAL-BIN-ROOM>
		       <COND (<AND <EQUAL? ,PRSO ,BEAM>
				   ,ROPE-TO-BEAM>
			      <MOVE ,ROPE ,LAGOON-FLOOR>
			      <MOVE ,BEAM ,LAGOON-FLOOR>
			      <SETG ROPE-IN-LOWER-CHUTE <>>
			      <FCLEAR ,ROPE ,TRYTAKEBIT>
			      <BEAM-AND-ROPE>)
			     (<AND <EQUAL? ,PRSO ,ROPE>
				   ,ROPE-TO-BEAM>
		              <COND (<DROP-BEAM-FIRST>
				     <RTRUE>)>
			      <SETG ROPE-IN-LOWER-CHUTE T>
			      <FSET ,ROPE ,TRYTAKEBIT>
		              <MOVE ,ROPE ,HERE>
		              <ROPE-HANGS>)
		             (T
			      <MOVE ,PRSO ,LAGOON-FLOOR>
			      <COND (<OR <FSET? ,PRSO ,SCROLLBIT>
					 <EQUAL? ,PRSO ,SPELL-BOOK>>
			             <FSET ,PRSO ,MUNGBIT>)>
		              <DISAPPEARS-DOWN-CHUTE>)>)
		      (<EQUAL? ,HERE ,COAL-BIN-ROOM>
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? LOOK-INSIDE>
		<PERFORM ,V?RESEARCH ,LOWER-CHUTE>
		<RTRUE>)>>

<ROUTINE DROP-BEAM-FIRST ()
	 <COND (<HELD? ,BEAM>
	        <TELL "You'll have to drop the beam before doing that." CR>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE BEAM-AND-ROPE ()
	 <TELL "The beam and rope both slide into the chute." CR>>

<ROUTINE ROPE-HANGS ()
	 <TELL "The rope hangs from the beam, into the chute." CR>>

<ROUTINE DISAPPEARS-DOWN-CHUTE ()
	 <TELL "The " D ,PRSO " disappears into the chute." CR>>

<OBJECT OLDER-SELF
	(IN DIAL)
	(DESC "your older self")
	(SYNONYM STRANG SELF OLDER TWIN)
	(ADJECTIVE YOUR MY OLDER)
	(FLAGS ACTORBIT NARTICLEBIT CONTBIT OPENBIT SEARCHBIT)
	(ACTION OLDER-SELF-F)>

<ROUTINE OLDER-SELF-F ()
	 <COND (<EQUAL? ,WINNER ,OLDER-SELF>
		<TELL "Your older self ignores your words." CR>
		<STOP>)
	       (<VERB? EXAMINE>
		<TELL
,OLDER-INTRO " The stranger is carrying a smelly scroll." CR>)
	       (<AND <VERB? GIVE>
		     <EQUAL? ,PRSO ,SPELL-BOOK>>
		<MOVE ,SPELL-BOOK ,OLDER-SELF>
		<FSET ,SPELL-BOOK ,TRYTAKEBIT>
		<TELL "Your older self accepts the spell book gratefully." CR>)
	       (<AND <VERB? FOLLOW>
		     ,TWIN-FOLLOW>
		<DO-WALK ,P?DOWN>)
	       (<VERB? AIMFIZ>
		<V-SWANZO>)
	       (<VERB? YOMIN>
		<TELL
"The thoughts of your older self center on attempting to breathe." CR>)>>

;<GLOBAL MOVE-N-TABLE
	 <TABLE
	  0
	  PRSA
	  PRSO
	  PRSI
	  SPELL-BOOK IN YOUNGER-SELF?>>

<GLOBAL MOVE-ONE-TABLE
	<TABLE 0 0 0 0>>

<GLOBAL MOVE-TWO-TABLE
	<TABLE 0 0 0 0>>

<GLOBAL MOVE-THREE-TABLE
	<TABLE 0 0 0 0>>

<GLOBAL OLDER-COUNTER 0>

<GLOBAL COMBO-DISCOVERED <>>

<GLOBAL OLDER-INTRODUCED <>>

<GLOBAL OLDER-INTRO
"Although your clothes are much cleaner and less torn, the stranger looks
virtually like your own twin!">

<ROUTINE I-OLDER-SELF ()
	 <ENABLE <QUEUE I-OLDER-SELF -1>>
	 <SETG OLDER-COUNTER <+ ,OLDER-COUNTER 1>>
	 <COND (<EQUAL? ,OLDER-COUNTER 1>
		<MOVE ,OLDER-SELF ,COAL-BIN-ROOM>
		<COND (<HELD? ,SPELL-BOOK>
		       <SETG YOUNGER-HAS-SPELL-BOOK T>)>
		<COND (<EQUAL? ,HERE ,COAL-BIN-ROOM>
		       <TELL CR
"Someone slides out of the coal chute, and lands near the bin. ">
		       <TELL ,OLDER-INTRO CR>
		       <SETG OLDER-INTRODUCED T>)
		      (<EQUAL? ,HERE ,DIAL-ROOM>
		       <TELL CR
"You here a commotion from the room to the west." CR>)
		      (T
		       <DISABLE <INT I-OLDER-SELF>>
		       <RFALSE>)>)
	       (<EQUAL? ,OLDER-COUNTER 2>
		<DATA-TO-TABLE ,MOVE-ONE-TABLE>
		<COND (<EQUAL? ,HERE ,COAL-BIN-ROOM>
		       <CRLF>
		       <COND (<NOT ,OLDER-INTRODUCED>
			      <SETG OLDER-INTRODUCED T>
			      <TELL
"Someone is standing near the coal bin. " ,OLDER-INTRO CR CR>)>
		       <SETG COMBO-DISCOVERED T>
		       <OLDER-TELLS-COMBO>
		       <COND (<NOT <IN? ,SPELL-BOOK ,OLDER-SELF>>
			      <TELL
" Your older self then looks at you, almost expectantly.">)>
		       <CRLF>)
		      (T
		       <TELL CR
"From the next room you glimpse someone gasping for air." CR>)>)
	       (<EQUAL? ,OLDER-COUNTER 3>
		<DATA-TO-TABLE ,MOVE-TWO-TABLE>
		<COND (<EQUAL? ,HERE ,COAL-BIN-ROOM>
		       <COND (<NOT ,OLDER-INTRODUCED>
			      <SETG OLDER-INTRODUCED T>
			      <TELL CR
"Someone is standing near the coal bin. " ,OLDER-INTRO CR>)>
		       <COND (<IN? ,SPELL-BOOK ,OLDER-SELF>
			      <MOVE ,SPELL-BOOK ,YOUNGER-SELF>
			      <FSET ,SPELL-BOOK ,TRYTAKEBIT>
			      <MOVE ,OLDER-SELF ,DIAL>
			      <MOVE ,VARDIK-SCROLL ,DIAL>
			      <SETG TWIN-FOLLOW T>
			      <ENABLE <QUEUE I-TWIN-UNFOLLOW 1>>
			      <TELL CR
"Your look-alike dives into the lower chute and slides out of view." CR>)
			     (<NOT ,COMBO-DISCOVERED>
			      <CRLF>
			      <OLDER-TELLS-COMBO>
			      <CRLF>)
			     (T
			      <TELL CR
"\"Give me...the spell book,\" croaks your older self." CR>)>)
		      (T
		       <MOVE ,OLDER-SELF ,DIAL>
		       <MOVE ,VARDIK-SCROLL ,DIAL>
		       <TELL CR
"Someone in the coal bin room dives into the lower chute." CR>)>)
	       (T
		<DATA-TO-TABLE ,MOVE-THREE-TABLE>
		<DISABLE <INT I-OLDER-SELF>>
		<COND (<AND <EQUAL? ,HERE ,COAL-BIN-ROOM>
			    <IN? ,OLDER-SELF ,HERE>>
		       <TELL CR
"Your older self dives into the lower chute." CR>)>
		<MOVE ,OLDER-SELF ,DIAL>
		<MOVE ,VARDIK-SCROLL ,DIAL>)>>

<ROUTINE OLDER-TELLS-COMBO ()
	 <TELL
"Your disheveled \"twin\" is having difficulty breathing, but gasps,
\"The combination is " N ,COMBO ".\"">>

<GLOBAL TWIN-FOLLOW <>>

<ROUTINE I-TWIN-UNFOLLOW ()
	 <SETG TWIN-FOLLOW <>>
	 <RFALSE>>

<ROUTINE DATA-TO-TABLE (TABLE)
	 <PUT .TABLE 1 ,PRSA>
	 <PUT .TABLE 2 ,PRSO>
	 <PUT .TABLE 3 ,PRSI>>

<OBJECT YOU-OBJECT
	(IN DIAL)
	(DESC "you")
	(FLAGS NARTICLEBIT NDESCBIT)>

<OBJECT YOUNGER-SELF
	(IN DIAL)
	(DESC "your younger self")
	(SYNONYM SELF YOUNGE TWIN)
	(ADJECTIVE YOUR YOUNGE MY)
	(FLAGS ACTORBIT NARTICLEBIT CONTBIT OPENBIT SEARCHBIT)
	(DESCFCN YOUNGER-SELF-DESCFCN)
	(ACTION YOUNGER-SELF-F)>

<GLOBAL COMBO-REVEALED <>>

<ROUTINE YOUNGER-SELF-F ()
	 <COND (<EQUAL? ,YOUNGER-SELF ,WINNER>
		<COND (<AND <VERB? COMBO>
			    <EQUAL? ,PRSO ,INTNUM>>
		       <COND (<EQUAL? ,P-NUMBER ,COMBO>
			      <SETG COMBO-REVEALED T>)>
		       <TELL
"Your younger self seems surprised by your statement." CR>)
		      (<AND <VERB? GIVE>
			    <EQUAL? ,PRSO ,SPELL-BOOK>
			    <EQUAL? ,PRSI ,ME>
			    <SPELL-BOOK-PASS-OFF-CHECK>>
		       <RTRUE>)
		      (T
		       <TELL
"Your younger self seems confused, and doesn't respond." CR>
		       <STOP>)>)
	       (<VERB? YOMIN>
		<TELL
"The thoughts of your younger self are confused, and seem to center on
whether or not to perform a SAVE." CR>)
	       (<VERB? AIMFIZ>
		<V-SWANZO>)
	       (<VERB? EXAMINE>
		<TELL
"It's almost like looking in a mirror. Your younger self looks confused">
		<COND (<IN? ,SPELL-BOOK ,YOUNGER-SELF>
		       <TELL ", and is carrying a spell book">)>
		<TELL "." CR>)>>

<ROUTINE YOUNGER-SELF-DESCFCN (TABLE)
	 <COND (<L? ,YOUNGER-COUNTER 3>
		<SET TABLE ,MOVE-ONE-TABLE>)
	       (<EQUAL? ,YOUNGER-COUNTER 3>
		<SET TABLE ,MOVE-TWO-TABLE>)
	       (T
		<SET TABLE ,MOVE-THREE-TABLE>)>
	 <COND (<FSET? ,YOUNGER-SELF ,TOUCHBIT>
		<TELL "Your younger self is here">
		<COND (,YOUNGER-HAS-SPELL-BOOK
		       <TELL ", holding your spell book." CR>)
		      (T
		       <TELL "." CR>)>)
	       (T
		<FSET ,YOUNGER-SELF ,TOUCHBIT>
		<TELL
"Standing here, looking quite confused, is someone who could only be your
younger self -- an exact duplicate of you, but cleaner and breathing with
considerably less difficulty. You remember seeing this scene from another
viewpoint just a short while ago.">
		<COND (,YOUNGER-HAS-SPELL-BOOK
		       <TELL
" Among the items carried by your \"twin\" is your spell book.">)>
		<CRLF>)>>

<ROUTINE SPELL-BOOK-PASS-OFF-CHECK ("AUX" TABLE)
	 <COND (<EQUAL? ,YOUNGER-COUNTER 1>
		<SET TABLE ,MOVE-ONE-TABLE>)
	       (<EQUAL? ,YOUNGER-COUNTER 2>
		<SET TABLE ,MOVE-TWO-TABLE>)
	       (<EQUAL? ,YOUNGER-COUNTER 3>
		<SET TABLE ,MOVE-THREE-TABLE>)
	       (T
		<RFALSE>)>
	 <COND (<OR <AND <EQUAL? <GET .TABLE 2> ,SPELL-BOOK>
		         <EQUAL? <GET .TABLE 3> ,OLDER-SELF>
		         <EQUAL? <GET .TABLE 1> ,V?GIVE>>
		    <AND <EQUAL? <GET .TABLE 2> ,OLDER-SELF>
		         <EQUAL? <GET .TABLE 3> ,SPELL-BOOK>
		         <EQUAL? <GET .TABLE 1> ,V?SGIVE>>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<GLOBAL YOUNGER-COUNTER 0>

<ROUTINE I-YOUNGER-SELF ()
	 <SETG YOUNGER-COUNTER <+ ,YOUNGER-COUNTER 1>>
	 <COND (<NOT <IN? ,YOUNGER-SELF ,HERE>>
		<RFALSE>)
	       (<AND <NOT ,LIT>
		     <NOT ,BLORTED>>
		<RFALSE>)
	       (<EQUAL? ,YOUNGER-COUNTER 2>
		<YOUNGER-ACTIONS ,MOVE-ONE-TABLE>)
	       (<EQUAL? ,YOUNGER-COUNTER 3>
		<YOUNGER-ACTIONS ,MOVE-TWO-TABLE>)
	       (<EQUAL? ,YOUNGER-COUNTER 4>
		<YOUNGER-ACTIONS ,MOVE-THREE-TABLE>)>>

<ROUTINE YOUNGER-ACTIONS (TABLE)
	 <COND (<NOT <GET .TABLE 2>>
		<PUT .TABLE 2 ,NOT-HERE-OBJECT>)>
	 <COND (<NOT <GET .TABLE 3>>
		<PUT .TABLE 3 ,NOT-HERE-OBJECT>)>
	 <COND (<EQUAL? <GET .TABLE 2> ,OLDER-SELF>
		<PUT .TABLE 2 ,YOU-OBJECT>)
	       (<EQUAL? <GET .TABLE 2> ,ME>
		<PUT .TABLE 2 ,YOUNGER-SELF>)>
	 <COND (<EQUAL? <GET .TABLE 3> ,OLDER-SELF>
		<PUT .TABLE 3 ,YOU-OBJECT>)
	       (<EQUAL? <GET .TABLE 3> ,ME>
		<PUT .TABLE 3 ,YOUNGER-SELF>)>
	 <TELL CR "Your younger self ">
	 <COND (<OR <AND <EQUAL? <GET .TABLE 2> ,SPELL-BOOK>
		         <EQUAL? <GET .TABLE 3> ,YOU-OBJECT>
		         <EQUAL? <GET .TABLE 1> ,V?GIVE>>
		    <AND <EQUAL? <GET .TABLE 2> ,YOU-OBJECT>
		         <EQUAL? <GET .TABLE 3> ,SPELL-BOOK>
		         <EQUAL? <GET .TABLE 1> ,V?SGIVE>>>
		<MOVE ,SPELL-BOOK ,PROTAGONIST>
		<FCLEAR ,SPELL-BOOK ,TRYTAKEBIT>
		<TELL "hands you your spell book!" CR>)
	       (<OR <EQUAL? <GET .TABLE 1> ,V?VERBOSE ,V?BRIEF ,V?SUPER-BRIEF>
		    <EQUAL? <GET .TABLE 1> ,V?SCORE ,V?SCRIPT ,V?UNSCRIPT>>
		<TELL "is performing a spell of high technology." CR>)
	       (<OR <EQUAL? <GET .TABLE 1> ,V?ANSWER ,V?REPLY ,V?CURSE>
		    <EQUAL? <GET .TABLE 1> ,V?HELLO ,V?TELL ,V?ASK-FOR>
		    <EQUAL? <GET .TABLE 1> ,V?SAY ,V?THANK ,V?YELL>
		    <EQUAL? <GET .TABLE 1> ,V?ASK-ABOUT>>
		<TELL "is attempting to talk." CR>)
	       (<OR <EQUAL? <GET .TABLE 1> ,V?CAST ,V?GNUSTO ,V?FROTZ>
		    <EQUAL? <GET .TABLE 1> ,V?REZROV ,V?IZYUK ,V?FWEEP>
		    <EQUAL? <GET .TABLE 1> ,V?AIMFIZ ,V?SWANZO ,V?VARDIK>
		    <EQUAL? <GET .TABLE 1> ,V?MEEF ,V?PULVER ,V?GOLMAC>
		    <EQUAL? <GET .TABLE 1> ,V?YOMIN ,V?VEZZA ,V?GASPAR>
		    <EQUAL? <GET .TABLE 1> ,V?YONK ,V?MALYON>>
		<TELL "is casting a familiar spell." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?INVENTORY>
		<TELL "is doing an inventory." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?DIAGNOSE>
		<TELL "is checking for wounds." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?WAIT>
		<TELL "is doing absolutely nothing." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?SLEEP>
		<TELL "is trying to fall asleep!" CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?LEARN>
		<TELL "is studying a spell book." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?SPELLS>
	        <TELL "seems lost in thought." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?LOOK>
		<TELL "is looking around." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?LEAP ,V?SKIP>
		<TELL "is hopping around like a crazed rabbit." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?WALK ,V?WALK-AROUND ,V?WALK-TO>
		<TELL "is moving around." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?GIVE>
		<TELL "is trying to give">
		<ARTICLE <GET .TABLE 2>>
		<TELL " to">
		<ARTICLE <GET .TABLE 3>>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?SHOW>
		<TELL "is trying to show">
		<ARTICLE <GET .TABLE 2>>
		<TELL " to">
		<ARTICLE <GET .TABLE 3>>
		<TELL "." CR>)
	       (<OR <EQUAL? <GET .TABLE 1> ,V?RAISE ,V?LOWER ,V?RUB>
		    <EQUAL? <GET .TABLE 1> ,V?MOVE ,V?SHAKE ,V?PUSH>
		    <EQUAL? <GET .TABLE 1> ,V?KICK ,V?PUT-ON ,V?PUSH-TO>
		    <EQUAL? <GET .TABLE 1> ,V?PUT ,V?PUT-UNDER ,V?PUT-BEHIND>>
		<COND (<AND <EQUAL? <GET .TABLE 1> ,V?PUT>
			    <EQUAL? <GET .TABLE 2> ,SPELL-BOOK>
			    <EQUAL? <GET .TABLE 3> ,LOWER-CHUTE>>
		       <MOVE ,SPELL-BOOK ,DIAL>)>
		<TELL "is attempting to move">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<OR <EQUAL? <GET .TABLE 1> ,V?EXAMINE ,V?LOOK-INSIDE>
		    <EQUAL? <GET .TABLE 1> ,V?LOOK-BEHIND ,V?LOOK-UNDER>>
		<TELL "is examining">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?BOARD ,V?ENTER ,V?THROUGH>
		<TELL "is trying to get into">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?THROW ,V?THROW-OFF>
		<TELL "is performing aeronautical experiments with">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?WHAT ,V?WHERE ,V?WHO>
		<TELL "is asking about">
		<ARTICLE <GET .TABLE 2>>
		<TELL ", addressing the question to no one in particular." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?ATTACK ,V?KILL ,V?MUNG>
		<TELL "is attacking">
		<ARTICLE <GET .TABLE 2> T>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?EAT ,V?DRINK>
		<TELL "is attempting to ingest">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<OR
		 <EQUAL? <GET .TABLE 1> ,V?CLIMB-ON ,V?CLIMB-UP ,V?CLIMB-FOO>
		 <EQUAL? <GET .TABLE 1> ,V?CLIMB-DOWN ,V?CLIMB-OVER>>
		<TELL "is climbing">
		<ARTICLE <GET .TABLE 2> T>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?READ>
		<TELL "is reading">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?SMELL>
		<TELL "is smelling">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?LISTEN>
		<TELL "seems to be listening to">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?KISS>
		<TELL "tries to kiss">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)	       
	       (<EQUAL? <GET .TABLE 1> ,V?OPEN>
		<TELL "is trying to open">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?CLOSE>
		<TELL "is closing">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?EXIT ,V?DISEMBARK>
		<TELL "is trying to leave">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?TAKE>
		<TELL "is reaching for">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (<EQUAL? <GET .TABLE 1> ,V?DROP>
		<TELL "is dropping">
		<ARTICLE <GET .TABLE 2>>
		<TELL "." CR>)
	       (T
		<TELL "is doing something." CR>)>>

<ROOM DIAL-ROOM
      (IN ROOMS)
      (SYNONYM FALLS)
      (ADJECTIVE ARAGAI)
      (DESC "Dial Room")
      (LDESC
"On the eastern wall is a heavy door with a dial set into it. There is a
sign on the door. Another exit leads west, and a wall-mounted lamp provides
illumination. The floor is deeply covered with lumps of coal.")
      (EAST TO SHAFT-BOTTOM IF DIAL-DOOR IS OPEN)
      (WEST TO COAL-BIN-ROOM)
      (FLAGS RLANDBIT INSIDEBIT ONBIT)
      (GLOBAL DIAL-DOOR COAL)
      (PSEUDO "LAMP" LAMP-PSEUDO)>

<ROUTINE LAMP-PSEUDO ()
	 <COND (<VERB? TAKE>
		<PERFORM ,V?TAKE ,KEROSENE-LAMP>
		<RTRUE>)>>

<OBJECT DIAL-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "heavy door")
	(SYNONYM DOOR DOORS SIGN)
	(ADJECTIVE HEAVY)
	(FLAGS DOORBIT READBIT NDESCBIT)
	(TEXT
"\"See the foreman for the current combination.|
|
(signed)|
Ernie Flathead, Manager|
GUE Coal Mine #502\"")
	(ACTION DIAL-DOOR-F)>

<GLOBAL COAL-DOOR-POINT 20>

<ROUTINE DIAL-DOOR-F ()
	 <COND (<AND <VERB? OPEN>
		     <NOT <FSET? ,DIAL-DOOR ,OPENBIT>>>
		<COND (,DIAL-OPEN
		       <FSET ,DIAL-DOOR ,OPENBIT>
		       <SETG SCORE <+ ,SCORE ,COAL-DOOR-POINT>>
		       <SETG COAL-DOOR-POINT 0>
		       <TELL "The door opens easily." CR>)
		      (T
		       <TELL "The door won't budge." CR>)>)
	       (<VERB? EXAMINE>
		<PERFORM ,V?EXAMINE ,DIAL>
		<RTRUE>)
	       (<VERB? REZROV>
		<JIGS-UP
"The door swings open as a loud alarm sounds. Laser beams criss-cross the
room, glinting off the blades of the thousand flying daggers. A hundred
well-armed and vicious kobolds rush into the room, swinging battle axes.">)>>

;"the object DIAL also contains all objects that have no current LOC. This
 allows MOBY-FIND to find these LOC-less objects. Yes, this is bizarre."

<OBJECT DIAL
	(IN DIAL-ROOM)
	(DESC "combination dial")
	(SYNONYM DIAL)
	(ADJECTIVE COMBIN)
	(FLAGS NDESCBIT)
	(ACTION DIAL-F)>

<ROUTINE DIAL-F ()
	 <COND (<VERB? EXAMINE READ>
		<TELL
"Set in the door is a large circular dial which can be set to any number
up to 873. It is currently set to " N ,CURRENT-SETTING "." CR>)
	       (<VERB? TURN>
		<COND (,FWEEPED
		       <BATTY>)
		      (<OR <NOT ,PRSI>
			   <NOT <EQUAL? ,PRSI ,INTNUM>>>
		       <TELL "You must say what number to turn it to." CR>)
		      (<EQUAL? ,CURRENT-SETTING ,P-NUMBER>
		       <TELL
"The dial is already set to " N ,CURRENT-SETTING "." CR>)
		      (T
		       <SETG CURRENT-SETTING ,P-NUMBER>
		       <TELL "The dial is now set to " N ,CURRENT-SETTING ".">
		       <COND (<EQUAL? ,CURRENT-SETTING ,COMBO>
			      <TELL " You hear a click from inside the door.">
			      <SETG DIAL-OPEN T>)>
		       <CRLF>)>)>>

<GLOBAL CURRENT-SETTING 0>

<GLOBAL DIAL-OPEN <>>

<GLOBAL COMBO 0> ;"set-up by COAL-BIN-ROOM's M-ENTER"

<OBJECT ROPE
	(IN SHAFT-BOTTOM)
	(DESC "rope")
	(FDESC "Lying in one corner is a coil of rope.")
	(SYNONYM COIL ROPE)
	(FLAGS TAKEBIT)
	(SIZE 20)
	(ACTION ROPE-F)>

<GLOBAL ROPE-TO-BEAM <>>

<GLOBAL ROPE-PLACED <>>

<GLOBAL ROPE-IN-LOWER-CHUTE <>>

<ROUTINE ROPE-F ()
	 <COND (<AND <VERB? PUT>
		     <NOT <ACCESSIBLE? ,ROPE>>>
		<RFALSE>)
	       (<AND <VERB? TIE>
		     <EQUAL? ,PRSI ,BEAM>>
		<TELL "The rope is ">
		<COND (,ROPE-TO-BEAM
		       <TELL "already ">)>
		<TELL "tied securely to the center of the beam." CR>
		<SETG ROPE-TO-BEAM T>)
	       (<AND <VERB? TIE>
		     <EQUAL? ,PRSI ,COAL-BIN>>
		<TELL "The bin is too large." CR>)
	       (<AND <VERB? UNTIE>
		     ,ROPE-TO-BEAM>
		<SETG ROPE-TO-BEAM <>>
		<TELL "The rope is untied." CR>)
	       (<VERB? CLIMB-DOWN>
		<COND (<AND <NOT ,ROPE-PLACED>
			    <NOT ,ROPE-IN-LOWER-CHUTE>>
		       <TELL
"It would be hard to climb down the rope in its current state." CR>)
		      (T
		       <DO-WALK ,P?DOWN>)>)
	       (<VERB? CLIMB-UP>
		<TELL "Do you also charm snakes?" CR>)
	       (<VERB? EXAMINE>
		<COND (<OR ,ROPE-PLACED ,ROPE-IN-LOWER-CHUTE>
		       <TELL
"The rope is tied to the beam and hangs into the chute." CR>)
		      (,ROPE-TO-BEAM
		       <TELL
"It is tied to the center of the timber." CR>)>)>>

<ROOM SHAFT-BOTTOM
      (IN ROOMS)
      (SYNONYM CASTLE LARGON)
      (ADJECTIVE CASTLE LARGON)
      (DESC "Shaft Bottom")
      (LDESC
"You are at the bottom of an air shaft which looks climbable. A heavy
door leads west.")
      (UP TO SHAFT-TOP)
      (WEST TO DIAL-ROOM IF DIAL-DOOR IS OPEN)
      (FLAGS INSIDEBIT RLANDBIT)
      (GLOBAL DIAL-DOOR)
      (PSEUDO "SHAFT" SHAFT-PSEUDO)
      (ACTION SHAFT-BOTTOM-F)>

<ROUTINE SHAFT-BOTTOM-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-ENTER>
		     <FSET? ,VARDIK-SCROLL ,TOUCHBIT>>
		<SETG BREATH-SHORTAGE 3>
		<I-BREATHE>)>>

<ROOM SHAFT-TOP
      (IN ROOMS)
      (SYNONYM TROLL TROLLS THOLL)
      (DESC "Shaft Top")
      (LDESC
"You are deep inside a large coal mine, at the top of an air shaft. You
could descend into the shaft; passages in many directions lead further
into the mine.")
      (DOWN TO SHAFT-BOTTOM)
      (NE TO COAL-MINE-2)
      (NW TO COAL-MINE-1)
      (SW TO COAL-MINE-1)
      (EAST TO SHAFT-TOP)
      (FLAGS RLANDBIT INSIDEBIT)
      (PSEUDO "SHAFT" SHAFT-PSEUDO)>

<ROUTINE SHAFT-PSEUDO ()
	 <COND (<VERB? CLIMB-DOWN>
		<COND (<EQUAL? ,HERE ,SHAFT-TOP>
		       <DO-WALK ,P?DOWN>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? CLIMB-FOO CLIMB-UP>
		<COND (<EQUAL? ,HERE ,SHAFT-TOP>
		       <LOOK-AROUND-YOU>)
		      (T
		       <DO-WALK ,P?UP>)>)
	       (<AND <VERB? PUT-ON>
		     <EQUAL? ,PRSO ,BEAM>>
		<TELL "The shaft is too wide." CR>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,HERE ,SHAFT-TOP>>
		<COND (<AND <EQUAL? ,PRSO ,ROPE>
			    ,ROPE-TO-BEAM>
		       <TELL "The rope now dangles into the shaft." CR>)
		      (T
		       <MOVE ,PRSO ,SHAFT-BOTTOM>
		       <TELL
"It disappears into the shaft. A moment later comes a distant thud." CR>)>)>>

<OBJECT BEAM
	(IN COAL-MINE-1)
	(DESC "beam of wood")
	(FDESC
"Lying near the mouth of one passage is a wooden timber, probably left over
from the construction of the mine.")
	(SYNONYM BEAM WOOD TIMBER)
	(ADJECTIVE WOODEN)
	(SIZE 40)
	(FLAGS TAKEBIT)
	(ACTION BEAM-F)>

<ROUTINE BEAM-F ()
	 <COND (<AND <VERB? PUT-ON>
		     <EQUAL? ,PRSI ,UPPER-CHUTE ,LOWER-CHUTE>>
		<MOVE ,BEAM ,HERE>
		<TELL
"The beam is now lying across the mouth of the chute." CR>)
	       (<AND <VERB? TAKE>
		     ,ROPE-PLACED>
		<TELL
"You'd have to take the rope out of the chute first." CR>)
	       (<VERB? EXAMINE>
		<COND (,ROPE-PLACED
		       <TELL "A rope hangs from the beam, into the chute." CR>)
		      (,ROPE-TO-BEAM
		       <TELL "A rope is tied to the beam." CR>)>)>>

<ROOM COAL-MINE-1
      (IN ROOMS)
      (SYNONYM ENTHAR)
      (ADJECTIVE KING)
      (DESC "Coal Mine")
      (LDESC
"You are in a winding tunnel in a large coal mine. Passages lead off in
many directions.")
      (SOUTH TO SHAFT-TOP)
      (NE TO COAL-MINE-2)
      (NW TO COAL-MINE-3)
      (EAST TO SHAFT-TOP)
      (FLAGS RLANDBIT INSIDEBIT)>

<ROOM COAL-MINE-2
      (IN ROOMS)
      (SYNONYM DUNCAN)
      (ADJECTIVE KING)
      (DESC "Coal Mine")
      (LDESC
"You are in a winding tunnel in a large coal mine. Passages lead off in
many directions.")
      (UP TO COAL-MINE-3)
      (SE TO COAL-MINE-2)
      (WEST TO COAL-MINE-1)
      (NORTH TO COAL-MINE-3)
      (SOUTH TO SHAFT-TOP)
      (FLAGS INSIDEBIT RLANDBIT)>

<ROOM COAL-MINE-3
      (IN ROOMS)
      (SYNONYM FLATHE)
      (ADJECTIVE LORD DIMWIT)
      (DESC "Coal Mine")
      (LDESC
"You are in a winding tunnel in a large coal mine. Passages lead off in
many directions.")
      (SW TO COAL-MINE-1)
      (DOWN TO COAL-MINE-2)
      (NORTH TO COAL-MINE-3)
      (EAST TO COAL-MINE-2)
      (WEST TO TOP-OF-CHUTE)
      (FLAGS INSIDEBIT RLANDBIT)>

<ROOM TOP-OF-CHUTE
      (IN ROOMS)
      (DESC "Top of Chute")
      (LDESC
"You are at the western end of the coal mine. A metal chute leads downward.")
      (DOWN PER CHUTE-EXIT-F)
      (EAST TO COAL-MINE-3)
      (FLAGS INSIDEBIT RLANDBIT)
      (GLOBAL UPPER-CHUTE)
      (ACTION TOP-OF-CHUTE-F)>

<ROUTINE TOP-OF-CHUTE-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <NOT <IN? ,TROGLODYTE ,HERE>>
		     <OR ,LIT ,BLORTED>
		     <PROB 30>>
		<MOVE ,TROGLODYTE ,HERE>
		<ENABLE <QUEUE I-TROGLODYTE 2>>
		<TELL CR
"A troglodyte trundles in and dumps a load of coal into the chute." CR>)>>

<ROUTINE I-TROGLODYTE ()
	 <MOVE ,TROGLODYTE ,DIAL>
	 <COND (<EQUAL? ,HERE ,TOP-OF-CHUTE>
		<SETG TROG-FOLLOW T>
		<ENABLE <QUEUE I-TROG-UNFOLLOW 1>>
		<TELL CR
"The troglodyte trundles off into the coal mine." CR>)>>

<GLOBAL TROG-FOLLOW <>>

<ROUTINE I-TROG-UNFOLLOW ()
	 <SETG TROG-FOLLOW <>>
	 <RFALSE>>

<OBJECT TROGLODYTE
	(IN DIAL)
	(DESC "troglodyte")
	(SYNONYM TROGLO)
	(FLAGS ACTORBIT)
	(ACTION TROGLODYTE-F)>

<ROUTINE TROGLODYTE-F ()
	 <COND (<EQUAL? ,WINNER ,TROGLODYTE>
		<TELL "The troglodyte ignores you." CR>
		<STOP>)
	       (<AND <VERB? FOLLOW>
		     ,TROG-FOLLOW>
		<TELL "You didn't notice which passage it took." CR>)
	       (<VERB? YOMIN>
		<TELL
"The troglodyte is worried about filling his coal quotas." CR>)
	       (<VERB? RESEARCH>
		<TELL
"Semi-intelligent subterranean beasts frequently used to dig and haul
coal." CR>)>>

<ROUTINE CHUTE-EXIT-F ()
	 <COND (,ROPE-PLACED
		<TELL
"You climb carefully down the rope, which is slippery with coal dust, ">
		<COND (<G? ,AWAKE 0>
		       <TELL
"but because of your fatigue you lose your grip.">
		       <ORANGE-FLASH>
		       <CRLF> <CRLF>
		       ,COAL-BIN-ROOM)
		      (<NOT <NOTHING-HELD?>>
		       <TELL
"but because of your load you are unable to maintain your grip.">
		       <ORANGE-FLASH>
		       <CRLF> <CRLF>
		       ,COAL-BIN-ROOM)
		      (T
		       <TELL
"and soon reach a small opening off the chute. You clamber inside..." CR CR>
		       <SETG SCORE <+ ,SCORE 20>>
		       <FCLEAR ,VARDIK-SPELL ,INVISIBLE>
		       ,SLANTED-ROOM)>)
	       (T
		<ROPE-BEAM-CHECK T>
		<TELL "Wheee!!! ">
		<ORANGE-FLASH>
		<TELL " You land beside an enormous bin of coal." CR CR>
		,COAL-BIN-ROOM)>>

<ROUTINE ORANGE-FLASH ()
	 <TELL " As you ">
	 <COND (,FLYING
		<TELL "float">)
	       (T
		<TELL "whiz">)>
	 <TELL
" down the chute, you notice a flash of orange light spilling
from an opening onto the chute.">>

<ROOM SLANTED-ROOM
      (IN ROOMS)
      (SYNONYM FROBOZ WIZARD)
      (DESC "Slanted Room")
      (LDESC
"This small room has a slanted roof, presumably due to the coal chute
which passes overhead. You can reenter the chute to the east.")
      (EAST PER SLANTED-ROOM-EXIT-F)
      (DOWN PER SLANTED-ROOM-EXIT-F)
      (UP PER CHUTE-ENTER-F)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL UPPER-CHUTE)
      (ACTION SLANTED-ROOM-F)>

<ROUTINE SLANTED-ROOM-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<PUT ,VEZZAS 6 0>)>>

<ROUTINE SLANTED-ROOM-EXIT-F ()
	 <COND (<AND <NOT <IN? ,GOLMAC-SCROLL ,PROTAGONIST>>
		     <NOT ,GOLMACKED>>
		<POOF>
		<RFALSE>)
	       (<AND <IN? ,GOLMAC-SCROLL ,PROTAGONIST>
		     ,GOLMACKED>
		<POOF>
		<RFALSE>)
	       (T
		<TELL "Wheeee!!!" CR CR>
		,COAL-BIN-ROOM)>>

<OBJECT KEROSENE-LAMP
	(IN SLANTED-ROOM)
	(DESC "kerosene lamp")	
	(SYNONYM LAMP DOOR COMPAR BOWL)
	(ADJECTIVE KEROSE SMALL METAL GLASS)
	(FLAGS ONBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 5)
	(DESCFCN KEROSENE-LAMP-DESCFCN)
	(ACTION KEROSENE-LAMP-F)>

<ROUTINE KEROSENE-LAMP-DESCFCN (RARG)
	 <TELL
"Mounted securely to the wall is a kerosene lamp, filling the room
with a serene orange glow. ">
	 <COND (<FSET? ,KEROSENE-LAMP ,OPENBIT>
		<TELL "A small compartment at its base is open.">)>
	 <CRLF>>

<ROUTINE KEROSENE-LAMP-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The lamp has a glass bowl where the flame burns. Below is a small metal
door, perhaps a compartment for storing extra wicks or kerosene." CR>)
	       (<VERB? TAKE>
		<TELL "It's mounted securely to the wall." CR>)
	       (<VERB? LAMP-OFF>
		<TELL "You can't spare the breath to blow out the lamp." CR>)>>

<OBJECT VARDIK-SCROLL
	(IN OLDER-SELF)
	(DESC "smelly scroll")
	(SYNONYM SCROLL)
	(ADJECTIVE SMELLY)
	(SIZE 3)
	(FLAGS TAKEBIT TRANSBIT CONTBIT READBIT SCROLLBIT)
	(ACTION SCROLL-F)>

<OBJECT VARDIK-SPELL
	(IN VARDIK-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE VARDIK)
	(DESC "vardik spell")
	(TEXT "shield a mind from an evil spirit")
	(SIZE 1)
	(COUNT 0)
	(FLAGS NDESCBIT SPELLBIT INVISIBLE)
	(ACTION SPELL-F)>

<OBJECT GOLMAC-SCROLL
	(IN SLANTED-ROOM)
	(DESC "shimmering scroll")
	(SYNONYM SCROLL)
	(ADJECTIVE SHIMME)
	(SIZE 3)
	(FLAGS TAKEBIT TRANSBIT CONTBIT READBIT SCROLLBIT)
	(ACTION SCROLL-F)>

<OBJECT GOLMAC-SPELL
	(IN GOLMAC-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE GOLMAC)
	(DESC "golmac spell")
	(TEXT "travel temporally")
	(SIZE 1)
	(COUNT 0)
	(FLAGS NDESCBIT SPELLBIT)
	(ACTION SPELL-F)>

<GLOBAL GOLMACKED <>>

<ROUTINE CHUTE-ENTER-F ()
	 <COND (,FLYING
		<TELL "The chute is too narrow to fly up.">)
	       (T
		<TELL "The chute is too steep and slippery.">)>
	 <CRLF>
	 <RFALSE>>

<ROUTINE BOTTOM-TOP-OF-CHUTE ("OPTIONAL" (TOP <>))
	 <TELL "You're already at the ">
	 <COND (.TOP
		<TELL "top">)
	       (T
		<TELL "bottom">)>
	 <TELL " of the chute." CR>>
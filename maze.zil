"MAZE for
			    SORCERER
       (c) Copyright 1984 by Infocom Inc.  All Rights Reserved."

<OBJECT MAZE
	(IN LOCAL-GLOBALS)
	(DESC "glass maze")
	(SYNONYM MAZE LABYRI)
	(ADJECTIVE GLASS)
	(FLAGS NDESCBIT)
	(ACTION MAZE-F)>

<ROUTINE MAZE-F ()
	 <COND (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,OUTSIDE-GLASS-DOOR>
		       <DO-WALK ,P?EAST>)
		      (<EQUAL? ,HERE ,HOLLOW>
		       <DO-WALK ,P?WEST>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? DROP EXIT>
		<COND (<EQUAL? ,HERE ,GLASS-MAZE>
		       <DO-WALK ,P?OUT>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? EXAMINE LOOK-INSIDE>
		<TELL
"You see nothing but reflected light in all directions." CR>)
	       (<VERB? RESEARCH>
		<TELL
"According to the article, Duncanthrax built the Glass Maze on a whim,
to amuse his friends and torture his enemies. A labyrinth of 27 cubicles, it
was full of devilish pitfalls and was located near his castle, Egreth." CR>)>>

<ROOM END-OF-HIGHWAY
      (IN ROOMS)
      (SYNONYM GALEPA MAREIL CITY)
      (ADJECTIVE ANCIEN)
      (DESC "End of Highway")
      (LDESC
"The underground road ends here. A hovel, carved into the rock, lies to the
east. To the north, wide marble stairs lead upward.")
      (EAST TO STONE-HUT)
      (WEST TO OUTSIDE-STORE)
      (UP TO ENTRANCE-HALL)
      (NORTH TO ENTRANCE-HALL)
      (IN TO STONE-HUT)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL ROAD HOVEL STAIRS)>

<OBJECT HOVEL
	(IN LOCAL-GLOBALS)
	(DESC "stone hovel")
	(SYNONYM HUT HOVEL)
	(ADJECTIVE UNDERG STONE)
	(FLAGS NDESCBIT)
	(ACTION HOVEL-F)>

<ROUTINE HOVEL-F ()
	 <COND (<VERB? THROUGH>
		<COND (<EQUAL? ,HERE ,END-OF-HIGHWAY>
		       <DO-WALK ,P?EAST>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? DROP EXIT>
		<COND (<EQUAL? ,HERE ,STONE-HUT>
		       <DO-WALK ,P?WEST>)
		      (T
		       <LOOK-AROUND-YOU>)>)
	       (<VERB? LOOK-INSIDE>
		<COND (<EQUAL? ,HERE ,STONE-HUT>
		       <LOOK-AROUND-YOU>)
		      (T
		       <MAKE-OUT>)>)>>
		      

<ROOM STONE-HUT
      (IN ROOMS)
      (SYNONYM QUENDO KINGDO) 
      (DESC "Stone Hut")
      (LDESC
"This is a small underground hovel. On the far wall is a small
fireplace, long unused.")
      (OUT TO END-OF-HIGHWAY)
      (WEST TO END-OF-HIGHWAY)
      (UP PER CHIMNEY-EXIT-F)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL CHIMNEY HOVEL)>

<ROUTINE CHIMNEY-EXIT-F ()
	 <COND (,FWEEPED
		<TELL "Too narrow even for bats." CR>
		<RFALSE>)
	       (T
		<TELL
"Where did you get the bizarre notion that you might fit up a chimney?" CR>
		<RFALSE>)>>

<OBJECT FIREPLACE
	(IN STONE-HUT)
	(DESC "fireplace")
	(SYNONYM FIREPL)
	(ADJECTIVE SMALL UNUSED)
	(FLAGS NDESCBIT CONTBIT OPENBIT SEARCHBIT)
	(CAPACITY 50)
	(ACTION FIREPLACE-F)>

<ROUTINE FIREPLACE-F ()
	 <COND (<VERB? OPEN CLOSE>
		<V-DEFLATE>)>>

<ROOM ENTRANCE-HALL
      (IN ROOMS)
      (SYNONYM EMPIRE GUE)
      (ADJECTIVE GREAT UNDERG)
      (DESC "Entrance Hall")
      (LDESC
"This is a large entrance hall, paved with polished stone. Large doorways
lead north and south.")
      (NORTH TO OUTSIDE-GLASS-DOOR)
      (SOUTH TO END-OF-HIGHWAY)
      (FLAGS INSIDEBIT RLANDBIT)
      (GLOBAL ARCHWAY)>

<OBJECT STATUE
	(IN ENTRANCE-HALL)
	(DESC "statue")
	(FDESC
"Standing in the center of the hall is a life-sized statue. An inscription
at the base is in a familiar language.")
	(LDESC
"There is a marble statue here, in a strikingly life-like pose of
pompous bellicosity.")
	(SYNONYM STATUE INSCRI)
	(ADJECTIVE LIFE- SIZED MARBLE)
	(FLAGS READBIT)
	(TEXT
"\"I, Duncanthrax, King of Quendor and all its subjugated outlands, invite
you to sample the delights of my Glass Labyrinth.\"")
	(ACTION STATUE-F)>

<ROUTINE STATUE-F ()
	 <COND (<VERB? MALYON>
		<TELL
"The statue transforms into a living figure, probably a King if the royal
attire is any clue. The King seems angry, and quickly settles his wrathful
gaze on you. He bellows \"Guards! Throw this trespasser into the glass
maze! Guards! ... GUARDS!!!\" When the guards fail to respond, the King
becomes livid, his voice rises to an incoherent squeak, and flecks of foam
spit from the corners of his mouth. Finally, eyes bulging with rage, he
storms out of the room." CR>
		<FSET ,STATUE ,TOUCHBIT>
		<SETG STATUE-FOLLOW T>
		<ENABLE <QUEUE I-STATUE-UNFOLLOW 1>>
		<COND (<EQUAL? ,HERE ,ENTRANCE-HALL ,OUTSIDE-STORE>
		       <COND (<PROB 50>
			      <MOVE ,STATUE ,HIGHWAY>)
			     (T
			      <MOVE ,STATUE ,BEND>)>)
		      (T
		       <COND (<PROB 50>
			      <MOVE ,STATUE ,ENTRANCE-HALL>)
			     (T
			      <MOVE ,STATUE ,OUTSIDE-STORE>)>)>)
	       (<AND <VERB? FOLLOW>
		     ,STATUE-FOLLOW>
		<TELL "The King moved too quickly to follow." CR>)>>

<GLOBAL STATUE-FOLLOW <>>

<ROUTINE I-STATUE-UNFOLLOW ()
	 <SETG STATUE-FOLLOW <>>
	 <RFALSE>>

<ROOM OUTSIDE-GLASS-DOOR
      (IN ROOMS)
      (SYNONYM TECH)
      (ADJECTIVE GUE)
      (DESC "Outside Glass Arch")
      (LDESC
"Through a breathtaking archway of glass to the east is an
area glistening with reflected light. Another exit leads south.")
      (EAST TO GLASS-MAZE)
      (SOUTH TO ENTRANCE-HALL)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL MAZE ARCHWAY)>

<ROUTINE NO-FLOOR? ()
	 <COND (<AND ,MAZE-CROSSED
		     <EQUAL? <GET ,POST-DOWN-EXITS ,ROOM-NUMBER> 0>>
		<RFALSE>)
	       (<AND <NOT ,MAZE-CROSSED>
		     <EQUAL? <GET ,PRE-DOWN-EXITS ,ROOM-NUMBER> 0>>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROOM GLASS-MAZE
      (IN ROOMS)
      (DESC "Inside the Glass Maze")
      (UP PER MAZE-EXIT-F)
      (DOWN PER MAZE-EXIT-F)
      (NORTH PER MAZE-EXIT-F)
      (SOUTH PER MAZE-EXIT-F)
      (WEST PER MAZE-EXIT-F)
      (EAST PER MAZE-EXIT-F)
      (OUT "Please use compass directions here.")
      (FLAGS INSIDEBIT RLANDBIT ONBIT)
      (GLOBAL MAZE)
      (ACTION GLASS-MAZE-F)>

<ROUTINE GLASS-MAZE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-ENTER>
		<TABLE-TO-MAZE ,ROOM-NUMBER>
		<FCLEAR ,GLASS-MAZE ,TOUCHBIT>
		<PUT ,VEZZAS 5 0>)
	       (<EQUAL? .RARG ,M-LOOK>
		<TELL
"You are inside a huge cubical maze, shimmering with light from an unseen
source above.">
		<COND (<NOT ,FWEEPED>
		       <TELL
" It is impossible to tell if the walls and ceilings around you are
glass surfaces or openings.">)>
		<COND (<AND <NOT ,FLYING>
			    <NO-FLOOR?>
			    <EQUAL? ,ROOM-NUMBER 13>>
		       <TELL " ">
		       <PLUMMET>
		       <RTRUE>)>
		<COND (<AND <NOT ,FLYING>
			    <NOT <NO-FLOOR?>>>
		       <TELL
" Since you are standing on something, the floor must be solid, but it is
virtually invisible and you feel as though you were walking on air.">)>
		<COND (,FWEEPED
		       <RADAR-VIEW>)>
		<CRLF>)>>

<ROUTINE RADAR-VIEW ("AUX" X COUNT LUP LDOWN NORTH SOUTH EAST WEST)
	 <SET X <>>
	 <SET LUP <>>
	 <SET LDOWN <>>
	 <SET NORTH <>>
	 <SET SOUTH <>>
	 <SET EAST <>>
	 <SET WEST <>>
	 <SET COUNT 0> ;"number of surfaces"
	 <TELL
" Thanks to your sonar-like bat senses, you can tell that there are surfaces ">
	 <COND (<OR <AND ,MAZE-CROSSED
			 <EQUAL? <GET ,POST-UP-EXITS ,ROOM-NUMBER> 0>>
		    <AND <NOT ,MAZE-CROSSED>
			 <EQUAL? <GET ,PRE-UP-EXITS ,ROOM-NUMBER> 0>>>
		<SET LUP T>
		<SET COUNT <+ .COUNT 1>>)>
	 <COND (<OR <AND ,MAZE-CROSSED
			 <EQUAL? <GET ,POST-DOWN-EXITS ,ROOM-NUMBER> 0>>
		    <AND <NOT ,MAZE-CROSSED>
			 <EQUAL? <GET ,PRE-DOWN-EXITS ,ROOM-NUMBER> 0>>>
		<SET LDOWN T>
		<SET COUNT <+ .COUNT 1>>)>
	 <COND (<OR <AND ,MAZE-CROSSED
			 <EQUAL? <GET ,POST-NORTH-EXITS ,ROOM-NUMBER> 0>>
		    <AND <NOT ,MAZE-CROSSED>
			 <EQUAL? <GET ,PRE-NORTH-EXITS ,ROOM-NUMBER> 0>>>
		<SET NORTH T>
		<SET COUNT <+ .COUNT 1>>)>
	 <COND (<OR <AND ,MAZE-CROSSED
			 <EQUAL? <GET ,POST-SOUTH-EXITS ,ROOM-NUMBER> 0>>
		    <AND <NOT ,MAZE-CROSSED>
			 <EQUAL? <GET ,PRE-SOUTH-EXITS ,ROOM-NUMBER> 0>>>
		<SET SOUTH T>
		<SET COUNT <+ .COUNT 1>>)>
	 <COND (<OR <AND ,MAZE-CROSSED
			 <EQUAL? <GET ,POST-EAST-EXITS ,ROOM-NUMBER> 0>>
		    <AND <NOT ,MAZE-CROSSED>
			 <EQUAL? <GET ,PRE-EAST-EXITS ,ROOM-NUMBER> 0>>>
		<SET EAST T>
		<SET COUNT <+ .COUNT 1>>)>
	 <COND (<OR <AND ,MAZE-CROSSED
			 <EQUAL? <GET ,POST-WEST-EXITS ,ROOM-NUMBER> 0>>
		    <AND <NOT ,MAZE-CROSSED>
			 <EQUAL? <GET ,PRE-WEST-EXITS ,ROOM-NUMBER> 0>>>
		<SET WEST T>
		<SET COUNT <+ .COUNT 1>>)>
	 <COND (.LUP
		<COND (<EQUAL? .COUNT 1>
		       <TELL " and ">)
		      (.X
		       <TELL ", ">)>
		<SET X T>
		<SET COUNT <- .COUNT 1>>
		<TELL "above you">)>
	 <COND (.LDOWN
		<COND (<EQUAL? .COUNT 1>
		       <TELL " and ">)
		      (.X
		       <TELL ", ">)>
		<SET X T>
		<SET COUNT <- .COUNT 1>>
		<TELL "below you">)>
	 <COND (.NORTH
		<COND (<EQUAL? .COUNT 1>
		       <TELL " and ">)
		      (.X
		       <TELL ", ">)>
		<SET X T>
		<SET COUNT <- .COUNT 1>>
		<TELL "to the north">)>
	 <COND (.SOUTH
		<COND (<EQUAL? .COUNT 1>
		       <TELL " and ">)
		      (.X
		       <TELL ", ">)>
		<SET X T>
		<SET COUNT <- .COUNT 1>>
		<TELL "to the south">)>
	 <COND (.EAST
		<COND (<EQUAL? .COUNT 1>
		       <TELL " and ">)
		      (.X
		       <TELL ", ">)>
		<SET X T>
		<SET COUNT <- .COUNT 1>>
		<TELL "to the east">)>
	 <COND (.WEST
		<COND (<EQUAL? .COUNT 1>
		       <TELL " and ">)
		      (.X
		       <TELL ", ">)>
		<SET X T>
		<SET COUNT <- .COUNT 1>>
		<TELL "to the west">)>
	 <TELL ".">>

<ROUTINE MAZE-EXIT-F ()
	 <COND (,MAZE-CROSSED
;"post-maze-exit-function"
	 <MAZE-TO-TABLE ,ROOM-NUMBER>
	 <COND (<EQUAL? ,PRSO ,P?UP>
		<COND (<NOT ,FLYING>
		       <CANT-JUMP>
		       <TABLE-TO-MAZE ,ROOM-NUMBER>
		       <RFALSE>)
		      (T
		       <COND (<EQUAL? <GET ,POST-UP-EXITS ,ROOM-NUMBER> 0>
			      <HIT-WALL>
			      <RFALSE>)
			     (T
			      <SETG ROOM-NUMBER
				    <GET ,POST-UP-EXITS ,ROOM-NUMBER>>)>)>)
	       (<EQUAL? ,PRSO ,P?DOWN>
		<COND (<NOT ,FLYING>
		       <SOLID-FLOOR>
		       <TABLE-TO-MAZE ,ROOM-NUMBER>
		       <RFALSE>)
		      (T
		       <COND (<EQUAL? <GET ,POST-DOWN-EXITS ,ROOM-NUMBER> 0>
			      <HIT-WALL>
			      <RFALSE>)
			     (T
			      <SETG ROOM-NUMBER
				    <GET ,POST-DOWN-EXITS ,ROOM-NUMBER>>)>)>)
	       (<EQUAL? ,PRSO ,P?NORTH>
		<COND (<EQUAL? <GET ,POST-NORTH-EXITS ,ROOM-NUMBER> 0>
		       <HIT-WALL>
		       <RFALSE>)
		    (T
		     <SETG ROOM-NUMBER <GET ,POST-NORTH-EXITS ,ROOM-NUMBER>>)>)
	       (<EQUAL? ,PRSO ,P?SOUTH>
		<COND (<EQUAL? <GET ,POST-SOUTH-EXITS ,ROOM-NUMBER> 0>
		       <HIT-WALL>
		       <RFALSE>)
		    (T
		     <SETG ROOM-NUMBER <GET ,POST-SOUTH-EXITS ,ROOM-NUMBER>>)>)
	       (<EQUAL? ,PRSO ,P?EAST>
		<COND (<EQUAL? <GET ,POST-EAST-EXITS ,ROOM-NUMBER> 0>
		       <HIT-WALL>
		       <RFALSE>)
		      (T
		       <SETG ROOM-NUMBER <GET ,POST-EAST-EXITS ,ROOM-NUMBER>>
		       <COND (<EQUAL? ,ROOM-NUMBER 30>
			      <SETG ROOM-NUMBER 24>
			      <RETURN ,HOLLOW>)>)>)
	       (<EQUAL? ,PRSO ,P?WEST>
		<COND (<EQUAL? <GET ,POST-WEST-EXITS ,ROOM-NUMBER> 0>
		       <HIT-WALL>
		       <RFALSE>)
		      (T
		       <SETG ROOM-NUMBER <GET ,POST-WEST-EXITS ,ROOM-NUMBER>>
		       <COND (<EQUAL? ,ROOM-NUMBER 40>
			      <SETG ROOM-NUMBER 13>
			      <RETURN ,OUTSIDE-GLASS-DOOR>)>)>)>
	 <TABLE-TO-MAZE ,ROOM-NUMBER>
	 <V-LOOK>
	 <PLUMMET>
	 <RFALSE>)
	       (T
;"pre-maze-exit-funtion"
	 <MAZE-TO-TABLE ,ROOM-NUMBER>
	 <COND (<EQUAL? ,PRSO ,P?UP>
		<COND (<NOT ,FLYING>
		       <CANT-JUMP>
		       <TABLE-TO-MAZE ,ROOM-NUMBER>
		       <RFALSE>)
		      (T
		       <COND (<EQUAL? <GET ,PRE-UP-EXITS ,ROOM-NUMBER> 0>
			      <HIT-WALL>
			      <RFALSE>)
			     (T
			      <SETG ROOM-NUMBER
				    <GET ,PRE-UP-EXITS ,ROOM-NUMBER>>)>)>)
	       (<EQUAL? ,PRSO ,P?DOWN>
		<COND (<NOT ,FLYING>
		       <SOLID-FLOOR>
		       <TABLE-TO-MAZE ,ROOM-NUMBER>
		       <RFALSE>)
		      (T
		       <COND (<EQUAL? <GET ,PRE-DOWN-EXITS ,ROOM-NUMBER> 0>
			      <HIT-WALL>
			      <RFALSE>)
			     (T
			      <SETG ROOM-NUMBER
				    <GET ,PRE-DOWN-EXITS ,ROOM-NUMBER>>)>)>)
	       (<EQUAL? ,PRSO ,P?NORTH>
		<COND (<EQUAL? <GET ,PRE-NORTH-EXITS ,ROOM-NUMBER> 0>
		       <HIT-WALL>
		       <RFALSE>)
		     (T
		      <SETG ROOM-NUMBER <GET ,PRE-NORTH-EXITS ,ROOM-NUMBER>>)>)
	       (<EQUAL? ,PRSO ,P?SOUTH>
		<COND (<EQUAL? <GET ,PRE-SOUTH-EXITS ,ROOM-NUMBER> 0>
		       <HIT-WALL>
		       <RFALSE>)
		     (T
		      <SETG ROOM-NUMBER <GET ,PRE-SOUTH-EXITS ,ROOM-NUMBER>>)>)
	       (<EQUAL? ,PRSO ,P?EAST>
		<COND (<EQUAL? <GET ,PRE-EAST-EXITS ,ROOM-NUMBER> 0>
		       <HIT-WALL>
		       <RFALSE>)
		      (T
		       <SETG ROOM-NUMBER <GET ,PRE-EAST-EXITS ,ROOM-NUMBER>>
		       <COND (<EQUAL? ,ROOM-NUMBER 30>
			      <SETG SCORE <+ ,SCORE ,HOLLOW-POINT>>
			      <SETG HOLLOW-POINT 0>
			      <SETG ROOM-NUMBER 24>
			      <RETURN ,HOLLOW>)>)>)
	       (<EQUAL? ,PRSO ,P?WEST>
		<COND (<EQUAL? <GET ,PRE-WEST-EXITS ,ROOM-NUMBER> 0>
		       <HIT-WALL>
		       <RFALSE>)
		      (T
		       <SETG ROOM-NUMBER <GET ,PRE-WEST-EXITS ,ROOM-NUMBER>>
		       <COND (<EQUAL? ,ROOM-NUMBER 40>
			      <SETG ROOM-NUMBER 13>
			      <RETURN ,OUTSIDE-GLASS-DOOR>)>)>)>
	 <TABLE-TO-MAZE ,ROOM-NUMBER>
	 <V-LOOK>
	 <PLUMMET>
	 <RFALSE>)>>

<GLOBAL MAZE-CROSSED <>>

<GLOBAL ROOM-NUMBER 13> ;"you enter maze at room number thirteen"

<ROUTINE HIT-WALL ()
	 <TELL "BONK! You ">
	 <COND (,FLYING
		<TELL "fly">)
	       (T
		<TELL "walk">)>
	 <TELL
" right into an almost invisible wall of glass -- a stunning blow!" CR>>

<ROUTINE CANT-JUMP ()
	 <TELL "You can't possibly jump that high." CR>>

<ROUTINE SOLID-FLOOR ()
	 <TELL "Fortunately, the floor is solid." CR>> 

<ROUTINE PLUMMET ()
	 <COND (<AND <NOT ,FLYING>
		     <NO-FLOOR?>>
		<JIGS-UP
"Unfortunately, this section of the glass maze has no floor.">
		<RFALSE>)>>

<GLOBAL PRE-UP-EXITS
	<PTABLE 0
10  0 12  0  0  0 16  0  0
 0 20 21  0  0  0  0 26  0
 0  0  0  0  0  0  0  0  0>>

<GLOBAL PRE-DOWN-EXITS
	<PTABLE 0
 0  0  0  0  0  0  0  0  0
 1  0  3  0  0  0  7  0  0
 0 11 12  0  0  0  0 17  0>>

<GLOBAL PRE-NORTH-EXITS
	<PTABLE 0
 0  0  0  1  2  3  0  0  6
 0  0  0 10 11  0  0 14 15
 0  0  0  0  0 21 22  0  0>>

<GLOBAL PRE-SOUTH-EXITS
	<PTABLE 0
 4  5  6  0  0  9  0  0  0
13 14  0  0 17 18  0  0  0
 0  0 24 25  0  0  0  0  0>>

<GLOBAL PRE-EAST-EXITS
	<PTABLE 0
 0  0  0  5  0  0  8  9  0
11  0  0  0  0  0 17 18  0
20  0  0 23  0 30 26 27  0>>

<GLOBAL PRE-WEST-EXITS
	<PTABLE 0
 0  0  0  0  4  0  0  7  8
 0 10  0 40  0  0  0 16 17
 0 19  0  0 22  0  0 25 26>>

<GLOBAL POST-UP-EXITS
	<PTABLE 0
 0  0 12 13  0  0 16  0 18
19 20  0  0  0  0 25  0 27
 0  0  0  0  0  0  0  0  0>>

<GLOBAL POST-DOWN-EXITS
	<PTABLE 0
 0  0  0  0  0  0  0  0  0
 0  0  3  4  0  0  7  0  9
10 11  0  0  0  0 16  0 18>>

<GLOBAL POST-NORTH-EXITS
	<PTABLE 0
 0  0  0  1  2  3  0  0  0
 0  0  0  0 11 12  0  0  0
 0  0  0 19  0  0 22 23  0>>

<GLOBAL POST-SOUTH-EXITS
	<PTABLE 0
 4  5  6  0  0  0  0  0  0
 0 14 15  0  0  0  0  0  0
22  0  0 25 26  0  0  0  0>>

<GLOBAL POST-EAST-EXITS
	<PTABLE 0
 0  3  0  5  0  0  8  9  0
11  0  0  0 15  0  0 18  0
 0 21  0  0 24 30  0 27  0>>

<GLOBAL POST-WEST-EXITS
	<PTABLE 0
 0  0  2  0  4  0  0  7  8
 0 10  0 40  0 14  0  0 17
 0  0 20  0  0 23  0  0 26>>

<ROUTINE MAZE-TO-TABLE (LOC "AUX" (CNT 0) (F <FIRST? ,GLASS-MAZE>) N)
	 <REPEAT ()
		 <COND (.F
			<SET N <NEXT? .F>>)
		       (T
			<RETURN>)>
		 <COND (<EQUAL? .F ,WINNER>
			T)
		       (<OR <FSET? .F ,TAKEBIT>
			    <EQUAL? .F ,DORN-BEAST-CORPSE>>
			<REPEAT ()
				<COND (<EQUAL? <GET ,MAZE-TABLE .CNT> 0>
				       <PUT ,MAZE-TABLE .CNT .LOC>
				       <PUT ,MAZE-TABLE <+ .CNT 1> .F>
				       <SET CNT <+ .CNT 2>>
				       <MOVE .F ,DIAL>
				       <RETURN>)
				      (T
				       <SET CNT <+ .CNT 2>>)>>)>
		 <SET F .N>>>

<ROUTINE TABLE-TO-MAZE (LOC "AUX" (TABLE ,MAZE-TABLE) (CNT 0))
	 <REPEAT ()
		 <COND (<NOT <L? .CNT ,MAZE-TABLE-LENGTH>>
			<RETURN>)
		       (<EQUAL? <GET ,MAZE-TABLE .CNT> .LOC>
			<PUT ,MAZE-TABLE .CNT 0>
			<MOVE <GET ,MAZE-TABLE <+ .CNT 1>> ,GLASS-MAZE>)>
		 <SET CNT <+ .CNT 2>>>>

<ROUTINE DROP-IN-MAZE ("AUX" (CNT 0) (NEW-ROOM 0))
	 <COND (,MAZE-CROSSED
		<COND (<EQUAL? ,ROOM-NUMBER 12>
		       <SET NEW-ROOM 3>)
		      (<EQUAL? ,ROOM-NUMBER 13>
		       <SET NEW-ROOM 4>)
		      (<EQUAL? ,ROOM-NUMBER 16>
		       <SET NEW-ROOM 7>)
		      (<EQUAL? ,ROOM-NUMBER 18>
		       <SET NEW-ROOM 9>)
		      (<EQUAL? ,ROOM-NUMBER 19>
		       <SET NEW-ROOM 10>)
		      (<EQUAL? ,ROOM-NUMBER 20>
		       <SET NEW-ROOM 11>)
		      (<EQUAL? ,ROOM-NUMBER 25>
		       <SET NEW-ROOM 7>)
		      (<EQUAL? ,ROOM-NUMBER 27>
		       <SET NEW-ROOM 9>)>)
	       (T
		<COND (<EQUAL? ,ROOM-NUMBER 10>
		       <SET NEW-ROOM 1>)
		      (<EQUAL? ,ROOM-NUMBER 12>
		       <SET NEW-ROOM 3>)
		      (<EQUAL? ,ROOM-NUMBER 16>
		       <SET NEW-ROOM 7>)
		      (<EQUAL? ,ROOM-NUMBER 20>
		       <SET NEW-ROOM 11>)
		      (<EQUAL? ,ROOM-NUMBER 21>
		       <SET NEW-ROOM 3>)
		      (<EQUAL? ,ROOM-NUMBER 26>
		       <SET NEW-ROOM 17>)>)>
	 <COND (<EQUAL? .NEW-ROOM 0>
		<TELL "Bug #14" CR>
		<RTRUE>)>
	 <REPEAT ()
		 <COND (<EQUAL? <GET ,MAZE-TABLE .CNT> 0>
			<PUT ,MAZE-TABLE .CNT .NEW-ROOM>
			<PUT ,MAZE-TABLE <+ .CNT 1> ,PRSO>
			<SET CNT <+ .CNT 2>>
			<RETURN>)
		       (T
			<SET CNT <+ .CNT 2>>)>>>

<ROUTINE REARRANGE-MAZE-TABLE ("AUX" (CNT 0))
	 <REPEAT ()
		 <COND (<NOT <L? .CNT ,MAZE-TABLE-LENGTH>>
			<RETURN>)
		       (<EQUAL? <GET ,MAZE-TABLE .CNT> 12>
			<PUT ,MAZE-TABLE .CNT 3>)
		       (<EQUAL? <GET ,MAZE-TABLE .CNT> 13>
			<PUT ,MAZE-TABLE .CNT 4>)
		       (<EQUAL? <GET ,MAZE-TABLE .CNT> 16>
			<PUT ,MAZE-TABLE .CNT 7>)
		       (<EQUAL? <GET ,MAZE-TABLE .CNT> 18>
			<PUT ,MAZE-TABLE .CNT 9>)
		       (<EQUAL? <GET ,MAZE-TABLE .CNT> 19>
			<PUT ,MAZE-TABLE .CNT 10>)
		       (<EQUAL? <GET ,MAZE-TABLE .CNT> 20>
			<PUT ,MAZE-TABLE .CNT 11>)
		       (<EQUAL? <GET ,MAZE-TABLE .CNT> 25>
			<PUT ,MAZE-TABLE .CNT 7>)
		       (<EQUAL? <GET ,MAZE-TABLE .CNT> 27>
			<PUT ,MAZE-TABLE .CNT 9>)>
		 <SET CNT <+ .CNT 2>>>>

<CONSTANT MAZE-TABLE-LENGTH 40>

<GLOBAL MAZE-TABLE ;"length should be 2*number of takeable objects"
	<TABLE 0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0
	       0 0 0 0 0 0 0 0 0 0>>

<GLOBAL HOLLOW-POINT 20>

<ROOM HOLLOW
      (IN ROOMS)
      (SYNONYM ANTHAR)
      (DESC "Hollow")
      (LDESC
"The maze opens here onto a tiny outdoor plateau, completely surrounded
by towering cliffs. The only way out is back through the dazzling archway
of glass to the west.|
Near the glass arch is a small rectangular brick structure. The center of
the structure is a hole about a foot wide, leading down into darkness.")
      (WEST TO GLASS-MAZE)
      (UP "You couldn't even fly over these cliffs.")
      (DOWN "The opening in the brick structure is too small for
humans or even bats.")
      (FLAGS RLANDBIT ONBIT)
      (PSEUDO "CLIFF" CLIFF-PSEUDO "CLIFFS" CLIFF-PSEUDO)
      (GLOBAL CHIMNEY HOLE SOOT MAZE ARCHWAY)
      (ACTION HOLLOW-F)>

<ROUTINE HOLLOW-F (RARG)
	 <COND (<AND <EQUAL? .RARG ,M-END>
		     <HELD? ,SPELL-BOOK>>
		<MOVE ,SPELL-BOOK ,DIAL>
		<TELL
"\"Caw! Caw!\" A giant bird of prey with a fondness for gnusto-receptive
paper swoops down and flies off with your spell book." CR>)>>

<OBJECT CHIMNEY
	(IN LOCAL-GLOBALS)
	(DESC "chimney")
	(SYNONYM CHIMNE)
	(FLAGS NDESCBIT)
	(ACTION CHIMNEY-F)>

<ROUTINE CHIMNEY-F ()
	 <COND (<EQUAL? ,HERE ,HOLLOW>
		<COND (<EQUAL? ,PRSO ,CHIMNEY>
		       <SETG PERFORMING-SPELL T>
		       <PERFORM ,PRSA ,BRICK-STRUCTURE ,PRSI>
		       <RTRUE>)
		      (T
		       <SETG PERFORMING-SPELL T>
		       <PERFORM ,PRSA ,PRSO ,BRICK-STRUCTURE>
		       <RTRUE>)>)>>

<OBJECT BRICK-STRUCTURE
	(IN HOLLOW)
	(DESC "brick structure")
	(SYNONYM STRUCT BRICKS SHAFT OPENIN)
	(ADJECTIVE BRICK RECTAN SMALL)
	(FLAGS NDESCBIT)
	(ACTION BRICK-STRUCTURE-F)>

<ROUTINE BRICK-STRUCTURE-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"The structure is about two feet on each side, and extends up from the
ground about three feet. Except for a large quantity of soot around the
opening, it looks a lot like a small, rectangular well." CR>)
	       (<VERB? LOOK-INSIDE>
		<TELL
"The opening is dark and you can only see a few feet into it." CR>)
	       (<VERB? ENTER CLIMB-DOWN>
		<DO-WALK ,P?DOWN>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,BRICK-STRUCTURE>>
		<MOVE ,PRSO ,FIREPLACE>
		<COND (<EQUAL? ,PRSO ,SWANZO-SCROLL>
		       <ENABLE <QUEUE I-DORN-BEAST 2>>)>
		<TELL
"The " D ,PRSO " disappears into the shaft." CR>)
	       (<VERB? REACH-IN>
		<TELL "The shaft extends beyond your reach." CR>)
	       (<VERB? THROUGH>
		<DO-WALK ,P?DOWN>)>>

<OBJECT SOOT
	(IN LOCAL-GLOBALS)
	(DESC "soot")
	(SYNONYM SOOT QUANTI)
	(ADJECTIVE LARGE BLACK)
	(FLAGS NDESCBIT NARTICLEBIT)>

<OBJECT SWANZO-SCROLL
	(IN HOLLOW)
	(DESC "parchment scroll")
	(SYNONYM SCROLL)
	(ADJECTIVE PARCHM)
	(SIZE 3)
	(FLAGS TAKEBIT TRYTAKEBIT TRANSBIT CONTBIT READBIT SCROLLBIT)
	(ACTION SCROLL-F)>

<OBJECT SWANZO-SPELL
	(IN SWANZO-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE SWANZO)
	(DESC "swanzo spell")
	(TEXT "exorcise an inhabiting presence")
	(SIZE 1)
	(COUNT 0)
	(FLAGS NDESCBIT SPELLBIT VOWELBIT)
	(ACTION SPELL-F)>

<OBJECT DORN-BEAST
	(IN DIAL)
	(DESC "ferocious dorn beast")
	(SYNONYM DORNBE DORN BEAST DORNS)
	(ADJECTIVE FEROCI DORN)
	(ACTION DORN-BEAST-F)>

<ROUTINE DORN-BEAST-F ()
	 <COND (<VERB? RESEARCH>
		<PERFORM ,V?RESEARCH ,LOBBY>
		<RTRUE>)>>

<OBJECT DORN-BEAST-CORPSE
	(IN DIAL)
	(DESC "splattered body")
	(LDESC
"A somewhat splattered corpse is sprawled across the floor.")
        (SYNONYM CORPSE BODY)
	(ADJECTIVE DEAD SPLATT)
	(ACTION CORPSE-F)>

<ROUTINE CORPSE-F ()
	 <COND (<VERB? MALYON>
		<JIGS-UP
"The corpse comes to life just long enough to fry you.">)>>

<GLOBAL DORN-BEAST-WARNING <>>

<GLOBAL DORN-BEAST-ROOM 0>

<GLOBAL LAST-DORN-ROOM 0>

<GLOBAL SPLATTERED <>>

<ROUTINE I-DORN-BEAST ()
	 <ENABLE <QUEUE I-DORN-BEAST -1>>
	 <COND (<EQUAL? ,HERE ,HOLLOW>
		<COND (,DORN-BEAST-WARNING
		       <DORN-DEATH>)
		      (T
		       <MOVE ,DORN-BEAST ,HERE>
		       <SETG DORN-BEAST-WARNING T>
		       <TELL CR
"With a loud roar, a dreadfully huge dorn beast emerges from the
shadows at the base of the cliff and gallops toward you." CR>)>)
	       (T
		<FSET ,DORN-BEAST ,NDESCBIT>
		<COND (<NOT ,DORN-BEAST-WARNING>
		       <SETG DORN-BEAST-WARNING T>
		       <TELL CR
"From outside the maze, you hear the bellowing of a ferocious dorn beast!" CR>)
		      (<EQUAL? ,ROOM-NUMBER ,DORN-BEAST-ROOM ,LAST-DORN-ROOM>
		       <CRLF>
		       <DORN-DEATH>)
		      (T
		       <TELL CR
"The dorn beast rushes after you. Its ear-splitting bellowing
resounds throughout the glass maze.">
		       <COND (<EQUAL? ,ROOM-NUMBER 27>
			      <SETG SPLATTERED T>
			      <DISABLE <INT I-DORN-BEAST>>
			      <MOVE ,DORN-BEAST ,DIAL>
			      <PUT ,MAZE-TABLE 38 9>
			      <PUT ,MAZE-TABLE 39 ,DORN-BEAST-CORPSE>
			      <TELL
" Suddenly, the dorn-beast realizes that it is galloping through midair,
and gives a surprisingly high-pitched squeal. It claws frantically at thin
air, trying desperately to invent dorn beast flight. You happily notice that
dorn beasts do not so much fly as plummet.">)
			     (T
			      <SETG LAST-DORN-ROOM ,DORN-BEAST-ROOM>
			      <SETG DORN-BEAST-ROOM ,ROOM-NUMBER>
			      <MOVE ,DORN-BEAST ,HERE>)>
		       <CRLF>)>)>>

<ROUTINE DORN-DEATH ()
	 <JIGS-UP
"The dorn beast fries your brain with its hypnotic gaze and begins
secreting digestive juices.">>
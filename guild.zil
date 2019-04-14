"GUILD for
			    SORCERER
       (c) Copyright 1984 by Infocom Inc.  All Rights Reserved."

<ROOM YOUR-QUARTERS
      (IN ROOMS)
      (SYNONYM CHEVAU)
      (DESC "Your Quarters")
      (LDESC
"This is your chamber in the Hall of the Guild of Enchanters, with a
doorway to the west. A private chamber is a great privilege, especially
for an Enchanter as young as yourself, but how many Enchanters can say
they defeated the infamous Krill?")
      (OUT TO HALLWAY-1)
      (WEST TO HALLWAY-1)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL ARCHWAY GLOBAL-BED)>

<OBJECT BED
	(IN YOUR-QUARTERS)
	(DESC "bed")
	(LDESC
"Your bed occupies the far corner of the room.")
	(SYNONYM BED)
	(FLAGS VEHBIT SURFACEBIT OPENBIT CONTBIT SEARCHBIT)
	(CAPACITY 60)
	(ACTION BED-F)>

<OBJECT GLOBAL-BED
	(IN LOCAL-GLOBALS)
	(DESC "bed")
	(SYNONYM BED)
	(FLAGS VEHBIT SURFACEBIT OPENBIT CONTBIT SEARCHBIT)
	(ACTION GLOBAL-BED-F)>

<ROUTINE BED-F ("OPTIONAL" (RARG <>))
	 <COND (<EQUAL? .RARG ,M-BEG>
		<COND (<VERB? WALK>
		       <NOT-GOING-ANYWHERE ,BED>)
		      (<AND <VERB? TAKE>
			    <NOT <HELD? ,PRSO>>
			    <NOT <EQUAL? ,PRSO ,GLOBAL-SLEEP>>>
		       <COND (<AND <NOT <EQUAL? ,PRSO ,GRUE ,ME ,BED>>
				   <NOT <IN? ,PRSO ,BED>>>
			      <TELL "You can't reach it from the bed." CR>)>)>)
	       (.RARG
		<RFALSE>)
	       (<VERB? OPEN CLOSE>
		<TELL "Huh?" CR>)
	       (<VERB? WALK-TO>
		<PERFORM ,V?WALK-TO ,GLOBAL-SLEEP>
		<RTRUE>)
	       (<VERB? CLIMB-ON LIE-DOWN>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)>>

<ROUTINE GLOBAL-BED-F ()
	 <COND (<EQUAL? ,GLOBAL-BED ,PRSO>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,BED ,PRSI>
		<RTRUE>)
	       (T
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,PRSO ,BED>
		<RTRUE>)>>	

<ROOM BELBOZ-QUARTERS
      (IN ROOMS)
      (DESC "Belboz's Quarters")
      (OUT TO HALLWAY-1)
      (EAST TO HALLWAY-1)
      (FLAGS INSIDEBIT RLANDBIT)
      (PSEUDO "PERCH" PERCH-PSEUDO)
      (ACTION BELBOZ-QUARTERS-F)>

<ROUTINE BELBOZ-QUARTERS-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The personal chamber of Belboz, who presides over the Circle of Enchanters,
is appointed with a beautiful woven wall hanging">
		<COND (<IN? ,MORGIA-PLANT ,HERE>
		       <TELL ", an exotic morgia plant,">)>
		<TELL
" and a wide darkwood desk crafted by the artisans of Gurth. The hallway
lies to the east." CR>)>>

<ROUTINE PERCH-PSEUDO ()
	 <COND (<VERB? CLIMB-ON>
		<TELL
"I'd recommend a good doctor, but we need the eggs." CR>)>>

<OBJECT PARROT
	(IN BELBOZ-QUARTERS)
	(DESC "parrot")
	(FDESC
"Pacing back and forth on a perch in the corner is Belboz's prized pet
parrot, native to the jungles of Miznia.")
	(SYNONYM PARROT BIRD POLLIB POLLY)
	(ADJECTIVE PRIZED PET)
	(FLAGS TRYTAKEBIT)
	(ACTION PARROT-F)>

<ROUTINE PARROT-F ()
	 <COND (<VERB? TAKE>
		<TELL "The parrot hops to the other end of the perch." CR>)>>

<ROUTINE I-PARROT ()
       <COND (<AND <IN? ,PARROT ,HERE>
		   <PROB 40>>
	      <TELL CR "\"Squawk! " <PICK-ONE ,PARROTISMS> " Squawk!\"" CR>)>>

<GLOBAL PARROTISMS
	<PLTABLE
	 "Pollibar want a cracker!"
	 "Now where can I hide this key?"
	 "You should never have let down your mindshield, you
doddering old Enchanter."
	 "This tea is cold! Get me another cup."
	 "Where did I leave my spectacles?"
	 "Belboz, the Circle is waiting for you.">>

<OBJECT BELBOZ-DESK
	(IN BELBOZ-QUARTERS)
	(DESC "darkwood desk")
	(SYNONYM DESK)
	(ADJECTIVE WOOD WIDE CRAFTE DARK DARKWO)
	(FLAGS SURFACEBIT NDESCBIT OPENBIT CONTBIT SEARCHBIT)
	(CAPACITY 60)
	(ACTION BELBOZ-DESK-F)>

<ROUTINE BELBOZ-DESK-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The desk has one drawer which is ">
		<COND (<FSET? ,DESK-DRAWER ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL "." CR>
		<COND (<FIRST? ,PRSO>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<AND <VERB? SEARCH>
		     <NOT <FSET? ,DESK-DRAWER ,OPENBIT>>
		     <FIRST? ,DESK-DRAWER>>
		<TELL "You open the desk drawer and find ">
		<PRINT-CONTENTS ,DESK-DRAWER>
		<FSET ,DESK-DRAWER ,OPENBIT>
		<TELL "." CR>)
	       (<VERB? CLOSE OPEN REZROV REACH-IN LOOK-INSIDE>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,PRSA ,DESK-DRAWER>
		<RTRUE>)
	       (<AND <VERB? TAKE>
		     <EQUAL? ,BELBOZ-DESK ,PRSI>
		     <FIRST? ,DESK-DRAWER>>
		<PERFORM ,V?TAKE ,PRSO ,DESK-DRAWER>
		<COND (<FIRST? ,BELBOZ-DESK>
		       <RFALSE>)
		      (T
		       <RTRUE>)>)
	       (<AND <VERB? PUT>
		     <EQUAL? ,PRSI ,BELBOZ-DESK>>
		<PERFORM ,V?PUT ,PRSO ,DESK-DRAWER>
		<RTRUE>)>>

<OBJECT DESK-DRAWER
	(IN BELBOZ-QUARTERS)
	(DESC "desk drawer")
	(SYNONYM DRAWER)
	(ADJECTIVE DESK)
	(CAPACITY 40)
	(FLAGS NDESCBIT CONTBIT SEARCHBIT)>

<OBJECT TINY-BOX
	(IN DESK-DRAWER)
	(DESC "tiny box")
	(SYNONYM BOX LID WRITIN)
	(ADJECTIVE TINY)
	(FLAGS CONTBIT SEARCHBIT TAKEBIT READBIT)
	(CAPACITY 3)
	(SIZE 4)
	(ACTION TINY-BOX-F)>

<ROUTINE TINY-BOX-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "There is writing on the lid of the box." CR>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL
"|
\"    MAGIC AMULET|
|
The closer this amulet is to|
its owner, the brighter it may|
glow. Ideal for leaving with|
your loved ones if you go on|
a long and hazardous journey.|
|
This amulet is sensitized to|
-> BELBOZ THE NECROMANCER|
|
Another fine product of the|
Frobozz Magic Amulet Company.\"" CR>
		<FIXED-FONT-OFF>)>>

<OBJECT MAGIC-AMULET
	(IN TINY-BOX)
	(DESC "magic amulet")
	(SYNONYM AMULET JEWEL AGGTHORA)
	(ADJECTIVE MAGIC BLUE)
	(SIZE 3)
	(FLAGS TAKEBIT WEARBIT)
	(DESCFCN AMULET-DESCFCN)
	(ACTION MAGIC-AMULET-F)>

<ROUTINE MAGIC-AMULET-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"A blue jewel hangs from a long golden chain. The jewel is ">
		<AMULET-GLOWS>
		<TELL "." CR>)
	       (<VERB? RESEARCH>
		<TELL
"The Amulet of Aggthora was a legendary jewel renowned for
its powers of augury." CR>)>>

<ROUTINE AMULET-DESCFCN (RARG)
	 <TELL "There is an amulet here. The amulet's jewel is ">
	 <AMULET-GLOWS>
	 <TELL "." CR>>

<ROUTINE AMULET-GLOWS ()
	 <COND (<IN-GUILD-HALL?>
		<TELL "dark">)
	       (<IN-MAZE-AREA?>
		<TELL "glowing">)
	       (<IN-CRATER-AREA?>
		<TELL "glowing brightly">)
	       (<IN-COAL-MINE?>
		<TELL "glowing very brightly">)
	       (<IN-END-GAME?>
		<TELL "pulsing with flashes of brilliant light">)
	       (T
		<TELL "glowing dimly">)>>

<ROUTINE IN-GUILD-HALL? ("OPTIONAL" (X <>))
	 <COND (<NOT .X>
		<SET X ,HERE>)>
	 <COND (<OR <EQUAL? .X ,HALLWAY-1 ,HALLWAY-2 ,CHAMBER-OF-THE-CIRCLE>
		    <EQUAL? .X ,YOUR-QUARTERS ,BELBOZ-QUARTERS ,LOBBY>
		    <EQUAL? .X ,FROBAR-QUARTERS ,HELISTAR-QUARTERS>
		    <EQUAL? .X ,STORE-ROOM ,LIBRARY ,CELLAR>
		    <EQUAL? .X ,APPRENTICE-QUARTERS ,SERVANT-QUARTERS>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE IN-COAL-MINE? ()
	 <COND (<OR <EQUAL? ,HERE ,COAL-BIN-ROOM ,DIAL-ROOM ,SHAFT-BOTTOM>
		    <EQUAL? ,HERE ,SHAFT-TOP ,TOP-OF-CHUTE ,SLANTED-ROOM>
		    <EQUAL? ,HERE ,COAL-MINE-1 ,COAL-MINE-2 ,COAL-MINE-3>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE IN-MAZE-AREA? ()
	 <COND (<OR <EQUAL? ,HERE ,TOLL-GATE ,END-OF-HIGHWAY ,HOLLOW>
		    <EQUAL? ,HERE ,OUTSIDE-GLASS-DOOR ,GLASS-MAZE ,STORE>
		    <EQUAL? ,HERE ,ENTRANCE-HALL ,STONE-HUT ,OUTSIDE-STORE>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE IN-CRATER-AREA? ()
	 <COND (<OR <EQUAL? ,HERE ,HIGHWAY ,BEND ,EDGE-OF-CRATER>
		    <EQUAL? ,HERE ,CRATER ,WINDING-TUNNEL ,HALL-OF-CARVINGS>
		    <EQUAL? ,HERE ,EDGE-OF-CHASM ,BARE-PASSAGE ,SOOTY-ROOM>
		    <EQUAL? ,HERE ,ELBOW-ROOM ,TREE-ROOM ,PARK-ENTRANCE>
		    <EQUAL? ,HERE ,EAST-END-OF-MIDWAY ,FLUME ,HAUNTED-HOUSE>
		    <EQUAL? ,HERE ,WEST-END-OF-MIDWAY ,ROLLER-COASTER ,ARCADE>
		    <EQUAL? ,HERE ,CASINO>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE IN-END-GAME? ()
	 <COND (<OR <EQUAL? ,HERE ,OCEAN-NORTH ,OCEAN-SOUTH ,BELBOZ-HIDEOUT>
		    <EQUAL? ,HERE ,MOUTH-OF-RIVER ,GRUE-LAIR ,MAMMOTH-CAVERN>
		    <EQUAL? ,HERE ,CHAMBER-OF-LIVING-DEATH ,COVE ,LAGOON-FLOOR>
		    <EQUAL? ,HERE ,HALL-OF-ETERNAL-PAIN ,LAGOON>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<OBJECT JOURNAL
	(IN DESK-DRAWER)
	(DESC "journal")
	(LDESC
"The personal journal of Belboz the Necromancer is lying here.")
	(SYNONYM DIARY NOTEBO ENTRIE JOURNA)
	(ADJECTIVE PERSON NOTE LAST THREE)
	(FLAGS TAKEBIT READBIT)
	(SIZE 10)
	(ACTION JOURNAL-F)>

<ROUTINE JOURNAL-F ()
	 <COND (<VERB? READ EXAMINE LOOK-INSIDE>
		<COND (<FSET? ,JOURNAL ,OPENBIT>
		       <TELL
"You skim through the pages of the journal, a combination diary and notebook.
Most of the notations, written in Belboz's familiar flowing script, deal with
meetings of the Circle and business of the Guild.|
|
There is one interesting entry toward the end of the book. Belboz refers
to an ancient and evil force known simply as Jeearr, a demon whose powers
could endanger the Circle and possibly the entire kingdom. He has decided
to conduct some dangerous exploratory experiments, operating alone to
shield the Circle from the perils involved.|
|
The last three entries are strange and frightening -- written in a hand quite
different from that of Belboz, and in a language totally unfamiliar to you.|
|
On the inside cover is an inscription, written in a light script,
which reads \"Current code: " <GET ,CODE-TABLE ,CODE-NUMBER> "\"." CR>)
		      (T
		       <TELL "It's closed and sealed with a lock." CR>)>)
	       (<VERB? OPEN UNLOCK REZROV>
		<COND (<FSET? ,JOURNAL ,OPENBIT>
		       <TELL "The journal is already open!" CR>)
	       	      (<VERB? REZROV>
		       <TELL
"The journal seems to bear a spell protecting it against
the simple rezrov spell." CR>)
		      (ELSE
		       <COND (<NOT ,PRSI>
			      <COND (<IN? ,KEY ,PROTAGONIST>
				     <SETG PRSI ,KEY>
				     <TELL "(with the key)" CR>)
				    (T
				     <SETG PRSI ,HANDS>)>)>
		       <COND (<EQUAL? ,PRSI ,KEY>
			      <FSET ,JOURNAL ,OPENBIT>
			      <TELL "The journal springs open." CR>)
			     (T
			      <TELL "You can't unlock it with">
			      <ARTICLE ,PRSI>
			      <TELL "." CR>)>)>)>>

<OBJECT WHEEL
	(IN DESK-DRAWER)
	(DESC "infotater")
	(SYNONYM INFOTA WHEEL)
	(ADJECTIVE LEATHE BOUND DATA)
	(FLAGS READBIT TAKEBIT VOWELBIT)
	(SIZE 10)
	(ACTION WHEEL-F)>

<ROUTINE WHEEL-F ()
	 <COND (<VERB? EXAMINE>
		<TELL
"Like most infotaters, this one has several windows and a rotating data
wheel. It is leather-bound and beautifully illustrated. ">
		<INFOTATER-NOTE>)
	       (<VERB? READ>
		<TELL
"The infotater has entries on a dozen native beasts. ">
		<INFOTATER-NOTE>)
	       (<VERB? TURN SPIN>
		<TELL "Refer to the infotater in your SORCERER package." CR>)
	       (<VERB? RESEARCH>
		<TELL
"The infotater, which popular legends say was invented by Entharion the
Wise, is the best way to store data ever discovered." CR>)>>

<ROUTINE INFOTATER-NOTE ()
	 <TELL
"(NOTE: This is the infotater included in your game package.)" CR>>

<OBJECT WALL-HANGING
	(IN BELBOZ-QUARTERS)
	(DESC "wall hanging")
	(SYNONYM HANGIN TAPEST)
	(ADJECTIVE WALL BEAUTI WOVEN)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION WALL-HANGING-F)>

<ROUTINE WALL-HANGING-F ()
	 <COND (<VERB? MOVE LOOK-BEHIND LOOK-UNDER RUB SHAKE RAISE>
		<COND (<NOT <FSET? ,KEY ,TOUCHBIT>>
		       <MOVE ,KEY ,HERE>
		       <THIS-IS-IT ,KEY>
		       <FSET ,KEY ,TOUCHBIT>
		       <SETG SCORE <+ ,SCORE 15>>
		       <TELL
"As you move the tapestry, a key falls out from behind it
and lands on the floor." CR>)
		      (T
		       <TELL "Nope, no more keys." CR>)>)
	       (<VERB? TAKE UNTIE>
		<TELL
"It looks too well fastened to remove from the wall." CR>)
	       (<VERB? EXAMINE>
		<TELL
"It is a beautiful piece of local handiwork, given to Belboz by the
grateful townspeople after his (admittedly showy) pyrotechnical
destruction of the evil giant Amathradonis. The hanging is affixed to
the wall at its upper corners." CR>)>> 

<OBJECT KEY
	(IN DIAL)
	(DESC "small key")
	(SYNONYM KEY)
	(ADJECTIVE TINY SMALL)
	(FLAGS TAKEBIT TOOLBIT)
	(SIZE 3)>

<OBJECT MORGIA-PLANT
	(IN BELBOZ-QUARTERS)
	(DESC "morgia plant")
	(SYNONYM PLANT PLANTS)
	(ADJECTIVE MORGIA EXOTIC)
	(FLAGS NDESCBIT TRYTAKEBIT)
	(ACTION MORGIA-PLANT-F)>

<ROUTINE MORGIA-PLANT-F ()
	 <COND (<VERB? MEEF>
		<MOVE ,MORGIA-PLANT ,DIAL>
		<TELL
"The morgia plant, particularly susceptible to the meef spell, shrivels
up and vanishes." CR>)
	       (<VERB? TAKE>
		<TELL
"The plant is so heavy you succeed only in budging it a few inches." CR>)
	       (<VERB? EAT>
		<TELL
"Morgias taste terrible; besides, Belboz wouldn't like someone munching
on his favorite plant." CR>)
	       (<VERB? RESEARCH>
		<TELL
"A beautiful and exotic plant, the morgia is well-known for
its susceptibility to magic spells." CR>)>>

<ROOM FROBAR-QUARTERS
       (IN ROOMS)
       (SYNONYM BARBEL ORKAN)
       (DESC "Frobar's Quarters")
       (LDESC
"This is the room of Frobar the Enchanter. There isn't much here in the way
of furnishings, Frobar being a pretty dull kind of guy.")
       (OUT TO HALLWAY-2)
       (WEST TO HALLWAY-2)
       (FLAGS RLANDBIT INSIDEBIT)>

<ROOM HELISTAR-QUARTERS
       (IN ROOMS)
       (SYNONYM THRIFF)
       (DESC "Helistar's Quarters")
       (LDESC
"Helistar is one of the foremost members of the Circle, and
this is her private chamber.")
       (OUT TO HALLWAY-2)
       (EAST TO HALLWAY-2)
       (FLAGS INSIDEBIT RLANDBIT)>

<OBJECT GASPAR-SCROLL
	(IN HELISTAR-QUARTERS)
	(DESC "shiny scroll")
	(FDESC
"Among Helistar's possessions is a scroll, new and shiny.")
	(SYNONYM SCROLL)
	(ADJECTIVE NEW SHINY)	
	(FLAGS TAKEBIT READBIT SCROLLBIT CONTBIT TRANSBIT)
	(SIZE 3)
	(ACTION SCROLL-F)>	

<OBJECT GASPAR-SPELL
	(IN GASPAR-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE GASPAR)
	(DESC "gaspar spell")
	(TEXT "provide for your own resurrection")
	(COUNT 0)
	(SIZE 1)
	(FLAGS NDESCBIT SPELLBIT)
	(ACTION SPELL-F)>

<GLOBAL RESURRECTION-ROOM <>>

<ROOM SERVANT-QUARTERS
      (IN ROOMS)
      (SYNONYM SORCER)
      (DESC "Servants' Quarters")
      (LDESC
"This is a sparsely furnished living area for the servants of the Guild.
None are in sight; presumably they are out doing their daily errands.
You can leave to the southwest.")
      (OUT TO LOBBY)
      (SW TO LOBBY)
      (FLAGS INSIDEBIT RLANDBIT)>

<ROOM APPRENTICE-QUARTERS
      (IN ROOMS)
      (SYNONYM GORGE)
      (ADJECTIVE RAZOR)
      (DESC "Apprentice Quarters")
      (LDESC
"This is a large hall where the Guild's young apprentices live and study
as they strive to achieve a seat on the Circle. You think back to the days
when you occupied these quarters. The apprentices are gone, having
accompanied Frobar into town to shop. You can leave to the southeast.")
      (OUT TO LOBBY)
      (SE TO LOBBY)
      (FLAGS INSIDEBIT RLANDBIT)>

<OBJECT FROBAR-NOTE
	(IN HALLWAY-1)
	(DESC "scribbled note")
	(FDESC
"Tacked to the doorframe of your room is a note, hurriedly scribbled on
parchment.")
	(SYNONYM NOTE MESSAG)
	(ADJECTIVE SCRIBB PARCHM)
	(FLAGS READBIT TAKEBIT)
	(SIZE 3)
	(TEXT
"\"I have taken the apprentices into town to shop for the Guild picnic. I
tried rousing you, but you seemed deep asleep. By the way, have you seen
Belboz anywhere? It's not like him to leave without telling someone -- but
then, he's been acting pretty odd of late.|
|
                            -- Frobar\"")>

<ROOM HALLWAY-1
      (IN ROOMS)
      (DESC "Hallway")
      (WEST TO BELBOZ-QUARTERS)
      (EAST TO YOUR-QUARTERS)
      (SOUTH TO HALLWAY-2)
      (NORTH TO CHAMBER-OF-THE-CIRCLE IF CHAMBER-DOOR IS OPEN)
      (FLAGS RLANDBIT ONBIT INSIDEBIT)
      (GLOBAL CHAMBER-DOOR)
      (ACTION HALLWAY-1-F)>

<ROUTINE HALLWAY-1-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<HALLWAY-DESC>
		<TELL "A heavy wooden door, currently ">
		<COND (<FSET? ,CHAMBER-DOOR ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL ", leads north." CR>)>>

<ROOM HALLWAY-2
      (IN ROOMS)
      (SYNONYM ZORK)
      (DESC "Hallway")
      (EAST TO FROBAR-QUARTERS)
      (WEST TO HELISTAR-QUARTERS)
      (NORTH TO HALLWAY-1)
      (SOUTH TO LOBBY)
      (FLAGS RLANDBIT ONBIT INSIDEBIT)
      (GLOBAL ARCHWAY)
      (ACTION HALLWAY-2-F)>

<ROUTINE HALLWAY-2-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<HALLWAY-DESC>
		<TELL
"A large marble archway to the south leads into an open area." CR>)>>

<ROUTINE HALLWAY-DESC ()
	 <TELL
"Rooms lie to the east and west from this north-south corridor. ">>

<OBJECT CHAMBER-DOOR
	(IN LOCAL-GLOBALS)
	(DESC "heavy wooden door")
	(SYNONYM DOOR DOORS)
	(ADJECTIVE HEAVY WOODEN)
	(FLAGS DOORBIT)>

<ROOM CHAMBER-OF-THE-CIRCLE
      (IN ROOMS)
      (DESC "Chamber of the Circle")
      (SOUTH TO HALLWAY-1 IF CHAMBER-DOOR IS OPEN)
      (FLAGS RLANDBIT INSIDEBIT)
      (GLOBAL CHAMBER-DOOR)
      (PSEUDO "TABLE" TABLE-PSEUDO)
      (ACTION CHAMBER-OF-THE-CIRCLE-F)>

<ROUTINE CHAMBER-OF-THE-CIRCLE-F (RARG)
	 <COND (<EQUAL? .RARG ,M-LOOK>
		<TELL
"The meeting place of the Circle of Enchanters is a large, round room with
a high domed ceiling. A table occupies the center of the room. Engraved on
the wall is a list of tenets, the Guild's code of honor. The only door, at
the southernmost point of the perimeter, is ">
		<COND (<FSET? ,CHAMBER-DOOR ,OPENBIT>
		       <TELL "open">)
		      (T
		       <TELL "closed">)>
		<TELL "." CR>)>>

<GLOBAL TABLE-WARNING <>>

<ROUTINE TABLE-PSEUDO ()
	 <COND (<VERB? PUT-ON CLIMB-ON>
		<SETG TABLE-WARNING T>
		<TELL
"A warning nymph appears, floating over the table. \"The servants just
finished waxing the table, and it's still wet.\" With a sly grin, the
nymph vanishes." CR>)
	       (<AND ,TABLE-WARNING
		     <VERB? PULVER>>
		<TELL
"That would cause the wax to dry dull and yellowish!" CR>)>> 

<OBJECT TENETS
	(IN CHAMBER-OF-THE-CIRCLE)
	(DESC "list of tenets")
	(SYNONYM ENGRAV LIST TENETS TENET)
	(ADJECTIVE ANCIEN FLOWER)
	(FLAGS READBIT NDESCBIT)
	(TEXT
"The first tenet states that Enchanters may never use their talents to aid
evil. The second points out that an Enchanter's duty is to the Guild and to
the Kingdom, not to the individual. Lesser tenets include rules for
conducting votes at meetings, guidelines for passing dishes at Guild
banquets, and penalties for revealing the Guild's secret handshake.")>

<ROOM LOBBY
      (SYNONYM ORC ORCS YIPPLE NABIZ)
      (IN ROOMS)
      (DESC "Lobby")
      (LDESC
"This is the entrance lobby of the Guild Hall. Befitting the status and
wealth of the Guild, the lobby is finished with polished Antharian marble,
inlaid with intricate patterns of silver leaf. To the north is a wide arch,
and smaller openings flank the area on the eastern and western sides, as
well as the northeastern and northwestern corners. A narrow stair leads
downward. Through another arch to the south, you can see the entrance steps
and the main road into town.")
      (NORTH TO HALLWAY-2)
      (EAST TO LIBRARY)
      (WEST TO STORE-ROOM)
      (DOWN TO CELLAR)
      (NE TO SERVANT-QUARTERS)
      (NW TO APPRENTICE-QUARTERS)
      (SOUTH "A tiny warning nymph appears, floating in the air next to your
ear. \"There's no one else here,\" it reminds you, \"so you'd better not leave
just now. Bye!\" It winks at you before vanishing.")
      (FLAGS RLANDBIT INSIDEBIT ONBIT)
      (PSEUDO "MARBLE" MARBLE-PSEUDO)
      (GLOBAL HOLE ROAD STAIRS ARCHWAY)>

<ROUTINE MARBLE-PSEUDO ()
	 <RFALSE>>

<OBJECT MAILBOX
	(IN LOBBY)
	(DESC "receptacle")
	(LDESC
"Affixed to the southern arch is an ornate brass receptacle, intended
for use by messengers.")
	(SYNONYM MAILBO RECEPT)
	(ADJECTIVE ORNATE BRASS)
	(FLAGS CONTBIT SEARCHBIT)
	(CAPACITY 20)>

<ROUTINE I-MAILMAN ()
	 <MOVE ,MAGAZINE ,MAILBOX>
	 <FCLEAR ,MAILBOX ,OPENBIT>
	 <COND (<IN? ,MATCHBOOK ,MAILBOX>
		<MOVE ,VILSTU-VIAL ,MAILBOX>
		<MOVE ,MATCHBOOK ,DIAL>)>
	 <COND (<EQUAL? ,HERE ,LOBBY>
		<SETG MAILMAN-FOLLOW T>
		<ENABLE <QUEUE I-MAILMAN-FOLLOW 1>>
		<TELL CR
"A member of the Messengers Guild walks up and puts something in the
receptacle. He closes it, and rings the doorbell. Noticing you, he gives
a friendly wave before departing." CR>)
	       (<IN-GUILD-HALL?>
		<TELL CR "The Guild Hall doorbell chimes." CR>)>>

<GLOBAL MAILMAN-FOLLOW <>>

<ROUTINE I-MAILMAN-FOLLOW ()
	 <SETG MAILMAN-FOLLOW <>>
	 <RFALSE>>

<OBJECT MAGAZINE
	(IN DIAL)
	(DESC "issue of Popular Enchanting")
	(SYNONYM MAGAZI ISSUE ENCHAN LABEL)
	(ADJECTIVE POPULA)
	(FLAGS READBIT TAKEBIT VOWELBIT)
	(SIZE 7)
	(ACTION MAGAZINE-F)>

<ROUTINE MAGAZINE-F ()
	 <COND (<VERB? OPEN LOOK-INSIDE READ>
		<TELL
"This month's cover story is about Belboz! Other stories relate the
explosion of spell scroll manufacturers, and the coming shakedown in
the magic potion industry. The address label on the cover reads:||">
		<FIXED-FONT-ON>
		<TELL"
   \"Z5 ACCAR256 4-964|
    Hall of the Guild of Enchanters|
    Village of Accardi-By-The-Sea|
    Land of Frobozz\"" CR>
		<FIXED-FONT-OFF>)>>

<OBJECT VILSTU-VIAL
	(IN DIAL)
	(DESC "orange vial")
	(LDESC
"An orange vial, labelled in tiny letters, is lying here.")
	(SYNONYM VIAL VIALS LABEL LETTER)
	(ADJECTIVE VIVID ORANGE VILSTU TINY)
	(FLAGS CONTBIT SEARCHBIT READBIT TAKEBIT VOWELBIT VIALBIT)
	(SIZE 3)
	(CAPACITY 1)
	(ACTION VILSTU-VIAL-F)>

<ROUTINE VILSTU-VIAL-F ()
	 <COND (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL
"|
       \"VILSTU POTION|
(obviate need for breathing)\"" CR>
		<FIXED-FONT-OFF>)>>

<OBJECT VILSTU-POTION
	(IN VILSTU-VIAL)
	(DESC "orange potion")
	(SYNONYM POTION)
	(ADJECTIVE ORANGE VILSTU)
	(FLAGS NARTICLEBIT VOWELBIT)
	(ACTION VILSTU-POTION-F)>

<ROUTINE VILSTU-POTION-F ()
	 <COND (<AND <VERB? EAT DRINK>
		     <NOT <IN? ,VILSTU-VIAL ,PROTAGONIST>>>
		<POTION-POUR ,VILSTU-VIAL>)
	       (<VERB? RESEARCH>
		<READ-ABOUT-POTIONS 3>)
	       (<VERB? EAT DRINK>
		<MOVE ,VILSTU-POTION ,DIAL>
		<COND (,UNDER-INFLUENCE
		       <TWO-POTIONS>
		       <RTRUE>)>
		<SETG UNDER-INFLUENCE ,VILSTU-POTION>
		<ENABLE <QUEUE I-BREATHE 19>>
		<SETG VILSTUED T>
		<COND (<EQUAL? ,HERE ,COAL-BIN-ROOM ,DIAL-ROOM>
		       <DISABLE <INT I-SUFFOCATE>>
		       <ENABLE <QUEUE I-OLDER-SELF 1>>)>
		<TELL
"The orange potion tasted like pepper, and made your nose tingle." CR>)
	       (<VERB? DROP>
		<PERFORM ,V?POUR ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <VERB? POUR>
		     <EQUAL? ,PRSO ,VILSTU-POTION>>
		<POTION-POUR ,VILSTU-VIAL>)>>

<GLOBAL VILSTUED <>>

<GLOBAL BREATH-SHORTAGE 0>

<ROUTINE I-BREATHE ()
	 <SETG BREATH-SHORTAGE <+ ,BREATH-SHORTAGE 1>>
	 <COND (<EQUAL? ,UNDER-INFLUENCE ,VILSTU-POTION>
		<SETG UNDER-INFLUENCE <>>)>
	 <COND (<EQUAL? ,BREATH-SHORTAGE 1>
		<ENABLE <QUEUE I-BREATHE 4>>
		<TELL CR
"You feel the vilstu potion beginning to wear off">
		<COND (<IN-COAL-MINE?>
		       <TELL ", and the air here seems pretty unbreathable">)>
		<TELL "." CR>)
	       (<EQUAL? ,BREATH-SHORTAGE 2>
		<ENABLE <QUEUE I-BREATHE 6>>
		<TELL CR
"The vilstu potion has almost completely worn off now">
		<COND (<IN-COAL-MINE?>
		       <TELL
", and I doubt you could survive here without it">)>
		<TELL "." CR>)
	       (T
		<SETG VILSTUED <>>
		<COND (<EQUAL? ,HERE ,LAGOON-FLOOR>
		       <ENABLE <QUEUE I-DROWN -1>>)>
		<TELL CR
"You feel the final effects of the vilstu potion vanish">
		<COND (<IN-COAL-MINE?>
		       <JIGS-UP
". Unfortunately, coal gas is a poor substitute for oxygen.">)
		      (T
		       <SETG AWAKE 8>
		       <SETG LOAD-ALLOWED 20>
		       <SETG FUMBLE-NUMBER 1>
		       <ENABLE <QUEUE I-TIRED 8>>
		       <TELL
", leaving you totally exhausted (an unfortunate side effect)." CR>)>)>> 

<ROOM LIBRARY
      (IN ROOMS)
      (DESC "Library")
      (LDESC
"This is a study chamber for members of the Guild. Usually, there would
be several elder Enchanters patiently training novices, but no one is here
at the moment. The only exit is west.|
Lying open on a stand in one corner is a heavy volume, probably
a copy of the Encyclopedia Frobizzica.")
      (WEST TO LOBBY)
      (FLAGS RLANDBIT INSIDEBIT)
      (PSEUDO "STAND" STAND-PSEUDO)>

<ROUTINE STAND-PSEUDO ()
	 <COND (<VERB? EXAMINE>
		<TELL "A volume lies open on the stand." CR>)>>

<OBJECT ENCYCLOPEDIA
	(IN LIBRARY)
	(DESC "copy of Encyclopedia Frobizzica")
	(SYNONYM ENCYCL COPY VOLUME FROBIZ)
	(ADJECTIVE HEAVY ENCYCL)
	(FLAGS READBIT TRYTAKEBIT NDESCBIT)
	(TEXT
"It would take days to read the entire encyclopedia. A better idea
would be to read about specific persons or things.")
	(ACTION ENCYCLOPEDIA-F)>

<ROUTINE ENCYCLOPEDIA-F ()
	 <COND (<VERB? EXAMINE>
		<TELL "The volume lies open to ">
		<COND (,VOLUME-USED
		       <TELL "a random entry." CR>)
		      (T
		       <TELL
"an entry about the Glass Maze of King Duncanthrax. ">
		       <PERFORM ,V?RESEARCH ,MAZE>
		       <CRLF>
		       <TELL
"You could probably read about all sorts of other interesting people,
places, and things by looking them up in the encyclopedia." CR>)>)
	       (<VERB? OPEN>
		<TELL "It is." CR>)
	       (<VERB? CLOSE>
		<TELL "Why bother?" CR>)
	       (<VERB? TAKE>
		<TELL
"A library nymph appears, sitting on your wrist. \"Sorry, but the
encyclopedia is never to be removed from the stand.\" Kicking you gently
in the thumb, the nymph vanishes." CR>)
	       (<VERB? LOOK-INSIDE>
	        <PERFORM ,V?READ ,PRSO>
		<RTRUE>)>> 

<GLOBAL VOLUME-USED <>>

<OBJECT MEEF-SCROLL
	(IN LIBRARY)
	(DESC "dusty scroll")
	(FDESC
"The servants have been lax lately, for a scroll is lying among the dust
in the corner.")
	(SYNONYM SCROLL)
	(ADJECTIVE DUSTY)
	(SIZE 3)
	(FLAGS TAKEBIT READBIT SCROLLBIT CONTBIT TRANSBIT)
	(ACTION SCROLL-F)>

<OBJECT MEEF-SPELL
	(IN MEEF-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE MEEF)
	(DESC "meef spell")
	(TEXT "cause plants to wilt")
	(SIZE 1)
	(COUNT 0)
	(FLAGS NDESCBIT SPELLBIT)
	(ACTION SPELL-F)> 

<ROOM STORE-ROOM
      (SYNONYM DRYAD DRYADS KOBOLD SURMIN)
      (IN ROOMS)
      (DESC "Store Room")
      (LDESC
"This is a closet for storage. The only exit is east.")
      (EAST TO LOBBY)
      (OUT TO LOBBY)
      (FLAGS RLANDBIT INSIDEBIT)>

<OBJECT BERZIO-VIAL
	(IN STORE-ROOM)
	(DESC "ochre vial")
	(FDESC "Among the provisions here is a small ochre-colored vial,
closed and labelled with tiny lettering.")
	(SYNONYM VIAL VIALS LABEL LETTER)
	(ADJECTIVE BERZIO OCHRE SMALL TINY)
	(SIZE 3)
	(CAPACITY 1)
	(FLAGS CONTBIT SEARCHBIT TAKEBIT VOWELBIT READBIT VIALBIT)
	(ACTION BERZIO-VIAL-F)>

<ROUTINE BERZIO-VIAL-F ()
	 <COND (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL
"|
        \"BERZIO POTION|
(obviate need for food or drink)\"" CR>
		<FIXED-FONT-OFF>)>>

<OBJECT BERZIO-POTION
	(IN BERZIO-VIAL)
	(DESC "ochre potion")
	(SYNONYM POTION)
	(ADJECTIVE OCHRE BERZIO)
	(FLAGS NARTICLEBIT VOWELBIT)
	(ACTION BERZIO-POTION-F)>

<GLOBAL BERZIOED <>>

<ROUTINE BERZIO-POTION-F ()
	 <COND (<AND <VERB? EAT DRINK>
		     <NOT <IN? ,BERZIO-VIAL ,PROTAGONIST>>>
		<POTION-POUR ,BERZIO-VIAL>)
	       (<VERB? RESEARCH>
		<READ-ABOUT-POTIONS 1>)
	       (<VERB? EAT DRINK>
		<MOVE ,BERZIO-POTION ,DIAL>
		<SETG BERZIOED T>
		<ENABLE <QUEUE I-UNBERZIO 100>>
		<SETG SCORE <+ ,SCORE 10>>
		<TELL "The potion was completely tasteless.">
		<COND (<OR <G? ,HUNGER-LEVEL 0>
			   <G? ,THIRST-LEVEL 0>>
		       <TELL
" You no longer feel hungry and thirsty, though.">)>
		<SETG HUNGER-LEVEL 0>
		<SETG THIRST-LEVEL 0>
		<CRLF>)
	       (<VERB? DROP>
		<PERFORM ,V?POUR ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <VERB? POUR>
		     <EQUAL? ,PRSO ,BERZIO-POTION>>
		<POTION-POUR ,BERZIO-VIAL>)>>

<ROUTINE I-UNBERZIO ()
	 <SETG BERZIOED <>>
	 <RFALSE>>

<OBJECT MATCHBOOK
	(IN STORE-ROOM)
	(DESC "depleted matchbook")
	(SYNONYM MATCHE MATCHB COVER PRINTI)
	(ADJECTIVE MATCH DEPLET INNER)
	(FLAGS READBIT TAKEBIT)
	(SIZE 3)
	(ACTION MATCHBOOK-F)>

<ROUTINE MATCHBOOK-F ()
	 <COND (<VERB? CLOSE>
		<TELL "Why bother?" CR>)
	       (<VERB? OPEN EXAMINE COUNT STRIKE>
		<TELL
"The matches are all gone, but there is some printing on the
inner cover." CR>)
	       (<VERB? READ>
		<FIXED-FONT-ON>
		<TELL
"\"Amazing Vilstu Potion!||
Get by without breathing! Amaze your|
friends! Be the first person on the|
block to own some!||
Order today by dropping this in any|
mailbox. Our shipping department will|
use the latest in temporal travel|
techniques to insure that your potion|
arrives the same day you order it!|
(Orders received before noon will|
arrive the day before you order).\"" CR>
		<FIXED-FONT-OFF>)>>

<OBJECT CALENDAR
	(IN STORE-ROOM)
	(DESC "calendar")
	(SYNONYM CALEND LEGEND)
	(SIZE 8)
	(FLAGS READBIT TAKEBIT ONBIT)
	(TEXT
"The calendar is for the current year, 957 GUE, and bears many stunning
pictures: the marble mines of Antharia, the sand dunes of the Kovalli
Desert, ancient Fort Griffspotter, and the giant infotater factories of
Borphee. A legend reads \"Best wishes for a leak-less year, from the
Accardi Plumbers Guild.\"")
	(ACTION CALENDAR-F)>

<ROUTINE CALENDAR-F ()
	 <COND (<VERB? OPEN LOOK-INSIDE>
		<PERFORM ,V?READ ,CALENDAR>
		<RTRUE>)>>

<ROOM CELLAR
      (SYNONYM ROTGRU BLOODW BROGMO)
      (IN ROOMS)
      (DESC "Cellar")
      (LDESC
"You are in the basement of the Guild Hall. A steep, narrow stair
leads upward from the southwest corner.")
      (UP TO LOBBY)
      (OUT TO LOBBY)
      (SW TO LOBBY)
      (FLAGS INSIDEBIT RLANDBIT)
      (PSEUDO "COBWEB" COBWEB-PSEUDO)
      (GLOBAL STAIRS)>

<ROUTINE COBWEB-PSEUDO ()
	 <RFALSE>>

<GLOBAL CODE-NUMBER 0> ;"set when you wake up from opening dream" 

<GLOBAL CODE-TABLE
	<PTABLE
	 0
	 "bloodworm"
	 "brogmoid"
	 "dorn"
	 "dryad"
	 "grue"
	 "hellhound"
	 "kobold"
	 "nabiz"
	 "orc"
	 "rotgrub"
	 "surmin"
	 "yipple">>

<GLOBAL CURRENT-TLOC 0> ;"set when you wake up from opening dream"

<GLOBAL NEXT-NUMBER 0> ;"set when you wake up from opening dream"

<GLOBAL NEXT-CODE-TABLE
	<PTABLE ;"1=black, 2=gray, 3=red, 4=purple, 5=white"
	 0 0 0 0 0 0
	 5 2 1 3 1 0 ;bloodworm
	 3 4 3 1 4 0 ;brogmoid
	 2 4 1 2 5 0 ;dorn
	 1 2 5 3 3 0 ;dryad
	 1 1 3 1 4 0 ;grue
	 4 5 2 3 2 0 ;hellhound
	 3 4 1 4 3 0 ;kobold
	 4 1 1 1 3 0 ;nabiz
	 3 2 4 2 3 0 ;orc
	 2 3 2 4 3 0 ;rotgrub
	 1 1 4 3 1 0 ;surmin
	 2 4 5 4 1 0 ;yipple>>

<OBJECT TRUNK
	(IN CELLAR)
	(DESC "sturdy trunk")
	(LDESC
"At the far end of the cellar, draped in cobwebs, is a large trunk. At
each corner of its lid is a button: a black button with a picture of a
star, a gray button depicting the moon, a red button illustrated with
a bloody knife, and a purple button engraved with a royal crown. In the
center of the lid is a white button picturing a dove in flight.")
	(SYNONYM TRUNK LID CHEST)
	(ADJECTIVE LARGE STURDY)
	(FLAGS CONTBIT SEARCHBIT TRYTAKEBIT)
	(CAPACITY 60)
	(ACTION TRUNK-F)>

<ROUTINE TRUNK-F ()
	 <COND (<AND <VERB? TAKE>
		     <EQUAL? ,PRSO ,TRUNK>>
		<TELL "It's too heavy to even budge." CR>)
	       (<NOT <FSET? ,TRUNK ,OPENBIT>>
		<COND (<VERB? OPEN>
		       <TELL "The lid won't budge." CR>)
		      (<VERB? UNLOCK>
		       <TELL "Perhaps the buttons..." CR>)
		      (<VERB? REZROV>
		       <TELL "The lid bulges outward for a moment." CR>)>)>>

<OBJECT BLACK-BUTTON
	(IN CELLAR)
	(DESC "black button")
	(SYNONYM BUTTON STAR)
	(ADJECTIVE BLACK)
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT GRAY-BUTTON
	(IN CELLAR)
	(DESC "gray button")
	(SYNONYM BUTTON MOON)
	(ADJECTIVE GRAY GREY)
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT RED-BUTTON
	(IN CELLAR)
	(DESC "red button")
	(SYNONYM BUTTON KNIFE)
	(ADJECTIVE BLOODY RED)
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT PURPLE-BUTTON
	(IN CELLAR)
	(DESC "purple button")
	(SYNONYM BUTTON CROWN)
	(ADJECTIVE PURPLE ROYAL)
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<OBJECT WHITE-BUTTON
	(IN CELLAR)
	(DESC "white button")
	(SYNONYM BUTTON DOVE)
	(ADJECTIVE WHITE)
	(FLAGS NDESCBIT)
	(ACTION BUTTON-F)>

<GLOBAL TRUNK-SCREWED <>>

<ROUTINE BUTTON-F ()
	 <COND (<VERB? LOOK-UNDER>
		<TELL <PICK-ONE ,YUKS> CR>)
	       (<VERB? PUSH>
	        <TELL "There is a click from the lid of the trunk">
		<COND (<OR <AND <EQUAL? ,PRSO ,BLACK-BUTTON>
				<EQUAL? ,NEXT-NUMBER 1>>
			   <AND <EQUAL? ,PRSO ,GRAY-BUTTON>
				<EQUAL? ,NEXT-NUMBER 2>>
			   <AND <EQUAL? ,PRSO ,RED-BUTTON>
				<EQUAL? ,NEXT-NUMBER 3>>
			   <AND <EQUAL? ,PRSO ,PURPLE-BUTTON>
				<EQUAL? ,NEXT-NUMBER 4>>
			   <AND <EQUAL? ,PRSO ,WHITE-BUTTON>
				<EQUAL? ,NEXT-NUMBER 5>>>
		       <SETG CURRENT-TLOC <+ ,CURRENT-TLOC 1>>
		       <SETG NEXT-NUMBER <GET ,NEXT-CODE-TABLE ,CURRENT-TLOC>>
		       <COND (<AND <EQUAL? ,NEXT-NUMBER 0>
				   <NOT ,TRUNK-SCREWED>>
			      <FSET ,TRUNK ,OPENBIT>
			      <SETG SCORE <+ ,SCORE 25>>
			      <TELL
". A moment later, the lid of the trunk swings slowly open, revealing ">
			      <PRINT-CONTENTS ,TRUNK>)>)
		      (T
		       <SETG TRUNK-SCREWED T>)>
		<TELL "." CR>)>>

<OBJECT AIMFIZ-SCROLL
	(IN TRUNK)
	(DESC "moldy scroll")
	(SYNONYM SCROLL)
	(ADJECTIVE MOLDY)
	(SIZE 3)
	(FLAGS TAKEBIT TRANSBIT CONTBIT READBIT SCROLLBIT)
	(ACTION SCROLL-F)>

<OBJECT AIMFIZ-SPELL
	(IN AIMFIZ-SCROLL)
	(SYNONYM SPELLS SPELL)
	(ADJECTIVE AIMFIZ)
	(DESC "aimfiz spell")
	(TEXT "transport caster to someone else's location")
	(SIZE 1)
	(COUNT 0)
	(FLAGS NDESCBIT SPELLBIT VOWELBIT)
	(ACTION SPELL-F)>
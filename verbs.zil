"VERBS for
			    SORCERER
	(c) Copyright 1984 Infocom, Inc.  All Rights Reserved."

;"subtitle game commands"

<GLOBAL VERBOSE <>>

<GLOBAL SUPER-BRIEF <>>

<ROUTINE V-VERBOSE ()
	 <SETG VERBOSE T>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Maximum verbosity." CR CR>
	 <V-LOOK>>

<ROUTINE V-BRIEF ()
	 <SETG VERBOSE <>>
	 <SETG SUPER-BRIEF <>>
	 <TELL "Brief descriptions." CR>>

<ROUTINE V-SUPER-BRIEF ()
	 <SETG SUPER-BRIEF T>
	 <TELL "Super-brief descriptions." CR>>

<ROUTINE V-DIAGNOSE ("AUX" (BOTH <>))
	 <COND (<L? ,AWAKE 0>
		<TELL "You are wide awake">)
	       (T
		<TELL "You are " <GET ,TIRED-TELL ,AWAKE>>)>
	 <TELL ", and you are in good health.">
	 <COND (<OR <G? ,HUNGER-LEVEL 0>
		    <G? ,THIRST-LEVEL 0>>
		<TELL " You feel ">
		<COND (<G? ,HUNGER-LEVEL 0>
		       <SET BOTH T>
		       <TELL <GET ,HUNGER-THIRST-TABLE ,HUNGER-LEVEL>>
		       <TELL " hungry">)>
		<COND (<G? ,THIRST-LEVEL 0>
		       <COND (.BOTH
			      <TELL ", and ">)>
		       <TELL <GET ,HUNGER-THIRST-TABLE ,THIRST-LEVEL>>
		       <TELL " thirsty">)>
		<TELL ".">)>
	 <COND (,BITTEN
		<TELL
" You have a small bite on your hand which doesn't seem too serious.">)> 
	 <CRLF>>  

<GLOBAL TIRED-TELL
       <PTABLE
	"beginning to tire"
	"feeling tired"
	"getting more and more tired"
	"worn out"
	"dead tired"
	"so tired you can barely concentrate"
	"moving only on your last reserves of strength"
	"practically asleep"
	"unable to keep your eyes open for more than a few moments at a time"
	"about to keel over from exhaustion">>

<ROUTINE V-INVENTORY ()
	 <COND (<FIRST? ,PROTAGONIST>
		<PRINT-CONT ,PROTAGONIST>)
	       (T
		<TELL "You are empty-">
		<COND (,FWEEPED
		       <TELL "taloned">)
		      (T
		       <TELL "handed">)>
		<TELL "." CR>)>>

<ROUTINE V-QUIT ()
	 <V-SCORE>
	 <DO-YOU-WISH "leave the game">
	 <COND (<YES?>
		<QUIT>)
	       (T
		<TELL "Ok." CR>)>>

<ROUTINE V-RESTART ()
	 <V-SCORE>
	 <DO-YOU-WISH "restart">
	 <COND (<YES?>
		<TELL "Restarting." CR>
		<RESTART>
		<TELL "Failed." CR>)>>

<ROUTINE DO-YOU-WISH (STRING)
	 <TELL CR "Do you wish to " .STRING "? (Y is affirmative): ">>

<ROUTINE FINISH ("OPTIONAL" (REPEATING <>))
	 <CRLF>
	 <COND (<NOT .REPEATING>
		<V-SCORE>
		<CRLF>)>
	 <TELL
"Would you like to restart the game from the beginning, restore a saved game
position, or end this session of the game? (Type RESTART, RESTORE, or QUIT):|
|
>">
	 <PUTB ,P-INBUF 0 10> ;"so you can't input too many characters"
	 <READ ,P-INBUF ,P-LEXV>
	 <PUTB ,P-INBUF 0 60>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?RESTAR>
	        <RESTART>
		<TELL "Failed." CR>
		<FINISH T>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?RESTOR>
		<V-RESTORE>
		<FINISH T>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?QUIT ,W?Q>
		<QUIT>)
	       (T
		<FINISH T>)>>

<ROUTINE YES? ()
	 <PRINTI ">">
	 <PUTB ,P-INBUF 0 10> ;"so you can't input too many characters"
	 <READ ,P-INBUF ,P-LEXV>
	 <PUTB ,P-INBUF 0 60>
	 <COND (<EQUAL? <GET ,P-LEXV 1> ,W?YES ,W?Y>
		<RTRUE>)
	       (<EQUAL? <GET ,P-LEXV 1> ,W?NO ,W?N>
		<RFALSE>)
	       (T
		<TELL "Please type YES or NO." CR CR>
		<AGAIN>)>>

<ROUTINE V-RESTORE ()
	 <COND (<NOT <RESTORE>> ;"if successful, can't go beyond this point"
	 	<TELL "Failed." CR>)>>

<ROUTINE V-SAVE ()
	 <COND (<SAVE>
	        <TELL "Ok." CR>)
	       (T
		<TELL "Failed." CR>)>>

<ROUTINE V-SCORE ()
	 <COND (,POOFED
		<TELL "If you still existed, your score would be ">)
	       (T
		<TELL "Your score is ">)>
	 <TELL N ,SCORE " of a possible 400, in " N ,MOVES " move">
	 <COND (<NOT <1? ,MOVES>>
		<TELL "s">)>
	 <TELL ". This puts you in the class of ">
	 <COND (<L? ,SCORE 0>
		<TELL "Menace to Society">)
	       (T
		<TELL <GET ,RANKINGS </ ,SCORE 50>>>)>
	 <TELL "." CR>>

<GLOBAL RANKINGS
	<PTABLE
	 "Charlatan"
	 "Parlor Magician"
	 "Novice Enchanter"
	 "Intermediate Enchanter"
	 "Senior Enchanter"
	 "Expert Enchanter"
	 "Member of the Circle of Enchanters"
         "Sorcerer"
	 "Leader of the Circle of Enchanters">>

<ROUTINE V-SCRIPT ()
	<PUT 0 8 <BOR <GET 0 8> 1>>
	<TELL "Here begins" ,COPR-NOTICE CR>
	<V-VERSION>>

<ROUTINE V-UNSCRIPT ()
	<TELL "Here ends" ,COPR-NOTICE CR>
	<V-VERSION>
	<PUT 0 8 <BAND <GET 0 8> -2>>
	<RTRUE>>

<GLOBAL COPR-NOTICE " a transcript of interaction with SORCERER.">

<ROUTINE V-VERSION ("AUX" (CNT 17))
	 <TELL
"SORCERER|
Infocom interactive fiction - a fantasy story|
Copyright (c) 1984 by Infocom, Inc. All rights reserved.|
SORCERER is a trademark of Infocom, Inc.|
Release ">
	 <PRINTN <BAND <GET 0 1> *3777*>>
	 <TELL " / Serial number ">
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> 23>
			<RETURN>)
		       (T
			<PRINTC <GETB 0 .CNT>>)>>
	 <CRLF>>

<ROUTINE V-$VERIFY ()
	 <COND (<AND <PRSO? ,INTNUM>
		     <EQUAL? ,P-NUMBER 502>>
		<TELL N ,SERIAL CR>)
	       (T
		<TELL "Performing the VERIFY spell..." CR>
	 	<COND (<VERIFY>
		       <TELL "Good." CR>)
	       	      (T
		       <TELL CR "** Bad **" CR>)>)>>

<CONSTANT SERIAL 0>

<CONSTANT D-RECORD-ON 4>
<CONSTANT D-RECORD-OFF -4>

<ROUTINE V-$COMMAND ()
	 <DIRIN 1>
	 <RTRUE>>

<ROUTINE V-$RANDOM ()
	 <COND (<NOT <EQUAL? ,PRSO ,INTNUM>>
		<TELL "Illegal call to #RANDOM." CR>)
	       (T
		<RANDOM <- 0 ,P-NUMBER>>
		<RTRUE>)>>

<ROUTINE V-$RECORD ()
	 <DIROUT ,D-RECORD-ON> ;"all READS and INPUTS get sent to command file"
	 <RTRUE>>

<ROUTINE V-$UNRECORD ()
	 <DIROUT ,D-RECORD-OFF>
	 <RTRUE>>

;"subtitle real verbs"

<ROUTINE V-AGAIN ("AUX" OBJ)
	 <COND (<NOT ,L-PRSA>
		<ANYMORE>)
	       (<AND <NOT <EQUAL? ,HERE ,LAST-PSEUDO-LOC>>
		     <EQUAL? ,PSEUDO-OBJECT ,L-PRSO ,L-PRSI>>
		<SETG L-PRSA <>>
		<ANYMORE>)
	       (<EQUAL? ,L-PRSA ,V?WALK>
		<DO-WALK ,L-PRSO>)
	       (<OR <EQUAL? ,L-PRSA ,V?FIND ,V?FOLLOW ,V?AIMFIZ>
		    <EQUAL? ,L-PRSA ,V?WHAT ,V?WHERE ,V?WHO>
		    <EQUAL? ,L-PRSA ,V?WAIT-FOR ,V?SEND ,V?WALK-TO>
		    <EQUAL? ,L-PRSA ,V?RESEARCH>>
		<TELL
"An adventure game nymph appears, sitting on your keyboard, and informs you
that the use of AGAIN is prohibited after that verb." CR>)
	       (T
	        <SET OBJ
		     <COND (<AND ,L-PRSO
				 <EQUAL? <LOC ,L-PRSO> ,DIAL>>
			    ,L-PRSO)
			   (<AND ,L-PRSI
				 <EQUAL? <LOC ,L-PRSI> ,DIAL>>
			    ,L-PRSI)>>
		<COND (<AND .OBJ 
			    <NOT <EQUAL? .OBJ ,PSEUDO-OBJECT ,ROOMS>>>
		       <TELL "You can't see">
		       <ARTICLE .OBJ T>
		       <TELL " anymore." CR>
		       <RFATAL>)
		      (T
		       <PERFORM ,L-PRSA ,L-PRSO ,L-PRSI>
		       <RTRUE>)>)>>

<ROUTINE V-ALARM ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<PERFORM ,V?ALARM ,ME>
		<RTRUE>)
	       (T
		<TELL "I don't think that">
	        <ARTICLE ,PRSO T>
	        <TELL " is sleeping." CR>)>>

<ROUTINE V-ANSWER ()
	 <TELL "Nobody seems to be awaiting your answer." CR>
	 <STOP>>

<ROUTINE V-ASK-ABOUT ()
	 <COND (<EQUAL? ,PRSO ,ME>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "After a moment's thought,">
		<ARTICLE ,PRSO T>
		<TELL " denies any knowledge of">
		<ARTICLE ,PRSI T>
		<TELL ".">
		<COND (<EQUAL? ,PRSO ,PRSI>
		       <TELL " (Rather disingenuous, if you ask me.)">)>
		<CRLF>)
	       (T
		<PERFORM ,V?TELL ,PRSO>
		<RTRUE>)>>

<ROUTINE V-ASK-FOR ()
	 <COND (<AND <EQUAL? ,PRSO ,YOUNGER-SELF>
		     <EQUAL? ,PRSI ,SPELL-BOOK>
		     <SPELL-BOOK-PASS-OFF-CHECK>>
		<RTRUE>)>
	 <TELL "Unsurprisingly,">
	 <ARTICLE ,PRSO T>
	 <TELL " is not likely to oblige." CR>>

<ROUTINE V-ATTACK ()
	 <IKILL "attack">>

<ROUTINE V-BITE ()
	 <HACK-HACK "Biting">>

<ROUTINE PRE-BOARD ("AUX" AV)
	 <SET AV <LOC ,PROTAGONIST>>
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<COND (,FLYING
		       <WHILE-FLYING>)
		      (<FSET? .AV ,VEHBIT>
		       <TELL "You are already in">
		       <ARTICLE ,PRSO T>
		       <TELL "!" CR>)
		      (T
		       <RFALSE>)>)
	       (T
		<TELL "You can't get into">
		<ARTICLE ,PRSO T>
		<TELL "!" CR>)>
	 <RFATAL>>

<ROUTINE V-BOARD ()
	 <MOVE ,PROTAGONIST ,PRSO>
	 <TELL "You are now in">
	 <ARTICLE ,PRSO T>
	 <TELL "." CR>
	 <APPLY <GETP ,PRSO ,P?ACTION> ,M-ENTER>>

<ROUTINE V-BURN ()
	 <COND (<NOT ,PRSI>
		<TELL "Your blazing gaze is insufficient." CR>)
	       (T
		<WITH???>)>>

<ROUTINE V-CHASTISE ()
	 <TELL
"Use prepositions to indicate precisely what you want to do: LOOK AT the
object, LOOK INSIDE it, LOOK UNDER it, etc." CR>>

<ROUTINE V-CLIMB-DOWN ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?DOWN>)
	       (T
		<V-DEFLATE>)>>

<ROUTINE V-CLIMB-FOO ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?UP>)
	       (T
		<V-DEFLATE>)>>

<ROUTINE V-CLIMB-ON ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?BOARD ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You can't climb onto">
		<ARTICLE ,PRSO T>
		<TELL "." CR>)>>

<ROUTINE V-CLIMB-OVER ()
	 <TELL "You can't do that." CR>>

<ROUTINE V-CLIMB-UP ()
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<DO-WALK ,P?UP>)
	       (T
		<V-DEFLATE>)>>

<ROUTINE V-CLOSE ()
	 <COND (<FSET? ,PRSO ,SCROLLBIT>
		<TELL-ME-HOW>)
	       (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Huh?" CR>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<TELL "There's no way to close">
		<ARTICLE ,PRSO>
		<TELL "." CR>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <TELL "Okay,">
		       <ARTICLE ,PRSO T>
		       <TELL " is now closed." CR>
		       <FCLEAR ,PRSO ,OPENBIT>)
		      (T
		       <ALREADY-CLOSED>)>)
	       (<OR <FSET? ,PRSO ,CONTBIT>
		    <EQUAL? ,PRSO ,JOURNAL>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <FCLEAR ,PRSO ,OPENBIT>
		       <TELL "Closed.">
		       <SETG LIT <LIT? ,HERE>>
		       <COND (<AND <NOT ,LIT>
				   <NOT ,BLORTED>>
			      <TELL " ">
			      <NOW-BLACK>)>
		       <CRLF>)
		      (T
		       <ALREADY-CLOSED>)>)
	       (T
		<TELL-ME-HOW>)>>

<ROUTINE V-COMBO ()
	 <COND (<AND <IN? ,YOUNGER-SELF ,HERE>
		     <EQUAL? ,PRSO ,INTNUM>>
		<TELL
"Don't tell me. Talk to your confused twin over there." CR>)
	       (T
		<TELL "What are you talking about?" CR>)>>

<ROUTINE V-COMPARE ()
	 <V-SIT>>

;<ROUTINE V-COMMAND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Unfortunately,">
		<ARTICLE ,PRSO T>
		<TELL " pays no attention." CR>)
	       (T
		<TELL "You cannot talk to that!" CR>)>>

<ROUTINE V-COUNT ()
	 <TELL "You have lost your mind." CR>>

<ROUTINE V-CROSS ()
	 <TELL "You can't cross that!" CR>>

<ROUTINE V-CURSE ()
	 <TELL "Such language from an Enchanter!" CR>>

<ROUTINE V-CUT ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?KILL ,PRSO ,PRSI>
		<RTRUE>)
	       (<AND <FSET? ,PRSO ,SCROLLBIT>
		     <FSET? ,PRSI ,WEAPONBIT>>
		<MOVE ,PRSO ,DIAL>
		<TELL "Your skillful" D ,PRSI "smanship slices">
		<ARTICLE ,PRSO T>
		<TELL " into slivers, which vanish." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "I doubt that the \"cutting edge\" of">
		<ARTICLE ,PRSI>
		<TELL " is adequate." CR>)
	       (T
		<TELL "Strange concept, cutting">
		<ARTICLE ,PRSO T>
		<TELL "...." CR>)>>

<ROUTINE V-DEFLATE ()
	 <TELL "Bizarre." CR>>

<ROUTINE V-DIG ()
	 <COND (,FLYING
		<WHILE-FLYING>)
	       (T
		<V-SIT>)>>

<ROUTINE V-DISEMBARK ()
	 <COND (<NOT <EQUAL? <LOC ,PROTAGONIST> ,PRSO>>
		<LOOK-AROUND-YOU>
		<RFATAL>)
	       (T
		<TELL "You are now on your feet." CR>
		<MOVE ,PROTAGONIST ,HERE>)>>

<ROUTINE V-DRINK ("AUX" S)
	 <TELL "You can't drink that!" CR>>

<ROUTINE V-DRINK-FROM ("AUX" X)
	 <COND (<EQUAL? ,PRSO ,WATER>
		<PERFORM ,V?DRINK ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,VIALBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <COND (<FIRST? ,PRSO>
			      <SET X <FIRST? ,PRSO>>
			      <PERFORM ,V?DRINK .X>
			      <RTRUE>)
			     (T
			      <TELL "The vial is empty." CR>)>)
		      (T
		       <TELL "The vial is closed!" CR>)>) 
	       (T
		<TELL "How peculiar!" CR>)>>

;<ROUTINE PRE-DROP ()
	 <COND (<EQUAL? ,PRSO <LOC ,PROTAGONIST>>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)>>

<ROUTINE V-DROP ()
	 <COND (<IDROP>
		<COND (<AND <EQUAL? ,HERE ,COAL-BIN-ROOM ,DIAL-ROOM>
			    <L? <GETP ,PRSO ,P?SIZE> 20>>
		       <BURIED-IN-COAL "drop">)
		      (T
		       <COND (<EQUAL? ,HERE ,HAUNTED-HOUSE>
		              <MOVE ,PRSO ,DIAL>)>
		       <TELL "Dropped." CR>)>)>>

<ROUTINE V-EAT ()
	 <TELL "Did they teach you to eat that in survival school?" CR>>

<ROUTINE V-ENTER ("AUX" VEHICLE)
	 <COND (<SET VEHICLE <FIND-IN ,HERE ,VEHBIT>>
		<PERFORM ,V?BOARD .VEHICLE>
		<RTRUE>)
	       (T
		<DO-WALK ,P?IN>)>>

<ROUTINE PRE-EXAMINE ()
	 <COND (<AND <NOT ,LIT>
		     <NOT ,BLORTED>>
		<TOO-DARK>)>>

<ROUTINE V-EXAMINE ()
	 <COND (<GETP ,PRSO ,P?TEXT>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,DOORBIT>
		<V-LOOK-INSIDE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <V-LOOK-INSIDE>)
		      (T
		       <TELL "It's closed." CR>)>)
	       (<FSET? ,PRSO ,ONBIT>
		<TELL "Someone must have cast the frotz spell on">
		<ARTICLE ,PRSO T>
		<TELL ", because it is glowing brightly." CR>)
	       (T
		<TELL "You see nothing special about">
		<ARTICLE ,PRSO T>
		<TELL "." CR>)>>

<ROUTINE V-EXIT ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (T
		<DO-WALK ,P?OUT>)>>

<ROUTINE V-EXORCISE ()
	 <TELL "You can't do that with mere words!" CR>>

<ROUTINE V-FILL ()
	 <COND (<NOT ,PRSI>
		<COND (<GLOBAL-IN? ,WATER ,HERE>
		       <PERFORM ,V?FILL ,PRSO ,WATER>
		       <RTRUE>)
		      (T
		       <TELL "There's nothing to fill it with." CR>)>)
	       (T 
		<TELL "Huh?" CR>)>>

<ROUTINE V-FIND ("OPTIONAL" (WHERE <>) "AUX" (L <LOC ,PRSO>))
	 <COND (<EQUAL? ,PRSO ,HANDS>
		<TELL
"Within six feet of your head, assuming you haven't left that somewhere." CR>)
	       (<EQUAL? ,PRSO ,ME>
		<TELL "You're around here somewhere..." CR>)
	       (<IN? ,PRSO ,PROTAGONIST>
		<TELL "You have it!" CR>)
	       (<OR <IN? ,PRSO ,HERE>
		    <EQUAL? ,PRSO ,PSEUDO-OBJECT>>
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "He's">)
		      (T
		       <TELL "It's">)>
		<TELL " right in front of you." CR>)
	       (<IN? ,PRSO ,LOCAL-GLOBALS>
		<TELL "You're the magician!" CR>)
	       (<AND <FSET? .L ,ACTORBIT>
		     <VISIBLE? .L>>
		<TELL "As far as you can tell,">
		<ARTICLE .L T>
		<TELL " has it." CR>)
	       (<AND <FSET? .L ,CONTBIT>
		     <VISIBLE? .L>>
		<TELL "It's in">
		<ARTICLE .L T>
		<TELL "." CR>)
	       (.WHERE
		<TELL "Beats me." CR>)
	       (T
		<TELL "You'll have to do that yourself." CR>)>>

<ROUTINE V-FIRST-LOOK ()
	 <COND (<DESCRIBE-ROOM>
		<COND (<NOT ,SUPER-BRIEF>
		       <DESCRIBE-OBJECTS>)>)>>

<ROUTINE V-FLY ()
	 <COND (<OR <NOT ,PRSO>
		    <EQUAL? ,PRSO ,ME>>
		<COND (,FLYING
		       <TELL "You are!" CR>)
	              (T
		       <TELL "Perhaps a spell would be useful..." CR>)>)
	       (<EQUAL? ,PRSO ,P-DIRECTION>
		<PERFORM ,V?WALK ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You can't make">
		<ARTICLE ,PRSO T>
		<TELL " fly!" CR>)>>

<ROUTINE V-FOLLOW ()
	 <COND (<IN? ,PRSO ,HERE>
		<TELL "But">
		<ARTICLE ,PRSO T>
		<TELL " is right here!" CR>)
	       (<AND <EQUAL? ,PRSO ,TURRET>
		     ,MAILMAN-FOLLOW>
		<DO-WALK ,P?SOUTH>)
	       (T
		<V-SIT>)>>

<ROUTINE V-FORGET ()
	 <TELL
"You might also try not thinking about a purple hippopotamus!" CR>>

<ROUTINE PRE-GIVE ()
	 <COND (<NOT <HELD? ,PRSO>>
		<TELL 
"That's easy for you to say since you don't even have it." CR>)
	       (<FSET? ,PRSO ,SPELLBIT>
		<TELL
"The spell is permanently inscribed in your spell book!" CR>)>>

<ROUTINE V-GIVE ()
	 <COND (<NOT <FSET? ,PRSI ,ACTORBIT>>
		<TELL "You can't give">
		<ARTICLE ,PRSO>
		<TELL " to">
		<ARTICLE ,PRSI>
		<TELL "!" CR>)
	       (T
		<TELL "Politely,">
		<ARTICLE ,PRSI T>
		<TELL " refuses your offer." CR>)>>

<ROUTINE V-HELLO ()
       <COND (,PRSO
	      <COND (<FSET? ,PRSO ,ACTORBIT>
		     <TELL "Silently,">
		     <ARTICLE ,PRSO T>
		     <TELL " bows his head to you in greeting." CR>)
		    (T
		     <TELL "Only schizophrenics say \"Hello\" to">
		     <ARTICLE ,PRSO>
		     <TELL "." CR>)>)
	     (T
	      <TELL <PICK-ONE ,HELLOS> CR>)>>

<GLOBAL HELLOS
	<PLTABLE
	 "Hello."
	 "Good day."
	 "Nice weather we've been having lately."
	 "Good-bye.">>

<ROUTINE V-HELP ()
	 <TELL
"If you're really stuck, maps and InvisiClues hint booklets are available.
If you have misplaced the order form that came in your package, send us a 
note at:|
  P.O. Box 620|
  Garden City, NY 11530|
  Dept. Z5|
and we'll be happy to send you an order form." CR>>

<ROUTINE V-HIDE ()
	 <COND (<NOT ,PRSO>
		<TELL "There's no place to hide here." CR>
		<RFATAL>)
	       (<AND ,PRSI <FSET? ,PRSI ,ACTORBIT>>
		<TELL "Why hide it when">
		<ARTICLE ,PRSI T>
		<TELL " isn't interested in it." CR>)
	       (<NOT ,PRSI>
		<TELL "From what? From whom? Why?" CR>)>>

<ROUTINE V-INFLATE ()
	 <TELL "How can you inflate that?" CR>>

;<ROUTINE V-INCANT ()
	 <TELL
"The incantation echoes back faintly, but nothing else happens." CR>
	 <STOP>>

<ROUTINE V-KICK ()
	 <HACK-HACK "Kicking">>

<ROUTINE V-KILL ()
	 <IKILL "kill">>

<ROUTINE IKILL (STR)
	 <COND (<NOT ,PRSO>
		<TELL "There is nothing here to " .STR "." CR>)
	       (<AND <NOT ,PRSI>
		     <HELD? ,KNIFE>>
		<SETG PRSI ,KNIFE>
		<TELL "(with the " D ,PRSI ")" CR>
		<PERFORM ,V?KILL ,PRSO ,PRSI>
		<RTRUE>)>
	 <COND (<AND <NOT <FSET? ,PRSO ,ACTORBIT>>
		     <NOT <EQUAL? ,PRSO ,BOA ,HELLHOUND ,DORN-BEAST>>>
		<TELL "I've known strange people, but fighting">
		<ARTICLE ,PRSO>
		<TELL "?" CR>)
	       (<OR <NOT ,PRSI>
		    <EQUAL? ,PRSI ,HANDS>>
		<TELL "Trying to " .STR>
		<ARTICLE ,PRSO>
		<TELL " with your bare hands is suicidal." CR>)
	       (<NOT <IN? ,PRSI ,PROTAGONIST>>
		<TELL "You aren't even holding">
		<ARTICLE ,PRSI T>
		<TELL "." CR>)
	       (<NOT <FSET? ,PRSI ,WEAPONBIT>>
		<TELL "Trying to " .STR>
		<ARTICLE ,PRSO T>
		<TELL " with">
		<ARTICLE ,PRSI>
		<TELL " is suicidal." CR>)
	       (T
		<TELL "You'd never survive the attack." CR>)>>

<ROUTINE V-KNOCK ()
	 <COND (<FSET? ,PRSO ,DOORBIT>
		<TELL "Nobody's home." CR>)
	       (T
		<TELL "Why knock on">
		<ARTICLE ,PRSO>
		<TELL "?" CR>)>>

<ROUTINE V-KISS ()
	 <TELL "I'd sooner kiss a pig." CR>>

<ROUTINE V-LAMP-OFF ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<NOT <FSET? ,PRSO ,ONBIT>>
		       <TELL "It is already off." CR>)
		      (T
		       <FCLEAR ,PRSO ,ONBIT>
		       <COND (,LIT
			      <SETG LIT <LIT? ,HERE>>)>
		       <TELL "Okay,">
		       <ARTICLE ,PRSO T>
		       <TELL " is now off." CR>
		       <COND (<AND <NOT <SETG LIT <LIT? ,HERE>>>
				   <NOT ,BLORTED>>
			      <NOW-BLACK>
			      <CRLF>)>)>)
	       (<FSET? ,PRSO ,ONBIT>
		<TELL "How? It's glowing by magic." CR>)
	       (T
		<TELL "You can't turn that off." CR>)>
	 <RTRUE>>

<ROUTINE V-LAMP-ON ()
	 <COND (<FSET? ,PRSO ,LIGHTBIT>
		<COND (<FSET? ,PRSO ,ONBIT>
		       <TELL "It is already on." CR>)
		      (T
		       <FSET ,PRSO ,ONBIT>
		       <TELL "Okay,">
		       <ARTICLE ,PRSO T>
		       <TELL " is now on." CR>
		       <COND (<AND <NOT ,LIT>
				   <NOT ,BLORTED>>
			      <SETG LIT <LIT? ,HERE>>
			      <CRLF>
			      <V-LOOK>)>)>)
	       (T
		<TELL "You can't turn that on." CR>)>
	 <RTRUE>>

<ROUTINE V-LAND ()
	 <COND (,FLYING
		<TELL "You'll have to wait for the spell to wear off." CR>)
	       (T
		<LOOK-AROUND-YOU>)>>

<ROUTINE V-LAUNCH ()
	 <COND (<FSET? ,PRSO ,VEHBIT>
		<TELL "You can't launch that by saying \"launch\"!" CR>)
	       (T
		<TELL "Huh?" CR>)>>

<ROUTINE V-LEAN-ON ()
	 <TELL "Are you so very tired, then?" CR>>

<ROUTINE V-LEAP ()
	 <COND (,FLYING
		<WHILE-FLYING>)
	       (,PRSO
		<COND (<IN? ,PRSO ,HERE>
		       <V-SKIP>)
		      (T
		       <TELL "That would be a good trick." CR>)>)
	       (<OR <EQUAL? ,HERE ,RIVER-BANK ,DRAWBRIDGE ,TOP-OF-FALLS>
		    <EQUAL? ,HERE ,TURRET ,EDGE-OF-CHASM ,BARE-PASSAGE>
		    <EQUAL? ,HERE ,TREE-BRANCH ,GUN-EMPLACEMENT>
		    ,RIDE-IN-PROGRESS>
		<JIGS-UP
"This was not a safe place to try jumping. You should have looked
before you leaped.">)
	       (<OR <EQUAL? ,HERE ,LAGOON ,DRAWBRIDGE>
		    <EQUAL? ,HERE ,COAL-BIN-ROOM ,TOP-OF-CHUTE>>
		<DO-WALK ,P?DOWN>)
	       (T
		<V-SKIP>)>>

<ROUTINE V-LEAVE ()
	 <DO-WALK ,P?OUT>>

<ROUTINE V-LIE-DOWN ()
	 <PERFORM ,V?SLEEP>
	 <RTRUE>>

<ROUTINE V-LISTEN ()
	 <TELL "At the moment,">
	 <ARTICLE ,PRSO T>
	 <TELL " makes no sound." CR>>

<ROUTINE V-LOCK ()
	 <TELL <PICK-ONE ,YUKS> CR>>

<ROUTINE V-LOOK ()
	 <COND (<DESCRIBE-ROOM T>
		<DESCRIBE-OBJECTS T>)>>

<ROUTINE V-LOOK-BEHIND ()
	 <TELL "There is nothing behind">
	 <ARTICLE ,PRSO T>
	 <TELL "." CR>>

<ROUTINE V-LOOK-DOWN ()
	 <COND (<AND <NOT ,LIT>
		     <NOT ,BLORTED>>
		<TOO-DARK>)
	       (<EQUAL? ,PRSO ,ROOMS>
		<PERFORM ,V?EXAMINE ,GROUND>
		<RTRUE>)
	       (T
		<PERFORM ,V?LOOK-INSIDE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-LOOK-INSIDE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "There is nothing special to be seen." CR>)
	       (<FSET? ,PRSO ,SURFACEBIT>
		<COND (<FIRST? ,PRSO>
		       <PRINT-CONT ,PRSO>)
		      (T
		       <TELL "There is nothing on">
		       <ARTICLE ,PRSO T>
		       <TELL "." CR>)>)
	       (<FSET? ,PRSO ,DOORBIT>
		<TELL "All you can tell is that">
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ARTICLE ,PRSO T>
		       <TELL " is open.">)
		      (T
		       <ARTICLE ,PRSO T>
		       <TELL " is closed.">)>
		<CRLF>)
	       (<FSET? ,PRSO ,SCROLLBIT>
		<PERFORM ,V?READ ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<EQUAL? ,PRSO <LOC ,PROTAGONIST>>
		       <MOVE ,PROTAGONIST ,ROOMS>
		       <COND (<FIRST? ,PRSO>
			      <PRINT-CONT ,PRSO>)
			     (T
			      <TELL "It's empty (not counting you)." CR>)>
		       <MOVE ,PROTAGONIST ,PRSO>)
		      (<SEE-INSIDE? ,PRSO>
		       <COND (<FIRST? ,PRSO>
			      <PRINT-CONT ,PRSO>)
			     (T
			      <TELL "It's empty." CR>)>)
		      (<AND <NOT <FSET? ,PRSO ,OPENBIT>>
			    <FIRST? ,PRSO>>
		       <PERFORM ,V?OPEN ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL "It seems that">
		       <ARTICLE ,PRSO T>
		       <TELL " is closed." CR>)>)
	       (T
		<TELL "You can't look inside">
		<ARTICLE ,PRSO>
		<TELL "." CR>)>>

<ROUTINE V-LOOK-UNDER ()
	 <COND (<HELD? ,PRSO>
		<TELL "You're ">
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "wear">)
		      (T
		       <TELL "hold">)>
		<TELL "ing it!" CR>)
	       (T
		<TELL "There is nothing but ">
		<COND (<EQUAL? ,HERE ,LAGOON-FLOOR>
		       <TELL "sand">)
		      (T
		       <TELL "dust">)>
		<TELL " there." CR>)>>

<ROUTINE V-LOWER ()
	 <V-RAISE>>

<ROUTINE V-LOWER-INTO ()
	 <V-RAISE>>

<ROUTINE V-MELT ()
	 <TELL "I'm not sure that">
	 <ARTICLE ,PRSO>
	 <TELL " can be melted." CR>>

<ROUTINE V-MOVE ()
	 <COND (<HELD? ,PRSO>
		<TELL "Why juggle objects?" CR>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "Moving">
		<ARTICLE ,PRSO T>
		<TELL " reveals nothing." CR>)
	       (T
		<TELL "You can't move">
		<ARTICLE ,PRSO T>
		<TELL "." CR>)>>

<ROUTINE V-MUNG ()
	 <HACK-HACK "Trying to break">>

<ROUTINE PRE-OPEN ()
	 <COND (,FWEEPED
		<BATTY>)>>

<ROUTINE V-OPEN ("AUX" F STR)
	 <COND (<FSET? ,PRSO ,SCROLLBIT>
		<TELL-ME-HOW>) 
	       (<EQUAL? ,PRSO ,ACTORBIT>
		<TELL "Huh?" CR>)
	       (<AND <FSET? ,PRSO ,VIALBIT>
		     <EQUAL? ,HERE ,LAGOON ,LAGOON-FLOOR>
		     <FIRST? ,PRSO>>
		<REMOVE <FIRST? ,PRSO>>
		<TELL
"As you open the vial it fills with water, washing away the potion. A moment
later a fish swims by, acting very strangely." CR>)
	       (<FSET? ,PRSO ,DOORBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ALREADY-OPEN>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <TELL "Okay,">
		       <ARTICLE ,PRSO T>
		       <TELL " is now open." CR>)>)
	       (<FSET? ,PRSO ,CONTBIT>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ALREADY-OPEN>)
		      (T
		       <FSET ,PRSO ,OPENBIT>
		       <FSET ,PRSO ,TOUCHBIT>
		       <COND (<OR <NOT <FIRST? ,PRSO>>
				  <FSET? ,PRSO ,TRANSBIT>>
			      <TELL "Opened." CR>)
			     ;(<AND <SET F <FIRST? ,PRSO>>
				   <NOT <NEXT? .F>>
				   <SET STR <GETP .F ,P?FDESC>>>
			      <TELL "Okay,">
			      <ARTICLE ,PRSO T>
			      <TELL " is now open." CR>
			      <TELL .STR CR>)
			     (T
			      <TELL "Opening">
			      <ARTICLE ,PRSO T>
			      <TELL " reveals ">
			      <PRINT-CONTENTS ,PRSO>
			      <TELL "." CR>)>)>)
	       (T
		<TELL-ME-HOW>)>>

<ROUTINE V-PAY ()
	 <COND (<NOT ,PRSI>
		<COND (<EQUAL? ,PRSO ,ZORKMID>
		       <SETG PRSI <FIND-IN ,HERE ,ACTORBIT>>
		       <COND (,PRSI
			      <PERFORM ,V?GIVE ,PRSO ,PRSI>
			      <RTRUE>)
			     (T
			      <TELL "There's no one here to pay." CR>
			      <RTRUE>)>)
		      (<HELD? ,ZORKMID>
		       <SETG PRSI ,ZORKMID>)
		      (T
		       <TELL "Pay with what?" CR>
		       <RTRUE>)>)>
	 <COND (<EQUAL? ,PRSI ,ZORKMID>
		<PERFORM ,V?GIVE ,PRSI ,PRSO>
		<RTRUE>)
	       (T
		<WITH???>)>>

<ROUTINE V-PICK ()
	 <TELL "You can't pick that!" CR>>

<ROUTINE V-PLAY ()
         <TELL "How peculiar!" CR>>

<ROUTINE V-PLUG ()
	 <TELL "This has no effect." CR>>

<ROUTINE V-POINT ()
	 <TELL "It's usually impolite to point." CR>>

<ROUTINE V-POUR ()
	 <TELL "You can't pour that!" CR>>

<ROUTINE V-PUMP ()
	 <TELL "It's not clear how." CR>>

<ROUTINE V-PUSH ()
	 <HACK-HACK "Pushing">>

<ROUTINE V-PUSH-TO ()
	 <TELL "You can't push things to that." CR>>

<ROUTINE PRE-PUT ()
	 <COND (<OR <IN? ,PRSO ,GLOBAL-OBJECTS>
		    <NOT <FSET? ,PRSO ,TAKEBIT>>>
		<TELL "Nice try." CR>)>>

<ROUTINE V-PUT ()
	 <COND (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,DOORBIT>>
		     <NOT <FSET? ,PRSI ,CONTBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>
		     <NOT <FSET? ,PRSI ,VEHBIT>>>
		<TELL "You can't do that." CR>
		<RTRUE>)
	       (<AND <NOT <FSET? ,PRSI ,OPENBIT>>
		     <NOT <FSET? ,PRSI ,SURFACEBIT>>>
		<THIS-IS-IT ,PRSI>
		<TELL "Inspection reveals that">
		<ARTICLE ,PRSI T>
		<TELL " isn't open." CR>)
	       (<EQUAL? ,PRSI ,PRSO>
		<TELL "How can you do that?" CR>)
	       (<IN? ,PRSO ,PRSI>
		<TELL "I think">
		<ARTICLE ,PRSO T>
		<TELL " is already in">
		<ARTICLE ,PRSI T>
		<TELL "." CR>)
	       (<G? <- <+ <WEIGHT ,PRSI> <WEIGHT ,PRSO>>
		       <GETP ,PRSI ,P?SIZE>>
		    <GETP ,PRSI ,P?CAPACITY>>
		<TELL "There's no room." CR>)
	       (<AND <NOT <HELD? ,PRSO>>
		     <EQUAL? <ITAKE> ,M-FATAL <>>>
		<RTRUE>)
	       (T
		<MOVE ,PRSO ,PRSI>
		<FSET ,PRSO ,TOUCHBIT>
		<TELL "Done." CR>)>>

<ROUTINE V-PUT-BEHIND ()
	 <TELL "That hiding place is too obvious." CR>>

<ROUTINE V-PUT-ON ()
	 <COND (<EQUAL? ,PRSI ,ME>
		<PERFORM ,V?WEAR ,PRSO>
		<RTRUE>)
	       (<FSET? ,PRSI ,SURFACEBIT>
		<V-PUT>)
	       (T
		<TELL "There's no good surface on">
		<ARTICLE ,PRSI T>
		<TELL "." CR>)>>

<ROUTINE V-PUT-UNDER ()
         <TELL "You can't put anything under that." CR>>

<ROUTINE V-RAPE ()
	 <TELL "What a (ahem!) strange idea." CR>>

<ROUTINE V-RAISE ()
	 <HACK-HACK "Playing in this way with">>

<ROUTINE V-REACH-IN ("AUX" OBJ)
	 <COND (<OR <NOT <FSET? ,PRSO ,CONTBIT>>
		    <FSET? ,PRSO ,ACTORBIT>>
		<TELL "What a maroon!" CR>)
	       (<NOT <FSET? ,PRSO ,OPENBIT>>
		<TELL "It's not open." CR>)
	       (<OR <NOT <SET OBJ <FIRST? ,PRSO>>>
		    <FSET? .OBJ ,INVISIBLE>
		    <NOT <FSET? .OBJ ,TAKEBIT>>>
		<TELL "It's empty." CR>)
	       (T
		<TELL "You reach into">
		<ARTICLE ,PRSO T>
		<TELL " and feel something." CR>)>>

<ROUTINE PRE-READ ()
	 <COND (,FWEEPED
		<BATTY>)
	       (<EQUAL? ,PRSO ,SPELL-BOOK>
		<RFALSE> ;"special case")
	       (<AND <FSET? ,PRSO ,SPELLBIT>
		     <IN? ,PRSO ,SPELL-BOOK>>
		<RFALSE> ;"same special case")
	       (<AND <NOT ,LIT>
		     <NOT ,BLORTED>>
		<TELL "It is impossible to read in the dark." CR>)
	       (<AND ,PRSI <NOT <FSET? ,PRSI ,TRANSBIT>>>
		<TELL "How does one look through">
		<ARTICLE ,PRSI>
		<TELL "?" CR>)>>

<ROUTINE V-READ ()
	 <COND (<OR <FSET? ,PRSO ,READBIT>
                    <FSET? ,PRSO ,SPELLBIT>>
		<TELL <GETP ,PRSO ,P?TEXT> CR>)
               (T
                <TELL "How can you read">
		<ARTICLE ,PRSO>
		<TELL "?" CR>)>>

<ROUTINE V-REPLY ()
	 <TELL "It is hardly likely that">
	 <ARTICLE ,PRSO T>
	 <TELL " is interested." CR>
	 <STOP>>

<ROUTINE PRE-RESEARCH ()
	 <COND (<AND <NOT ,PRSI>
		     <EQUAL? ,HERE ,LIBRARY>>
		<SETG PRSI ,ENCYCLOPEDIA>)>
	 <COND (<EQUAL? ,PRSO ,ROOMS>
		<COND (<NOT <NOT ,LIT>
			    <NOT ,BLORTED>>
		       <TOO-DARK>
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,GLASS-MAZE>
		       <PERFORM ,V?EXAMINE ,MAZE>
		       <RTRUE>)
		      (<FSET? ,HERE ,INSIDEBIT>
		       <PERFORM ,V?EXAMINE ,CEILING>
		       <RTRUE>)
		      (T
		       <PERFORM ,V?EXAMINE ,SKY>
		       <RTRUE>)>)
	       (<AND <NOT ,PRSI>
		     <OR <EQUAL? ,PRSO ,LOWER-CHUTE ,UPPER-CHUTE ,STAIRS>
			 <EQUAL? ,PRSO ,CHIMNEY ,FIREPLACE ,FLAG-POLE>
			 <EQUAL? ,PRSO ,PSEUDO-OBJECT ,ZORKMID-TREE ,TREE>>>
		<MAKE-OUT>)
	       (<AND <NOT ,LIT>
		     <NOT ,BLORTED>>
		<PERFORM ,V?READ ,ENCYCLOPEDIA>
		<RTRUE>)
	       (<NOT ,PRSI>
		<TELL "There's no encyclopedia here to look it up in." CR>)
	       (<NOT <EQUAL? ,PRSI ,ENCYCLOPEDIA>>
		<TELL "You can't read about things in">
		<ARTICLE ,PRSI>
		<TELL "." CR>)
	       (T
		<SETG VOLUME-USED T>
		<RFALSE>)>>

<ROUTINE V-RESEARCH ()
	 <COND (<EQUAL? ,PRSO ,LOBBY ,CELLAR ,STORE-ROOM>
		<TELL
"The spot where the entry should be is blank, as though the text
were magically excised or transported to some other location." CR>)
	       (<EQUAL? ,PRSO ,COAL-MINE-1>
		<TELL
"Entharion the Wise united many warring tribes to form the kingdom of
Quendor. He ruled from Largoneth Castle, near the ancient cities of
Galepath and Mareilon. Our current calendar dates from the first year
of his reign." CR>)
	       (<EQUAL? ,PRSO, COAL-MINE-2>
		<TELL
"Duncanthrax was King of Quendor from 659 GUE through 688 GUE. Known
as the \"Bellicose King\", he extended Quendor's domain, even conquering
lands across the Great Sea (thus forming what his great-great-grandson,
Dimwit Flathead, named the Great Underground Empire). Duncanthrax was
quite eccentric, and his castle, Egreth, was reputed to be located
in the most dangerous and deadly territory in the known lands." CR>)
	       (<EQUAL? ,PRSO ,COAL-MINE-3>
		<TELL
"Lord Dimwit Flathead the Excessive, a descendant of King Duncanthrax, ruled
the Great Underground Empire from 770 GUE until 789 GUE. His accomplishments,
achieved by overtaxing the kingdom, include Flood Control Dam #3 and the
Royal Museum. Extremely vain, he renamed the Great Sea the Flathead Ocean,
and preferred to spend his time in the strange lands that lay across it." CR>)
	       (<EQUAL? ,PRSO ,SLANTED-ROOM>
		<TELL
"The Wizard of Frobozz was once a member of the influential Accardi
chapter of the Enchanter's Guild. He was exiled by Dimwit Flathead after
accidentally turning Flathead's castle into a mountain of fudge." CR>)
	       (<EQUAL? ,PRSO ,OCEAN-NORTH>
		<TELL
"Flood Control Dam #3, a great engineering feat, is the source of the
Frigid River." CR>)
	       (<EQUAL? ,PRSO ,OCEAN-SOUTH>
		<TELL
"The article describes the exhibits of the Royal Museum, which included
the crown jewels and a sandstone & marble maze." CR>) 
	       (<EQUAL? ,PRSO ,SHAFT-BOTTOM>
		<TELL
"Largoneth was the castle of Entharion the Wise." CR>)
	       (<EQUAL? ,PRSO ,END-OF-HIGHWAY>
		<TELL
"A short article calls it an ancient city of Quendor." CR>)
	       (<EQUAL? ,PRSO ,STONE-HUT>
		<TELL
"The entry says \"See GREAT UNDERGROUND EMPIRE.\"" CR>)
	       (<EQUAL? ,PRSO ,ENTRANCE-HALL>
		<TELL
"Formerly known as Quendor, the Great Underground Empire reached its height
under King Duncanthrax, began declining under the excessive rule of Dimwit
Flathead, and finally fell in 883 GUE. The area is now called the Land of
Frobozz, after its largest province." CR>)
	       (<EQUAL? ,PRSO ,CRATER>
		<TELL
"The entry says \"See FLATHEAD OCEAN.\"" CR>)
	       (<EQUAL? ,PRSO ,EDGE-OF-CHASM>
		<TELL
"The tiniest of articles mentions that Accardi-By-The-Sea is a village
in the Land of Frobozz." CR>)
	       (<EQUAL? ,PRSO ,BELBOZ-HIDEOUT>
		<TELL
"Miznia is a province in the southlands, mostly jungle." CR>)
	       (<EQUAL? ,PRSO ,SOOTY-ROOM>
		<TELL
"The Frigid River, the mightiest in the Great Underground Empire, runs
from Flood Control Dam #3 to Aragain Falls." CR>)
	       (<EQUAL? ,PRSO ,DIAL-ROOM>
		<TELL
"According to this article, Aragain Falls is the most breathtaking
and awesome waterfall in the known lands. It lies at the end of the
Frigid River, and was a favorite honeymoon spot during the 8th and
9th centuries." CR>)
	       (<EQUAL? ,PRSO ,BARE-PASSAGE>
		<TELL
"Amathradonis was a terrible giant who terrorized Accardi-By-The-Sea for
many centuries. He was finally vanquished by Belboz the Necromancer in
952 GUE." CR>)
	       (<EQUAL? ,PRSO ,ELBOW-ROOM>
		<TELL
"Nymphs are tiny, magical beings. They are known for their exuberance, fondness
for practical jokes, and willingness to perform small tasks. The leading
temporary nymph services agency is the venerable firm Nymph-O-Mania." CR>)
	       (<EQUAL? ,PRSO ,HALLWAY-2>
		<TELL
"Zork is a classic folk myth about a treasure-hunting adventurer who
became a master of magic. It has been translated into novels, theatricals,
giant wall murals ... almost every imaginable medium." CR>)
	       (<EQUAL? ,PRSO ,TREE-ROOM>
		<TELL
"The encyclopedia describes it as one of the southlands, known for its
fine artisans, and a popular vacation spot." CR>)
	       (<EQUAL? ,PRSO ,HOLLOW>
		<TELL
"Antharia an island in the Flathead Ocean, is very prosperous thanks
to its rich marble quarries." CR>)
	       (<EQUAL? ,PRSO ,WINDING-TUNNEL>
		<TELL
"A leading manufacturer of magic scrolls and potions." CR>)
	       (<EQUAL? ,PRSO ,BEND>
		<TELL
"The Kovalli Desert lies beyond the mountains that formed the western
boundary of ancient Quendor. It is an uncrossable wasteland, believed
to stretch to the edge of the world." CR>)
	       (<EQUAL? ,PRSO ,FOREST-EDGE>
		<TELL
"Lonely Mountain is a towering peak to the west of Largoneth Castle." CR>)
	       (<EQUAL? ,PRSO ,SLIMY-ROOM>
		<TELL
"A long article tells that Krill was a powerful warlock who plotted to
overthrow the Circle of Enchanters and enslave this corner of the kingdom.
He almost achieved his goal, but was vanquished by a young Enchanter." CR>)
	       (<EQUAL? ,PRSO ,RIVER-BED>
		<TELL
"The article points out that the Servants Guild is not the most respected
of trade guilds." CR>)
	       (<EQUAL? ,PRSO ,STAGNANT-POOL>
		<TELL
"It is a corrupt and simplified form of Double Fannucci, popular in taverns,
and frequently played for stakes." CR>)
	       (<EQUAL? ,PRSO ,RUINS>
		<TELL
"A complex, thinking man's version of Gabber Tumper, and probably the most
popular game in the world." CR>)
	       (<EQUAL? ,PRSO ,TOP-OF-FALLS>
		<TELL
"The capital and biggest city in Frobozz, and the center of the spell
scroll and infotater industries. The port of Borphee is the busiest on
the Flathead Ocean." CR>)
	       (<EQUAL? ,PRSO ,TURRET>
		<TELL
"The Messengers Guild is among the oldest guilds, and its members are
incredibly dedicated. Their motto is \"Not even really bad precipitation
or very early nightfall will prevent us from completing our route.\"" CR>)
	       (<EQUAL? ,PRSO ,DUNGEON>
		<TELL
"Temporal travel technology, though in existence for many centuries,
is still considered to be experimental by the magic industry. Several
government agencies are currently looking into its potential long-term
effects." CR>)
	       (<EQUAL? ,PRSO ,HIGHWAY>
		<TELL
"The Enchanter's Guild can date its roots to the reign of Entharion, over
900 years ago. Chapters are usually located in small villages, since the
bustle of city life interferes with an Enchanter's work (\"Excuse me, I
locked my keys in my house. Could you please rezrov my door?\"). The most
influential chapter is Accardi Chapter, home of the Circle of Enchanters." CR>)
	       (<EQUAL? ,PRSO ,STORE>
		<TELL
"Gnomes are a race of short, furry people known for their greed and business
acumen. They are often employed as toll and fare collectors, bank tellers,
ticket sellers, and presidents of small software firms." CR>)
	       (<EQUAL? ,PRSO ,SHAFT-TOP>
		<TELL
"Trolls are a race of ferocious, semi-intelligent creatures. They are often
employed as security guards and bouncers." CR>)
	       (<EQUAL? ,PRSO ,YOUR-QUARTERS>
		<TELL
"The leading supplier of designer spell books." CR>)
	       (<EQUAL? ,PRSO ,FROBAR-QUARTERS>
		<TELL
"The head of one chapter of the Enchanters Guild." CR>)
	       (<EQUAL? ,PRSO ,HELISTAR-QUARTERS>
		<TELL
"A village in the northlands." CR>)
	       (<EQUAL? ,PRSO ,SERVANT-QUARTERS>
		<TELL
"According to this article, there are two meanings for Sorcerer. In general,
it refers to a powerful magic-user. More specifically, the term is used
by the Enchanters Guild to denote a senior member of the Circle." CR>)
	       (<EQUAL? ,PRSO ,APPRENTICE-QUARTERS>
		<TELL
"A famous chasm near Accardi-By-The-Sea." CR>)
	       (<EQUAL? ,PRSO ,OUTSIDE-GLASS-DOOR>
		<TELL
"The most prestigious engineering school in the land." CR>)
	       (T
		<TELL "You look in the encyclopedia but find no entry about">
	        <ARTICLE ,PRSO T>
	        <TELL "." CR>)>>

<ROUTINE V-RUB ()
	 <HACK-HACK "Fiddling with">>

<ROUTINE V-SAY ("AUX" V)
	 <COND (<SET V <FIND-IN ,HERE ,ACTORBIT>>
		<TELL "You must address">
		<ARTICLE .V T>
		<TELL " directly." CR>
		<STOP>)
	       (<EQUAL? <GET ,P-LEXV ,P-CONT> ,W?HELLO>
		<SETG QUOTE-FLAG <>>
		<RTRUE>)
	       (T
		<SETG QUOTE-FLAG <>>
		<SETG P-CONT <>>
		<PERFORM ,V?TELL ,ME>
		<RTRUE>)>>

<ROUTINE V-SEARCH ()
	 <COND (,FWEEPED
		<BATTY>)
	       (T
		<TELL "You find nothing unusual." CR>)>>

<ROUTINE V-SEND ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Why would you send for">
		<ARTICLE ,PRSO T>
		<TELL "?" CR>)
	       (T
		<TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-SGIVE ()
	 <PERFORM ,V?GIVE ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SHAKE ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Be real." CR>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<TELL "You can't take it; thus, you can't shake it!" CR>)
	       (T
		<TELL "There's no point in shaking that." CR>)>>

<ROUTINE V-SHARPEN ()
	 <TELL "You'll never sharpen anything with that!" CR>>

<ROUTINE V-SHOOT ()
	 <TELL "Don't bother applying for a job as an armaments expert." CR>>

<ROUTINE V-SHOW ()
	 <TELL "I doubt">
	 <ARTICLE ,PRSI T>
	 <TELL " is interested." CR>>

<ROUTINE V-SIT ()
	 <TELL "That would be a waste of time." CR>>

<ROUTINE V-SKIP ()
	 <TELL "Wasn't that fun?" CR>>

<ROUTINE V-SLEEP ("OPTIONAL" (TOLD? <>))
	 <COND (,FLYING
		<TELL
"You'd better settle down before thinking about settling down." CR>)
	       (<EQUAL? ,AWAKE -1>
		<TELL
"You settle down to sleep, but you really aren't tired, so you
thrash around for a while and then give up." CR>)
	       (T
		<SETG REAL-SPELL-MAX <+ ,REAL-SPELL-MAX 1>>
		<SETG SPELL-MAX ,REAL-SPELL-MAX>
		<SETG SPELL-ROOM ,SPELL-MAX>
		<SETG MOVES <+ ,MOVES 50>>
		<SETG LAST-SLEPT ,MOVES>
		<SETG LOAD-ALLOWED ,LOAD-MAX>
		<SETG FUMBLE-NUMBER 7>
		<ENABLE <QUEUE I-TIRED 80>>
		<SETG AWAKE -1>
		<FORGET-ALL>
		<WEAR-OFF-SPELLS>
		<COND (<NOT <FSET? ,TWISTED-FOREST ,TOUCHBIT>>
		       <TELL
"You drift off to sleep and dream of the distant Kovalli Desert. Waves of
heat from the sand make breathing hard, and the bright sunlight burns
against your eyelids. Suddenly you awake -- the Guild Hall is on fire!
Through the thick smoke, you see Belboz standing before you. But no, this
could not be Belboz, his face an unrecognizable mask of hatred, his
outstretched arms dripping with blood.|
|
He who is not Belboz speaks, in a voice filled with malevolence. \"So, you
are the young Enchanter that Belboz thinks so highly of. That senile wizard
thought you would be the one to rescue him from my clutches. I wonder why I
bothered to come at all -- an insect like you poses no threat! Still...\" He
gestures and your surroundings change." CR CR>
		       <ROB ,PROTAGONIST>
		       <DISABLE <INT I-TIRED>>
		       <DISABLE <INT I-HUNGER>>
		       <DISABLE <INT I-THIRST>>
		       <WEAR-OFF-SPELLS>
		       <GOTO ,CHAMBER-OF-LIVING-DEATH>
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,RIVER-BED ,STAGNANT-POOL ,TOP-OF-FALLS>
		       <JIGS-UP
"Just as you doze off, a wall of water smashes over you!">
		       <RTRUE>)>
		<COND (<AND <IN-COAL-MINE?>
			    ,VILSTUED>
		       <JIGS-UP
"The vilstu potion wears off as you sleep, and you awaken clawing
frantically at your chest.">
		       <RTRUE>)>
		<COND (<IN-COAL-MINE?>
		       <JIGS-UP
"Before you fall asleep you pass out from the bad air.">
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,TWISTED-FOREST>
		       <JIGS-UP
"You awake in the middle of the night to find a hellhound gnawing on you.">
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,TREE-BRANCH>
		       <JIGS-UP
"Your eyes are barely closed before the snake reaches you.">
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,SNAKE-PIT>
		       <JIGS-UP
"You awake to find snakes and beetles crawling all over you.">
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,MINE-FIELD>
		       <JIGS-UP
"Unfortunately, you roll over in the middle of the night. Kaboom!!">
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,MEADOW>
		       <JIGS-UP
"Locusts pick your bones clean while you sleep.">
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,DRAWBRIDGE>
		       <TELL
"You are rudely awakened by the collapse of the rotting drawbridge. ">
		       <DO-WALK ,P?DOWN>
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,RIVER-BANK>
		       <JIGS-UP
"During the night the river bank collapses beneath you, throwing you
into the turbulent waters.">
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,HOLLOW>
		       <JIGS-UP
"You have a nightmare about a ferocious dorn beast. When it begins gnawing
on you, you realize that it isn't a dream at all.">
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,LAGOON ,LAGOON-FLOOR>
		       <JIGS-UP
"Amazing how difficult it is to sleep while swimming (and vice versa).">
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,BELBOZ-HIDEOUT>
		       <TELL
"An unknown amount of time later you awake and look around. ">
		       <I-BELBOZ-AWAKES>
		       <RTRUE>)>
		<COND (<AND <IN? ,PROTAGONIST ,BED>
			    <NOT .TOLD?>>
		       <TELL
"You're not all that tired, but the bed is very comfortable." CR>)
		      (,RIDE-IN-PROGRESS
		       <END-RIDE>
		       <TELL
"Hard to believe that you could fall asleep during such an exciting
ride, but you are pretty tired." CR>)
		      (T
		       <TELL
"Ah, sleep! It's been a long day and rest will do you good. You spread
your cloak on the floor and drift off, renewing your powers and
refreshing your mind. Time passes as you snore blissfully." CR>)>
		<CRLF>
		<MOVE ,PROTAGONIST ,HERE>
	        <COND (<PROB 50>
		       <TELL
"You sleep uneventfully, awake refreshed, and rise to your feet." CR>)
	              (T
		       <TELL <PICK-ONE ,DREAMS>>
		       <TELL " You awaken and stand." CR>)>)>>

<ROUTINE V-SMELL ()
	 <TELL "It smells just like">
	 <ARTICLE ,PRSO>
	 <TELL "." CR>>

<ROUTINE V-SPAY ()
	 <PERFORM ,V?PAY ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SPIN ()
	 <TELL "You can't spin that!" CR>>

<ROUTINE V-SPRAY ()
	 <COND (<NOT ,PRSI>
		<COND (<EQUAL? ,PRSO ,GRUE-REPELLENT>
		       <TELL "Specify who or what you want to spray." CR>)
		      (<HELD? ,GRUE-REPELLENT>
		       <PERFORM ,V?SPRAY ,GRUE-REPELLENT ,PRSO>
		       <RTRUE>)
		      (T
		       <TELL "You don't have anything that sprays!" CR>)>)
	       (T
                <V-SQUEEZE>)>>

<ROUTINE V-SQUEEZE ()
	 <TELL "How singularly useless." CR>>

<ROUTINE PRE-SSHOW ()
	 <PERFORM ,V?SHOW ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-SSHOW ()
	 <V-SGIVE>>

<ROUTINE V-SSPRAY ()
	 <PERFORM ,V?SPRAY ,PRSI ,PRSO>
	 <RTRUE>>

<ROUTINE V-STAND ()
	 <COND (<FSET? <LOC ,PROTAGONIST> ,VEHBIT>
		<PERFORM ,V?DISEMBARK <LOC ,PROTAGONIST>>
		<RTRUE>)
	       (,FLYING
		<WHILE-FLYING>)
	       (T
		<TELL "You are already standing." CR>)>>

<ROUTINE V-STAND-ON ()
	 <V-SIT>>

<ROUTINE V-STRIKE ()
	 <PERFORM ,V?ATTACK ,PRSO>
	 <RTRUE>>

<ROUTINE V-SWING ()
	 <COND (<NOT ,PRSI>
		<TELL "Whoosh!" CR>)
	       (T
		<PERFORM ,V?ATTACK ,PRSI ,PRSO>
		<RTRUE>)>>

<ROUTINE V-SWIM ()
	 <COND (,PRSO
		<PERFORM ,V?THROUGH ,PRSO>
		<RTRUE>)
	       (<EQUAL? ,HERE ,LAGOON ,LAGOON-FLOOR>
		<LOOK-AROUND-YOU>)
	       (<EQUAL? ,HERE ,COVE ,OCEAN-NORTH ,OCEAN-SOUTH>
		<PERFORM ,V?THROUGH ,LAGOON-OBJECT>
		<RTRUE>)
	       (<EQUAL? ,HERE ,RIVER-BANK>
		<DO-WALK ,P?DOWN>)
	       (<EQUAL? ,HERE ,MOUTH-OF-RIVER>
		<DO-WALK ,P?EAST>)
	       (<EQUAL? ,HERE ,HIDDEN-CAVE>
		<DO-WALK ,P?OUT>)
	       (<EQUAL? ,HERE ,DRAWBRIDGE>
		<DO-WALK ,P?DOWN>)
	       (<EQUAL? ,HERE ,STAGNANT-POOL>
		<DO-WALK ,P?NW>)
	       (T
		<TELL "There's nothing to swim in!" CR>)>>

<ROUTINE PRE-TAKE ()
	 <COND (,FWEEPED
		<BATTY>)
	       (<IN? ,PRSO ,PROTAGONIST>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "You are already wearing it." CR>)
		      (T
		       <TELL "You already have it." CR>)>)
	       (<AND <FSET? ,PRSO ,SPELLBIT>
		     <FSET? <LOC ,PRSO> ,SCROLLBIT>
		     <ACCESSIBLE? <LOC ,PRSO>>>
		<PERFORM ,V?TAKE <LOC ,PRSO>>
		<RTRUE>)
	       (<AND <FSET? <LOC ,PRSO> ,CONTBIT>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "You can't reach that." CR>
		<RTRUE>)
	       (,PRSI
		<COND (<EQUAL? ,PRSO ,ME>
		       <PERFORM ,V?DROP ,PRSI>
		       <RTRUE>)
		      (<AND <NOT <EQUAL? ,PRSI <LOC ,PRSO>>>
			    <NOT <EQUAL? ,PRSI ,BELBOZ-DESK>>>
		       <TELL "But">
		       <ARTICLE ,PRSO T>
		       <TELL " isn't in">
		       <ARTICLE ,PRSI T>
		       <TELL "." CR>)
		      (T
		       <SETG PRSI <>>
		       <RFALSE>)>)
	       (<EQUAL? ,PRSO <LOC ,PROTAGONIST>>
		<TELL "You are in it!" CR>)>>

<ROUTINE V-TAKE ()
	 <COND (<EQUAL? <ITAKE> T>
		<COND (<FSET? ,PRSO ,WEARBIT>
		       <TELL "You are now wearing">
		       <ARTICLE ,PRSO T>
		       <TELL "." CR>)
		      (,FLYING
		       <TELL "You swoop low and pick it up." CR>)
		      (T
		       <COND (<AND <EQUAL? ,PRSO ,ROPE>
				   <OR ,ROPE-PLACED ,ROPE-IN-LOWER-CHUTE>>
			      <SETG ROPE-PLACED <>>
			      <SETG ROPE-IN-LOWER-CHUTE <>>
			      <FCLEAR ,BEAM ,TRYTAKEBIT>
			      <FCLEAR ,ROPE ,TRYTAKEBIT>)>
		       <TELL "Taken." CR>)>)>>

<ROUTINE V-TAKE-OFF ()
	 <COND (<EQUAL? ,PRSO <LOC ,PROTAGONIST>> ;"TAKE OFF also = GET OFF"
		<PERFORM ,V?DISEMBARK ,PRSO>
		<RTRUE>)
	       (<AND <HELD? ,PRSO>
		     <FSET? ,PRSO ,WEARBIT>>
		<PERFORM ,V?DROP ,PRSO>
		<RTRUE>)
	       (T
		<TELL "You're not wearing that!" CR>)>>

<ROUTINE V-TELL ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<COND (,P-CONT
		       <SETG WINNER ,PRSO>
		       <SETG HERE <LOC ,WINNER>>)
		      (<AND <EQUAL? ,PRSO ,GNOME>
			    ,GNOME-SLEEPING>
		       <POOR-LISTENERS>)
		      (T
		       <TELL "Hmmm...">
		       <ARTICLE ,PRSO T>
		       <TELL
" looks at you expectantly, as though he thought
you were about to talk." CR>)>)
	       (<EQUAL? ,PRSO ,PARROT>
		<TELL
"Although the parrot is a marvelous imitator of human speech, it is
incapable of understanding or initiating any." CR>
		<STOP>)
	       (T
		<TELL "You can't talk to">
		<ARTICLE ,PRSO>
		<TELL "!" CR>
		<STOP>)>>

<ROUTINE V-THANK ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "You do so, but">
		<ARTICLE ,PRSO T>
		<TELL " seems less than overjoyed." CR>)
	       (T
		<TELL
"The Circle will revoke your certificate if you keep this up." CR>)>>

<ROUTINE V-THROUGH ()
	<COND (<FSET? ,PRSO ,DOORBIT>
	       <DO-WALK <OTHER-SIDE ,PRSO>>
	       <RTRUE>)
	      (<FSET? ,PRSO ,VEHBIT>
	       <PERFORM ,V?BOARD ,PRSO>
	       <RTRUE>)
	      (<NOT <FSET? ,PRSO ,TAKEBIT>>
	       <TELL "You hit your head against">
	       <ARTICLE ,PRSO T>
	       <TELL " as you attempt this feat." CR>)
	      (<IN? ,PRSO ,PROTAGONIST>
	       <TELL "That would involve quite a contortion!" CR>)
	      (T
	       <TELL <PICK-ONE ,YUKS> CR>)>>

<ROUTINE V-THROW ()
	 <COND (<IDROP>
		<COND (<AND <EQUAL? ,HERE ,COAL-BIN-ROOM ,DIAL-ROOM>
			    <L? <GETP ,PRSO ,P?SIZE> 20>>
		       <BURIED-IN-COAL "throw">)
		      (T
		       <COND (<EQUAL? ,HERE ,HAUNTED-HOUSE>
		              <MOVE ,PRSO ,DIAL>)>
		       <TELL "Thrown." CR>)>)>>

<ROUTINE V-THROW-OFF ()
	 <TELL "You can't throw anything off that!" CR>>

<ROUTINE V-TIE ()
	 <TELL "You can't tie">
	 <ARTICLE ,PRSO T>
	 <TELL " to that." CR>>

<ROUTINE V-TIE-UP ()
	 <TELL "You could certainly never tie it with that!" CR>>

<ROUTINE V-TIME ("AUX" X)
	 <SET X <- ,MOVES ,LAST-SLEPT>>
	 <TELL "It's ">
	 <COND (<L? .X 15>
		<TELL "early morning">)
	       (<L? .X 30>
		<TELL "mid-morning">)
	       (<L? .X 50>
		<TELL "mid-day">)
	       (<L? .X 65>
		<TELL "late afternoon">)
	       (<L? .X 80>
		<TELL "early evening">)
	       (T
		<TELL "late evening">)>
	 <TELL "." CR>>

<ROUTINE V-TORTURE ()
	<COND (<NOT <EQUAL? ,HERE ,TORTURE-CHAMBER>>
	       <TELL "There are no torture devices here!" CR>)
	      (<EQUAL? ,PRSO ,ME>
	       <JIGS-UP "Ooops! You overdid it a little.">)
	      (T
	       <TELL "Despite your best effort,">
	       <ARTICLE ,PRSO T>
	       <TELL " fails to divulge any useful information." CR>)>>

<ROUTINE V-TURN ()
	 <TELL "This has no effect." CR>>

<ROUTINE V-UNLOCK ()
	 <V-LOCK>>

<ROUTINE V-UNTIE ()
	 <TELL "This cannot be tied, so it cannot be untied!" CR>>

<ROUTINE V-WALK ("AUX" PT PTS STR OBJ RM)
	 ;<COND (<AND ,TRY-FLY <PRE-FLY>>
		<RTRUE>)>
	 <COND (<NOT ,P-WALK-DIR>
		<PERFORM ,V?WALK-TO ,PRSO>
		<RTRUE>)
	       (<SET PT <GETPT ,HERE ,PRSO>>
		<COND (<EQUAL? <SET PTS <PTSIZE .PT>> ,UEXIT>
		       <GOTO <GETB .PT ,REXIT>>)
		      (<EQUAL? .PTS ,NEXIT>
		       <TELL <GET .PT ,NEXITSTR> CR>
		       <RFATAL>)
		      (<EQUAL? .PTS ,FEXIT>
		       <COND (<SET RM <APPLY <GET .PT ,FEXITFCN>>>
			      <GOTO .RM>)
			     (T
			      <COND (<OR <EQUAL? ,HERE ,GLASS-MAZE>
					 <EQUAL? ,HERE ,PARK-ENTRANCE>>
				     <RFALSE>)
				    (T
				     <RFATAL>)>)>)
		      (<EQUAL? .PTS ,CEXIT>
		       <COND (<VALUE <GETB .PT ,CEXITFLAG>>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,CEXITSTR>>
			      <TELL .STR CR>
			      <RFATAL>)
			     (T
			      <CANT-GO>
			      <RFATAL>)>)
		      (<EQUAL? .PTS ,DEXIT>
		       <COND (<FSET? <SET OBJ <GETB .PT ,DEXITOBJ>> ,OPENBIT>
			      <GOTO <GETB .PT ,REXIT>>)
			     (<SET STR <GET .PT ,DEXITSTR>>
			      <TELL .STR CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)
			     (T
			      <TELL "The " D .OBJ " is closed." CR>
			      <THIS-IS-IT .OBJ>
			      <RFATAL>)>)>)
	       (<AND ,FLYING
		     <EQUAL? ,PRSO ,P?UP>>
		     <TELL "You're already flying as high as you can." CR>
		     <RFATAL>)
	       (T
		<CANT-GO>
		<RFATAL>)>>

;<ROUTINE PRE-FLY ()
	 <COND (,FLYING
		<RFALSE>)
	       (,PRSO
		<TELL "What a loon!" CR>
		<RTRUE>)
	       (T
		<TELL "You are probably a loon, although you can't fly." CR>)>>

<ROUTINE V-WALK-AROUND ()
	 <TELL "Please use compass directions for movement." CR>>

<ROUTINE V-WALK-TO ()
	 <COND (<OR <IN? ,PRSO ,HERE>
		    <GLOBAL-IN? ,PRSO ,HERE>>
		<TELL "It's here!" CR>)
	       (T
		<V-WALK-AROUND>)>>

<ROUTINE V-WAIT ("OPTIONAL" (NUM 3))
	 <TELL "Time passes..." CR>
	 <REPEAT ()
		 <COND (<L? <SET NUM <- .NUM 1>> 0>
			<RETURN>)
		       (<CLOCKER>
			<RETURN>)>>
	 <SETG CLOCK-WAIT T>>

<ROUTINE V-WAIT-FOR ()
	 <COND (<EQUAL? <LOC ,PRSO> ,HERE ,PROTAGONIST>
		<TELL "It's already here!" CR>)
	       (T
		<TELL "You will probably be waiting quite a while." CR>)>>

<ROUTINE V-WAVE ()
	 <HACK-HACK "Waving">>

<ROUTINE V-WAVE-AT ()
	 <TELL "Despite your friendly nature,">
	 <ARTICLE ,PRSO T>
	 <TELL " isn't likely to respond." CR>>

<ROUTINE V-WAX ()
	 <COND (<AND <NOT ,PRSI>
		     <VISIBLE? ,WAXER>>
		<SETG PRSI ,WAXER>)
	       (<NOT ,PRSI>
		<TELL "With what?" CR>
		<RTRUE>)>
	 <COND (<AND <EQUAL? ,PRSI ,WAXER>
		     <EQUAL? ,PRSO ,GROUND>>
		<PERFORM ,V?LAMP-ON ,WAXER>
		<RTRUE>)
	       (T
		<WITH???>)>>

<ROUTINE V-WEAR ()
	 <COND (<NOT <FSET? ,PRSO ,WEARBIT>>
		<TELL "You can't wear">
		<ARTICLE ,PRSO T>
		<TELL "." CR>)
	       (T 
		<PERFORM ,V?TAKE ,PRSO>
		<RTRUE>)>>

<ROUTINE V-WHAT ()
	 <TELL "Try reading an encyclopedia." CR>>

<ROUTINE V-WHERE ()
	 <COND (<EQUAL? ,PRSO ,RIVER-BED>
		<TELL "Out doing their daily errands, probably." CR>)
	       (T
		<V-FIND T>)>>

<ROUTINE V-WHO ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<PERFORM ,V?WHAT ,PRSO>
		<RTRUE>)
	       (<OR <EQUAL? ,PRSO ,COAL-MINE-1 ,COAL-MINE-2 ,COAL-MINE-3>
		    <EQUAL? ,PRSO ,SLANTED-ROOM ,BARE-PASSAGE ,SLIMY-ROOM>
		    <EQUAL? ,PRSO ,RIVER-BED ,TURRET ,FROBAR-QUARTERS>>
		<PERFORM ,V?WHAT ,PRSO>
		<RTRUE>)
	       (T
		<TELL "That's not a person!" CR>)>>

<ROUTINE V-YELL ()
	 <TELL "Aarrrrrgggggggghhhhhhhhhhh!" CR>
	 <COND (<AND <EQUAL? ,HERE ,TOLL-GATE>
		     ,GNOME-SLEEPING
		     <OR ,LIT ,BLORTED>>
		<CRLF>
		<PERFORM ,V?ALARM ,GNOME>
		<RTRUE>)>>

;"subtitle magic-related verbs"

<ROUTINE PRE-CAST ("AUX" MEM? SPELL SCROLL)
	 <SET SPELL
	      <COND (<VERB? GNUSTO> ,GNUSTO-SPELL)
		    (<VERB? FROTZ> ,FROTZ-SPELL)
		    (<VERB? REZROV> ,REZROV-SPELL)
		    (<VERB? IZYUK> ,IZYUK-SPELL)
		    (<VERB? AIMFIZ> ,AIMFIZ-SPELL)
		    (<VERB? FWEEP> ,FWEEP-SPELL)
		    (<VERB? SWANZO> ,SWANZO-SPELL)
		    (<VERB? GOLMAC> ,GOLMAC-SPELL)
		    (<VERB? VARDIK> ,VARDIK-SPELL)
		    (<VERB? PULVER> ,PULVER-SPELL)
		    (<VERB? MEEF> ,MEEF-SPELL)
		    (<VERB? VEZZA> ,VEZZA-SPELL)
		    (<VERB? GASPAR> ,GASPAR-SPELL)
		    (<VERB? YOMIN> ,YOMIN-SPELL)
		    (<VERB? YONK> ,YONK-SPELL)
		    (<VERB? MALYON> ,MALYON-SPELL)
		    (T
		     <TELL "Bug #55" CR>
		     <RTRUE>)>>
	 <COND (,PERFORMING-SPELL
	        <SETG PERFORMING-SPELL <>>
		<RFALSE>)>
	 <COND (<OR <EQUAL? .SPELL ,PRSO>
		    <AND <EQUAL? <LOC .SPELL> ,PRSO>
			 <NOT <EQUAL? <LOC .SPELL> ,SPELL-BOOK>>>>
		<TELL
"As you must remember from Thaumaturgy 101, you cannot cast a spell upon
itself, or upon the scroll it is written on." CR>
		<RTRUE>)
	       (<FSET? <LOC .SPELL> ,MUNGBIT>
		<TELL "The spell no longer readable." CR>
		<RTRUE>)
	       (<FSET? <LOC .SPELL> ,SCROLLBIT>
		<SET SCROLL <LOC .SPELL>>
		<COND (<IN? .SCROLL ,PROTAGONIST>
		       <COND (<AND <EQUAL? .SPELL ,YONK-SPELL>
				   <NOT <VISIBLE? ,PRSO>>>
			      <RFALSE>)>
		       <MOVE .SCROLL ,DIAL> ;"in case moby-search wants it"
		       <TELL
"As you cast the spell, the " D .SCROLL " vanishes!" CR>
		       <PUTP .SPELL ,P?COUNT 1>)
		      (<OR <FSET? .SPELL ,TOUCHBIT>
			   <IN? .SCROLL ,HERE>>
		       <TELL
"You don't have the " D .SPELL " memorized, nor do you have the scroll
on which it is written." CR>
		       <RTRUE>)
		      (T
		       <TELL
"The " D .SPELL " is not committed to memory, and you haven't seen any scroll
on which it is written." CR>
		       <RTRUE>)>)>
	 <SET MEM? <GETP .SPELL ,P?COUNT>>
	 <COND (,FWEEPED
		<TELL
"When you attempt to incant the " D .SPELL ", all that comes out is
a high-pitched squeak!" CR>)
	       (<EQUAL? .SPELL ,GNUSTO-SPELL ,REZROV-SPELL ,FROTZ-SPELL>
		<RFALSE> ;"Always memorized")
	       (<EQUAL? .MEM? 0>
		<TELL
"You don't have the " D .SPELL " committed to memory!" CR>
		<THIS-IS-IT .SPELL>
		<RTRUE>)
	       (T
		<PUTP .SPELL ,P?COUNT <- .MEM? 1>>
		<SETG SPELL-ROOM <+ ,SPELL-ROOM 1>>
		<RFALSE>)>>

<GLOBAL PERFORMING-SPELL <>>

<ROUTINE V-CAST ("AUX" VRB)
	 <COND (<NOT <FSET? ,PRSO ,SPELLBIT>>
		<TELL
"You might as well be casting with a fly rod, as to try to cast">
		<ARTICLE ,PRSO>
		<TELL "." CR>)
	       (T
		<SET VRB
		     <COND (<EQUAL? ,PRSO ,GNUSTO-SPELL> ,V?GNUSTO)
			   (<EQUAL? ,PRSO ,FROTZ-SPELL> ,V?FROTZ)
			   (<EQUAL? ,PRSO ,REZROV-SPELL> ,V?REZROV)
			   (<EQUAL? ,PRSO ,IZYUK-SPELL> ,V?IZYUK)
			   (<EQUAL? ,PRSO ,AIMFIZ-SPELL> ,V?AIMFIZ)
			   (<EQUAL? ,PRSO ,FWEEP-SPELL> ,V?FWEEP)
			   (<EQUAL? ,PRSO ,SWANZO-SPELL> ,V?SWANZO)
			   (<EQUAL? ,PRSO ,GOLMAC-SPELL> ,V?GOLMAC)
			   (<EQUAL? ,PRSO ,VARDIK-SPELL> ,V?VARDIK)
			   (<EQUAL? ,PRSO ,PULVER-SPELL> ,V?PULVER)
			   (<EQUAL? ,PRSO ,MEEF-SPELL> ,V?MEEF)
			   (<EQUAL? ,PRSO ,VEZZA-SPELL> ,V?VEZZA)
			   (<EQUAL? ,PRSO ,GASPAR-SPELL> ,V?GASPAR)
			   (<EQUAL? ,PRSO ,YOMIN-SPELL> ,V?YOMIN)
			   (<EQUAL? ,PRSO ,YONK-SPELL> ,V?YONK)
			   (<EQUAL? ,PRSO ,MALYON-SPELL> ,V?MALYON)
			   (T
			    <TELL "Bug #90" CR>
			    <RTRUE>)>>
		<COND (<NOT ,PRSI>
		       <TELL
"You might as well be casting it away as not cast it on something." CR>)
		      (T
		       <PERFORM .VRB ,PRSI>)>
		<RTRUE>)>>

<GLOBAL ALL-SPELLS
	<PLTABLE
	  GNUSTO-SPELL
	  FROTZ-SPELL
	  REZROV-SPELL
	  IZYUK-SPELL
	  AIMFIZ-SPELL
	  FWEEP-SPELL
	  SWANZO-SPELL
	  GOLMAC-SPELL
	  VARDIK-SPELL
	  PULVER-SPELL
	  MEEF-SPELL
	  VEZZA-SPELL
	  GASPAR-SPELL
	  YOMIN-SPELL
	  YONK-SPELL
	  MALYON-SPELL>>

<ROUTINE V-SPELLS ("AUX" (CNT <GET ,ALL-SPELLS 0>) S (ANY <>) (OS <>) TMP)
	 <TELL
"The gnusto, rezrov, and frotz spells are yours forever. Other than that,
you have ">
	 <REPEAT ()
		 <COND (<EQUAL? .CNT 0>
			<COND (.OS
			       <SPELL-PRINT .OS .ANY T>
			       <SET ANY T>)>
			<COND (<NOT .ANY>
			       <TELL "no spells memorized.">)
			      (T
			       <TELL " committed to memory.">)>
			<CRLF>
			<RTRUE>)>
		 <COND (<SET TMP <SPELL-TIMES <GET ,ALL-SPELLS .CNT>>>
			<COND (.OS
			       <SPELL-PRINT .OS .ANY>
			       <SET ANY T>)>
			<SET OS .TMP>)>
		 <SET CNT <- .CNT 1>>>>

<ROUTINE SPELL-PRINT (S ANY "OPTIONAL" (PAND? <>) "AUX" X)
	 <COND (.ANY
		<COND (.PAND?
		       <TELL " and ">)
		      (T
		       <TELL ", ">)>)>
	 <TELL "the " D .S " ">
	 <SET X <- <GETP .S ,P?COUNT> 1>>
	 <COND (<G? .X 4>
		<SET X 4>)> ;"prevents ,COUNTERS table overflow"
	 <TELL <GET ,COUNTERS .X>>
	 .S>

<ROUTINE SPELL-TIMES (S)
	 <COND (<G? <GETP .S ,P?COUNT> 0>
		<COND (<IN? .S ,SPELL-BOOK> .S)
		      (<AND <==? .S ,AIMFIZ-SPELL>
			    <NOT <IN? ,AIMFIZ-SPELL ,AIMFIZ-SCROLL>>>
		       .S)
		      (<AND <==? .S ,YONK-SPELL>
			    <NOT <IN? ,YONK-SPELL ,YONK-SCROLL>>>
		       .S)>)>>

<GLOBAL COUNTERS	;"should be as many entries as ,SPELL-MAX"
	<PTABLE "once"
	       "twice"
	       "thrice"
	       "four times"
	       "many times">>

<ROUTINE V-LEARN ()
	 <TELL "You don't have that spell, if indeed that is a spell." CR>>

<ROUTINE V-AIMFIZ ()
	 <COND (<EQUAL? ,PRSO ,COAL-MINE-1 ,COAL-MINE-2 ,COAL-MINE-3>
		<JIGS-UP
"You materialize in a royal tomb somewhere. Before being devoured by rats,
you notice a well-decayed corpse nearby.">)
	       (<EQUAL? ,PRSO ,SLANTED-ROOM>
		<JIGS-UP
"You appear in a strange room. Framed diplomas and wand racks adorn the
walls, and a stuffed owl is perched above a trophy case. An incredibly
old man with a long white beard spots you. \"Fertilize!\" he cries,
pointing a slightly bent wand at you. You turn into a pile of bat guano,
a fitting end for a trespasser.">)
	       (<EQUAL? ,PRSO ,SLIMY-ROOM>
		<TELL "You join Krill in oblivion." CR>
		<FINISH>)
	       (<EQUAL? ,PRSO ,RIVER-BED>
		<JIGS-UP
"You appear in the woods behind the Guild Hall. The servants (who should
be doing their daily chores) are lazing about, drinking ale and betting
on games of Gabber Tumper. To prevent you from reporting their goofing off,
they cut your throat. You just can't get good help these days.">)
	       (<EQUAL? ,PRSO ,TURRET>
		<JIGS-UP
"You appear on the lawn of a large estate. A domesticated wolf, foaming
saliva, is chasing the messenger across the lawn. With graceful agility, the
messenger jumps aside, and the wolf sinks its rabid teeth into you instead.">)
	       (<EQUAL? ,PRSO ,FROBAR-QUARTERS>
		<JIGS-UP
"You materialize in the middle of a powerful thaumaturgical experiment. A
Guildmaster stands nearby, but before he can react you have turned into
a large and rather ugly mushroom.">)
	       (<EQUAL? ,PRSO ,SERVANT-QUARTERS>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,V?AIMFIZ ,ME>
		<RTRUE>)
	       (T
		<V-SWANZO>)>>

<ROUTINE V-AIMFIZ-TO ()
	 <COND (<NOT <EQUAL? ,PRSO ,ME>>
		<TELL "This spell only has an effect on the caster." CR>)
	       (T
		<TELL "You should just say \"aimfiz " D ,PRSI "\"." CR>)>>

<ROUTINE V-GASPAR ()
	 <COND (<NOT ,PRSO>
		<SETG PERFORMING-SPELL T>
		<PERFORM ,V?GASPAR ,ME>
		<RTRUE>)>
	 <TELL "How nice --">
	 <ARTICLE ,PRSO T>
	 <TELL " is now provided for in the event of ">
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "his">)
	       (T
		<TELL "its">)>
	 <TELL " death." CR>>

<GLOBAL BOOK-GLOWS "Your spell book begins to glow softly. ">

<ROUTINE V-GNUSTO ("AUX" SCROLL)
	 <COND (<NOT <IN? ,SPELL-BOOK ,PROTAGONIST>>
		<TELL
"The spell quests around in your hands, looking for your spell book, and
not finding it, fades reluctantly." CR>)
	       (<NOT <FSET? ,PRSO ,SPELLBIT>>
		<TELL "You can't inscribe">
		<ARTICLE ,PRSO>
		<TELL " in your spell book!" CR>)
	       (<IN? ,PRSO ,SPELL-BOOK>
		<TELL
"You already have that spell inscribed in your book!" CR>)
	       (<FSET? <LOC ,PRSO> ,MUNGBIT>
		<TELL "The spell no longer readable." CR>)
	       (T
		<SET SCROLL <LOC ,PRSO>>
		<COND (<AND <FSET? .SCROLL ,SCROLLBIT>
			    <HELD? .SCROLL>> 
		       <COND (<EQUAL? ,PRSO ,AIMFIZ-SPELL ,YONK-SPELL>
			      <TELL ,BOOK-GLOWS
"In a spectacular effort of magic, the powers of the gnusto spell
attempt to copy the " D ,PRSO " into your book, but the spell is
too long, too complicated, and too powerful. The glow fades, but
fortunately the " D .SCROLL " remains intact." CR>)
			     (T
			      <MOVE .SCROLL ,DIAL>
			      <MOVE ,PRSO ,SPELL-BOOK>
			      <PUTP ,PRSO ,P?COUNT 0>
			      <TELL ,BOOK-GLOWS
"Slowly, ornately, the words of the " D ,PRSO " are inscribed, glowing even
more brightly than the book itself. The book's brightness fades, ">
			      <COND (<FSET? ,SPELL-BOOK ,MUNGBIT>
				     <TELL
"and the spell is now illegible in the damp, ruined book. T">)
				    (T
				     <TELL
"but the spell remains! However, t">)>
			      <TELL
"he scroll on which it was written vanishes as the last word is copied." CR>)>)
		      (T
		       <TELL
"You must have a legible spell scroll in your hands before the gnusto spell
will work on it." CR>)>)>>

<ROUTINE V-FROTZ ("AUX" OLIT) ;"light"
	 <SET OLIT ,LIT>
	 <COND (<FSET? ,PRSO ,ONBIT>
		<TELL "Have you forgotten that you already frotzed">
		<ARTICLE ,PRSO T>
		<TELL "?" CR>)
	       (<OR <FSET? ,PRSO ,TAKEBIT>
		    <FSET? ,PRSO ,ACTORBIT>>
		<FSET ,PRSO ,ONBIT>
		<COND (<NOT <EQUAL? ,PRSO ,BAT-GUANO ,FWEEP-SCROLL>>
		       <FSET ,PRSO ,TOUCHBIT>)>
		<TELL "There is an almost blinding flash of light as">
		<ARTICLE ,PRSO T>
		<TELL
" begins to glow! It slowly fades to a less painful level, but">
		<ARTICLE ,PRSO T>
		<TELL " is now quite usable as a light source.">
		<COND (<OR <EQUAL? ,PRSO ,PARK-GNOME>
			   <AND <EQUAL? ,PRSO ,GNOME>
				<NOT ,GNOME-SLEEPING>>>
		       <JIGS-UP
" The gnome looks livid. \"Very funny! Have you seen this one?\" He incants
a brief spell, and you turn into a bowl of petunias (which eventually wilt).">
		       <RTRUE>)>
		<CRLF>
		<SETG LIT <LIT? ,HERE>>
		<COND (<AND <NOT .OLIT> ,LIT>
		       <CRLF>
		       <V-LOOK>)>
		<RTRUE>)
	       (T
		<V-SWANZO>)>>

<ROUTINE V-FWEEP ("AUX" X N) ;"bat"
	 <COND (<OR <NOT ,PRSO>
		    <EQUAL? ,PRSO ,ME>>
		<COND (,RIDE-IN-PROGRESS
		       <FLY-DURING-RIDE>
		       <RTRUE>)
		      (<EQUAL? ,HERE ,LAGOON ,LAGOON-FLOOR>
		       <JIGS-UP
"Unfortunately, bats make poor swimmers. Glug, glug.">
		       <RTRUE>)>
		<SETG FWEEPED T>
		<SETG FLYING T>
		<ENABLE <QUEUE I-UNFWEEP 15>>
		<DISABLE <INT I-FLY>>
		<SET X <FIRST? ,PROTAGONIST>>
		<TELL
"With keen disappointment, you note that nothing has changed. Then, you
slowly realize that you are black, have two wing-like appendages, and are
flying a few feet above the ground.">
		<COND (.X
		       <TELL
" Understandably, you dropped everything you were carrying.">)>
		<COND (<EQUAL? ,HERE ,GLASS-MAZE>
		       <RADAR-VIEW>)>
		<CRLF>
		<REPEAT ()
			<COND (.X
			       <SET N <NEXT? .X>>
			       <MOVE .X ,HERE>
			       <SET X .N>)
		              (T
			       <RETURN>)>>)
	       (T
		<TELL "The fweep spell can be cast only on yourself." CR>)>>

<ROUTINE V-IZYUK ()
	 <COND (<AND ,FLYING
		     <EQUAL? ,PRSO ,ME>>
		<TELL "You are already flying." CR>)
	       (<OR <NOT ,PRSO>
		    <EQUAL? ,PRSO ,ME>>
		<COND (,RIDE-IN-PROGRESS
		       <FLY-DURING-RIDE>
		       <RTRUE>)>
		<COND (<EQUAL? ,HERE ,LAGOON-FLOOR>
		       <TELL "Gloooop! ">)>
		<TELL "You are now floating serenely in midair." CR>
		<COND (<EQUAL? ,HERE ,LAGOON-FLOOR>
		       <DO-WALK ,P?UP>)>
		<SETG FLYING T>
		<ENABLE <QUEUE I-FLY 3>>
		<MOVE ,PROTAGONIST ,HERE>)
	       (<EQUAL? ,PRSO ,FLAG>
		<V-FLY>)
	       (T
		<PERFORM ,V?FLY ,PRSO>
		<RTRUE>)>>

<ROUTINE FLY-DURING-RIDE ()
	 <TELL "You fly out of the ">
	 <COND (<EQUAL? ,HERE ,FLUME>
		<TELL "log boat">)
	       (T
		<TELL "car">)>
	 <TELL
", and immediately splat into one of the structural cross-beams of the ">
	 <COND (<EQUAL? ,HERE ,FLUME>
		<TELL "flume">)
	       (T
		<TELL "roller coaster">)>
	 <JIGS-UP ".">>

<ROUTINE V-MALYON ()
	 <COND (<FSET? ,PRSO ,ACTORBIT>
		<TELL "Wow! It looks like">
		<ARTICLE ,PRSO T>
		<TELL " is now alive! What a magician you are!" CR>)
	       (<FSET? ,PRSO ,TAKEBIT>
		<TELL "As you complete the spell,">
		<ARTICLE ,PRSO T>
		<TELL
" comes alive! It blinks, dances a little jig,
and a moment later returns to normal." CR>)
	       (T
		<V-SWANZO>)>>

<ROUTINE V-MEEF ()
	 <V-SWANZO>>

<ROUTINE V-PULVER () ;"evaporate"
	 <COND (<OR <EQUAL? ,PRSO ,FOOBLE-POTION ,FLAXO-POTION ,BLORT-POTION>
		    <EQUAL? ,PRSO ,VILSTU-POTION ,BERZIO-POTION>>
		<MOVE ,PRSO ,DIAL>
		<TELL "The potion vanishes." CR>)
	       (T
		<TELL "After completing the spell,">
		<ARTICLE ,PRSO T>
		<TELL " remains unchanged. It must not be a liquid." CR>)>>

<ROUTINE V-REZROV () ;"open"
	 <COND (<OR <FSET? ,PRSO ,CONTBIT>
		    <FSET? ,PRSO ,DOORBIT>>
		<COND (<FSET? ,PRSO ,OPENBIT>
		       <ALREADY-OPEN>)
		      (<NOT <FSET? ,PRSO ,SCROLLBIT>>
		       <TELL "Silently,">
		       <ARTICLE ,PRSO T>
		       <TELL " swings open">
		       <COND (<FIRST? ,PRSO>
			      <TELL ", revealing ">
			      <PRINT-CONTENTS ,PRSO>)>
		       <TELL
". Like swatting a fly with a sledge hammer, if you ask me." CR>
		       <FSET ,PRSO ,OPENBIT>)
		      (T
		       <V-SWANZO>)>)
	       (T
		<V-SWANZO>)>>

<ROUTINE V-SWANZO () ;"exorcise"
	 <TELL
"Although you complete the spell, nothing seems to have happened">
	 <COND (<VERB? AIMFIZ>
		<TELL ". Perhaps this spell only works on people">)>
	 <TELL "." CRLF>>

<ROUTINE V-GOLMAC () ;"time travel"
	 <COND (<AND <FSET? ,PRSO ,ACTORBIT>
		     <NOT <EQUAL? ,PRSO ,BELBOZ ,JEEARR>>>
		<MOVE ,PRSO ,DIAL>
		<TELL "With a puff of smoke,">
		<ARTICLE ,PRSO T>
		<TELL " vanishes!" CR>)
	       (T
		<TELL "There is a puff of smoke, but when it clears">
		<ARTICLE ,PRSO T>
		<TELL " is still there." CR>)>>

<ROUTINE V-VARDIK () ;"mind shield"
	 <TELL "The mind of">
	 <ARTICLE ,PRSO T>
	 <COND (<NOT <FSET? ,PRSO ,ACTORBIT>>
		<TELL " (if it has one)">)>
	 <TELL " is now shielded against evil spirits." CR>>

<ROUTINE V-VEZZA ("AUX" VISION) ;"clairvoyance"
	 <COND (<OR <NOT ,PRSO>
		    <EQUAL? ,PRSO ,ME>>
		<TELL "You see ">
		<REPEAT ()
			<SET VISION <GET ,VEZZAS <RANDOM 10>>>
			<COND (<NOT <EQUAL? .VISION 0>>
			       <RETURN>)>>
		<TELL .VISION>
		<TELL " A moment later, the vision fades." CR>)
	       (T
		<TELL "Thanks to you,">
		<ARTICLE ,PRSO T>
		<TELL " is given a brilliant but momentary glimpse of ">
		<COND (<FSET? ,PRSO ,ACTORBIT>
		       <TELL "his">)
		      (T
		       <TELL "its">)>
		<TELL " own future." CR>)>>

<GLOBAL VEZZAS
	<TABLE
0
"a dried-up river bed, full of sharp rocks and muddy puddles.
A dark cave beckons."
"a field surrounded by fortified ramparts. A tattered flag flies
atop a tall pole."
"a brightly lit room. A tree fills the room, its branches twinkling
with gold and silver."
"a glittering midway filled with garish lights and honky-tonk music,
surrounded by a spidery wooden structure."
"a startling location of transparent walls, twinkling with reflected light."
"a small room with a slanted roof, covered with black dust. The room
is bathed in orange light."
"a door of the whitest wood, opening slowly to reveal the face of Belboz,
which quickly melts into a frightening visage of unspeakable malevolence."
"a heated debate among the Guildmasters of the land, in the ancient
Guild Hall at Borphee."
"a pile of pure-white blocks, engraved with runes of power. Each block
has a word written on it."
0>>

<ROUTINE V-YOMIN ()
	 <TELL "I'm afraid">
	 <ARTICLE ,PRSO T>
	 <TELL " doesn't have much of a mind for you to read." CR>>

<ROUTINE V-YONK ()
	 <COND (<NOT <FSET? ,PRSO ,SPELLBIT>>
		<TELL
"Nothing happens. I think this spell is meant to be cast on other spells...">
		<CRLF>)
	       (T
		<TELL "The words of the spell glow brightly for a moment." CR>
		<COND (<EQUAL? ,PRSO ,MALYON-SPELL>
		       <SETG MALYON-YONKED T>)>)>>

;"subtitle object manipulation"

<GLOBAL FUMBLE-NUMBER 7>

<ROUTINE ITAKE ("OPTIONAL" (VB T) "AUX" CNT OBJ)
	 <COND (,FWEEPED
		<COND (.VB
		       <BATTY>)>
		<RFALSE>)
	       (<NOT <FSET? ,PRSO ,TAKEBIT>>
		<COND (.VB
		       <TELL <PICK-ONE ,YUKS> CR>)>
		<RFALSE>)
	       (<AND <IN? ,PRSO ,YOUNGER-SELF>
		     <EQUAL? ,PRSO ,SPELL-BOOK>
		     <SPELL-BOOK-PASS-OFF-CHECK>>
		<RFATAL>)
	       (<OR <IN? ,PRSO ,YOUNGER-SELF>
		    <IN? ,PRSO ,OLDER-SELF>>
		<TELL "Your twin refuses to part with">
		<ARTICLE ,PRSO T>
		<TELL "." CR>
		<RFATAL>)
	       (<AND
		 <NOT <IN? <LOC ,PRSO> ,PROTAGONIST>>
		 <G? <+ <WEIGHT ,PRSO> <WEIGHT ,PROTAGONIST>> ,LOAD-ALLOWED>>
		<COND (.VB
		       <COND (<FIRST? ,PROTAGONIST>
			      <TELL "Your load is too heavy">)
			     (T
			      <TELL "It's a little too heavy">)>
		       <COND (<L? ,LOAD-ALLOWED ,LOAD-MAX>
			      <TELL
", especially in light of your exhaustion">)>
		       <TELL "." CR>)>
		<RFATAL>)
	       (<G? <SET CNT <CCOUNT ,PROTAGONIST>> ,FUMBLE-NUMBER>
		<COND (.VB
		       <TELL "You're holding too many things already." CR>)>
		<RFATAL>)
	       (T
		<MOVE ,PRSO ,PROTAGONIST>
		<SCORE-OBJECT>
		<FSET ,PRSO ,TOUCHBIT>
		<RTRUE>)>>

<GLOBAL SWANZO-POINT 25>

<ROUTINE SCORE-OBJECT ()
	 <COND (<AND <EQUAL? ,PRSO ,SWANZO-SCROLL>
		     <EQUAL? ,HERE ,STONE-HUT>>
		<SETG SCORE <+ ,SCORE ,SWANZO-POINT>>
		<SETG SWANZO-POINT 0>)
	       (<AND <EQUAL? ,PRSO ,VARDIK-SCROLL>
		     <NOT <FSET? ,VARDIK-SCROLL ,TOUCHBIT>>>
		<SETG SCORE <+ ,SCORE 25>>)
	       (<AND <EQUAL? ,PRSO ,VILSTU-VIAL>
		     <NOT <FSET? ,VILSTU-VIAL ,TOUCHBIT>>>
		<SETG SCORE <+ ,SCORE 10>>)
	       (<AND <EQUAL? ,PRSO ,MEEF-SCROLL>
		     <NOT <FSET? ,MEEF-SCROLL ,TOUCHBIT>>>
		<SETG SCORE <+ ,SCORE 10>>)
	       (<AND <EQUAL? ,PRSO ,YONK-SCROLL>
		     <NOT <FSET? ,YONK-SCROLL ,TOUCHBIT>>>
		<SETG SCORE <+ ,SCORE 10>>)>>

<ROUTINE IDROP ()
	 <COND (<PRSO? ,HANDS>
		<V-LOCK>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,PROTAGONIST>>
		     <NOT <IN? <LOC ,PRSO> ,PROTAGONIST>>>
		<TELL "You're not carrying">
		<ARTICLE ,PRSO T>
		<TELL "." CR>
		<RFALSE>)
	       (<AND <NOT <IN? ,PRSO ,PROTAGONIST>>
		     <NOT <FSET? <LOC ,PRSO> ,OPENBIT>>>
		<TELL "Impossible since">
		<ARTICLE ,PRSO T>
		<TELL " is closed." CR>
		<RFALSE>)
	       (<EQUAL? ,HERE ,TREE-BRANCH>
		<MOVE ,PRSO ,TWISTED-FOREST>)
	       (<EQUAL? ,HERE ,LAGOON>
		<MOVE ,PRSO ,LAGOON-FLOOR>)
	       (<AND <EQUAL? ,HERE ,GLASS-MAZE>
		     <NO-FLOOR?>>
		<DROP-IN-MAZE>
		<MOVE ,PRSO ,DIAL>
		<TELL
"It drops into the shimmering light below you. A moment later, you
hear a gentle thud." CR>)
	       (T
		<MOVE ,PRSO <LOC ,PROTAGONIST>>
		<RTRUE>)>>

<ROUTINE CCOUNT (OBJ "AUX" (CNT 0) X)
	 <COND (<SET X <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<NOT <FSET? .X ,WEARBIT>>
			       <SET CNT <+ .CNT 1>>)>
			<COND (<NOT <SET X <NEXT? .X>>>
			       <RETURN>)>>)>
	 .CNT>

;"WEIGHT: Gets sum of SIZEs of supplied object, recursing to nth level."
<ROUTINE WEIGHT (OBJ "AUX" CONT (WT 0))
	 <COND (<SET CONT <FIRST? .OBJ>>
		<REPEAT ()
			<COND (<AND <EQUAL? .OBJ ,PLAYER>
				    <FSET? .CONT ,WEARBIT>>
			       <SET WT <+ .WT 1>>)
			      (T <SET WT <+ .WT <WEIGHT .CONT>>>)>
			<COND (<NOT <SET CONT <NEXT? .CONT>>> <RETURN>)>>)>
	 <+ .WT <GETP .OBJ ,P?SIZE>>>

;"subtitle describers"

<ROUTINE DESCRIBE-ROOM ("OPTIONAL" (LOOK? <>) "AUX" V? STR AV)
	 <SET V? <OR .LOOK? ,VERBOSE>>
	 <COND (<AND <NOT ,LIT>
		     <NOT ,BLORTED>>
		<TELL "It is pitch black">
		<COND (,FWEEPED
		       <TELL
", and your bat sonar-sense isn't much help in this terrain">)>
		<TELL ".">
		<COND (<EQUAL? ,HERE ,GRUE-LAIR>
		       <TELL
" Gurgling noises come from every direction!">)
		      (<NOT ,SPRAYED?>
		       <TELL
" Dangerous creatures, such as grues, probably abound in the darkness.">)>
		<CRLF>
		<RETURN <>>)>
	 <COND (<NOT <FSET? ,HERE ,TOUCHBIT>>
		<FSET ,HERE ,TOUCHBIT>
		<SET V? T>)>
	 <COND (<IN? ,HERE ,ROOMS>
		<TELL D ,HERE>
		<COND (,FLYING
		       <TELL " (you are flying)">)>
		<COND (<NOT <FSET? <LOC ,PROTAGONIST> ,VEHBIT>>
		       <CRLF>)>)>
	 <COND (<OR .LOOK?
		    <NOT ,SUPER-BRIEF>
		    <EQUAL? ,HERE ,GLASS-MAZE>>
		<SET AV <LOC ,PROTAGONIST>>
		<COND (<FSET? .AV ,VEHBIT>
		       <TELL ", in the " D .AV CR>)>
		<COND (<AND .V? <APPLY <GETP ,HERE ,P?ACTION> ,M-LOOK>>
		       <RTRUE>)
		      (<AND .V? <SET STR <GETP ,HERE ,P?LDESC>>>
		       <TELL .STR CR>)
		      (T
		       <APPLY <GETP ,HERE ,P?ACTION> ,M-FLASH>)>
		<COND (<AND <NOT <EQUAL? ,HERE .AV>>
			    <FSET? .AV ,VEHBIT>>
		       <APPLY <GETP .AV ,P?ACTION> ,M-LOOK>)>)>
	 T>

<ROUTINE DESCRIBE-OBJECTS ("OPTIONAL" (V? <>))
	 <COND (<OR ,LIT ,BLORTED>
		<COND (<FIRST? ,HERE>
		       <PRINT-CONT ,HERE <SET V? <OR .V? ,VERBOSE>> -1>)>)
	       (T
		<TOO-DARK>)>>

"DESCRIBE-OBJECT -- takes object and flag.  if flag is true will print a
long description (fdesc or ldesc), otherwise will print short."

<GLOBAL DESC-OBJECT <>>

<ROUTINE DESCRIBE-OBJECT (OBJ V? LEVEL "AUX" (STR <>) AV)
	 <SETG DESC-OBJECT .OBJ>
	 <COND (<AND <0? .LEVEL>
		     <APPLY <GETP .OBJ ,P?DESCFCN> ,M-OBJDESC>>
		<RTRUE>)
	       (<AND <0? .LEVEL>
		     <OR <AND <NOT <FSET? .OBJ ,TOUCHBIT>>
			      <SET STR <GETP .OBJ ,P?FDESC>>>
			 <SET STR <GETP .OBJ ,P?LDESC>>>>
		<TELL .STR>)
	       (<0? .LEVEL>
		<COND (<AND <EQUAL? .OBJ ,OLDER-SELF>
			    <NOT ,OLDER-INTRODUCED>>
		       <RTRUE>)>
		<TELL "There is">
		<ARTICLE .OBJ>
		<TELL " here">
		<PARANTHETICAL-NOTES .OBJ>
		<TELL ".">)
	       (T
		<TELL <GET ,INDENTS .LEVEL>>
		<SPACELESS-ARTICLE .OBJ>
		<PARANTHETICAL-NOTES .OBJ>)>
	 <COND (<AND <0? .LEVEL>
		     <SET AV <LOC ,PROTAGONIST>>
		     <FSET? .AV ,VEHBIT>>
		<TELL " (outside the " D .AV ")">)>
	 <CRLF>
	 <COND (<AND <SEE-INSIDE? .OBJ> <FIRST? .OBJ>>
		<PRINT-CONT .OBJ .V? .LEVEL>)>>

<ROUTINE PARANTHETICAL-NOTES (OBJ)
	 <COND (<AND <EQUAL? .OBJ ,ROPE>
		     ,ROPE-TO-BEAM>
		<TELL " (tied to the beam)">)
	       (<AND <FSET? .OBJ ,WEARBIT>
		     <IN? .OBJ ,PROTAGONIST>>
		<TELL " (being worn">
		<COND (<FSET? .OBJ ,ONBIT>
		       <TELL " and providing light)">)
		      (T
		       <TELL ")">)>)
	       (<FSET? .OBJ ,ONBIT>
		<TELL " (providing light)">)>>

<ROUTINE PRINT-CONT (OBJ "OPTIONAL" (V? <>) (LEVEL 0)
		         "AUX" Y 1ST? AV STR (PV? <>) (INV? <>))
	 <COND (<NOT <SET Y <FIRST? .OBJ>>>
		<RTRUE>)>
	 <COND (<FSET? <LOC ,PROTAGONIST> ,VEHBIT>
		<SET AV <LOC ,PROTAGONIST>>)
	       (T
		<SET AV <>>)>
	 <SET 1ST? T>
	 <COND (<EQUAL? ,PROTAGONIST .OBJ <LOC .OBJ>>
		<SET INV? T>)
	       (T
		<REPEAT ()
			<COND (<NOT .Y>
			       <RETURN <NOT .1ST?>>)
			      (<==? .Y .AV>
			       <SET PV? T>)
			      (<==? .Y ,PROTAGONIST>)
			      (<AND <NOT <FSET? .Y ,INVISIBLE>>
				    <NOT <FSET? .Y ,TOUCHBIT>>
				    <SET STR <GETP .Y ,P?FDESC>>>
			       <COND (<NOT <FSET? .Y ,NDESCBIT>>
				      <TELL .STR CR>)>
			       <COND (<AND <SEE-INSIDE? .Y>
					   <NOT <GETP <LOC .Y> ,P?DESCFCN>>
					   <FIRST? .Y>>
				      <PRINT-CONT .Y .V? 0>)>)>
			<SET Y <NEXT? .Y>>>)>
	 <SET Y <FIRST? .OBJ>>
	 <REPEAT ()
		 <COND (<NOT .Y>
			<COND (<AND .PV? .AV <FIRST? .AV>>
			       <PRINT-CONT .AV .V? .LEVEL>)>
			<RETURN <NOT .1ST?>>)
		       (<EQUAL? .Y .AV ,PROTAGONIST>)
		       (<AND <NOT <FSET? .Y ,INVISIBLE>>
			     <OR .INV?
				 <FSET? .Y ,TOUCHBIT>
				 <NOT <GETP .Y ,P?FDESC>>>>
			<COND (<NOT <FSET? .Y ,NDESCBIT>>
			       <COND (.1ST?
				      <COND (<FIRSTER .OBJ .LEVEL>
					     <COND (<L? .LEVEL 0>
						    <SET LEVEL 0>)>)>
				      <SET LEVEL <+ 1 .LEVEL>>
				      <SET 1ST? <>>)>
			       <DESCRIBE-OBJECT .Y .V? .LEVEL>)
			      (<AND <FIRST? .Y> <SEE-INSIDE? .Y>>
			       <PRINT-CONT .Y .V? .LEVEL>)>)>
		 <SET Y <NEXT? .Y>>>>

<ROUTINE PRINT-CONTENTS (OBJ "AUX" F N (1ST? T) (IT? <>) (TWO? <>))
	 <COND (<SET F <FIRST? .OBJ>>
		<REPEAT ()
			<SET N <NEXT? .F>>
			<COND (.1ST? <SET 1ST? <>>)
			      (T
			       <TELL ", ">
			       <COND (<NOT .N>
				      <TELL "and ">)>)>
			<SPACELESS-ARTICLE .F>
			<COND (<AND <NOT .IT?>
				    <NOT .TWO?>>
			       <SET IT? .F>)
			      (T
			       <SET TWO? T>
			       <SET IT? <>>)>
			<SET F .N>
			<COND (<NOT .F>
			       <COND (<AND .IT? <NOT .TWO?>>
				      <THIS-IS-IT .IT?>)>
			       <RTRUE>)>>)>>

<ROUTINE FIRSTER (OBJ LEVEL)
	 <COND (<EQUAL? .OBJ ,PROTAGONIST>
		<TELL "You are carrying:" CR>)
	       (<NOT <IN? .OBJ ,ROOMS>>
		<COND (<G? .LEVEL 0>
		       <TELL <GET ,INDENTS .LEVEL>>)>
		<COND (<FSET? .OBJ ,SURFACEBIT>
		       <TELL "Sitting on the " D .OBJ " is:" CR>)
		      (<FSET? .OBJ ,ACTORBIT>
		       <TELL "It looks like">
		       <ARTICLE .OBJ T>
		       <TELL " is holding:" CR>)
		      (T
		       <TELL "The " D .OBJ " contains:" CR>)>)>>

;"subtitle movement"

<CONSTANT REXIT 0>
<CONSTANT UEXIT 1>
<CONSTANT NEXIT 2>
<CONSTANT FEXIT 3>
<CONSTANT CEXIT 4>
<CONSTANT DEXIT 5>

<CONSTANT NEXITSTR 0>
<CONSTANT FEXITFCN 0>
<CONSTANT CEXITFLAG 1>
<CONSTANT CEXITSTR 1>
<CONSTANT DEXITOBJ 1>
<CONSTANT DEXITSTR 1>

;<ROUTINE GO-NEXT (TBL "AUX" VAL)
	 <COND (<SET VAL <LKP ,HERE .TBL>>
		<GOTO .VAL>)>>

;<ROUTINE LKP (ITM TBL "AUX" (CNT 0) (LEN <GET .TBL 0>))
	 <REPEAT ()
		 <COND (<G? <SET CNT <+ .CNT 1>> .LEN>
			<RFALSE>)
		       (<EQUAL? <GET .TBL .CNT> .ITM>
			<COND (<EQUAL? .CNT .LEN> <RFALSE>)
			      (T
			       <RETURN <GET .TBL <+ .CNT 1>>>)>)>>>

<ROUTINE GOTO (RM "OPTIONAL" (V? T) "AUX" OLIT OHERE)
	 <SET OHERE ,HERE>
	 <SET OLIT ,LIT>
	 <MOVE ,PROTAGONIST .RM>
	 <SETG HERE .RM>
	 <SETG LIT <LIT? ,HERE>>
	 <COND (<AND <NOT .OLIT>
		     <NOT ,LIT>
		     <NOT ,SPRAYED?>
		     <NOT ,RESURRECTING>
		     <NOT <EQUAL? ,HERE ,HAUNTED-HOUSE>>
		     <NOT <IN? ,GRUE-SUIT ,PROTAGONIST>>
		     <PROB 80>>
		<COND (,BLORTED
		       <JIGS-UP
"A hideous creature with slavering fangs lurks up and, before
you can move, begins feasting!">)
		      (T
		       <JIGS-UP
"Oh, no! Something lurked up and devoured you!">)>
		<RTRUE>)>
	 <SETG RESURRECTING <>>
	 <ROPE-BEAM-CHECK T>
	 <APPLY <GETP ,HERE ,P?ACTION> ,M-ENTER>
	 <COND (<NOT <EQUAL? ,HERE .RM>>
		<RTRUE>)
	       (.V?
		<V-FIRST-LOOK>)>
	 <RTRUE>>

<ROUTINE ROPE-BEAM-CHECK ("OPTIONAL" (PRINT <>))
	 <COND (<AND <HELD? ,BEAM>
		     <NOT <HELD? ,ROPE>>
		     ,ROPE-TO-BEAM>
		<MOVE ,ROPE ,PROTAGONIST>
		<SETG ROPE-PLACED <>>
		<SETG ROPE-IN-LOWER-CHUTE <>>
		<FCLEAR ,BEAM ,TRYTAKEBIT>
		<FCLEAR ,ROPE ,TRYTAKEBIT>
		<COND (.PRINT
		       <TELL "(taking the rope first)" CR>)>)
	       (<AND <HELD? ,ROPE>
		     <NOT <HELD? ,BEAM>>
		     ,ROPE-TO-BEAM>
		<MOVE ,BEAM ,PROTAGONIST>
		<COND (.PRINT
		       <TELL "(taking the beam of wood first)" CR>)>)>>

;"subtitle death and stuff"

<ROUTINE JIGS-UP (DESC "OPTIONAL" (STARVED <>))
	 <COND (.DESC 
		<TELL .DESC CR>)>
	 <FORGET-ALL>
	 <KILL-INTERRUPTS>
	 <COND (,SLEEPING
		<TELL
CR "...and a moment later you wake up in a cold sweat and realize you've
been dreaming." CR>
	        <SETG SLEEPING <>>
	        <FCLEAR ,TWISTED-FOREST ,TOUCHBIT>
	        <FCLEAR ,TREE-BRANCH ,TOUCHBIT>
	        <FCLEAR ,FOREST-EDGE ,TOUCHBIT>
	        <FCLEAR ,MINE-FIELD ,TOUCHBIT>
	        <FCLEAR ,SNAKE-PIT ,TOUCHBIT>
	        <FCLEAR ,MEADOW ,TOUCHBIT>
	        <FCLEAR ,RIVER-BANK ,TOUCHBIT>
	        <FCLEAR ,FORT-ENTRANCE ,TOUCHBIT>
	        <FCLEAR ,DRAWBRIDGE ,TOUCHBIT>
	        <FCLEAR ,RUINS ,TOUCHBIT>
		<ENABLE <QUEUE I-PARROT -1>>
		<ENABLE <QUEUE I-MAILMAN 25>>
		<ENABLE <QUEUE I-TIRED 80>>
		<ENABLE <QUEUE I-HUNGER 21>>
		<ENABLE <QUEUE I-THIRST 18>>
		<SETG LAST-SLEPT ,MOVES>
		<SETG CODE-NUMBER <RANDOM 12>>
		<SETG CURRENT-TLOC <* ,CODE-NUMBER 6>>
		<SETG NEXT-NUMBER <GET ,NEXT-CODE-TABLE ,CURRENT-TLOC>>
		<SETG SCORE <+ ,SCORE 5>>
		<MOVE ,SPELL-BOOK ,PROTAGONIST>
		<SETG HERE ,YOUR-QUARTERS>
		<MOVE ,PROTAGONIST ,BED>
		<CRLF>
		<V-VERSION>
		<CRLF>
		<SETG PRSO <>>
		<SETG LIT <>>
		<TELL
"Your frotz spell seems to have worn off during the night, and it
is now pitch black." CR>)
	       (T	       
		<TELL "
|    ****  You have died  ****||">
		<COND (,RESURRECTION-ROOM
		       <COND (<AND <IN? ,SWANZO-SCROLL ,PROTAGONIST>
				   <NOT <EQUAL? ,SWANZO-POINT 0>>>
			      <MOVE ,SWANZO-SCROLL ,HOLLOW>
			      <FCLEAR ,SWANZO-SCROLL ,TOUCHBIT>)>
		       <ROPE-BEAM-CHECK>
		       <RANDOMIZE-OBJECTS>
		       <WEAR-OFF-SPELLS>
		       <TELL
"Your guardian angel, draped in white, appears floating in the nothingness
before you. \"Gotten in a bit of a scrape, eh?\" he asks, writing frantically
in a notebook. \"I'd love to chat, but we're so busy this month.\" ">
		       <COND (<EQUAL? ,RESURRECTION-ROOM ,GLASS-MAZE>
			      <TELL
"The angel looks pained. \"I hate resurrections in these stupid glass mazes!
I can never tell one room from the next.\" A moment later, you appear in
the maze. Unfortunately, this is one of the floor-less rooms. This time,
your demise is permanent." CR>
			      <FINISH>)
			     (<AND <EQUAL? ,RESURRECTION-ROOM ,RIVER-BED
				           ,STAGNANT-POOL ,TOP-OF-FALLS>
				   <NOT ,RIVER-EVAPORATED>>
			      <TELL
"A moment later you find yourself at the bottom of a river, between
a whirpool, some sharp rocks, and a school of river sharks. This time,
your death is terminal." CR>
			      <FINISH>)
			     (<AND <IN-GUILD-HALL? ,RESURRECTION-ROOM>
				   <FSET? ,TWISTED-FOREST ,TOUCHBIT>>
			      <TELL
"A look of consternation crosses the angel's face. \"According to the
records, you're to be resurrected in your local Guild Hall. But that's
quite far, and I've had a rough day. How about Egreth Castle instead,
hmmm?\" Being disembodied, you find it difficult to object, and a moment
later you are among the...">
			      <SETG RESURRECTION-ROOM ,RUINS>)
			     (T
			      <TELL
"The angel twitches his nose, and the nothingness is replaced by...">)>
		       <CRLF> <CRLF>
		       <SETG RESURRECTING T>
	               <GOTO ,RESURRECTION-ROOM>
		       <COND (<EQUAL? ,RESURRECTION-ROOM ,HOLLOW>
			      <SETG ROOM-NUMBER 24>
			      <COND (<NOT ,SPLATTERED>
			             <SETG DORN-BEAST-WARNING <>>
			             <SETG DORN-BEAST-ROOM 0>
			             <SETG LAST-DORN-ROOM 0>
			             <ENABLE <QUEUE I-DORN-BEAST 2>>)>)>
		       <COND (.STARVED
			      <TELL
"Unfortunately, you are still long overdue for a meal and immediately
drop dead again." CR>
			      <FINISH>)>
		       <COND (<IN-COAL-MINE?>
			      <ENABLE <QUEUE I-SUFFOCATE 2>>
			      <TELL
"The air here is almost unbreathable." CR>)>
		       <SETG RESURRECTION-ROOM <>>
	               <SETG P-CONT <>>
	               <RFATAL>)
		      (T
		       <TELL
"Unfortunately, you made no provisions for your untimely death." CR>
		       <FINISH>)>)>>

<GLOBAL RESURRECTING <>>

<ROUTINE RANDOMIZE-OBJECTS ("AUX" (F <FIRST? ,PROTAGONIST>) N)
	 <REPEAT ()
		 <COND (.F
			<SET N <NEXT? .F>>
			<COND (<FSET? .F ,SCROLLBIT>
			       <COND (<EQUAL? ,HERE ,HAUNTED-HOUSE
					      ,COAL-BIN-ROOM ,DIAL-ROOM>
				      <MOVE .F ,DIAL>)
				     (T
				      <MOVE .F ,HERE>)>)>
			<SET F .N>)
		       (T
			<RETURN>)>>
	 <RTRUE>>

<ROUTINE KILL-INTERRUPTS ()
	 <DISABLE <INT I-WAKE-UP>>
	 <DISABLE <INT I-HELLHOUND>>
	 <SETG HELLHOUND-WARNING <>>
	 <DISABLE <INT I-BOA>>
	 <SETG BOA-WARNING <>>
	 <DISABLE <INT I-LOCUSTS>>
	 <SETG LOCUST-WARNING 0>
	 <DISABLE <INT I-SUFFOCATE>>
	 <DISABLE <INT I-FLUME-TRIP>>
	 <END-RIDE>
	 <SETG ROOM-NUMBER 13>
	 <SETG DORN-BEAST-ROOM 0>
	 <SETG LAST-DORN-ROOM 0>
	 <DISABLE <INT I-DORN-BEAST>>	 
	 <SETG DORN-BEAST-WARNING <>>
	 <FCLEAR ,DORN-BEAST ,NDESCBIT>
	 <MOVE ,DORN-BEAST ,DIAL>
	 <SETG FWEEPED <>>
	 <SETG SUFFOCATE-WARNING <>>
	 <DISABLE <INT I-UNFWEEP>>
	 <DISABLE <INT I-BELBOZ-AWAKES>>
	 <RTRUE>>

;"subtitle useful utility routines"

<ROUTINE THIS-IS-IT (OBJ)
	 <SETG P-IT-OBJECT .OBJ>
	 ;<SETG P-IT-LOC ,HERE>>

<ROUTINE ACCESSIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player TOUCH object?"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<FSET? .OBJ ,INVISIBLE>
		<RFALSE>)
	       (<EQUAL? .OBJ ,PSEUDO-OBJECT>
		<COND (<EQUAL? ,LAST-PSEUDO-LOC ,HERE>
		       <RTRUE>)
		      (T
		       <RFALSE>)>)
	       (<NOT .L>
		<RFALSE>)
	       (<EQUAL? .L ,GLOBAL-OBJECTS>
		<RTRUE>)	       
	       (<AND <EQUAL? .L ,LOCAL-GLOBALS>
		     <GLOBAL-IN? .OBJ ,HERE>>
		<RTRUE>)
	       (<NOT <EQUAL? <META-LOC .OBJ> ,HERE>>
		<RFALSE>)
	       (<EQUAL? .L ,PROTAGONIST ,HERE>
		<RTRUE>)
	       (<AND <FSET? .L ,OPENBIT>
		     <ACCESSIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE VISIBLE? (OBJ "AUX" (L <LOC .OBJ>)) ;"can player SEE object"
	 ;"revised 5/2/84 by SEM and SWG"
	 <COND (<ACCESSIBLE? .OBJ>
		<RTRUE>)
	       (<AND <SEE-INSIDE? .L>
		     <VISIBLE? .L>>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE META-LOC (OBJ)
	 <REPEAT ()
		 <COND (<NOT .OBJ>
			<RFALSE>)
		       (<IN? .OBJ ,GLOBAL-OBJECTS>
			<RETURN ,GLOBAL-OBJECTS>)>
		 <COND (<IN? .OBJ ,ROOMS>
			<RETURN .OBJ>)
		       (T
			<SET OBJ <LOC .OBJ>>)>>>

<ROUTINE OTHER-SIDE (DOBJ "AUX" (P 0) TEE) ;"finds room on other side of door"
	 <REPEAT ()
		 <COND (<L? <SET P <NEXTP ,HERE .P>> ,LOW-DIRECTION>
			<RETURN <>>)
		       (T
			<SET TEE <GETPT ,HERE .P>>
			<COND (<AND <EQUAL? <PTSIZE .TEE> ,DEXIT>
				    <EQUAL? <GETB .TEE ,DEXITOBJ> .DOBJ>>
			       <RETURN .P>)>)>>>

<ROUTINE NOTHING-HELD? ("AUX" X N) ;"is player empty-handed?"
	 <SET X <FIRST? ,PROTAGONIST>>
	 <REPEAT ()
		 <COND (.X
			<COND (<NOT <FSET? .X ,WEARBIT>>
			       <RFALSE>)>
			<SET X <NEXT? .X>>)
		       (T
			<RTRUE>)>>>

<ROUTINE HELD? (OBJ) ;"is object carried, or in something carried, by player?"
	 <COND (<NOT .OBJ>
		<RFALSE>)
	       (<IN? .OBJ ,PROTAGONIST>
		<RTRUE>)
	       (<IN? .OBJ ,ROOMS>
		<RFALSE>)
	       (<IN? .OBJ ,GLOBAL-OBJECTS>
		<RFALSE>)
	       (T
		<HELD? <LOC .OBJ>>)>>

<ROUTINE SEE-INSIDE? (OBJ)
	 <AND <NOT <FSET? .OBJ ,INVISIBLE>>
	      <OR <FSET? .OBJ ,TRANSBIT>
	          <FSET? .OBJ ,OPENBIT>>>>

<ROUTINE GLOBAL-IN? (OBJ1 OBJ2 "AUX" TEE)
	 <COND (<SET TEE <GETPT .OBJ2 ,P?GLOBAL>>
		<ZMEMQB .OBJ1 .TEE <- <PTSIZE .TEE> 1>>)>>

<ROUTINE FIND-IN (WHERE WHAT "AUX" W)
	 <SET W <FIRST? .WHERE>>
	 <COND (<NOT .W>
		<RFALSE>)>
	 <REPEAT ()
		 <COND (<FSET? .W .WHAT>
			<RETURN .W>)
		       (<NOT <SET W <NEXT? .W>>>
			<RETURN <>>)>>>

<ROUTINE DO-WALK (DIR)
	 <SETG P-WALK-DIR .DIR>
	 <PERFORM ,V?WALK .DIR>>

;<ROUTINE 2OBJS? ()
	 <COND (<NOT <EQUAL? <GET ,P-PRSO 0> 2>>
		<PUT ,P-PRSO 0 1>
		<TELL "That sentence doesn't make sense." CR>
		<RFALSE>)
	       (T
		<RTRUE>)>>

<ROUTINE ROB (WHO "AUX" N X)
	 <SET X <FIRST? .WHO>>
	 <REPEAT ()
		 <COND (<NOT .X>
			<RETURN>)>
		 <SET N <NEXT? .X>>
		 <MOVE .X ,DIAL>
		 <SET X .N>>>

<ROUTINE STOP ()
	 <SETG P-CONT <>>
	 <SETG QUOTE-FLAG <>>
	 <RFATAL>>

<ROUTINE HACK-HACK (STR)
	 <TELL .STR>
	 <ARTICLE ,PRSO T>
	 <TELL <PICK-ONE ,HO-HUM> CR>>

<GLOBAL HO-HUM
	<PLTABLE
	 " doesn't do anything."
	 " accomplishes nothing."
	 " has no desirable effect.">>		 

<GLOBAL YUKS
	<PLTABLE
	 "No spell would help with that!"
	 "It would take more magic than you've got!"
	 "You can't be serious."
	 "You must have had a silliness spell cast upon you.">>

<ROUTINE OPEN-CLOSE ()
	 <COND (<AND <VERB? OPEN>
		     <FSET? ,PRSO ,OPENBIT>>
		<ALREADY-OPEN>
		<RTRUE>)
	       (<AND <VERB? CLOSE>
		     <NOT <FSET? ,PRSO ,OPENBIT>>>
		<ALREADY-CLOSED>
		<RTRUE>)
	       (T
		<RFALSE>)>>

<ROUTINE SPACELESS-ARTICLE (OBJ "OPTIONAL" (THE <>))
	 <COND (<FSET? .OBJ ,NARTICLEBIT>
		T)
	       (.THE
		<TELL "the ">)
	       (<FSET? .OBJ ,VOWELBIT>
		<TELL "an ">)
	       (T
		<TELL "a ">)>
	 <PRINTD .OBJ>>

<ROUTINE ARTICLE (OBJ "OPTIONAL" (THE <>))
	 <TELL " ">
	 <COND (.THE
		<SPACELESS-ARTICLE .OBJ T>)
	       (T
		<SPACELESS-ARTICLE .OBJ>)>>

<ROUTINE CANT-ENTER (LOC "OPTIONAL" (LEAVE <>))
	 <TELL "You can't ">
	 <COND (.LEAVE
		<TELL "leave">)
	       (T
		<TELL "enter">)>
	 <ARTICLE .LOC T>
	 <TELL " from here." CR>>

<ROUTINE YOU-CANT-SEE-ANY (STRING)
	 <TELL "You can't see any " .STRING " here!" CR>>

<ROUTINE WITH??? ()
	 <TELL "With">
	 <ARTICLE ,PRSI>
	 <TELL "??!?" CR>>

<ROUTINE TELL-ME-HOW ()
	 <TELL "You must tell me how to do that to">
	 <ARTICLE ,PRSO>
	 <TELL "." CR>>

<ROUTINE NOT-GOING-ANYWHERE (VEHICLE)
	 <TELL
"You're not going anywhere until you get out of the " D .VEHICLE "." CR>>

<ROUTINE SPLASH ()
	 <TELL "With a splash,">
	 <ARTICLE ,PRSO T>
	 <TELL " plunges into the water." CR>>

<ROUTINE BURIED-IN-COAL (STRING)
	 <MOVE ,PRSO ,DIAL>
	 <TELL "When you " .STRING>
	 <ARTICLE ,PRSO T>
	 <TELL " it falls between the lumps of coal and is buried." CR>>

<ROUTINE LOOK-AROUND-YOU ()
	 <TELL "Look around you." CR>>

<ROUTINE BATTY ()
	 <TELL "You're batty!" CR>>

<ROUTINE TOO-DARK ()
	 <TELL "It's too dark to see">
	 <COND (,FWEEPED
		<TELL
", and your bat sonar-sense isn't of much help, either.">)
	       (T
		<TELL "!">)>
	 <CRLF>>

<ROUTINE WHILE-FLYING ()
	 <TELL "While flying?" CR>>

<ROUTINE CANT-GO ()
	 <TELL "You can't go that way." CR>>

<ROUTINE NOW-BLACK ()
	 <TELL "It is now pitch black." CR>>

<ROUTINE ALREADY-OPEN ()
	 <TELL "It is already open." CR>>

<ROUTINE ALREADY-CLOSED ()
	 <TELL "It is already closed." CR>>

<ROUTINE MAKE-OUT ()
	 <TELL "You can't make out anything." CR>>

<ROUTINE BOOK-DAMP ()
	 <TELL "The book is damp and the writing unreadable." CR>>

<ROUTINE REFERRING ()
	 <TELL "I don't see what you're referring to." CR>>

<ROUTINE POOR-LISTENERS ()
	 <TELL "Sleeping gnomes make poor listeners." CR>>

<ROUTINE ANYMORE ()
	 <TELL "You can't see that anymore." CR>>

<ROUTINE SETTLE-ONTO-BRANCH ()
	 <TELL "You settle onto the branch." CR>>

<ROUTINE SPLASH-INTO-WATER ()
	 <TELL "You splash down into the water." CR>>

<GLOBAL YNH "You're not holding">
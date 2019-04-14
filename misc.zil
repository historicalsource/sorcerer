"MISC for
			    SORCERER
	     (c) 1984 by Infocom, Inc.  All Rights Reserved."

;"former MACROS.ZIL stuff"

<SETG C-ENABLED? 0>
<SETG C-ENABLED 1>
<SETG C-DISABLED 0>

<DEFMAC TELL ("ARGS" A)
	<FORM PROG ()
	      !<MAPF ,LIST
		     <FUNCTION ("AUX" E P O)
			  <COND (<EMPTY? .A> <MAPSTOP>)
				(<SET E <NTH .A 1>>
				 <SET A <REST .A>>)>
			  <COND (<TYPE? .E ATOM>
				 <COND (<OR <=? <SET P <SPNAME .E>>
						"CRLF">
					    <=? .P "CR">>
					<MAPRET '<CRLF>>)
				       (<EMPTY? .A>
					<ERROR INDICATOR-AT-END? .E>)
				       (ELSE
					<SET O <NTH .A 1>>
					<SET A <REST .A>>
					<COND (<OR <=? <SET P <SPNAME .E>>
						       "DESC">
						   <=? .P "D">
						   <=? .P "OBJ">
						   <=? .P "O">>
					       <MAPRET <FORM PRINTD .O>>)
					      (<OR <=? .P "NUM">
						   <=? .P "N">>
					       <MAPRET <FORM PRINTN .O>>)
					      (<OR <=? .P "CHAR">
						   <=? .P "CHR">
						   <=? .P "C">>
					       <MAPRET <FORM PRINTC .O>>)
					      (ELSE
					       <MAPRET
						 <FORM PRINT
						       <FORM GETP .O .E>>>)>)>)
				(<TYPE? .E STRING ZSTRING>
				 <MAPRET <FORM PRINTI .E>>)
				(<TYPE? .E FORM LVAL GVAL>
				 <MAPRET <FORM PRINT .E>>)
				(ELSE <ERROR UNKNOWN-TYPE .E>)>>>>>

<DEFMAC VERB? ("ARGS" ATMS)
	<MULTIFROB PRSA .ATMS>>

<DEFMAC PRSO? ("ARGS" ATMS)
	<MULTIFROB PRSO .ATMS>>

<DEFMAC PRSI? ("ARGS" ATMS)
	<MULTIFROB PRSI .ATMS>>

<DEFMAC ROOM? ("ARGS" ATMS)
	<MULTIFROB HERE .ATMS>>

<DEFINE MULTIFROB (X ATMS "AUX" (OO (OR)) (O .OO) (L ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .OO 1> <ERROR .X>)
				       (<LENGTH? .OO 2> <NTH .OO 2>)
				       (ELSE <CHTYPE .OO FORM>)>>)>
		<REPEAT ()
			<COND (<EMPTY? .ATMS> <RETURN!->)>
			<SET ATM <NTH .ATMS 1>>
			<SET L
			     (<COND (<TYPE? .ATM ATOM>
				     <CHTYPE
					   <COND (<==? .X PRSA>
						  <PARSE
						    <STRING "V?"
							    <SPNAME .ATM>>>)
						 (ELSE .ATM)> GVAL>)
				    (ELSE .ATM)>
			      !.L)>
			<SET ATMS <REST .ATMS>>
			<COND (<==? <LENGTH .L> 3> <RETURN!->)>>
		<SET O <REST <PUTREST .O (<FORM EQUAL? <CHTYPE .X GVAL> !.L>)>>>
		<SET L ()>>>

<DEFMAC BSET ('OBJ "ARGS" BITS)
	<MULTIBITS FSET .OBJ .BITS>>

<DEFMAC BCLEAR ('OBJ "ARGS" BITS)
	<MULTIBITS FCLEAR .OBJ .BITS>>

<DEFMAC BSET? ('OBJ "ARGS" BITS)
	<MULTIBITS FSET? .OBJ .BITS>>

<DEFINE MULTIBITS (X OBJ ATMS "AUX" (O ()) ATM) 
	<REPEAT ()
		<COND (<EMPTY? .ATMS>
		       <RETURN!- <COND (<LENGTH? .O 1> <NTH .O 1>)
				       (<==? .X FSET?> <FORM OR !.O>)
				       (ELSE <FORM PROG () !.O>)>>)>
		<SET ATM <NTH .ATMS 1>>
		<SET ATMS <REST .ATMS>>
		<SET O
		     (<FORM .X
			    .OBJ
			    <COND (<TYPE? .ATM FORM> .ATM)
				  (ELSE <CHTYPE .ATM GVAL>)>>
		      !.O)>>>

<DEFMAC RFATAL ()
	'<PROG () <PUSH 2> <RSTACK>>>

<DEFMAC PROB ('BASE?)
	<FORM NOT <FORM L? .BASE? '<RANDOM 100>>>>

;<DEFMAC PROB ('BASE? "OPTIONAL" 'LOSER?)
	<COND (<ASSIGNED? LOSER?> <FORM ZPROB .BASE?>)
	      (ELSE <FORM G? .BASE? '<RANDOM 100>>)>>

;<ROUTINE ZPROB (BASE)
	  <G? .BASE <RANDOM 100>>>

<ROUTINE PICK-ONE (FROB)
	 <GET .FROB <RANDOM <GET .FROB 0>>>>

;<ROUTINE PICK-ONE (FROB
		   "AUX" (L <GET .FROB 0>) (CNT <GET .FROB 1>) RND MSG RFROB)
	 <SET L <- .L 1>>
	 <SET FROB <REST .FROB 2>>
	 <SET RFROB <REST .FROB <* .CNT 2>>>
	 <SET RND <RANDOM <- .L .CNT>>>
	 <SET MSG <GET .RFROB .RND>>
	 <PUT .RFROB .RND <GET .RFROB 1>>
	 <PUT .RFROB 1 .MSG>
	 <SET CNT <+ .CNT 1>>
	 <COND (<==? .CNT .L> <SET CNT 0>)>
	 <PUT .FROB 0 .CNT>
	 .MSG>

<DEFMAC ENABLE ('INT) <FORM PUT .INT ,C-ENABLED? 1>>

<DEFMAC DISABLE ('INT) <FORM PUT .INT ,C-ENABLED? 0>>

<DEFMAC OPENABLE? ('OBJ)
	<FORM OR <FORM FSET? .OBJ ',DOORBIT>
	         <FORM FSET? .OBJ ',CONTBIT>>> 

<DEFMAC ABS ('NUM)
	<FORM COND (<FORM L? .NUM 0> <FORM - 0 .NUM>)
	           (T .NUM)>>

<ROUTINE FIXED-FONT-ON () ;"turns off proportional spacing for the Mac"
	 <PUT 0 8 <BOR <GET 0 8> 2>>>

<ROUTINE FIXED-FONT-OFF () ;"turns it back on"
	 <PUT 0 8 <BAND <GET 0 8> -3>>>

;"former MAIN.ZIL stuff"

<GLOBAL PLAYER <>>

<GLOBAL P-WON <>>

<CONSTANT M-FATAL 2>
 
<CONSTANT M-HANDLED 1>   
 
<CONSTANT M-NOT-HANDLED <>>   
 
<CONSTANT M-OBJECT <>>

<CONSTANT M-BEG 1>  
 
<CONSTANT M-END 6> 
 
<CONSTANT M-ENTER 2>
 
<CONSTANT M-LOOK 3> 
 
<CONSTANT M-FLASH 4>

<CONSTANT M-OBJDESC 5>

<GLOBAL LAST-USED-PRSO <>>

<ROUTINE GO () 
	 <PUTB ,P-LEXV 0 59>
;"put interrupts on clock chain"
	 <ENABLE <QUEUE I-WAKE-UP 7>>
	 <ENABLE <QUEUE I-HELLHOUND -1>>	 
;"set up and go"
	 <SETG LIT T>
	 <SETG WINNER ,PROTAGONIST>
	 <SETG PLAYER ,WINNER>
	 <SETG HERE ,TWISTED-FOREST>
	 <MOVE ,WINNER ,HERE>
	 <THIS-IS-IT ,HELLHOUND>
	 <PUTB ,P-INBUF 0 60>
	 <TELL
"You are in a strange location, but you cannot remember how you got here.
Everything is hazy, as though viewed through a gauze...">
	 <CRLF> <CRLF>
	 <V-LOOK>
	 <I-HELLHOUND>
	 <MAIN-LOOP>
	 <AGAIN>>    

<ROUTINE MAIN-LOOP ("AUX" TRASH)
	 <REPEAT ()
		 <SET TRASH <MAIN-LOOP-1>>>>

<ROUTINE MAIN-LOOP-1 ("AUX" ICNT OCNT NUM CNT OBJ TBL V PTBL OBJ1 TMP)
     <SETG LAST-USED-PRSO <>>
     <SET CNT 0>
     <SET OBJ <>>
     <SET PTBL T>
     <COND (<SETG P-WON <PARSER>>
	    <SET ICNT <GET ,P-PRSI ,P-MATCHLEN>>
	    <SET OCNT <GET ,P-PRSO ,P-MATCHLEN>>
	    <COND (<AND ,P-IT-OBJECT <ACCESSIBLE? ,P-IT-OBJECT>>
		   <SET TMP <>>
		   <REPEAT ()
		    <COND (<G? <SET CNT <+ .CNT 1>> .ICNT>
			   <RETURN>)
			  (T
			   <COND (<EQUAL? <GET ,P-PRSI .CNT> ,IT>
				  <PUT ,P-PRSI .CNT ,P-IT-OBJECT>
				  <SET TMP T>
				  <RETURN>)>)>>
		   <COND (<NOT .TMP>
			  <SET CNT 0>
			  <REPEAT ()
			   <COND (<G? <SET CNT <+ .CNT 1>> .OCNT>
				  <RETURN>)
				 (T
				  <COND (<EQUAL? <GET ,P-PRSO .CNT> ,IT>
					 <PUT ,P-PRSO .CNT ,P-IT-OBJECT>
					 <RETURN>)>)>>)>
		   <SET CNT 0>)>
	    <SET NUM <COND (<0? .OCNT>
			    .OCNT)
			   (<G? .OCNT 1>
			    <SET TBL ,P-PRSO>
			    <COND (<0? .ICNT>
				   <SET OBJ <>>)
				  (T
				   <SET OBJ <GET ,P-PRSI 1>>)>
			    .OCNT)
			   (<G? .ICNT 1>
			    <SET PTBL <>>
			    <SET TBL ,P-PRSI>
			    <SET OBJ <GET ,P-PRSO 1>>
			    .ICNT)
			   (T
			    1)>>
	    <COND (<AND <NOT .OBJ>
			<1? .ICNT>>
		   <SET OBJ <GET ,P-PRSI 1>>)>
	    <COND (<==? ,PRSA ,V?WALK>
		   <SET V <PERFORM ,PRSA ,PRSO>>)
		  (<0? .NUM>
		   <COND (<0? <BAND <GETB ,P-SYNTAX ,P-SBITS> ,P-SONUMS>>
			  <SET V <PERFORM ,PRSA>>
			  <SETG PRSO <>>)
			 (<AND <NOT ,LIT>
			       <NOT ,BLORTED>>
			  <SETG QUOTE-FLAG <>>
			  <SETG P-CONT <>>
			  <TOO-DARK>)
			 (<EQUAL? ,HERE ,CHAMBER-OF-LIVING-DEATH
				        ,HALL-OF-ETERNAL-PAIN>
			  <SETG QUOTE-FLAG <>>
			  <SETG P-CONT <>>
			  <AGONY>)
			 (T
			  <TELL "There isn't anything to ">
			  <SET TMP <GET ,P-ITBL ,P-VERBN>>
			  <COND (<VERB? TELL>
				 <TELL "talk to">)
				(<OR ,P-OFLAG ,P-MERGED>
				 <PRINTB <GET .TMP 0>>)
				(T
				 <WORD-PRINT <GETB .TMP 2>
					     <GETB .TMP 3>>)>
			  <TELL "!" CR>
			  <SET V <>>)>)
		  (T
		   <SETG P-NOT-HERE 0>
		   <SETG P-MULT <>>
		   <COND (<G? .NUM 1>
			  <SETG P-MULT T>)>
		   <SET TMP <>>
		   <REPEAT ()
		    <COND (<G? <SET CNT <+ .CNT 1>> .NUM>
			   <COND (<G? ,P-NOT-HERE 0>
				  <TELL "The ">
				  <COND (<NOT <EQUAL? ,P-NOT-HERE .NUM>>
					 <TELL "other ">)>
				  <TELL "object">
				  <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
					 <TELL "s">)>
				  <TELL " that you mentioned ">
				  <COND (<NOT <EQUAL? ,P-NOT-HERE 1>>
					 <TELL "are">)
					(T
					 <TELL "is">)>
				  <TELL "n't here." CR>)
				 (<NOT .TMP>
				  <REFERRING>)>
			   <RETURN>)
			  (T
			   <COND (.PTBL
				  <SET OBJ1 <GET ,P-PRSO .CNT>>)
				 (T
				  <SET OBJ1 <GET ,P-PRSI .CNT>>)>
			   <SETG PRSO <COND (.PTBL
					     .OBJ1)
					    (T
					     .OBJ)>>
			   <SETG PRSI <COND (.PTBL
					     .OBJ)
					    (T
					     .OBJ1)>>
			   <COND (<OR <G? .NUM 1>
				      <EQUAL? <GET <GET ,P-ITBL ,P-NC1> 0>
					      ,W?ALL>>
				  <COND (<EQUAL? .OBJ1 ,NOT-HERE-OBJECT>
					 <SETG P-NOT-HERE <+ ,P-NOT-HERE 1>>
					 <AGAIN>)
					(<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
					      <VERB? TAKE>
					      <OR
					       <AND <NOT <EQUAL? <LOC .OBJ1>
							         ,WINNER
							         ,HERE
								 .OBJ>>
						    <NOT <FSET? <LOC .OBJ1>
							        ,SURFACEBIT>>
						    <NOT <EQUAL? <LOC .OBJ1>
							         ,FIREPLACE>>>
					       <NOT <OR <FSET? .OBJ1 ,TAKEBIT>
							<FSET? .OBJ1
							       ,TRYTAKEBIT>>>>>
						<AGAIN>)
					(<AND <VERB? TAKE>
					      ,PRSI
					      <EQUAL?
					       <GET <GET ,P-ITBL ,P-NC1> 0>
					       ,W?ALL>
					      <NOT <IN? ,PRSO ,PRSI>>
					      <DESK-KLUDGE>>
					 <AGAIN>)
					(<AND <EQUAL? ,P-GETFLAGS ,P-ALL>
					      <VERB? DROP>
					      <NOT <IN? .OBJ1 ,WINNER>>
					      <NOT <IN? ,P-IT-OBJECT ,WINNER>>>
					 <AGAIN>)
					(<NOT <VISIBLE? .OBJ1>>
					 <AGAIN>)
					(T
					 <COND (<EQUAL? .OBJ1 ,IT>
						<PRINTD ,P-IT-OBJECT>)
					       (T
						<PRINTD .OBJ1>)>
					 <TELL ": ">)>)>
				  <SET TMP T>
				  <SET V <PERFORM ,PRSA ,PRSO ,PRSI>>
				  <SETG LAST-USED-PRSO ,PRSO>
				  <COND (<==? .V ,M-FATAL>
					 <RETURN>)>)>>)>
	    <COND (<NOT <==? .V ,M-FATAL>>
		   ;<COND (<==? <LOC ,WINNER> ,PRSO>
			  <SETG PRSO <>>)> ;"removed per Retrofix #17"
		   <COND (<VERB? TELL BRIEF SUPER-BRIEF VERBOSE
				 SAVE VERSION RESTORE SCRIPT UNSCRIPT>
			  T)
			 (T
			  <SET V
			     <APPLY <GETP <LOC ,WINNER> ,P?ACTION> ,M-END>>)>)>
	    ;<COND (<VERB? AGAIN SAVE RESTORE SCORE VERSION>
		   T)
		  (T
		   <SETG L-PRSA ,PRSA>
		   <COND (,LAST-USED-PRSO
			  <SETG L-PRSO ,LAST-USED-PRSO>)
			 (T
			  <SETG L-PRSO ,PRSO>)>
		   <SETG L-PRSI ,PRSI>)>
	    <COND (<==? .V ,M-FATAL>
		   <SETG P-CONT <>>)>)
	   (T
	    <SETG P-CONT <>>)>
     <COND (,P-WON
	    <COND (<VERB? TELL BRIEF SUPER-BRIEF VERBOSE SAVE VERSION
			  TIME QUIT RESTART SCORE SCRIPT UNSCRIPT RESTORE
			  $RANDOM $COMMAND $RECORD $UNRECORD>
		   T)
		  (T
		   <SET V <CLOCKER>>)>)>>

<ROUTINE DESK-KLUDGE ()
	 <COND (<AND <EQUAL? ,PRSI ,BELBOZ-DESK>
		     <IN? ,PRSO ,DESK-DRAWER>>
		<RFALSE>)
	       (T
		<RTRUE>)>>

;<GLOBAL L-PRSA <>>  
;<GLOBAL L-PRSO <>>  
;<GLOBAL L-PRSI <>>  

<GLOBAL P-MULT <>>

<GLOBAL P-NOT-HERE 0>


<ROUTINE FAKE-ORPHAN ("AUX" TMP)
	 <ORPHAN ,P-SYNTAX <>>
	 <TELL "Be specific: what object do you want to ">
	 <SET TMP <GET ,P-OTBL ,P-VERBN>>
	 <COND (<==? .TMP 0> <TELL "tell">)
	       (<0? <GETB ,P-VTBL 2>>
		<PRINTB <GET .TMP 0>>)
	       (T
		<WORD-PRINT <GETB .TMP 2> <GETB .TMP 3>>
		<PUTB ,P-VTBL 2 0>)>
	 <SETG P-OFLAG T>
	 <SETG P-WON <>>
	 <PREP-PRINT
	     <GETB ,P-SYNTAX ,P-SPREP1>>
	 <TELL "?" CR>>

<ROUTINE PERFORM (A "OPTIONAL" (O <>) (I <>) "AUX" V OA OO OI)
	;<COND (,DEBUG
	       <TELL "[Perform: ">
	       %<COND (<GASSIGNED? PREDGEN> '<TELL N .A>)
		      (T '<PRINC <NTH ,ACTIONS <+ <* .A 2> 1>>>)>
	       <COND (<AND .O <NOT <==? .A ,V?WALK>>>
		      <TELL " / PRSO = " D .O>)>
	       <COND (.I <TELL " / PRSI = " D .I>)>
	       <TELL "]" CR>)>
	<SET OA ,PRSA>
	<SET OO ,PRSO>
	<SET OI ,PRSI>
	<SETG PRSA .A>
	<COND (<EQUAL? ,IT .I .O>
	       ;<AND <EQUAL? ,IT .I .O>
		    <NOT <EQUAL? ,P-IT-LOC ,HERE>>>
	       <COND (<NOT .I> <FAKE-ORPHAN>)
		     (T
		      <REFERRING>)>
	       <RFATAL>)>
	;<COND (<==? .O ,IT> <SET O ,P-IT-OBJECT>)>
	;<COND (<==? .I ,IT> <SET I ,P-IT-OBJECT>)>
	<SETG PRSO .O>
	<COND (<AND ,PRSO
		    <NOT <VERB? WALK>>
		    <NOT <EQUAL? ,PRSO ,NOT-HERE-OBJECT>>>
	       <THIS-IS-IT ,PRSO>)>
	<SETG PRSI .I>
	;<COND (<NOT <==? .A ,V?AGAIN>>
	       <SETG L-PRSA .A>
	       <COND (<==? .A ,V?WALK> <SETG L-PRSO <>>)
		     (T <SETG L-PRSO .O>)>
	       <SETG L-PRSI .I>)>
	<COND (<AND <EQUAL? ,NOT-HERE-OBJECT ,PRSO ,PRSI>
		    <SET V <D-APPLY "Not Here" ,NOT-HERE-OBJECT-F>>>
	       <SETG P-WON <>>
	       .V)
	      (T
	       <SET O ,PRSO>
	       <SET I ,PRSI>
	       <COND (<SET V <D-APPLY "Actor"
				      <GETP ,WINNER ,P?ACTION>>> .V)
		     (<SET V <D-APPLY "Room (M-BEG)"
				      <GETP <LOC ,WINNER> ,P?ACTION>
				      ,M-BEG>> .V)
		     (<SET V <D-APPLY "Preaction"
				      <GET ,PREACTIONS .A>>> .V)
		     (<AND .I <SET V <D-APPLY "PRSI"
					      <GETP .I ,P?ACTION>>>> .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <LOC .O>
			   <GETP <LOC .O> ,P?CONTFCN>
			   <SET V <D-APPLY "Container"
					   <GETP <LOC .O> ,P?CONTFCN>>>>
		      .V)
		     (<AND .O
			   <NOT <==? .A ,V?WALK>>
			   <SET V <D-APPLY "PRSO"
					   <GETP .O ,P?ACTION>>>>
		      .V)
		     (<SET V <D-APPLY <>
				      <GET ,ACTIONS .A>>> .V)>)>
	<SETG PRSA .OA>
	<SETG PRSO .OO>
	<SETG PRSI .OI>
	.V>

<ROUTINE D-APPLY (STR FCN "OPTIONAL" (FOO <>) "AUX" RES)
	<COND (<NOT .FCN> <>)
	      (T
	       ;<COND (,DEBUG
		      <COND (<NOT .STR>
			     <TELL CR "  Default ->" CR>)
			    (T <TELL CR "  " .STR " -> ">)>)>
	       <SET RES
		    <COND (.FOO <APPLY .FCN .FOO>)
			  (T <APPLY .FCN>)>>
	       ;<COND (<AND ,DEBUG .STR>
		      <COND (<==? .RES ,M-FATAL>
			     <TELL "Fatal" CR>)
			    (<NOT .RES>
			     <TELL "Not handled">)
			    (T <TELL "Handled" CR>)>)>
	       .RES)>>

;"former CLOCK.ZIL stuff"

<CONSTANT C-TABLELEN 300>

<GLOBAL C-TABLE <ITABLE NONE 300>>

<GLOBAL C-DEMONS 300>

<GLOBAL C-INTS 300>

<CONSTANT C-INTLEN 6>

<CONSTANT C-ENABLED? 0>

<CONSTANT C-TICK 1>

<CONSTANT C-RTN 2>

;<ROUTINE DEMON (RTN TICK "AUX" CINT)
	 <PUT <SET CINT <INT .RTN T>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE QUEUE (RTN TICK "AUX" CINT)
	 <PUT <SET CINT <INT .RTN>> ,C-TICK .TICK>
	 .CINT>

<ROUTINE INT (RTN "OPTIONAL" (DEMON <>) E C INT)
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <SET C <REST ,C-TABLE ,C-INTS>>
	 <REPEAT ()
		 <COND (<==? .C .E>
			<SETG C-INTS <- ,C-INTS ,C-INTLEN>>
			<AND .DEMON <SETG C-DEMONS <- ,C-DEMONS ,C-INTLEN>>>
			<SET INT <REST ,C-TABLE ,C-INTS>>
			<PUT .INT ,C-RTN .RTN>
			<RETURN .INT>)
		       (<EQUAL? <GET .C ,C-RTN> .RTN> <RETURN .C>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<GLOBAL CLOCK-WAIT <>>

<ROUTINE CLOCKER ("AUX" C E TICK (FLG <>))
	 <COND (,CLOCK-WAIT <SETG CLOCK-WAIT <>> <RFALSE>)>
	 <SET C <REST ,C-TABLE <COND (,P-WON ,C-INTS) (T ,C-DEMONS)>>>
	 <SET E <REST ,C-TABLE ,C-TABLELEN>>
	 <REPEAT ()
		 <COND (<==? .C .E>
			<SETG MOVES <+ ,MOVES 1>>
			<RETURN .FLG>)
		       (<NOT <0? <GET .C ,C-ENABLED?>>>
			<SET TICK <GET .C ,C-TICK>>
			<COND (<0? .TICK>)
			      (T
			       <PUT .C ,C-TICK <- .TICK 1>>
			       <COND (<AND <NOT <G? .TICK 1>>
					   <APPLY <GET .C ,C-RTN>>>
				      <SET FLG T>)>)>)>
		 <SET C <REST .C ,C-INTLEN>>>>

<ROUTINE NULL-F () <RFALSE>>

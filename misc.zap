

	.FUNCT	PICK-ONE,FROB
	GET	FROB,0
	RANDOM	STACK
	GET	FROB,STACK
	RSTACK	


	.FUNCT	FIXED-FONT-ON
	GET	0,8
	BOR	STACK,2
	PUT	0,8,STACK
	RTRUE	


	.FUNCT	FIXED-FONT-OFF
	GET	0,8
	BAND	STACK,-3
	PUT	0,8,STACK
	RTRUE	


	.FUNCT	GO
START::

?FCN:	PUTB	P-LEXV,0,59
	CALL	QUEUE,I-WAKE-UP,7
	PUT	STACK,0,1
	CALL	QUEUE,I-HELLHOUND,-1
	PUT	STACK,0,1
	SET	'LIT,TRUE-VALUE
	SET	'WINNER,PROTAGONIST
	SET	'PLAYER,WINNER
	SET	'HERE,TWISTED-FOREST
	MOVE	WINNER,HERE
	CALL	THIS-IS-IT,HELLHOUND
	PUTB	P-INBUF,0,60
	PRINTI	"You are in a strange location, but you cannot remember how you got here. Everything is hazy, as though viewed through a gauze..."
	CRLF	
	CRLF	
	CALL	V-LOOK
	CALL	I-HELLHOUND
	CALL	MAIN-LOOP
	JUMP	?FCN


	.FUNCT	MAIN-LOOP,TRASH
?PRG1:	CALL	MAIN-LOOP-1 >TRASH
	JUMP	?PRG1


	.FUNCT	MAIN-LOOP-1,ICNT,OCNT,NUM,CNT,OBJ,TBL,V,PTBL,OBJ1,TMP,?TMP1
	SET	'LAST-USED-PRSO,FALSE-VALUE
	SET	'CNT,0
	SET	'OBJ,FALSE-VALUE
	SET	'PTBL,TRUE-VALUE
	CALL	PARSER >P-WON
	ZERO?	P-WON /?ELS3
	GET	P-PRSI,P-MATCHLEN >ICNT
	GET	P-PRSO,P-MATCHLEN >OCNT
	ZERO?	P-IT-OBJECT /?CND4
	CALL	ACCESSIBLE?,P-IT-OBJECT
	ZERO?	STACK /?CND4
	SET	'TMP,FALSE-VALUE
?PRG9:	IGRTR?	'CNT,ICNT \?ELS13
	JUMP	?REP10
?ELS13:	GET	P-PRSI,CNT
	EQUAL?	STACK,IT \?PRG9
	PUT	P-PRSI,CNT,P-IT-OBJECT
	SET	'TMP,TRUE-VALUE
?REP10:	ZERO?	TMP \?CND19
	SET	'CNT,0
?PRG22:	IGRTR?	'CNT,OCNT \?ELS26
	JUMP	?CND19
?ELS26:	GET	P-PRSO,CNT
	EQUAL?	STACK,IT \?PRG22
	PUT	P-PRSO,CNT,P-IT-OBJECT
?CND19:	SET	'CNT,0
?CND4:	ZERO?	OCNT \?ELS36
	PUSH	OCNT
	JUMP	?CND32
?ELS36:	GRTR?	OCNT,1 \?ELS38
	SET	'TBL,P-PRSO
	ZERO?	ICNT \?ELS41
	SET	'OBJ,FALSE-VALUE
	JUMP	?CND39
?ELS41:	GET	P-PRSI,1 >OBJ
?CND39:	PUSH	OCNT
	JUMP	?CND32
?ELS38:	GRTR?	ICNT,1 \?ELS45
	SET	'PTBL,FALSE-VALUE
	SET	'TBL,P-PRSI
	GET	P-PRSO,1 >OBJ
	PUSH	ICNT
	JUMP	?CND32
?ELS45:	PUSH	1
?CND32:	SET	'NUM,STACK
	ZERO?	OBJ \?CND48
	EQUAL?	ICNT,1 \?CND48
	GET	P-PRSI,1 >OBJ
?CND48:	EQUAL?	PRSA,V?WALK \?ELS55
	CALL	PERFORM,PRSA,PRSO >V
	JUMP	?CND53
?ELS55:	ZERO?	NUM \?ELS57
	GETB	P-SYNTAX,P-SBITS
	BAND	STACK,P-SONUMS
	ZERO?	STACK \?ELS60
	CALL	PERFORM,PRSA >V
	SET	'PRSO,FALSE-VALUE
	JUMP	?CND53
?ELS60:	ZERO?	LIT \?ELS62
	ZERO?	BLORTED \?ELS62
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-CONT,FALSE-VALUE
	CALL	TOO-DARK
	JUMP	?CND53
?ELS62:	EQUAL?	HERE,CHAMBER-OF-LIVING-DEATH,HALL-OF-ETERNAL-PAIN \?ELS66
	SET	'QUOTE-FLAG,FALSE-VALUE
	SET	'P-CONT,FALSE-VALUE
	CALL	AGONY
	JUMP	?CND53
?ELS66:	PRINTI	"There isn't anything to "
	GET	P-ITBL,P-VERBN >TMP
	EQUAL?	PRSA,V?TELL \?ELS73
	PRINTI	"talk to"
	JUMP	?CND71
?ELS73:	ZERO?	P-OFLAG \?THN78
	ZERO?	P-MERGED /?ELS77
?THN78:	GET	TMP,0
	PRINTB	STACK
	JUMP	?CND71
?ELS77:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
?CND71:	PRINTI	"!"
	CRLF	
	SET	'V,FALSE-VALUE
	JUMP	?CND53
?ELS57:	SET	'P-NOT-HERE,0
	SET	'P-MULT,FALSE-VALUE
	GRTR?	NUM,1 \?CND86
	SET	'P-MULT,TRUE-VALUE
?CND86:	SET	'TMP,FALSE-VALUE
?PRG89:	IGRTR?	'CNT,NUM \?ELS93
	GRTR?	P-NOT-HERE,0 \?ELS96
	PRINTI	"The "
	EQUAL?	P-NOT-HERE,NUM /?CND99
	PRINTI	"other "
?CND99:	PRINTI	"object"
	EQUAL?	P-NOT-HERE,1 /?CND106
	PRINTI	"s"
?CND106:	PRINTI	" that you mentioned "
	EQUAL?	P-NOT-HERE,1 /?ELS115
	PRINTI	"are"
	JUMP	?CND113
?ELS115:	PRINTI	"is"
?CND113:	PRINTI	"n't here."
	CRLF	
	JUMP	?REP90
?ELS96:	ZERO?	TMP \?REP90
	CALL	REFERRING
	JUMP	?REP90
?ELS93:	ZERO?	PTBL /?ELS130
	GET	P-PRSO,CNT >OBJ1
	JUMP	?CND128
?ELS130:	GET	P-PRSI,CNT >OBJ1
?CND128:	ZERO?	PTBL /?ELS138
	PUSH	OBJ1
	JUMP	?CND134
?ELS138:	PUSH	OBJ
?CND134:	SET	'PRSO,STACK
	ZERO?	PTBL /?ELS146
	PUSH	OBJ
	JUMP	?CND142
?ELS146:	PUSH	OBJ1
?CND142:	SET	'PRSI,STACK
	GRTR?	NUM,1 /?THN153
	GET	P-ITBL,P-NC1
	GET	STACK,0
	EQUAL?	STACK,W?ALL \?CND150
?THN153:	EQUAL?	OBJ1,NOT-HERE-OBJECT \?ELS157
	INC	'P-NOT-HERE
	JUMP	?PRG89
?ELS157:	EQUAL?	P-GETFLAGS,P-ALL \?ELS159
	EQUAL?	PRSA,V?TAKE \?ELS159
	LOC	OBJ1
	EQUAL?	STACK,WINNER,HERE,OBJ /?ELS165
	LOC	OBJ1
	FSET?	STACK,SURFACEBIT /?ELS165
	LOC	OBJ1
	EQUAL?	STACK,FIREPLACE \?PRG89
?ELS165:	FSET?	OBJ1,TAKEBIT /?ELS159
	FSET?	OBJ1,TRYTAKEBIT /?ELS159
	JUMP	?PRG89
?ELS159:	EQUAL?	PRSA,V?TAKE \?ELS169
	ZERO?	PRSI /?ELS169
	GET	P-ITBL,P-NC1
	GET	STACK,0
	EQUAL?	STACK,W?ALL \?ELS169
	IN?	PRSO,PRSI /?ELS169
	CALL	DESK-KLUDGE
	ZERO?	STACK /?ELS169
	JUMP	?PRG89
?ELS169:	EQUAL?	P-GETFLAGS,P-ALL \?ELS173
	EQUAL?	PRSA,V?DROP \?ELS173
	IN?	OBJ1,WINNER /?ELS173
	IN?	P-IT-OBJECT,WINNER /?ELS173
	JUMP	?PRG89
?ELS173:	CALL	VISIBLE?,OBJ1
	ZERO?	STACK \?ELS177
	JUMP	?PRG89
?ELS177:	EQUAL?	OBJ1,IT \?ELS182
	PRINTD	P-IT-OBJECT
	JUMP	?CND180
?ELS182:	PRINTD	OBJ1
?CND180:	PRINTI	": "
?CND150:	SET	'TMP,TRUE-VALUE
	CALL	PERFORM,PRSA,PRSO,PRSI >V
	SET	'LAST-USED-PRSO,PRSO
	EQUAL?	V,M-FATAL \?PRG89
	JUMP	?CND53
?REP90:	
?CND53:	EQUAL?	V,M-FATAL /?CND190
	EQUAL?	PRSA,V?SUPER-BRIEF,V?BRIEF,V?TELL /?CND193
	EQUAL?	PRSA,V?VERSION,V?SAVE,V?VERBOSE /?CND193
	EQUAL?	PRSA,V?UNSCRIPT,V?SCRIPT,V?RESTORE \?ELS195
	JUMP	?CND190
?ELS195:	LOC	WINNER
	GETP	STACK,P?ACTION
	CALL	STACK,M-END >V
?CND193:	
?CND190:	EQUAL?	V,M-FATAL \?CND1
	SET	'P-CONT,FALSE-VALUE
	JUMP	?CND1
?ELS3:	SET	'P-CONT,FALSE-VALUE
?CND1:	ZERO?	P-WON /FALSE
	EQUAL?	PRSA,V?SUPER-BRIEF,V?BRIEF,V?TELL /TRUE
	EQUAL?	PRSA,V?VERSION,V?SAVE,V?VERBOSE /TRUE
	EQUAL?	PRSA,V?RESTART,V?QUIT,V?TIME /TRUE
	EQUAL?	PRSA,V?UNSCRIPT,V?SCRIPT,V?SCORE /TRUE
	EQUAL?	PRSA,V?$COMMAND,V?$RANDOM,V?RESTORE /TRUE
	EQUAL?	PRSA,V?$UNRECORD,V?$RECORD /TRUE
	CALL	CLOCKER >V
	RETURN	V


	.FUNCT	DESK-KLUDGE
	EQUAL?	PRSI,BELBOZ-DESK \TRUE
	IN?	PRSO,DESK-DRAWER \TRUE
	RFALSE	


	.FUNCT	FAKE-ORPHAN,TMP,?TMP1
	CALL	ORPHAN,P-SYNTAX,FALSE-VALUE
	PRINTI	"Be specific: what object do you want to "
	GET	P-OTBL,P-VERBN >TMP
	ZERO?	TMP \?ELS5
	PRINTI	"tell"
	JUMP	?CND3
?ELS5:	GETB	P-VTBL,2
	ZERO?	STACK \?ELS9
	GET	TMP,0
	PRINTB	STACK
	JUMP	?CND3
?ELS9:	GETB	TMP,2 >?TMP1
	GETB	TMP,3
	CALL	WORD-PRINT,?TMP1,STACK
	PUTB	P-VTBL,2,0
?CND3:	SET	'P-OFLAG,TRUE-VALUE
	SET	'P-WON,FALSE-VALUE
	GETB	P-SYNTAX,P-SPREP1
	CALL	PREP-PRINT,STACK
	PRINTR	"?"


	.FUNCT	PERFORM,A,O=0,I=0,V,OA,OO,OI
	SET	'OA,PRSA
	SET	'OO,PRSO
	SET	'OI,PRSI
	SET	'PRSA,A
	EQUAL?	IT,I,O \?CND1
	ZERO?	I \?ELS6
	CALL	FAKE-ORPHAN
	RETURN	2
?ELS6:	CALL	REFERRING
	RETURN	2
?CND1:	SET	'PRSO,O
	ZERO?	PRSO /?CND11
	EQUAL?	PRSA,V?WALK /?CND11
	EQUAL?	PRSO,NOT-HERE-OBJECT /?CND11
	CALL	THIS-IS-IT,PRSO
?CND11:	SET	'PRSI,I
	EQUAL?	NOT-HERE-OBJECT,PRSO,PRSI \?ELS18
	CALL	D-APPLY,STR?1,NOT-HERE-OBJECT-F >V
	ZERO?	V /?ELS18
	SET	'P-WON,FALSE-VALUE
	JUMP	?CND16
?ELS18:	SET	'O,PRSO
	SET	'I,PRSI
	GETP	WINNER,P?ACTION
	CALL	D-APPLY,STR?2,STACK >V
	ZERO?	V /?ELS25
	JUMP	?CND16
?ELS25:	LOC	WINNER
	GETP	STACK,P?ACTION
	CALL	D-APPLY,STR?3,STACK,M-BEG >V
	ZERO?	V /?ELS27
	JUMP	?CND16
?ELS27:	GET	PREACTIONS,A
	CALL	D-APPLY,STR?4,STACK >V
	ZERO?	V /?ELS29
	JUMP	?CND16
?ELS29:	ZERO?	I /?ELS31
	GETP	I,P?ACTION
	CALL	D-APPLY,STR?5,STACK >V
	ZERO?	V /?ELS31
	JUMP	?CND16
?ELS31:	ZERO?	O /?ELS35
	EQUAL?	A,V?WALK /?ELS35
	LOC	O
	ZERO?	STACK /?ELS35
	LOC	O
	GETP	STACK,P?CONTFCN
	ZERO?	STACK /?ELS35
	LOC	O
	GETP	STACK,P?CONTFCN
	CALL	D-APPLY,STR?6,STACK >V
	ZERO?	V /?ELS35
	JUMP	?CND16
?ELS35:	ZERO?	O /?ELS39
	EQUAL?	A,V?WALK /?ELS39
	GETP	O,P?ACTION
	CALL	D-APPLY,STR?7,STACK >V
	ZERO?	V /?ELS39
	JUMP	?CND16
?ELS39:	GET	ACTIONS,A
	CALL	D-APPLY,FALSE-VALUE,STACK >V
	ZERO?	V /?CND16
?CND16:	SET	'PRSA,OA
	SET	'PRSO,OO
	SET	'PRSI,OI
	RETURN	V


	.FUNCT	D-APPLY,STR,FCN,FOO=0,RES
	ZERO?	FCN /FALSE
	ZERO?	FOO /?ELS12
	CALL	FCN,FOO
	JUMP	?CND8
?ELS12:	CALL	FCN
?CND8:	SET	'RES,STACK
	RETURN	RES


	.FUNCT	QUEUE,RTN,TICK,CINT
	CALL	INT,RTN >CINT
	PUT	CINT,C-TICK,TICK
	RETURN	CINT


	.FUNCT	INT,RTN,DEMON=0,E,C,INT
	ADD	C-TABLE,C-TABLELEN >E
	ADD	C-TABLE,C-INTS >C
?PRG1:	EQUAL?	C,E \?ELS5
	SUB	C-INTS,C-INTLEN >C-INTS
	ZERO?	DEMON /?ELS7
	SUB	C-DEMONS,C-INTLEN >C-DEMONS
?ELS7:	ADD	C-TABLE,C-INTS >INT
	PUT	INT,C-RTN,RTN
	RETURN	INT
?ELS5:	GET	C,C-RTN
	EQUAL?	STACK,RTN \?CND3
	RETURN	C
?CND3:	ADD	C,C-INTLEN >C
	JUMP	?PRG1


	.FUNCT	CLOCKER,C,E,TICK,FLG=0
	ZERO?	CLOCK-WAIT /?CND1
	SET	'CLOCK-WAIT,FALSE-VALUE
	RFALSE	
?CND1:	ZERO?	P-WON /?ELS9
	PUSH	C-INTS
	JUMP	?CND5
?ELS9:	PUSH	C-DEMONS
?CND5:	ADD	C-TABLE,STACK >C
	ADD	C-TABLE,C-TABLELEN >E
?PRG13:	EQUAL?	C,E \?ELS17
	INC	'MOVES
	RETURN	FLG
?ELS17:	GET	C,C-ENABLED?
	ZERO?	STACK /?CND15
	GET	C,C-TICK >TICK
	ZERO?	TICK \?ELS22
	JUMP	?CND15
?ELS22:	SUB	TICK,1
	PUT	C,C-TICK,STACK
	GRTR?	TICK,1 /?CND20
	GET	C,C-RTN
	CALL	STACK
	ZERO?	STACK /?CND20
	SET	'FLG,TRUE-VALUE
?CND20:	
?CND15:	ADD	C,C-INTLEN >C
	JUMP	?PRG13


	.FUNCT	NULL-F
	RFALSE	

	.ENDI

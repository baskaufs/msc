1 REM * CODE
2 REM * CODEBREAKER GAME
3 REM * WRITTEN 1983 JAN 4
4 REM * BY STEVE BASKAUF
10 PRINT "INPUT NUM. OF DIF. LETTERS TO USE:";
20 INPUT NlETTERS
30 PRINT "INPUT LENGTH OF CODE:";
40 INPUT CODELEN
50 DIM DIGIT(CODELEN),GUESS$(CODELEN)
60 FOR I=1 TO CODELEN
65 SEED = PEEK(78) + 256*PEEK(79) : REM USE RANDOM TIMER DATA AS SEED
70 DIGIT(I)=INT(NLETTERS*RND(-SEED))+ASC("A")
80 NEXT I
83 PRINT ,"GUESS","CORRECT","CORRECT"
84 PRINT ,,"LETTER","PLACE"
90 REM
100 INPUT GUESS$
110 IF LEN(GUESS$)<CODELEN THEN PRINT "TOO SHORT":GOTO 90
150 C=C+1
160 PRINT C,GUESS$,:PLACE=0:CHAR=0
170 FOR I=1 TO CODELEN
180 IF ASC(MID$(GUESS$,I,1))=DIGIT(I) THEN PLACE=PLACE+1
190 NEXT I
200 FOR I=1 TO CODELEN
210 FOR J=1 TO CODELEN
220 IF ASC(MID$(GUESS$,J,1))=DIGIT(I) THEN CHAR=CHAR+1:GUESS$=LEFT$(GUESS$,J-1)+"*"+RIGHT$(GUESS$,CODELEN-J):GOTO 240
230 NEXT J
240 NEXT I
250 PRINT CHAR,PLACE
260 IF PLACE<>CODELEN THEN GOTO 90
270 PRINT "YOU BROKE THE CODE IN ";C;" GUESSES"

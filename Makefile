NAME=tmasm
LEX=flex -l
YACC=byacc -d
CC=gcc
CFLAGS=-ansi -pedantic
RM=rm

all: tmasm

tmasm: lex.yy.c y.tab.c
	$(CC) -o$@ $(CFLAGS) lex.yy.c y.tab.c

lex.yy.c: tmasm.l
	$(LEX) tmasm.l

y.tab.c: tmasm.y
	$(YACC) tmasm.y

clean:
	$(RM) lex.yy.c y.tab.c *~


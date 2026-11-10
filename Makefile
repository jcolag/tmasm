# SPDX-FileCopyrightText: 2016 John Colagioia <john@colagioia.net>
#
# SPDX-License-Identifier: GPL-3.0-or-later

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
	$(RM) lex.yy.c y.tab.? *~


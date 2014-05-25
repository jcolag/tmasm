%{

/* Parser for a Turing Machine Assembler */

#include <stdio.h>
#include <stdlib.h>

extern  int     lineno;

int     yylex   (void);
int     yyparse (void);

char    state, nstate, flags;
int     bytes = 0;

%}

%token  NUM CHAR TERM

%%

stmts   :       stmts stmt                      { ; }
        |       /* empty */                     { ; }
        ;

stmt    :       NUM '/' CHAR ':' NUM '/' CHAR dir opts TERM {
                                        if ($1 > 127 || $5 > 127)
                                            yyerror ("No more than 128 states");
                                        state = $1 % 128 << 1;
                                        nstate = $5 % 128 << 1;
                                        flags = $3 % 2 << 1 |
                                                $7 % 2 << 2 |
                                                $8 << 3     |
                                                $9 << 4;
                                        fprintf (yyout, "%c%c%c",
                                                state, nstate,
                                                flags | 0x41);
                                        bytes += 3;
                                        printf ("%d\t%d\t%d\t\t%d\n",
                                                state, nstate,
                                                flags, bytes | 0x41);
                                    }
        |       TERM                { printf ("NULL\n") ; }
        ;

dir     :       'L'                     { $$ = 0; }
        |       'l'                     { $$ = 0; }
        |       'R'                     { $$ = 1; }
        |       'r'                     { $$ = 1; }
        |       /* empty? Assume Left */{ $$ = 0; }
        ;

opts    :       '.'                     { $$ = 1; }
        |       'p'                     { $$ = 1; }
        |       /* empty */             { $$ = 0; }
        ;
%%

extern  FILE    *yyin, *yyout;

int main (int argc, char *argv[])
{
 switch (argc)
        {
         case 1:        yyin = stdin;
                        yyout = fopen ("a.out", "w");
                        break;
         case 2:        yyin = fopen (argv[1], "r");
                        yyout = fopen ("a.out", "w");
                        break;
         case 3:        yyin = fopen (argv[1], "r");
                        yyout = fopen (argv[2], "w");
                        break;
         default:       fprintf (stderr,
                        "Usage:\n\t%s [<infile> [<outfile>]]\n\n", argv[0]);
                        exit (1);
                        break;
        }

 if (yyin == NULL)
        {
         fprintf (stderr, "Cannot open \"%s\" as input.\n", argv[1]);
         exit (1);
        }
 if (yyout == NULL)
        {
         fprintf (stderr, "Cannot open \"%s\" as output.\n", argv[2]);
         exit (1);
        }

 while (!feof (yyin)) yyparse ();

 printf ("%s -> %s:  %d bytes\n", (argc>1)?argv[1]:"STDIN",
        (argc>2)?argv[2]:"a.out", bytes);
 return (0);
}

void yyerror (char *s)
{
 fprintf (stderr, "\nError on line %d:  %s!\n", lineno, s);
}


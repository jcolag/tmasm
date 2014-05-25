%{

/* Lexical Analyzer for a Turing Machine Assembler */

#include <stdlib.h>
#include "y.tab.h"

#define yy_flex_realloc realloc
#define yy_flex_alloc   malloc
#define yy_flex_free    free
#define yy_strcpy       strcpy

extern  long    yylval;
extern  int     times;

void    yy_fatal_error  (yyconst char[]);
int     yywrap          (void);

int     lineno = 1;

%}

%%

[0-9]+          { yylval = atoi (yytext); return (NUM); }
;[^\n]*         { /* Comments */ ; }
\r\n            { ++lineno; return (TERM); }
[ \t]           { /* Whitespace */ ; }
`[a-zA-Z0-9]    { yylval = yytext[1]; return (CHAR); }
\\[0-9]{3}      { yylval = atoi (&yytext[1]); return (CHAR); }
.               { return (yytext[0]); }

%%

int yywrap (void)
{
 return (1);
}

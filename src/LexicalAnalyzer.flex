%%

%class LexicalAnalyzer
%unicode
%type Symbol
%function nextSymbol
%line
%column
%yylexthrow UnkownLexicalUnitException

PROGNAME = [A-Z][a-zA-Z0-9_]*
VARNAME = [a-z][a-zA-Z0-9]*
NUMBER = [1-9][0-9]*|0
WHITESPACE = [ \t\f\r\n]+


%%

"Prog"              { return new Symbol(LexicalUnit.PROG, yyline, yycolumn, yytext()); }
"Is"                { return new Symbol(LexicalUnit.IS, yyline, yycolumn, yytext()); }
"End"               { return new Symbol(LexicalUnit.END, yyline, yycolumn, yytext()); }
";"                 { return new Symbol(LexicalUnit.SEMI, yyline, yycolumn,yytext()); }
"="                 { return new Symbol(LexicalUnit.ASSIGN, yyline, yycolumn,yytext()); }
"("                 { return new Symbol(LexicalUnit.LPAREN, yyline, yycolumn,yytext()); }
")"                 { return new Symbol(LexicalUnit.RPAREN, yyline, yycolumn,yytext()); }
"+"                 { return new Symbol(LexicalUnit.PLUS, yyline, yycolumn,yytext()); }
"-"                 { return new Symbol(LexicalUnit.MINUS, yyline, yycolumn,yytext()); }
"*"                 { return new Symbol(LexicalUnit.TIMES, yyline, yycolumn,yytext()); }
"/"                 { return new Symbol(LexicalUnit.DIVIDE, yyline, yycolumn,yytext()); }
"If"                { return new Symbol(LexicalUnit.IF, yyline, yycolumn,yytext()); }
"Then"              { return new Symbol(LexicalUnit.THEN, yyline, yycolumn,yytext()); }
"Else"              { return new Symbol(LexicalUnit.ELSE, yyline, yycolumn,yytext()); }
"{"                 { return new Symbol(LexicalUnit.LBRACK, yyline, yycolumn,yytext()); }
"}"                 { return new Symbol(LexicalUnit.RBRACK, yyline, yycolumn,yytext()); }
"->"                { return new Symbol(LexicalUnit.IMPLIES, yyline, yycolumn,yytext()); }
"|"                 { return new Symbol(LexicalUnit.PIPE, yyline, yycolumn,yytext()); }
"=="                { return new Symbol(LexicalUnit.EQUAL, yyline, yycolumn,yytext()); }
"<="                { return new Symbol(LexicalUnit.SMALEQ, yyline, yycolumn,yytext()); }
"<"                 { return new Symbol(LexicalUnit.SMALLER, yyline, yycolumn,yytext()); }
"While"             { return new Symbol(LexicalUnit.WHILE, yyline, yycolumn,yytext()); }
"Do"                { return new Symbol(LexicalUnit.DO, yyline, yycolumn,yytext()); }
"Print"             { return new Symbol(LexicalUnit.PRINT, yyline, yycolumn,yytext()); }
"Input"             { return new Symbol(LexicalUnit.INPUT, yyline, yycolumn,yytext()); }

{NUMBER}            { return new Symbol(LexicalUnit.NUMBER, yyline, yycolumn, Integer.parseInt(yytext())); }
{VARNAME}           { return new Symbol(LexicalUnit.VARNAME, yyline, yycolumn, yytext()); }
{PROGNAME}          { return new Symbol(LexicalUnit.PROGNAME, yyline, yycolumn, yytext()); }

{WHITESPACE}        { }


"!!"[^!]*"!!"       { }
"$".*               { }

.                   { System.err.println("Unknown symbol: " + yytext()); }




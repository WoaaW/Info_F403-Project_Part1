%%

%standalone
%class LexicalAnalyzer
%unicode
%type Symbol
%function nextSymbol
%line
%column

VARNAME = [a-z][a-zA-Z0-9]*
NUMBER = [1-9][0-9]*|0
PROGNAME = [A-Z][a-zA-Z0-9_]*
WHITESPACE = [ \t\f\r\n]+


%%

"Prog"              { return new Symbol(LexicalUnit.PROG, yyline, yycolumn, yytext()); }
"Is"                { return new Symbol(LexicalUnit.IS, yyline, yycolumn, yytext()); }
"End"               { return new Symbol(LexicalUnit.END, yyline, yycolumn, yytext()); }
";"                 { return new Symbol(LexicalUnit.SEMI, yyline, yycolumn); }
"="                 { return new Symbol(LexicalUnit.ASSIGN, yyline, yycolumn); }
"("                 { return new Symbol(LexicalUnit.LPAREN, yyline, yycolumn); }
")"                 { return new Symbol(LexicalUnit.RPAREN, yyline, yycolumn); }
"+"                 { return new Symbol(LexicalUnit.PLUS, yyline, yycolumn); }
"-"                 { return new Symbol(LexicalUnit.MINUS, yyline, yycolumn); }
"*"                 { return new Symbol(LexicalUnit.TIMES, yyline, yycolumn); }
"/"                 { return new Symbol(LexicalUnit.DIVIDE, yyline, yycolumn); }
"If"                { return new Symbol(LexicalUnit.IF, yyline, yycolumn); }
"Then"              { return new Symbol(LexicalUnit.THEN, yyline, yycolumn); }
"Else"              { return new Symbol(LexicalUnit.ELSE, yyline, yycolumn); }
"{"                 { return new Symbol(LexicalUnit.LBRACK, yyline, yycolumn); }
"}"                 { return new Symbol(LexicalUnit.RBRACK, yyline, yycolumn); }
"->"                { return new Symbol(LexicalUnit.IMPLIES, yyline, yycolumn); }
"|"                 { return new Symbol(LexicalUnit.PIPE, yyline, yycolumn); }
"=="                { return new Symbol(LexicalUnit.EQUAL, yyline, yycolumn); }
"<="                { return new Symbol(LexicalUnit.SMALEQ, yyline, yycolumn); }
"<"                 { return new Symbol(LexicalUnit.SMALLER, yyline, yycolumn); }
"While"             { return new Symbol(LexicalUnit.WHILE, yyline, yycolumn); }
"Do"                { return new Symbol(LexicalUnit.DO, yyline, yycolumn); }
"Print"             { return new Symbol(LexicalUnit.PRINT, yyline, yycolumn); }
"Input"             { return new Symbol(LexicalUnit.INPUT, yyline, yycolumn); }

{NUMBER}            { return new Symbol(LexicalUnit.NUMBER, yyline, yycolumn, Integer.parseInt(yytext())); }
{VARNAME}           { symbolTable.putIfAbsent(yytext(), yyline + 1); return new Symbol(LexicalUnit.VARNAME, yyline, yycolumn, yytext()); }
{PROGNAME}          { return new Symbol(LexicalUnit.PROGNAME, yyline, yycolumn, yytext()); }

{WHITESPACE}        { }

"!!"[^!]*"!!"       { /* long comment, ignore */ }
"$".*               { /* short comment, ignore */ }

.                   { System.err.println("Unknown symbol: " + yytext()); }




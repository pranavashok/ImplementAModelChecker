lexer grammar LTLLexer;

// LOGIC
TRUE       : 'tt' | 'true' | '1';
FALSE      : 'ff' | 'false' | '0';

// Logical Unary
NOT        : '!' | 'NOT';

// Logical Binary
IMP        : '->' | '-->' | '=>' | '==>' | 'IMP';
BIIMP      : '<->' | '<=>' | 'BIIMP';
XOR        : '^' | 'XOR' | 'xor';

// Logical n-ary
AND        : '&&' | '&' | 'AND' ;
OR         : '||' | '|' | 'OR' ;

// Modal Unary
FINALLY    : 'F';
GLOBALLY   : 'G';
NEXT       : 'X';

// Modal Binary
UNTIL      : 'U';
WUNTIL     : 'W';
RELEASE    : 'R';
SRELEASE   : 'M';

// MISC
LPAREN     : '(';
RPAREN     : ')';

// Need to be at the bottom because of precedence rules
VARIABLE   : [a-z_][a-zA-Z_0-9]*;

fragment
WHITESPACE : [ \t\n\r\f]+;

SKIP_DEF   : WHITESPACE -> skip;

SKIP_FREQ  : WHITESPACE -> skip;

ERROR : . ;

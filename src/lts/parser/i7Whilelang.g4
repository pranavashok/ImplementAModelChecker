grammar i7Whilelang;

program: declarationList? initializationList? seqProcess;

declarationList: DECL declaration (',' declaration)* ';';
declaration: integerDecl;
integerDecl: ID RANGE;

initializationList: assignment*;

seqProcess: process (';'? seqProcess)* ;

process : BEGIN seqStatement END;

seqStatement: labelstatement+;

labelstatement: (label LABELSEP)? statement;

statement: assignment                                  # attrib
         | 'skip' ';'                                  # skip
         | 'if' bool 'then' statement 'else' statement # if
         | 'while' bool 'do' statement                 # while
         | 'await' bool ';'                            # await
         | 'assert' bool ';'                           # assert
         | 'print' Text ';'                            # print
         | 'write' expression ';'                      # write
         | '{' seqStatement '}'                        # block
         ;

assignment: ID ASSIGN expression ';';

expression: INT                                        # int
          | ID                                         # id
          | expression '*' expression                  # binOp
          | expression ('+'|'-') expression            # binOp
          | '(' expression ')'                         # expParen
          ;

bool: ('true'|'false')                                 # boolean
    | expression '=' expression                        # relOp
    | expression '<=' expression                       # relOp
    | 'not' bool                                       # not
    | bool 'and' bool                                  # and
    | '(' bool ')'                                     # boolParen
    ;

label: LABEL;

BEGIN : 'beginprocess';
END : 'endprocess';
DECL : 'decl';
INT: [0-9];
ID: [a-zA-Z][a-zA-Z0-9]*;
LABEL: '_'[a-zA-Z][a-zA-Z0-9]*;
Text: '"' ~["\r\n]+ '"';
RANGE: '[' [0-9]+ ']';
ASSIGN: ':=';
LABELSEP: ':';
Space: [ \t\n\r] -> skip;

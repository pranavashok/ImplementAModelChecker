// forked from https://github.com/lrlucena/whilelang
grammar i7Whilelang;

program: declarationList? initializationList? seqProcess atomicPropositions?;

declarationList: DECL declaration (',' declaration)* ';';
declaration: integerDecl;
integerDecl: ID '[' range ']';
range: INT;

initializationList: assignment*;

atomicPropositions: label LABELSEP bool;

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
ASSIGN: ':=';
LABELSEP: ':';
Space: [ \t\n\r] -> skip;

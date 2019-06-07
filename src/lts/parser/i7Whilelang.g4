grammar i7Whilelang;

program: declarationList? seqProcess;

declarationList: DECL declaration (',' declaration)* ';';

declaration: booleanDecl | integerDecl;
integerDecl: ID RANGE;
booleanDecl: ID;

seqProcess: process (';'? seqProcess)* ;

process : BEGIN seqStatement END;

seqStatement: labelstatement (';' labelstatement)* ;

labelstatement: (label LABELSEP)? statement;

statement: ID ASSIGN expression                        # attrib
         | 'skip'                                      # skip
         | 'if' bool 'then' statement 'else' statement # if
         | 'while' bool 'do' statement                 # while
         | 'await' bool                                # await
         | 'assert' bool                               # assert
         | 'print' Text                                # print
         | 'write' expression                          # write
         | '{' seqStatement '}'                        # block
         ;

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

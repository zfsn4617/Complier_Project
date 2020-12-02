%{
    #include "common.h"
    #define YYSTYPE TreeNode *  
    TreeNode* root;
    extern int lineno;
    int yylex();
    int yyerror( char const * );
%}
%token T_CHAR T_BOOL T_INT

%token IDENTIFIER INTEGER CHAR BOOL STRING

%token IF ELSE

%token LPAREN RPAREN LBRACE RBRACE LSQUBR RSQUBR SEMICOLON COMMA

%token EQ NE GE LE GT LT ASSIGN PLUS SUB MUL DIV REM

%token WHILE FOR RETURN

%token BREAK CASE CONST CONTINUE DEFAULT DELETE DO ENUM FALSE NEW NULLPTR STRUCT SWITCH TRUE UNION VOID

%right ASSIGN

%left OR

%left AND

%left EQ NE GE LE GT LT 

%left ADD SUB 

%left MUL DIV REM

%left NOT

%%

program
: statements { root = new TreeNode(0, NODE_PROG); root->addChild($1);};

block
: LBRACE statements RBRACE { $$ = $1; };

statements
:  statement { $$ = $1;}
|  statements statement { $$ = $1; $$->addSibling($2);}
;

statement
: SEMICOLON  { $$ = new TreeNode(lineno, NODE_STMT); $$->stype = STMT_SKIP;}
| declaration SEMICOLON { $$ = $1;}
| assign_expr SEMICOLON { $$ = $1;}
| expr SEMICOLON { $$ = $1; } 
| if_stmt { $$ = $1; }
| for_stmt { $$ = $1; }
| while_stmt { $$ = $1; }
| return_stmt { $$ = $1; }
| block { $$ = $1; }
;

declaration
: T IDENTIFIER ASSIGN expr{  // declare and init
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    node->addChild($4);
    $$ = node;   
} 
| T IDENTIFIER {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_DECL;
    node->addChild($1);
    node->addChild($2);
    $$ = node;   
}
;

T: T_INT {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_INT;} 
| T_CHAR {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_CHAR;}
| T_BOOL {$$ = new TreeNode(lineno, NODE_TYPE); $$->type = TYPE_BOOL;}
;

expr
: IDENTIFIER { $$ = $1; }
| INTEGER { $$ = $1; }
| CHAR { $$ = $1; }
| STRING { $$ = $1; }
| expr ADD expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_ADD;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr SUB expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_SUB;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr MUL expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_MUL;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr DIV expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_DIV;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr REM expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_REM;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr EQ expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_EQ;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr NE expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_NE;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr LE expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_LE;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr GE expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_GE;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr LT expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_LT;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr GT expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_GT;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr AND expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_AND;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| expr OR expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_OR;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
}
| NOT expr {
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_NOT;
    node->addChild($2);
    $$ = node;   
}
| SUB expr {
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_MINUS;
    node->addChild($2);
    $$ = node;   
}
| ADD expr {
    TreeNode* node = new TreeNode($1->lineno, NODE_EXPR);
    node->stype = STMT_EXPR;
    node->optype = OP_PLUS;
    node->addChild($2);
    $$ = node;   
}
;

left_val
: IDENTIFIER  {$$ = $1; };

assign_expr
: left_val ASSIGN expr {
    TreeNode* node = new TreeNode($2->lineno, NODE_STMT);
    node->stype = STMT_ASSIGN;
    node->addChild($1);
    node->addChild($3);
    $$ = node;   
};

if_stmt
:  IF LPAREN expr RPAREN statement {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_IF;
    node->addChild($3);
    node->addChild($5);
    $$ = node;   
};

for_stmt
: FOR LPAREN expr SEMICOLON expr SEMICOLON expr RPAREN statement
{
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_FOR;
    node->addChild($3);
    node->addChild($5);
    node->addChild($7);
    node->addChild($9);
    $$ = node;   
};

while_stmt
: WHILE LPAREN expr RPAREN statement {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_WHILE;
    node->addChild($3);
    node->addChild($5);
    $$ = node;   
};

return_stmt
: RETURN SEMICOLON {
    TreeNode* node = new TreeNode($1->lineno, NODE_STMT);
    node->stype = STMT_RETURN;
    $$ = node;   
};

%%

int yyerror(char const* message)
{
  cout << message << " at line " << lineno << endl;
  return -1;
}

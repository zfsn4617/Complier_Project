%option nounput
%{
#include "common.h"
#include "main.tab.h"  // yacc header
int lineno=1;
%}
%{
	int chars=0,words=0,lines=0,numbers=0;
	list<pair<int, string> > lexeme;
	stack<int> id_section;
	map<int,string> typelist;
	map<pair<int, string>, int> idlist;
	int ids=0;
%}
BLOCKCOMMENT \/\*([^\*^\/]*|[\*^\/*]*|[^\**\/]*)*\*\/
LINECOMMENT \/\/[^\n]*
EOL	(\r\n|\r|\n)
WHILTESPACE [[:blank:]]

INTEGER [0-9]+

CHAR \'.?\'
STRING \".+\"

IDENTIFIER [[:alpha:]_][[:alpha:][:digit:]_]*

LPAREN	\(
RPAREN	\)
LBRACE	\{
RBRACE	\}
LSQUBR	\[
RSQUBR	\]
SEMICOLON	\;
COMMA	,

EQ	==
NE	!=
GE	>=
LE	<=
GT	>
LT	<
ASSIGN	=
ADD	\+
SUB	-
MUL	\*
DIV	\/
REM	%
AND	&&
OR	\|\|
NOT	!

T_BOOL		bool
BREAK		break
CASE		case
T_CHAR		char
CONST		const
CONTINUE	continue
DEFAULT		default
DELETE		delete
DO		do
ELSE		else
ENUM		enum
FALSE		false
FOR		for
IF		if
T_INT		int
NEW		new
NULLPTR		nullptr
RETURN		return
STRUCT		struct
SWITCH		switch
TRUE		true
UNION		union
VOID		void
WHILE		while

%%

{BLOCKCOMMENT}  /* do nothing */
{LINECOMMENT}  /* do nothing */

{WHILTESPACE} /* do nothing */

{EOL} {lineno++;}

{LPAREN} {
    TreeNode* node = new TreeNode(lineno, NODE_SIGN);
    node->var_name = yytext[1];
    yylval = node;
    return LPAREN;
}
{RPAREN} {
    TreeNode* node = new TreeNode(lineno, NODE_SIGN);
    node->var_name = yytext[1];
    yylval = node;
    return RPAREN;
}
{LBRACE} {
    TreeNode* node = new TreeNode(lineno, NODE_SIGN);
    node->var_name = yytext[1];
    yylval = node;
    return LBRACE;
}
{RBRACE} {
    TreeNode* node = new TreeNode(lineno, NODE_SIGN);
    node->var_name = yytext[1];
    yylval = node;
    return RBRACE;
}
{LSQUBR} {
    TreeNode* node = new TreeNode(lineno, NODE_SIGN);
    node->var_name = yytext[1];
    yylval = node;
    return LSQUBR;
}
{RSQUBR} {
    TreeNode* node = new TreeNode(lineno, NODE_SIGN);
    node->var_name = yytext[1];
    yylval = node;
    return RSQUBR;
}
{SEMICOLON} {
    TreeNode* node = new TreeNode(lineno, NODE_SIGN);
    node->var_name = yytext[1];
    yylval = node;
    return SEMICOLON;
}
{COMMA} {
    TreeNode* node = new TreeNode(lineno, NODE_SIGN);
    node->var_name = yytext[1];
    yylval = node;
    return COMMA;
}
		
{EQ} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "EQ";
    yylval = node;
    return EQ;
}
{NE} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "NE";
    yylval = node;
    return NE;
}
{GE} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "GE";
    yylval = node;
    return GE;
}
{LE} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "LE";
    yylval = node;
    return LE;
}
{GT} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "GT";
    yylval = node;
    return GT;
}
{LT} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "LT";
    yylval = node;
    return LT;
}
{ASSIGN} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "ASSIGN";
    yylval = node;
    return ASSIGN;
}
{ADD} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "ADD";
    yylval = node;
    return ADD;
}
{SUB} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "SUB";
    yylval = node;
    return SUB;
}
{MUL} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "MUL";
    yylval = node;
    return MUL;
}
{DIV} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "DIV";
    yylval = node;
    return DIV;
}
{REM} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "REM";
    yylval = node;
    return REM;
}
{AND} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "AND";
    yylval = node;
    return AND;
}
{OR} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "OR";
    yylval = node;
    return OR;
}
{NOT} {
    TreeNode* node = new TreeNode(lineno, NODE_OP);
    node->var_name = "NOT";
    yylval = node;
    return NOT;
}
		
{T_BOOL} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "T_BOOL";
    node->type = TYPE_BOOL;
    yylval = node;
    return T_BOOL;
}
{BREAK} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "BREAK";
    yylval = node;
    return BREAK;
}
{CASE} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "CASE";
    yylval = node;
    return CASE;
}
{T_CHAR} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "T_CHAR";
    node->type = TYPE_CHAR;
    yylval = node;
    return T_CHAR;
}
{CONST} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "CONST";
    yylval = node;
    return CONST;
}
{CONTINUE} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "CONTINUE";
    yylval = node;
    return CONTINUE;
}
{DEFAULT} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "DEFAULT";
    yylval = node;
    return DEFAULT;
}
{DELETE} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "DELETE";
    yylval = node;
    return DELETE;
}
{DO} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "DO";
    yylval = node;
    return DO;
}
{ELSE} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "ELSE";
    yylval = node;
    return ELSE;
}
{ENUM} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "ENUM";
    yylval = node;
    return ENUM;
}
{FALSE} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "FALSE";
    yylval = node;
    return FALSE;
}
{FOR} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "FOR";
    yylval = node;
    return FOR;
}
{IF} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "IF";
    yylval = node;
    return IF;
}
{T_INT} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "T_INT";
    node->type = TYPE_INT;
    yylval = node;
    return T_INT;
}
{NEW} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "NEW";
    yylval = node;
    return NEW;
}
{NULLPTR} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "NULLPTR";
    yylval = node;
    return NULLPTR;
}
{RETURN} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "RETURN";
    yylval = node;
    return RETURN;
}
{STRUCT} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "STRUCT";
    yylval = node;
    return STRUCT;
}
{SWITCH} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "SWITCH";
    yylval = node;
    return SWITCH;
}
{TRUE} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "TRUE";
    yylval = node;
    return TRUE;
}
{UNION} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "UNION";
    yylval = node;
    return UNION;
}
{VOID} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "VOID";
    yylval = node;
    return VOID;
}
{WHILE} {
    TreeNode* node = new TreeNode(lineno, NODE_KEY);
    node->var_name = "WHILE";
    yylval = node;
    return WHILE;
}

{INTEGER} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_INT;
    node->int_val = atoi(yytext);
    yylval = node;
    return INTEGER;
}

{CHAR} {
    TreeNode* node = new TreeNode(lineno, NODE_CONST);
    node->type = TYPE_CHAR;
    node->int_val = yytext[1];
    yylval = node;
    return CHAR;
}

{IDENTIFIER} {
    TreeNode* node = new TreeNode(lineno, NODE_VAR);
    node->var_name = string(yytext);
    yylval = node;
    return IDENTIFIER;
}

. {
    cerr << "[line "<< lineno <<" ] unknown character:" << yytext << endl;
}

%%



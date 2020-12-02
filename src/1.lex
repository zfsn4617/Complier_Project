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
OR	||
NOT	!

ASM		asm
AUTO		auto
T_BOOL		bool
BREAK		break
CASE		case
CATCH		catch
T_CHAR		char
CLASS		class
CONST		const
CONST_CAST	const_cast
CONTINUE	continue
DEFAULT		default
DELETE		delete
DO		do
DOUBLE		double
DYNAMIC_CAST	dynamic_cast
ELSE		else
ENUM		enum
EXPLICIT	explicit
EXPORT		export
EXTERN		extern
FALSE		false
FLOAT		float
FOR		for
FRIEND		friend
GOTO		goto
IF		if
INLINE		inline
T_INT		int
LONG		long
MUTABLE		mutable
NAMESPACE	namespace
NEW		new
NULLPTR		nullptr
OPERATOR	operator
PRIVATE		private
PROTECTED	protected
PUBLIC		public
REGISTER	register
REINTERPRET_CAST	reinterpret_cast
RETURN		return
SHORT		short
SIGNED		signed
SIZEOF		sizeof
STATIC		static
STATIC_CAST	static_cast
STRUCT		struct
SWITCH		switch
TEMPLATE	template
THIS		this
THROW		throw
TRUE		true
TRY		try
TYPEDEF		typedef
TYPEID		typeid
TYPENAME	typename
UNION		union
UNSIGNED	unsigned
USING		using
VIRTUAL		virtual
VOID		void
VOLATILE	volatile
WCHAR_T		wchar_t
WHILE		while

%%

{BLOCKCOMMENT}  /* do nothing */
{LINECOMMENT}  /* do nothing */

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

{WHILTESPACE} /* do nothing */

{EOL} lineno++;

. {
    cerr << "[line "<< lineno <<" ] unknown character:" << yytext << endl;
}

{LPAREN}	{lexeme.push_back(pair<int, string>(101, yytext));}
{RPAREN}	{lexeme.push_back(pair<int, string>(102, yytext));}
{LBRACE}	{lexeme.push_back(pair<int, string>(103, yytext));
		 id_section.push(lines);}
{RBRACE}	{lexeme.push_back(pair<int, string>(104, yytext));
		 id_section.pop();}
{LSQUBR}	{lexeme.push_back(pair<int, string>(105, yytext));}
{RSQUBR}	{lexeme.push_back(pair<int, string>(106, yytext));}
{SEMICOLON}	{lexeme.push_back(pair<int, string>(107, yytext));}
{COMMA}		{lexeme.push_back(pair<int, string>(108, yytext));}

{EQ}		{lexeme.push_back(pair<int, string>(201, yytext));}
{NE}		{lexeme.push_back(pair<int, string>(212, yytext));}
{GE}		{lexeme.push_back(pair<int, string>(202, yytext));}
{LE}		{lexeme.push_back(pair<int, string>(203, yytext));}
{GT}		{lexeme.push_back(pair<int, string>(204, yytext));}
{LT}		{lexeme.push_back(pair<int, string>(205, yytext));}
{ASSIGN}	{lexeme.push_back(pair<int, string>(206, yytext));}
{ADD}		{lexeme.push_back(pair<int, string>(207, yytext));}
{SUB}		{lexeme.push_back(pair<int, string>(208, yytext));}
{MUL}		{lexeme.push_back(pair<int, string>(209, yytext));}
{DIV}		{lexeme.push_back(pair<int, string>(210, yytext));}
{REM}		{lexeme.push_back(pair<int, string>(211, yytext));}
{AND}		{lexeme.push_back(pair<int, string>(212, yytext));}
{OR}		{lexeme.push_back(pair<int, string>(213, yytext));}
{NOT}		{lexeme.push_back(pair<int, string>(214, yytext));}

{ASM}		{lexeme.push_back(pair<int,string>(301,yytext));}
{AUTO}		{lexeme.push_back(pair<int,string>(302,yytext));}
{T_BOOL}	{lexeme.push_back(pair<int,string>(303,yytext));}
{BREAK}		{lexeme.push_back(pair<int,string>(304,yytext));}
{CASE}		{lexeme.push_back(pair<int,string>(305,yytext));}
{CATCH}		{lexeme.push_back(pair<int,string>(306,yytext));}
{T_CHAR}	{lexeme.push_back(pair<int,string>(307,yytext));}
{CLASS}		{lexeme.push_back(pair<int,string>(308,yytext));}
{CONST}		{lexeme.push_back(pair<int,string>(309,yytext));}
{CONST_CAST}	{lexeme.push_back(pair<int,string>(310,yytext));}
{CONTINUE}	{lexeme.push_back(pair<int,string>(311,yytext));}
{DEFAULT}	{lexeme.push_back(pair<int,string>(312,yytext));}
{DELETE}	{lexeme.push_back(pair<int,string>(313,yytext));}
{DO}		{lexeme.push_back(pair<int,string>(314,yytext));}
{DOUBLE}	{lexeme.push_back(pair<int,string>(315,yytext));}
{DYNAMIC_CAST}	{lexeme.push_back(pair<int,string>(316,yytext));}
{ELSE}		{lexeme.push_back(pair<int,string>(317,yytext));}
{ENUM}		{lexeme.push_back(pair<int,string>(318,yytext));}
{EXPLICIT}	{lexeme.push_back(pair<int,string>(319,yytext));}
{EXPORT}	{lexeme.push_back(pair<int,string>(320,yytext));}
{EXTERN}	{lexeme.push_back(pair<int,string>(321,yytext));}
{FALSE}		{lexeme.push_back(pair<int,string>(322,yytext));}
{FLOAT}		{lexeme.push_back(pair<int,string>(323,yytext));}
{FOR}		{lexeme.push_back(pair<int,string>(324,yytext));}
{FRIEND}	{lexeme.push_back(pair<int,string>(325,yytext));}
{GOTO}		{lexeme.push_back(pair<int,string>(326,yytext));}
{IF}		{lexeme.push_back(pair<int,string>(327,yytext));}
{INLINE}	{lexeme.push_back(pair<int,string>(328,yytext));}
{T_INT}		{lexeme.push_back(pair<int,string>(329,yytext));}
{LONG}		{lexeme.push_back(pair<int,string>(330,yytext));}
{MUTABLE}	{lexeme.push_back(pair<int,string>(331,yytext));}
{NAMESPACE}	{lexeme.push_back(pair<int,string>(332,yytext));}
{NEW}		{lexeme.push_back(pair<int,string>(333,yytext));}
{NULLPTR}	{lexeme.push_back(pair<int,string>(334,yytext));}
{OPERATOR}	{lexeme.push_back(pair<int,string>(334,yytext));}
{PRIVATE}	{lexeme.push_back(pair<int,string>(335,yytext));}
{PROTECTED}	{lexeme.push_back(pair<int,string>(336,yytext));}
{PUBLIC}	{lexeme.push_back(pair<int,string>(337,yytext));}
{REGISTER}	{lexeme.push_back(pair<int,string>(338,yytext));}
{REINTERPRET_CAST}	{lexeme.push_back(pair<int,string>(339,yytext));}
{RETURN}	{lexeme.push_back(pair<int,string>(340,yytext));}
{SHORT}		{lexeme.push_back(pair<int,string>(341,yytext));}
{SIGNED}	{lexeme.push_back(pair<int,string>(342,yytext));}
{SIZEOF}	{lexeme.push_back(pair<int,string>(343,yytext));}
{STATIC}	{lexeme.push_back(pair<int,string>(344,yytext));}
{STATIC_CAST}	{lexeme.push_back(pair<int,string>(345,yytext));}
{STRUCT}	{lexeme.push_back(pair<int,string>(346,yytext));}
{SWITCH}	{lexeme.push_back(pair<int,string>(347,yytext));}
{TEMPLATE}	{lexeme.push_back(pair<int,string>(348,yytext));}
{THIS}		{lexeme.push_back(pair<int,string>(349,yytext));}
{THROW}		{lexeme.push_back(pair<int,string>(350,yytext));}
{TRUE}		{lexeme.push_back(pair<int,string>(351,yytext));}
{TRY}		{lexeme.push_back(pair<int,string>(352,yytext));}
{TYPEDEF}	{lexeme.push_back(pair<int,string>(353,yytext));}
{TYPEID}	{lexeme.push_back(pair<int,string>(354,yytext));}
{TYPENAME}	{lexeme.push_back(pair<int,string>(355,yytext));}
{UNION}		{lexeme.push_back(pair<int,string>(356,yytext));}
{UNSIGNED}	{lexeme.push_back(pair<int,string>(357,yytext));}
{USING}		{lexeme.push_back(pair<int,string>(358,yytext));}
{VIRTUAL}	{lexeme.push_back(pair<int,string>(359,yytext));}
{VOID}		{lexeme.push_back(pair<int,string>(360,yytext));}
{VOLATILE}	{lexeme.push_back(pair<int,string>(361,yytext));}
{WCHAR_T}	{lexeme.push_back(pair<int,string>(362,yytext));}
{WHILE}		{lexeme.push_back(pair<int,string>(363,yytext));}


{ID} {
	lexeme.push_back(pair<int, string>(501, yytext));
	map<pair<int, string>, int>::iterator iter_id;
	if (id_section.size() > 0)
	{
		iter_id = idlist.find(pair<int, string>(id_section.top(), yytext));
		if (iter_id == idlist.end())
		{
			pair<int, string> p(id_section.top(), yytext);
			idlist.insert(pair<pair<int, string>, int>(p, ids));
			ids++;
		}
	}
	else
	{
		pair<int, string> p(0, yytext);
		idlist.insert(pair<pair<int, string>, int>(p, ids));
		ids++;
	}
}
{NUMBER}	{lexeme.push_back(pair<int, string>(502, yytext));}

/*{commentbegin} {BEGIN COMMENT; }
<COMMENT>{commentelement} {}
<COMMENT>{commentend} {BEGIN INITIAL; }
{commentline} {BEGIN COMMENTLINE; }
<COMMENTLINE>{commentlineelement} {}
<COMMENTLINE>{line} {BEGIN INITIAL; }*/
%%

void setTypelist()
{
	typelist.insert(pair<int, string>(101, "LPAREN"));
	typelist.insert(pair<int, string>(102, "RPAREN"));
	typelist.insert(pair<int, string>(103, "LBRACE"));
	typelist.insert(pair<int, string>(104, "RBRACE"));
	typelist.insert(pair<int, string>(105, "LSQUBR"));
	typelist.insert(pair<int, string>(106, "RSQUBR"));
	typelist.insert(pair<int, string>(107, "SEMICOLON"));
	typelist.insert(pair<int, string>(108, "COMMA"));

	typelist.insert(pair<int, string>(201, "EQ"));
	typelist.insert(pair<int, string>(212, "NE"));
	typelist.insert(pair<int, string>(202, "GE"));
	typelist.insert(pair<int, string>(203, "LE"));
	typelist.insert(pair<int, string>(204, "GT"));
	typelist.insert(pair<int, string>(205, "LT"));
	typelist.insert(pair<int, string>(206, "ASSIGN"));
	typelist.insert(pair<int, string>(207, "ADD"));
	typelist.insert(pair<int, string>(208, "SUB"));
	typelist.insert(pair<int, string>(209, "MUL"));
	typelist.insert(pair<int, string>(210, "DIV"));
	typelist.insert(pair<int, string>(211, "REM"));
	typelist.insert(pair<int, string>(213, "AND"));
	typelist.insert(pair<int, string>(214, "OR"));
	typelist.insert(pair<int, string>(215, "NOT"));

	typelist.insert(pair<int, string>(301, "ASM"));
	typelist.insert(pair<int, string>(302, "AUTO"));
	typelist.insert(pair<int, string>(303, "T_BOOL"));
	typelist.insert(pair<int, string>(304, "BREAK"));
	typelist.insert(pair<int, string>(305, "CASE"));
	typelist.insert(pair<int, string>(306, "CATCH"));
	typelist.insert(pair<int, string>(307, "T_CHAR"));
	typelist.insert(pair<int, string>(308, "CLASS"));
	typelist.insert(pair<int, string>(309, "CONST"));
	typelist.insert(pair<int, string>(310, "CONST_CAST"));
	typelist.insert(pair<int, string>(311, "CONTINUE"));
	typelist.insert(pair<int, string>(312, "DEFAULT"));
	typelist.insert(pair<int, string>(313, "DELETE"));
	typelist.insert(pair<int, string>(314, "DO"));
	typelist.insert(pair<int, string>(315, "DOUBLE"));
	typelist.insert(pair<int, string>(316, "DYNAMIC_CAST"));
	typelist.insert(pair<int, string>(317, "ELSE"));
	typelist.insert(pair<int, string>(318, "ENUM"));
	typelist.insert(pair<int, string>(319, "EXPLICIT"));
	typelist.insert(pair<int, string>(320, "EXPORT"));
	typelist.insert(pair<int, string>(321, "EXTERN"));
	typelist.insert(pair<int, string>(322, "FALSE"));
	typelist.insert(pair<int, string>(323, "FLOAT"));
	typelist.insert(pair<int, string>(324, "FOR"));
	typelist.insert(pair<int, string>(325, "FRIEND"));
	typelist.insert(pair<int, string>(326, "GOTO"));
	typelist.insert(pair<int, string>(327, "IF"));
	typelist.insert(pair<int, string>(328, "INLINE"));
	typelist.insert(pair<int, string>(329, "T_INT"));
	typelist.insert(pair<int, string>(330, "LONG"));
	typelist.insert(pair<int, string>(331, "MUTABLE"));
	typelist.insert(pair<int, string>(332, "NAMESPACE"));
	typelist.insert(pair<int, string>(333, "NEW"));
	typelist.insert(pair<int, string>(334, "NULLPTR"));
	typelist.insert(pair<int, string>(334, "OPERATOR"));
	typelist.insert(pair<int, string>(335, "PRIVATE"));
	typelist.insert(pair<int, string>(336, "PROTECTED"));
	typelist.insert(pair<int, string>(337, "PUBLIC"));
	typelist.insert(pair<int, string>(338, "REGISTER"));
	typelist.insert(pair<int, string>(339, "REINTERPRET_CAST"));
	typelist.insert(pair<int, string>(340, "RETURN"));
	typelist.insert(pair<int, string>(341, "SHORT"));
	typelist.insert(pair<int, string>(342, "SIGNED"));
	typelist.insert(pair<int, string>(343, "SIZEOF"));
	typelist.insert(pair<int, string>(344, "STATIC"));
	typelist.insert(pair<int, string>(345, "STATIC_CAST"));
	typelist.insert(pair<int, string>(346, "STRUCT"));
	typelist.insert(pair<int, string>(347, "SWITCH"));
	typelist.insert(pair<int, string>(348, "TEMPLATE"));
	typelist.insert(pair<int, string>(349, "THIS"));
	typelist.insert(pair<int, string>(350, "THROW"));
	typelist.insert(pair<int, string>(351, "TRUE"));
	typelist.insert(pair<int, string>(352, "TRY"));
	typelist.insert(pair<int, string>(353, "TYPEDEF"));
	typelist.insert(pair<int, string>(354, "TYPEID"));
	typelist.insert(pair<int, string>(355, "TYPENAME"));
	typelist.insert(pair<int, string>(356, "UNION"));
	typelist.insert(pair<int, string>(357, "UNSIGNED"));
	typelist.insert(pair<int, string>(358, "USING"));
	typelist.insert(pair<int, string>(359, "VIRTUAL"));
	typelist.insert(pair<int, string>(360, "VOID"));
	typelist.insert(pair<int, string>(361, "VOLATILE"));
	typelist.insert(pair<int, string>(362, "WCHAR_T"));
	typelist.insert(pair<int, string>(363, "WHILE"));

	typelist.insert(pair<int, string>(501, "ID"));
	typelist.insert(pair<int, string>(502, "NUMBER"));

	typelist.insert(pair<int, string>(601, "LINES"));
}
int getNum(string s)
{
	int temp = 0;
	for (int i = 0; s[i] != 0; i++)
	{
		temp *= 10;
		temp += s[i] - '0';
	}
	return temp;
}
int main() {
	yyFlexLexer lexer;
	lexer.yylex();
	setTypelist();
	list<pair<int, string> >::iterator iter;
	map<int, string>::iterator iter2;
	map<pair<int, string>, int>::iterator iter_id;
	iter = lexeme.begin();
	int i = 0;
	lines = 0;   //clear variable lines
	for (i = 0; i < id_section.size(); i++)    //clear the id_section
	{
		id_section.pop();
	}
	while (iter != lexeme.end())
	{
		int& num = iter->first;
		string& str = iter->second;
		iter2 = typelist.find(num);
		if (iter2 != typelist.end())
		{
			if (num < 600)   //remove \n
			{
				cout.setf(ios::left);
				cout << setw(16) << iter2->second << setw(16) << str;
				switch (num)
				{
				case 501:  //identifier
					int temp;
					if (id_section.size() == 0)
						temp = 0;
					else
						temp = id_section.top();
					iter_id = idlist.find(pair<int, string>(temp, str));
					if (iter_id != idlist.end())
					{
						cout.setf(ios::left);
						cout << iter_id->second;
					}
					break;
				case 502:  //number
					cout << getNum(str);
					break;
				case 103:  //LBRACE
					id_section.push(lines);
					break;
				case 104:
					id_section.pop();
					break;

				}

				cout << endl;
			}
			else
				lines++;
		}
		else
			cout << "Wrong!" << endl;
		iter++;
	}
	return 0;
}

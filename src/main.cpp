#include "common.h"
#include <fstream>

extern TreeNode* root;
extern FILE* yyin;
extern int yyparse();

using namespace std;
int main(int argc, char* argv[])
{
    TYPE_INT = new Type(VALUE_INT);
    TYPE_CHAR = new Type(VALUE_CHAR);
    TYPE_BOOL = new Type(VALUE_BOOL);
    TYPE_STRING = new Type(VALUE_STRING);
    if (argc == 2)
    {
        FILE* fin = fopen(argv[1], "r");
        if (fin != nullptr)
        {
            yyin = fin;
        }
        else
        {
            cerr << "failed to open file: " << argv[1] << endl;
        }
    }
    yyparse();
    if (root != NULL) {
        root->genNodeId();
        root->printAST();   //lab5   问题：遍历树的算法，根据类型约束语法约束
        //root->check();    //lab6
        //root->genASM();   //lab7
    }
    return 0;
}

#ifndef TREE_H
#define TREE_H

#include "pch.h"
#include "type.h"

enum NodeType
{
    NODE_CONST,
    NODE_VAR,
    NODE_EXPR,
    NODE_TYPE,
    NODE_ASSIGN,
    NODE_STMT,
    NODE_PROG,
    NODE_SIGN,
    NODE_OP,
    NODE_KEY
};

enum OperatorType
{
    OP_ADD,
    OP_SUB,
    OP_MUL,
    OP_DIV,
    OP_REM,
    OP_EQ,
    OP_NE,
    OP_LE,
    OP_GE,
    OP_LT,
    OP_GT,
    OP_AND,
    OP_OR,
    OP_NOT,
    OP_PLUS,
    OP_MINUS
};

enum StmtType {
    STMT_SKIP,
    STMT_DECL,
    STMT_ASSIGN,
    STMT_EXPR,
    STMT_IF,
    STMT_FOR,
    STMT_WHILE,
    STMT_RETURN,
    STMT_BLOCK
}
;
extern int nodeCount;
struct TreeNode {
public:
    int nodeID;  // ������ҵ��������
    int lineno;  //�к�
    NodeType nodeType;

    TreeNode* child = nullptr;
    TreeNode* sibling = nullptr;

    void addChild(TreeNode*);
    void addSibling(TreeNode*);

    void printNodeInfo();   //����ڵڼ��е���Ϣ
    void printChildrenId();  //����ӽڵ㼰����Ϣ

    void printAST(); // ������Լ� + �����ǵ�id����������ÿ���������AST��
    void printSpecialInfo();

    void genNodeId();   //Ϊÿ���ڵ�����һ��������ID

public:
    OperatorType optype;  // ����Ǳ��ʽ
    Type* type;  // ���������͡����ʽ��㣬�����͡�
    StmtType stype;
    int int_val;
    char ch_val;
    bool b_val;
    string str_val;
    string var_name;
public:
    static string nodeType2String(NodeType type);
    static string opType2String(OperatorType type);
    static string sType2String(StmtType type);

public:
    TreeNode(int lineno, NodeType type);
};
extern TreeNode* root;

#endif

#pragma once
#ifndef TYPESYSTEM_H
#define TYPESYSTEM_H
#include "./pch.h"
using namespace std;

enum ValueType
{
    VALUE_BOOL,
    VALUE_INT,
    VALUE_CHAR,
    VALUE_STRING,
    COMPOSE_STRUCT,
    COMPOSE_UNION,
    COMPOSE_FUNCTION
};

class Type
{
public:
    ValueType type;
    Type(ValueType valueType);
public:
    /* �����Ҫ��Ƹ�������ϵͳ�Ļ��������޸���һ���� */
    ValueType* childType; // for union or struct
    ValueType* paramType, retType; // for function

    void addChild(Type* t);
    void addParam(Type* t);
    void addRet(Type* t);
public:
    ValueType* sibling;
public:
    string getTypeInfo();
};

// ���ü�������Type�����Խ�ʡ�ռ俪��
extern Type* TYPE_INT;
extern Type* TYPE_CHAR;
extern Type* TYPE_BOOL;
extern Type* TYPE_STRING;

int getSize(Type* type);

#endif

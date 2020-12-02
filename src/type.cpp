#include "type.h"

Type::Type(ValueType valueType) {
    this->type = valueType;
}
Type* TYPE_INT;
Type* TYPE_CHAR;
Type* TYPE_BOOL;
Type* TYPE_STRING;
string Type::getTypeInfo() {
    switch (this->type) {
    case VALUE_BOOL:
        return "bool";
    case VALUE_INT:
        return "int";
    case VALUE_CHAR:
        return "char";
    case VALUE_STRING:
        return "string";
    default:
        cerr << "shouldn't reach here, typeinfo";
        assert(0);
    }
    return "?";
}

module bddl.parser;

import bddl.lexer;

class BinaryDataDescriptor
{
    string name;
    BinaryDataDescriptor[] childs;
}

struct Bddl
{
    BinaryDataDescriptor[] structs;
    string[ulong][string] enums;
    BinaryDataDescriptor main;
}

class ConditionalBDD : public BinaryDataDescriptor
{
}




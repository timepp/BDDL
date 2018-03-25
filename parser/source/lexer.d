module bddl.lexer;

import std.array;
import std.variant;
import core.stdc.ctype;
import std.algorithm;

enum TokenType
{
    Symbol, Number, String, Operator, Other
}

struct Token
{
    TokenType type;
    string val;
}

bool isValidSymbolChar(char ch)
{
    return isalnum(ch) || ch == '_';
}

bool isValidSymbolLeadingChar(char ch)
{
    return isalpha(ch) || ch == '_';
}

// This function leaves string and number as is. i.e. won't parse escape char inside string and won't parse number to integral types.
Token[] tokenize(string str)
{
    Token[] result;
    enum ParseState {
        InString,
        InStringEscapeSequence,
        InComment,
        InSymbol,
        InNumber,
        None
    }

    ParseState state = ParseState.None;

    size_t i = 0;
    size_t token_start = 0;
    while (i < str.length) 
    {
        if (state == ParseState.None)
        {
            if (str[i] == '\"')
            {
                i++;
                token_start = i;
                state = ParseState.InString;
            }
            else if (isdigit(str[i]))
            {
                token_start = i;
                i++;
                state = ParseState.InNumber;
            }
            else if (i+1 < str.length && str[i..i+2] == "//")
            {
                state = ParseState.InComment;
                i += 2;
            }
            else if (isspace(str[i]))
            {
                i++;
            }
            else if (isValidSymbolLeadingChar(str[i]))
            {
                token_start = i;
                i++;
                state = ParseState.InSymbol;
            }
            else if (i+1 < str.length && ![">=", "<=", "==", "<>"].find(str[i..i+1]).empty)
            {
                result ~= Token(TokenType.Operator, str[i..i+2]);
                i += 2;
            }
            else if (!"+-*/><".find(str[i]).empty)
            {
                result ~= Token(TokenType.Operator, str[i..i+1]);
                i++;
            }
            else
            {
                result ~= Token(TokenType.Other, str[i..i+1]);
                i++;
            }
        }
        else if (state == ParseState.InComment)
        {
            if (str[i] == '\n') state = ParseState.None;
            i++;
        }
        else if (state == ParseState.InString)
        {
            if (str[i] == '\\')
            {
                state = ParseState.InStringEscapeSequence;
            }
            else if (str[i] == '\"') 
            {
                state = ParseState.None;
                result ~= Token(TokenType.String, str[token_start..i]);
            }
            i++;
        }
        else if (state == ParseState.InStringEscapeSequence)
        {
            state = ParseState.InString;
            i++;
        }
        else if (state == ParseState.InSymbol)
        {
            if (isValidSymbolChar(str[i]))
            {
                i++;
            }
            else
            {
                state = ParseState.None;
                result ~= Token(TokenType.Symbol, str[token_start..i]);
            }
        }
        else if (state == ParseState.InNumber)
        {
            if (isdigit(str[i]) ||
                (str[i] == 'x' || str[i] == 'X') && str[token_start] == '0' && i == token_start+1)
            {
                i++;
            }
            else
            {
                state = ParseState.None;
                result ~= Token(TokenType.Number, str[token_start..i]);
            }
        }
    }
    return result;
}

unittest
{
    struct TestCase
    {
        string input;
        Token[] expected;
    }

    TestCase[] cases = [
        TestCase("", []),
        TestCase("symbol\n", [Token(TokenType.Symbol, "symbol")])
    ];

    foreach (c; cases)
    {
        auto result = tokenize(c.input);
        assert(result == c.expected);
    }

    foreach (c; cases)
    {
        
    }
}

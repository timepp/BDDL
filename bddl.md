# overview


# keywords
import
struct
enum
optional
offset
if
else
as
byte
int16LE int16BE uint16LE uint16BE int32LE int32BE uint32LE uint32BE int64LE uint64LE int64BE uint64BE

# import
import "FILENAME"
parse "FILENAME" and merge the information into current scope

# struct
define compound data types

# byte, u?int(16|32|64)(LE|BE)
scalar types

# as
byte[10] as "UTF8"
byte[20] as "UserDefinedParser"
enum apptype {
aaa = 1;
bbb = 2;
};
uint16LE as apptype appType;

# optional
this field is optional

enum BOM {
  byte[] UTF8 = "EF BB BF",
  byte[] UTF16LE = "EE EF",
  byte[] UTF16BE = "EF EE"
};

optional BOM bom;

# enum
give special value a name

# todo
byte[10] marker = "00 01 02 03";

# EBNF

bddl = { statement };

statement = import | enum | struct ; 

struct = "struct", name, "{", { struct | enum | var | offset | if }, "}" ;

var = [optional], type, name, ";"

offset = "@", expression, ":"

if = "if", expression, "{", { var }, "}"

import = "import", string, ";" ;

enum = "enum", name, "{", {enumvar}, "}" ;

enumvar = type, name, "=", expression, ";"

name = /[a-zA-Z][a-zA-Z0-9_]+/

type = basic_type | udt | array;

array = type, "[", expression, "]" | type, "[", "]" ;

udt = struct_name | enum_name;

basic_type = byte int16LE int16BE uint16LE uint16BE int32LE int32BE uint32LE uint32BE int64LE uint64LE int64BE uint64BE; 



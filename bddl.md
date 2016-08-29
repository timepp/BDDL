# keywords
import
struct
enum
optional
if
else
as
byte
int16LE
int16BE
uint16LE
uint16BE
int32LE
int32BE
uint32LE
uint32BE
int64LE
uint64LE
int64BE
uint64BE

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

# enum
give special value a name

# todo
byte[10] marker = "00 01 02 03";

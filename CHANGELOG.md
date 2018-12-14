# CHANGELOG

### 0.8.0 - (2018-12-14)

* __feature__  
  string interpolation  
  the values of variables are substituted into string literals  
  string interpolation works for double-quoted strings and default strings 
  example:
    $object = house
    setup "This is a $(object)."
    # => { setup: "This is a house." }

* __feature__  
  schema definition:  
  if there are more values listed than keys for the schema specifier are defined, then an exception is raised
  if there are less values listed than keys for the schema specifier are defined, then only the keys for the available values will be set 

* __breaking change__, __bugfix__  
  in array definition with schema specifier  
  syntax change: now after colon (:) for defining a hash, there needs to be at least one space character between the colon 
  and the next expression on the same line

* __feature__  
  schema specifiers can now also be defined at the time of use   
  example:  
    persons1 , @schema person(firstname,lastname,age)
      : Harry   | Langemann | 44
      : Susi    | Heimstett | 32
    persons2 , @schema person  
      : Ludwig  | Reinemann | 33

* __feature__  
  anonymous schema specifiers  
  defined when used, defined without a name, for one-time use  
  example:  
    persons , @schema(firstname,lastname,age)  
      : Harry | Langemann | 44

* __breaking change__  
  change of the definition of a schema specifier  
    before : $name(key1,key2,...)  
    now    : @schema name(key1,key2,...)
    this makes it different from variables
  change of the use of a schema specifier
    before : , $name  
    now    : , @schema name
  
* __breaking change__  
  default strings are no longer allowed to begin with one of the following characters: ;$!@&*:,  
  exception is a beginning string interpolation: $(var)
  
* __feature__  
  for a reference (e.g. ref)  
  @merge *ref    : in a hash  
  @insert *ref   : in an array

* __feature__  
  supporting references, definition: &ref, use: *ref
  if a reference is used which was not defined before, then an exception is raised

* __feature__  
  @na directive (na = not available) inside definitions with schema specifiers

* __feature__  
  if a schema specifier is used which was not defined before, then an exception is raised

* __feature__  
  supporting variables, $variable  
  if a variable is used which was not defined before, then an exception is raised

### 0.7.1 - (2018-11-12)

* __bugfix__  
  again an error in escaping single-quoted and double-quoted strings  
  
### 0.7.0 - (2018-11-09)

* __feature__  
  classic Ruby syntax: now the expression can be spread over multiple lines, that means line breaks (newline characters) can occure within the expression

* __bugfix__  
  classic Ruby syntax: the following was not recognized: [k: 'v']

* __feature__  
  escaping in single-quoted and double-quoted strings: \n is now converted to a newline character

* __bugfix__  
  escaping in single-quoted and double-quoted strings was not handled properly  
  there also was a syntax issue
  
### 0.6.1 - (2018-10-27)

* __bugfix__  
  bugs in classic Ruby syntax fixed: [:a], and {a: :b} was not recognized
  
* __change__  
  if @env is not allowed (allow_env: false) then the result will be nil, it was "" before
  if @r is not allowed (context: not set to binding) then the result will be nil, it was "" before
    
* __bugfix__  
  @env: now before and after the environment variable there are space characters allowed, they will be stripped off
    
* __bugfix__  
  now: between the definition of a key and a value there needs to be at least one space character or a block comment  
  before: for example, the definition lkmönnk was converted to { lkm: "önnk" }, now it produces a syntax error  
  the following expressiong for defining a key and a value (symbol) is not valid any more: k:v  
  you would need to write it like k :v  

### 0.6.0 - (2018-10-23)

* __feature__  
  directive @r to evaluate embedded Ruby source code  

* __feature__  
  directive @env to access the value of environment variables  

* __feature__  
  enhancement for the definition of a key of a hash, use single or double quoting to define keys with special symbols or space characters

* __feature__  
  symbols (Ruby symbols) as new basic values  

* __feature__  
  improvements on classic Ruby style  

* __feature__  
  if the definition starts with a hash, then no longer a colon (:) at the beginning is necessary,
  you can right start with the first key  
  that means: the default structure is a hash

* __breaking change__  
  syntax change: now after colon (:) for defining a hash, there needs to be at least one space character between the colon and the key 
  (if it is on the same line)

* __bugfix__  
  if the definition ended without a newline character in some cases this produced errors 

* __bugfix__  
  error in single-quoted and double-quoted string:  
  space characters after first quote character were not considered to be part of the string

### 0.5.1 - (2018-09-12)

* __bugfix__  
  0 and 0d0 was not recognized as an integer, it was recognized as a string ("0","0d0")
  
### 0.5.0 - (2018-09-06)

* some changes and reorganization

### 0.0.1 - (2018-07-20)

* Initial release

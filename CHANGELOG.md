# CHANGELOG

### 0.9.4 - (2025-03-02)

* __feature__  
  schema for single hash definition  
  ~~~
  @schema adr ( 
      firstname , lastname   , age ) /*
  -----------------------------------*/
  addresses  
    hla  @schema adr
      Harry     | Langemann  | 44
    she  @schema adr
      Susi      | Heimstett  | 32
    bme  @schema adr
      Bob       | Meiermann  | 57

  # => { addresses: { hla: { firstname: "Harry", lastname: "Langemann", age: 44 }, she: { firstname: "Susi" , lastname: "Heimstett", age: 32 }, bme: { firstname: "Bob"  , lastname: "Meiermann", age: 57 } } }
  ~~~

### 0.9.3 - (2024-04-30)

* __fix__  
  In version 0.9.2 the embedded Ruby code feature (__@r__ directive) was not working.  

* __feature__  
  __@env__ directive can now handle a default value  
  if the access to environment variables is not allowed (parameter __allow_env__) or if the environment variable does not exist then the default value is returned  
  the default value is a single-quoted or double-quoted string literal  
  ~~~
  host @env( DATABASE_HOST, 'localhost' )

  # if the environment variable DATABASE_HOST does not exist:
  # => { host: 'localhost' }
  ~~~
  double-quoted strings support string interpolation  
  ~~~
  $basename = myproject
  database  @env( DATABASE_NAME, "$(basename)_development" )

  # if the environment variable DATABASE_NAME does not exist:
  # => { database: 'myproject_development' }
  ~~~

* __feature__  
  new syntax style: an array element can be defined as a hash with a key and the related value as an array defined with a schema definition, everything written on the same line  
  all three types of schema definitions are supported: predefined, defined at first time use and anonymous  
  ~~~
  @schema valuedef( name, value )
  all ,
    : vals , @schema valuedef
        : n1 | v1
        : n2 | v2

  # => { all: [ { vals: [ { name: "n1", value: "v1" }, { name: "n2", value: "v2" } ] } ] }
  ~~~
  ~~~
  all ,
    : vals , @schema valuedef( name, value )
        : n1 | v1
        : n2 | v2

  # => { all: [ { vals: [ { name: "n1", value: "v1" }, { name: "n2", value: "v2" } ] } ] }
  ~~~
  ~~~
  all ,
    : vals , @schema( name, value )
        : n1 | v1
        : n2 | v2

  # => { all: [ { vals: [ { name: "n1", value: "v1" }, { name: "n2", value: "v2" } ] } ] }
  ~~~

### 0.9.2 - (2020-07-31)

* __change__  
  the keyword literal for true is changed to __@true__; the old literal __!true__ is still working, but is deprecated  
  the segil __@__ is more consistent with the overall GDS syntax and the leading __!__
  could be confusing because in many programming languages it is used as a logical negation operator  
  the keyword literal for false is changed to __@false__; the old literal __!false__ is still working, but is deprecated  
  the keyword literal for nil is changed to __@nil__; the old literal __!nil__ is still working, but is deprecated  

* __internal changes__  
  different handling of global variables and context (binding) for embedded Ruby

### 0.9.1 - (2019-08-16)

* __feature__  
  new syntax style: an array element can be defined as a hash with a key and an array as a value for the key and one or more values for that array on the same line  
  multiple values for the array has to be separated by a vertical bar symbol (|)
  that means a colon (:) a key and a comma (,) and one or more values on the same line
  ~~~
  valuespecs ,
    : valuelist , 1 | 2 | 3

  # => { valuespecs: [ { valuelist: [ 1, 2, 3 ] } ] }
  ~~~
  ~~~
  valuespecs ,
    : valuelist , 1 | 2 | 3
        4
        5

  # => { valuespecs: [ { valuelist: [ 1, 2, 3, 4, 5 ] } ] }
  ~~~

* __feature__  
  on a nested level: after a comma (,) a colon (:) can follow on the same line  
  that means you can create an array and as the first element of this array a hash, everything on the same line  
  ~~~
  ,
    , :

  # => [ [ {} ] ]
  ~~~
  ~~~
  ,
    , :
        k1
          k11 v11
      b
    a

  # => [ [ { k1: { k11: "v11" } }, "b" ], "a" ]
  ~~~
  additionally a key for the first key-value pair of the hash can also be on this line
  ~~~
  ,
    , : k

  # => [ [ { k: {} } ] ]
  ~~~
  ~~~
  ,
    , : k1
          k11 v11
          k12 v12
        k2
          k21 v21
    a1

  # => [ [ { k1: { k11: "v11", k12: "v12" }, k2: { k21: "v21" } } ], "a1" ]
  ~~~
  a first key-value pair of the hash can be on this line
  ~~~
  ,
    , : k v

  # => [ [ { k: "v" } ] ]
  ~~~
  multiple key-value pairs separated by the vertical bar symbol
  ~~~
  ,
    , : k1 v1 | k2 v2

  # => [ [ { k1: "v1", k2: "v2" } ] ]
  ~~~

* __feature__  
  new syntax style: an array element can be defined as a hash with a key and an array as a value for the key on the same line  
  that means a colon (:) a key and a comma (,) on the same line
  ~~~
  allvalues ,
    : valueset1 ,
        100

  # => { allvalues: [ { valueset1: [ 100 ] } ] }
  ~~~
  ~~~
  k ,
    : k1 ,
        100
        200 | 300
    : k2

  # => { k: [ { k1: [ 100, 200, 300 ] }, { k2: {} } ] }
  ~~~

* __feature__  
  on top level: after a comma (,) a colon (:) can follow on the same line  
  that means you can create an array and as the first element of this array a hash, everything on the same line  
  ~~~
  , :

  # => [ {} ]
  ~~~
  ~~~
  , :
      k1
        k11 v11
    a1

  # => [ { k1: { k11: "v11" } }, "a1" ]
  ~~~
  additionally a key for the first key-value pair of the hash can also be on this line
  ~~~
  , : k

  # => [ { k: {} } ]
  ~~~
  ~~~
  , : k1
        k11 v11
        k12 v12
      k2
        k21 v21
    a1

  # => [ { k1: { k11: "v11", k12: "v12" }, k2: { k21: "v21" } }, "a1" ]
  ~~~
  a first key-value pair of the hash can be on this line
  ~~~
  , : k v

  # => [ { k: "v" } ]
  ~~~
  multiple key-value pairs separated by the vertical bar symbol
  ~~~
  , : k1 v1 | k2 v2

  # => [ { k1: "v1", k2: "v2" } ]
  ~~~

* __bugfix__  
  definition of ruby symbols has been changed, rectified and improved
  single quotes and double quotes have to be balanced or escaped with a backslash character  
  the following definitions are no longer valid   
  ~~~
  :'
  :"
  :'"
  :"'
  :'''
  :"""
  ~~~
  the following definitions are valid
  ~~~
  :'\''
  :"\""
  :'"'
  :"'"
  ~~~
  it is now possible to define an empty symbol by  
  ~~~
  :''
  ~~~
  or
  ~~~
  :""
  ~~~

### 0.9.0 - (2019-07-15)

* __feature__  
  class GDstruct::Creator  
  for the creation of a Ruby Hash/Array structure out of possibly several separated  GDS definition strings  
  arbitrary combination of #include and #include_file method calls  
  final call of #create method  
  ~~~
  # file: data.gdstruct
  &persons persons, @schema person        /*
      firstname   lastname    yearOfBirth */
    : John      | McArthur  | 1987
    : Berry     | Miller    | 1976
  ~~~
  ~~~
  # file: example.rb
  require 'gdstruct'

  creator = GDstruct::Creator.new

  creator.include( <<-EOS )
  @schema person( firstname, lastname, yearOfBirth )
  EOS

  creator.include_file( 'data.gdstruct' )

  creator.include( <<-EOS )
  all
    mypersons *persons
  EOS

  res = creator.create

  # => res = {:persons=>[{:firstname=>"John", :lastname=>"McArthur", :yearOfBirth=>1987}, {:firstname=>"Berry", :lastname=>"Miller", :yearOfBirth=>1976}],
  #           :all=>{:mypersons=>{:persons=>[{:firstname=>"John", :lastname=>"McArthur", :yearOfBirth=>1987}, {:firstname=>"Berry", :lastname=>"Miller", :yearOfBirth=>1976}]}}}
  ~~~

* __feature__  
  on top level: a single key, for the definition of a subhash can now follow a colon (:) on the same line; before you had to put it on a new line   
  the following syntax is allowed now  
  ~~~
  : k
  ~~~
  ~~~
  : k1
      k11 v11
  ~~~
  ~~~
  : k1
      k11 v11
    k2
  ~~~
  ~~~
  : k1
    k2
  ~~~

### 0.8.2 - (2019-03-18)

* __feature__  
  modification for classic Ruby syntax  
  inside an array definition: after the last element a comma (,) is allowed  
  this conforms to the Ruby syntax: a trailing comma is ignored  
  ~~~
  [ 1, 2, ]
  ~~~

* __feature__  
  modification for classic Ruby syntax  
  inside a hash definition: after the last key-value pair a comma (,) is allowed  
  this conforms to the Ruby syntax  
  ~~~
  { k1: 'v1', k2: 'v2', }
  ~~~

* __feature__  
  after an array definition: a single key, for the definition of a subhash can now follow a colon (:) on the same line; before you had to put it on a new line   
  the following syntax is allowed now  
  ~~~
  ,  
    : k
  ~~~
  ~~~
  ,  
    : k1
        k11 v11
  ~~~
  ~~~
  ,  
    : k1
        k11 v11
      k2
  ~~~
  ~~~
  ,  
    : k1
      k2
  ~~~

* __feature__  
  @merge can now follow a colon (:) on the same line, before you had to put it on a new line   
  the following syntax is allowed now  
  ~~~
  init &init
    prio 10
  all,  
    : @merge *init
  ~~~

### 0.8.1 - (2019-02-08)

* __feature__  
  improving the consistency of block comments; they can appear now at the beginning of every line and every construct  
  now they even can appear before a colon (:) for the definition of a hash, and before a comma (,) for the definition of an array  
  you just need to pay attention for the proper indentation  
  the following syntax is allowed now  
  ~~~
  ,
    /* !!! this block comment is allowed now !!! */ ,
      1
      2
  ~~~
  ~~~
  ,
    /* !!! this block comment is allowed now */ :
      k1 v1
  ~~~

* __change__  
  internal change: improving the grammar for the GDS language - reducing the number of rule alternatives  

### 0.8.0 - (2018-12-14)

* __feature__  
  string interpolation  
  the values of variables are substituted into string literals  
  string interpolation works for double-quoted strings and default strings  
  example:  
  ~~~
  $object = house
  setup "This is a $(object)."
  # => { setup: "This is a house." }
  ~~~

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
  ~~~
  persons1 , @schema person(firstname,lastname,age)
    : Harry   | Langemann | 44
    : Susi    | Heimstett | 32
  persons2 , @schema person  
    : Ludwig  | Reinemann | 33
  ~~~

* __feature__  
  anonymous schema specifiers  
  defined when used, defined without a name, for one-time use  
  example:  
  ~~~
  persons , @schema(firstname,lastname,age)  
    : Harry | Langemann | 44
  ~~~

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

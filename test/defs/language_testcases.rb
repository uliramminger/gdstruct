# language_testcases.rb

#===============================================================================

TestCases_positive = [

# ----------------------------------------------------------------------------------------------------
# hash

[
<<EOS,
: k
EOS
  { k: {} }
],

[
<<EOS,
: k
  v
EOS
  { k: {}, v: {} }
],

[
<<EOS,
: k
    k1 v1
EOS
  { k: { k1: 'v1' } }
],

[
<<EOS,
: k1
    k11 v11
  k2
EOS
  { k1: { k11: 'v11' }, k2: {} }
],

[
<<EOS,
:
EOS
  {}
],

[
<<EOS,
:
  k1 v1
  k2 v2
  k3 v3
EOS
  { k1: 'v1', k2: 'v2', k3: 'v3' }
],

[
<<EOS,
: k1 v1
  k2 v2
  k3 v3
EOS
  { k1: 'v1', k2: 'v2', k3: 'v3' }
],

[
<<EOS,
:
  k1
EOS
  { k1: {} }
],

[
<<EOS,
:
  k1 v1
  k2 v2
  k3
    k31 v31
    k32
    k33
      k331 v331
      k332
        k3321
  k4 v4
EOS
  { k1: 'v1', k2: 'v2', k3: { k31: 'v31', k32: {}, k33: { k331: 'v331', k332: { k3321: {} } } }, k4: 'v4' }
],

# pipe symbol, multiple key-value pairs on a single line
[
<<EOS,
:
  k1 v1 | k2 v2 | k3 v3
EOS
  { k1: 'v1', k2: 'v2', k3: 'v3' }
],

[
<<EOS,
:
  k1 v1 | k2 v2 | k3 v3
  k4 v4 | k5 v5 | k6 v6
  k7 v7 | k8 v8 | k9 v9
EOS
  { k1: 'v1', k2: 'v2', k3: 'v3', k4: 'v4', k5: 'v5', k6: 'v6', k7: 'v7', k8: 'v8', k9: 'v9' }
],

[
<<EOS,
: k1 v1 | k2 v2
  k3 v3
  k4 v4
  k5 v5 | k6 v6
  k7 v7 | k8 v8 | k9 v9
EOS
  { k1: 'v1', k2: 'v2', k3: 'v3', k4: 'v4', k5: 'v5', k6: 'v6', k7: 'v7', k8: 'v8', k9: 'v9' }
],

[
<<EOS,
: k1 v1 | k2 v2 | k3 v3 | k4 v4
EOS
  { k1: 'v1', k2: 'v2', k3: 'v3', k4: 'v4' }
],

[
<<EOS,
: k1 v1 | k2 v2 | k3 v3 | k4 v4
  k5 v5
  k6 v6 | k7 v7
EOS
  { k1: 'v1', k2: 'v2', k3: 'v3', k4: 'v4', k5: 'v5', k6: 'v6', k7: 'v7' }
],

# ----------------------------------------------------------------------------------------------------
# hash containing array

[
<<EOS,
:
  k1 v1
  k2 ,
    v21
    v22
    v23
  k3 v3
EOS
  { k1: 'v1', k2: [ 'v21', 'v22', 'v23' ], k3: 'v3' }
],

[
<<EOS,
:
  k1 v1
  k2 ,
    v21
    v22
    v23
  k3 v3
  k4,
    1
  k5,
  k6 v6
EOS
  { k1: 'v1', k2: [ 'v21', 'v22', 'v23' ], k3: 'v3', k4: [1], k5: [], k6: 'v6' }
],

[
<<EOS,
:
  k1 v1
  k2 , v21
EOS
  { k1: 'v1', k2: [ 'v21' ] }
],

[
<<EOS,
:
  k1 v1
  k2 , v21 | v22 | v23 | v24
EOS
  { k1: 'v1', k2: [ 'v21', 'v22', 'v23', 'v24' ] }
],

[
<<EOS,
:
  k1 v1
  k2 , v21 | v22
    v23 | v24 | v25
EOS
  { k1: 'v1', k2: [ 'v21', 'v22', 'v23', 'v24', 'v25' ] }
],

[
<<EOS,
:
  k1 v1
  k2 , v21 | v22
    v23 | v24 | v25
    v26 | v27
EOS
  { k1: 'v1', k2: [ 'v21', 'v22', 'v23', 'v24', 'v25', 'v26', 'v27' ] }
],

# ----------------------------------------------------------------------------------------------------
# array

[
<<EOS,
,
EOS
  [ ]
],

[
<<EOS,
,
  ,
EOS
  [ [] ]
],

[
<<EOS,
,
  ,
    ,
EOS
  [ [ [] ] ]
],

[
<<EOS,
,
  v1
  v2
  v3
EOS
  [ 'v1', 'v2', 'v3' ]
],

[
<<EOS,
,
  v1 | v2 | v3
EOS
  [ 'v1', 'v2', 'v3' ]
],

[
<<EOS,
,
  v1 | v2 | v3
  v4 | v5
EOS
  [ 'v1', 'v2', 'v3', 'v4', 'v5' ]
],

[
<<EOS,
,
  v1
  v2
  ,
    v31
    ,
    ,
    v32
    ,
      v331
      v332
EOS
  [ 'v1', 'v2', [ 'v31', [], [], 'v32', [ 'v331', 'v332' ] ] ]
],

[
<<EOS,
,
  this is text 1 | this is text 2 | this is text 3
EOS
  [ 'this is text 1', 'this is text 2', 'this is text 3' ]
],

[
<<EOS,
,
  1
  2
EOS
  [ 1, 2 ]
],

[
<<EOS,
,
  1 | 2 | 3
EOS
  [ 1, 2, 3 ]
],

[
<<EOS,
,  1 | 2 | 3 | 4
EOS
  [ 1, 2, 3, 4 ]
],

# ----------------------------------------------------------------------------------------------------
# array containing hash

# array containing hashes with single key-value pairs
[
<<EOS,
,
  : k1 v1
  : k2 v2
EOS
  [ { k1: 'v1' }, { k2: 'v2' } ]
],

# array containing hashes with more key-value pairs
[
<<EOS,
,
  :
    k11 v11
    k12 v12
  :
    k21 v21
    k22 v22
EOS
  [ { k11: 'v11', k12: 'v12' }, { k21: 'v21', k22: 'v22' } ]
],

[
<<EOS,
,
  :
  k11 v11
  k12 v12
  :
  k21 v21
  k22 v22
EOS
  [ {}, 'k11 v11', 'k12 v12', {}, 'k21 v21', 'k22 v22' ]
],

[
<<EOS,
,
# test comment
  : k11 v11 | k12 v12 | k13 v13
  # test comment
EOS
  [ { k11: 'v11', k12: 'v12', k13: 'v13' } ]
],

# mixture
[
<<EOS,
,
  v1
  : k2 v2
  : k3 v3
  :
    k41 v41
    k42 v42
  v5
EOS
  [ 'v1', { k2: 'v2' }, { k3: 'v3' }, { k41: 'v41', k42: 'v42' }, 'v5' ]
],

[
<<EOS,
,
  v1
  : k2 v2
  : k31 v31 | k32 v32 | k33 v33
  :
    k41 v41
    k42 v42
    k43,
    k44,
      1
      2
      : k441 v441
  v5
EOS
  [ 'v1', { k2: 'v2' }, { k31: 'v31', k32: 'v32', k33: 'v33' }, { k41: 'v41', k42: 'v42', k43: [], k44: [1, 2, { k441: 'v441' } ] }, 'v5' ]
],

[
<<EOS,
,
  v1
  : k2 v2
  : k31 v31 | k32 v32 | k33 v33
    k34 v34
    k35 v35 | k36 v36
  :
    k41 v41
    k42 v42
    k43,
    k44,
      1
      2
      : k441 v441
  v5
EOS
  [ 'v1', { k2: 'v2' }, { k31: 'v31', k32: 'v32', k33: 'v33', k34: 'v34', k35: 'v35', k36: 'v36' }, { k41: 'v41', k42: 'v42', k43: [], k44: [1, 2, { k441: 'v441' } ] }, 'v5' ]
],

[
<<EOS,
,
  v1
  : k2 v2
  : k31 v31 | k32 v32 | k33 v33
    k34 v34
    k35 v35 | k36 v36
  :
    k41 v41
    k42 v42
    k43,
    k44, 1 | 2 | 3
      4 | 5
      6
      7
      8 | 9
      : k441 v441
  v5
EOS
  [ 'v1', { k2: 'v2' }, { k31: 'v31', k32: 'v32', k33: 'v33', k34: 'v34', k35: 'v35', k36: 'v36' }, { k41: 'v41', k42: 'v42', k43: [], k44: [1, 2, 3, 4, 5, 6, 7, 8, 9, { k441: 'v441' } ] }, 'v5' ]
],

[
<<EOS,
, v11 | v12 | v13
EOS
  [ 'v11', 'v12', 'v13' ]
],

[
<<EOS,
, v11 | v12 | v13
  v14 | v15
EOS
  [ 'v11', 'v12', 'v13', 'v14', 'v15' ]
],

[
<<EOS,
, v11 | v12 | v13
  v14 | v15
  v16 | v17 | v18
EOS
  [ 'v11', 'v12', 'v13', 'v14', 'v15', 'v16', 'v17', 'v18' ]
],

[
<<EOS,
,
  , v11 | v12 | v13
EOS
  [ [ 'v11', 'v12', 'v13' ] ]
],

[
<<EOS,
,
  , v11 | v12 | v13
    v14 | v15
EOS
  [ [ 'v11', 'v12', 'v13', 'v14', 'v15' ] ]
],

# ----------------------------------------------------------------------------------------------------
# different kind of values

[
<<EOS,
,
  _
  _ _ _ _ _ _ a very long string
  nil
  true
  false
  1
  -2
  +2
  1.0
  -3.0
  +3.0
  .4
  -.5
  +.5
  0.6
  -0.7
  +0.7
  !nil
  !true
  !false
EOS
  [ '_', '_ _ _ _ _ _ a very long string', 'nil', 'true', 'false', 1, -2, 2, 1.0, -3.0, 3.0, 0.4, -0.5, 0.5, 0.6, -0.7, 0.7, nil, true, false ]
],

# --------------------------------------------------
# floating-point numbers
[
<<EOS,
,
  1.0
  -3.0
  +3.0
  .4
  -.5
  +.5
  0.6
  -0.7
  +0.7
  0024.01
  1_0_0_0.2_3_3
  1.4e2
  1.4E2
  1.5e1_2_3
  1.5E1_2_3
  1.4e-2
  1.4E-2
  1.5e-1_2_3
  1.5E-1_2_3
  1.4e+2
  1.4E+2
  1.5e+1_2_3
  1.5E+1_2_3
EOS
  [ 1.0, -3.0, 3.0, 0.4, -0.5, 0.5, 0.6, -0.7, 0.7, 24.01, 1000.233, 140.0, 140.0, 1.5e+123, 1.5e+123, 0.014, 0.014, 1.5e-123, 1.5e-123, 140.0, 140.0, 1.5e+123, 1.5e+123 ]
],

# --------------------------------------------------
# integer numbers, binary
[
<<EOS,
,
  0b0
  0b1
  0b00
  0b11
  0b0_0
  0b0_0_0
  0b1_0
  0b1_0_0
EOS
  [ 0, 1, 0, 3, 0, 0, 2, 4 ]
],

# --------------------------------------------------
# integer numbers, octal
[
<<EOS,
,
  0o0
  00
  0o27
  027
  01
  07
  0o7
  010
  0o10
EOS
  [ 0, 0, 23, 23, 1, 7, 7, 8, 8 ]
],

# --------------------------------------------------
# integer numbers, hexadecimal
[
<<EOS,
,
  0x0
  0xff
  0x1001
  -0xBB
  -0xFa
EOS
  [ 0, 255, 4097, -187, -250 ]
],

# --------------------------------------------------
# integer numbers, decimal
[
<<EOS,
,
  0
  1
  -1
  +1
  0d0
  0d1
  -0d1
  +0d1
  1_000_000
EOS
  [ 0, 1, -1, 1, 0, 1, -1, 1, 1000000 ]
],

# --------------------------------------------------
# symbols, Ruby symbols

# none quoted symbols
[
<<EOS,
,
  :a
  :longerstring
  :longer_string
  :@
  :$
  :$;
  :$,
  :$,,
  :π
  :'
  :"
  ::
  :::
  ::::
EOS
  [ :a, :longerstring, :longer_string, :"@", :"$", :$;, :$,, :"$,,", :π, :"'", :"\"", :":", :"::", :":::" ]
],

# quoted symbols
[
<<EOS,
,
  :' '
  :" "
EOS
  [ :" ", :" " ]
],

# --------------------------------------------------
# string literals
[
<<EOS,
,
  ""
  "\\""
  '\\"'
  ''
  '\\''
  "\\'"
  "'"
  '"'
  "first \n second"
EOS
  [ "", "\"", "\\\"", "", "'", "\\'", "'", "\"", "first \n second" ]
],

# --------------------------------------------------
# double-quoted strings
[
<<EOS,
k01 "\\""
k02 "\\\""
k03 "\\n"
k04 "\\\\"
k05 "\\\\n"
k06 "\\\\\\n"
k07 "\\\\\\\\n"
EOS
  { k01: "\"", k02: "\"", k03: "\n", k04: "\\", k05: "\\n", k06: "\\\n", k07: "\\\\n" }
],

# --------------------------------------------------
# single-quoted strings
[
<<EOS,
k01 '\\''
k02 '\\\''
k03 '\\n'
k04 '\\\\'
k05 '\\\\n'
k06 '\\\\\\n'
k07 '\\\\\\\\n'
EOS
  { k01: "'", k02: "'", k03: "\n", k04: "\\", k05: "\\n", k06: "\\\n", k07: "\\\\n" }
],

# --------------------------------------------------
# keyword literals
[
<<EOS,
,
  !true
  !false
  !nil
EOS
  [ true, false, nil ]
],

# ----------------------------------------------------------------------------------------------------
# comments

# --------------------------------------------------
# inline comments
[
<<EOS,
,
  v1 # inline comment at the end of a line

# inline comment with 0 space indentation
 # inline comment with 1 space indentation
  # inline comment with 2 space indentation
   # inline comment with 3 space indentation
    # inline comment with 4 space indentation
      # ...

  v2
EOS
  [ 'v1', 'v2' ]
],

# --------------------------------------------------
# block comments
[
<<EOS,
:
  k1 v1
  /* bc (block comment), attention: respect proper indentation of this line */ k2 /*bc*/ v2 /*bc*/

/* block comment with 0 space indentation */
 /* block comment with 1 space indentation */
  /* block comment with 2 space indentation */
   /* block comment with 3 space indentation */
    /* block comment with 4 space indentation */
     /* ... */

/****
         multi-line block comment
****/

  /*bc (respect indentation)*/ k3 /*bc*/ , /*bc*/
    /*bc (respect indentation)*/ 1 /*bc*/
    /*bc (respect indentation) /*nested bc*/ */ /*bc*/ 2 /*bc*/ | /*bc*/ 3 /*bc*/

  /*bc (respect indentation)*/ k4 /*bc*/ , /*bc*/ 1 /*bc*/ | /*bc*/ 2 /*bc*/
EOS
  { k1: 'v1', k2: 'v2', k3: [1,2,3], k4: [1,2] }
],

[
<<EOS,
,
  /* !!! wrong block comment !!! */ ,
    1
    2
EOS
  [ [ 1, 2 ] ]
],

[
<<EOS,
,
  /* !!! wrong block comment !!! */ :
    k1 v1
EOS
  [ { k1: 'v1' } ]
],

# --------------------------------------------------

[
<<EOS,
:
  k1 v1# comment
  k2 v2 # comment
  k3 /* comment */ v3 /* comment */
  /* comment */ k4 /* comment */ v4 /* comment */
  /* comment /* nested */ */ /* again comment */ k5 /* comment */ /*again comment*/ v5 /* comment */ /*again comment*/
  /* comment */ k6
    k61 v61
  /* comment */ k7 ,
    1
    2
    3
  /* comment */ k8 /* comment */ , /* comment */ 1.0 /*comment*/ | /*comment*/ 2.0 /*comment*/
EOS
  { k1: 'v1', k2: 'v2', k3: 'v3', k4: 'v4', k5: 'v5', k6: { k61: 'v61' }, k7: [ 1, 2, 3 ], k8: [ 1.0, 2.0 ]}
],

# --------------------------------------------------
# comments inside format schemas
[
<<EOS,
@schema person(firstname,lastname,age)
:
  /* comment */ persons /*c*/ , /*c*/ @schema person /*c*/
    : /*c*/ Harry /*c*/ | /*c*/ Langemann /*c*/ | /*c*/ 44 /*c*/
    : Susi  | Heimstett | 32
    : /*c*/ 'Bob' /*c*/ | /*c*/ "Meiermann" /*c*/ | /*c*/ 57 /*c*/
EOS
  { persons: [
    { firstname: 'Harry', lastname: 'Langemann', age: 44 },
    { firstname: 'Susi', lastname: 'Heimstett', age: 32 },
    { firstname: 'Bob', lastname: 'Meiermann', age: 57 },
  ] }
],

[
<<EOS,
,
  # val0 (inline comment)
  #/*test comment*/val0a
  #/*test comment*/ val0b
  #/*test comment*/ val0c
  val1
  val2    /*test comment /*inner comment*/ */
/*test comment /*inner comment*/ */
 /*test comment /*inner comment*/ */
/*
  this is a comment section within a data structure
  /* a nested comment */
*/
# also a comment
 # also a comment
  # also a comment
   # also a comment
    # also a comment
     # also a comment
      # also a comment
  val3
  /**-/
  val3a
  val3b
  val3c /* more comments here */
  /-**/
  val4
  val5 # inline comment
  val6# inline comment
  val7/*
  */
  /* comment */ val8
  val9
  val10 /* comment */ | /* comment */ val11 /* comment */ | /* comment */ val12 /* comment */
  val13 /* comment */ | /*comment*/ val14 /* comment */
  /* comment /* nested */ */        val15
  /* comment /* nested */ */  /* again comment */    val16
  /* comment */ k1 /*c*/ : /*c*/
    /*c*/ k11 /*c*/ v11 /*c*/
EOS
  [ 'val1', 'val2', 'val3', 'val4', 'val5', 'val6', 'val7', 'val8', 'val9', 'val10', 'val11', 'val12', 'val13', 'val14', 'val15', 'val16', { k1: { k11: 'v11' } } ]
],

# ----------------------------------------------------------------------------------------------------
# default string literals

[
<<EOS,
,
  mystring
  this is a really long string
  first string : (1)   |   second string : (2)    /*comment*/    |   third string : (3)      # comment
EOS
  [ "mystring", "this is a really long string", "first string : (1)", "second string : (2)", "third string : (3)" ]
],

# ----------------------------------------------------------------------------------------------------
# schema specifier

[
<<EOS,
@schema country(name,capital,area,population,vehicleRegistrationCode,iso3166code,callingCode)
, @schema country   /*
    name                  capital            area (km^2)   population      vehicleRegistrationCode   iso3166code   callingCode
  ---------------------------------------------------------------------------------------------------------------------------- */
  : Deutschland         | Berlin           |    357_385  |    82_521_653 | D                       | DE          | 49
  : USA                 | Washington, D.C. |  9_833_520  |   325_719_178 | USA                     | US          | 1
  : China               | Beijing          |  9_596_961  | 1_403_500_365 | CHN                     | CN          | 86
  : India               | New Dehli        |  3_287_469  | 1_339_180_000 | IND                     | IN          | 91
  : Austria             | Vienna           |     83_878  |     8_822_267 | A                       | AT          | 43
  : Denmark             | Copenhagen       |     42_921  |     5_748_769 | DK                      | DK          | 45
  : Canada              | Ottawa           |  9_984_670  |    36_503_097 | CDN                     | CA          | 1
  : France              | Paris            |    643_801  |    66_991_000 | F                       | FR          | 33
  : Russia              | Moscow           | 17_075_400  |   144_526_636 | RUS                     | RU          | 7
EOS
  [
    { :name=>"Deutschland", :capital=>"Berlin", :area=>357385, :population=>82521653, :vehicleRegistrationCode=>"D", :iso3166code=>"DE", :callingCode=>49 },
    { :name=>"USA", :capital=>"Washington, D.C.", :area=>9833520, :population=>325719178, :vehicleRegistrationCode=>"USA", :iso3166code=>"US", :callingCode=>1 },
    { :name=>"China", :capital=>"Beijing", :area=>9596961, :population=>1403500365, :vehicleRegistrationCode=>"CHN", :iso3166code=>"CN", :callingCode=>86 },
    { :name=>"India", :capital=>"New Dehli", :area=>3287469, :population=>1339180000, :vehicleRegistrationCode=>"IND", :iso3166code=>"IN", :callingCode=>91 },
    { :name=>"Austria", :capital=>"Vienna", :area=>83878, :population=>8822267, :vehicleRegistrationCode=>"A", :iso3166code=>"AT", :callingCode=>43 },
    { :name=>"Denmark", :capital=>"Copenhagen", :area=>42921, :population=>5748769, :vehicleRegistrationCode=>"DK", :iso3166code=>"DK", :callingCode=>45 },
    { :name=>"Canada", :capital=>"Ottawa", :area=>9984670, :population=>36503097, :vehicleRegistrationCode=>"CDN", :iso3166code=>"CA", :callingCode=>1 },
    { :name=>"France", :capital=>"Paris", :area=>643801, :population=>66991000, :vehicleRegistrationCode=>"F", :iso3166code=>"FR", :callingCode=>33 },
    { :name=>"Russia", :capital=>"Moscow", :area=>17075400, :population=>144526636, :vehicleRegistrationCode=>"RUS", :iso3166code=>"RU", :callingCode=>7 }
  ]
],

[
<<EOS,
@schema p(firstname, lastname, phone1, phone2, email, website)  # person
@schema a(street, zipcode, city, country)                       # address
, @schema p
  : May         |  Grimes       |  '1-916-595-1175'   |  '(690) 557-4123'   |  may@connelly.name      |  https://www.ryanwolff.net
    addresses , @schema a
      : Grayce Mall 4833           |  77071  |  East Rebeka           |  Cocos (Keeling) Islands
      : Abshire Turnpike 297       |  94595  |  Dasiaberg             |  Cocos (Keeling) Islands
      : Ortiz Shores 29441         |  56813  |  Windlerbury           |  Anguilla
      : Legros Village 621         |  42101  |  North Flavio          |  Cape Verde

  : Jammie      |  Beahan       |  '(717) 922-5565'   |  '(345) 161-3052'   |  jammie@dicki.biz       |  https://www.corkerylind.org
    addresses , @schema a
      : Rosalyn Ports 2019        |  35316  |  East Willachester     |  Democratic People's Republic of Korea
      : Rosario Locks 56923       |  11183  |  North Marionbury      |  Mozambique

  : Mariane     |  Roob         |  '(749) 095-8597'   |  '(783) 183-1409'   |  mariane@fay.com        |  https://www.bosco.co
    addresses , @schema a
      : Dickens Pine 89210        |  24325  |  Lake Alessandraton    |  Nicaragua
      : Kamren Corners 742        |  98862  |  Brionnamouth          |  Guadeloupe
      : Erik Branch 67028         |  56464  |  Kertzmannstad         |  Kyrgyz Republic

  : Ansel       |  Braun        |  '(162) 247-8471'   |  '303-108-0535'     |  ansel@heidenreich.name |  https://www.quitzondickens.net
    addresses , @schema a
      : Littel Path 650           |  26250  |  Lorenzoton            |  Saint Helena
EOS
  [
    { firstname: "May", lastname: "Grimes", phone1: "1-916-595-1175", phone2: "(690) 557-4123", email: "may@connelly.name", website: "https://www.ryanwolff.net",
      addresses: [
        { street: "Grayce Mall 4833"    , zipcode: 77071, city: "East Rebeka"       , country: "Cocos (Keeling) Islands" },
        { street: "Abshire Turnpike 297", zipcode: 94595, city: "Dasiaberg"         , country: "Cocos (Keeling) Islands" },
        { street: "Ortiz Shores 29441"  , zipcode: 56813, city: "Windlerbury"       , country: "Anguilla" },
        { street: "Legros Village 621"  , zipcode: 42101, city: "North Flavio"      , country: "Cape Verde" }
      ], },
   { firstname: "Jammie", lastname: "Beahan", phone1: "(717) 922-5565", phone2: "(345) 161-3052", email: "jammie@dicki.biz", website: "https://www.corkerylind.org",
     addresses: [
       { street: "Rosalyn Ports 2019"   , zipcode: 35316, city: "East Willachester" , country: "Democratic People's Republic of Korea" },
       { street: "Rosario Locks 56923"  , zipcode: 11183, city: "North Marionbury"  , country: "Mozambique" }
     ], },
   { firstname: "Mariane", lastname: "Roob", phone1: "(749) 095-8597", phone2: "(783) 183-1409", email: "mariane@fay.com", website: "https://www.bosco.co",
     addresses: [
       { street: "Dickens Pine 89210"   , zipcode: 24325, city: "Lake Alessandraton", country: "Nicaragua" },
       { street: "Kamren Corners 742"   , zipcode: 98862, city: "Brionnamouth"      , country: "Guadeloupe" },
       { street: "Erik Branch 67028"    , zipcode: 56464, city: "Kertzmannstad"     , country: "Kyrgyz Republic" }
     ], },
   { firstname: "Ansel", lastname: "Braun", phone1: "(162) 247-8471", phone2: "303-108-0535", email: "ansel@heidenreich.name", website: "https://www.quitzondickens.net",
     addresses: [
       { street: "Littel Path 650"      , zipcode: 26250, city: "Lorenzoton"        , country: "Saint Helena" }
     ], },
  ]
],

# ----------------------------------------------------------------------------------------------------
# Ruby classic style

[
<<EOS,
{}
EOS
{}
],

[
<<EOS,
{ }
EOS
{}
],

[
<<EOS,
{ k1: 'v1', k2: 'v2' }
EOS
  { k1: 'v1', k2: 'v2' }
],

[
<<EOS,
{ v1: { v11: "val11" } }
EOS
{ v1: { v11: "val11" } }
],

[
<<EOS,
{ v1: [ 1, 2, 3 ] }
EOS
{ v1: [ 1, 2, 3 ] }
],

[
<<EOS,
[]
EOS
[]
],

[
<<EOS,
[   ]
EOS
[]
],

[
<<EOS,
[ [  ] ]
EOS
[ [  ] ]
],

[
<<EOS,
[[]]
EOS
[ [  ] ]
],

[
<<EOS,
[ "val1" ]
EOS
[ "val1" ]
],

[
<<EOS,
[ "val1", "val2" ]
EOS
[ "val1", "val2" ]
],

[
<<EOS,
[ "val1", 2, .3, 1000.123 ]
EOS
[ "val1", 2, 0.3, 1000.123 ]
],

[
<<EOS,
[ "v1", "v2", "v3", "v4", "v5" ]
EOS
[ "v1", "v2", "v3", "v4", "v5" ]
],

[
<<EOS,
[ 1, 1_000, 2.0, 3.0e10, true, false, nil, { key: 'val' } ]
EOS
  [ 1, 1000, 2.0, 30000000000.0, true, false, nil, { key: 'val' } ]
],

[
<<EOS,
[ 1, 1_000, /* block comment /*nested*/ */ 2.0, 3.0e10, true, false, nil, { key: 'val' } ]
EOS
  [ 1, 1000, 2.0, 30000000000.0, true, false, nil, { key: 'val' } ]
],

[
<<EOS,
{ a: nil, b: true, c: false }
EOS
{ a: nil, b: true, c: false }
],

]

#===============================================================================

TestCases_negative = [

# no valid syntax
<<EOS,
:
  :
    val a
EOS


# floating-point numbers
<<EOS,
,
  1._2_3_3
EOS

# wrong indentation or definition
<<EOS,
:
  k1 v1
  k2 , v21 | v22
    v23 | v24 | v25
      v26 | v27
EOS

# wrong indentation or definition
<<EOS,
:
  k1 v1
  k2 , v21 | v22
    v23 | v24 | v25
  v26 | v27
EOS

# wrong indentation using block comments
<<EOS,
,
  v1
   /*bc !!! wrong indentation !!! */ v2

EOS

<<EOS,
,
  v1
 /*bc !!! wrong indentation !!! */ v2

EOS

<<EOS,
,
  v1
    /*bc !!! wrong indentation !!! */ v2

EOS

<<EOS,
:
  k1 v1
  k2 v2
  k3
    k31 v31
    k32
    k33
      +k331 v331
      k332
        k3321
  k4 v4
EOS

<<EOS,
:
  k1 v1
  k2 v2
  k3
    k31 v31
    k32
    k33
+     k331 v331
      k332
        k3321
  k4 v4
EOS

]

#===============================================================================

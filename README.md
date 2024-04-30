gdstruct - GDS - General Data Structure
=======================================

A General Data Structure (GDS) is a universal, composable data structure, used to store any kind of data.   
The building blocks for general data structures are hashes and arrays.
In this definition a General Data Structure (GDS) is either a hash or an array or any composition of nested hashes and arrays.  

The defined data can be used in the following situations:
* for the configuration or specification of systems, processes, services, frameworks, objects, methods or functions
* for seeding a database or any other data model
* to convert to other data representation formats like JSON, XML, YAML

The GDS language is a special DSL (domain specific language) for defining general data structures.  
It uses a succinct, indentation-sensitive syntax which makes data representation clear and readable.

Installation
============

~~~
gem install gdstruct
~~~

A Short Example
===============

~~~
require "gdstruct"

h = GDstruct.c( <<-EOS )
key1 value a
key2 value b
EOS

# => h = { key1: 'value a', key2: 'value b' }
~~~

An Introduction
===============

The GDS language uses two basic symbols (__:__ and __,__) for the creation of hashes and arrays.

A colon (__:__) is used to define a hash.  
A comma (__,__) is used to define an array.  

Use indentation with two spaces for the definition of elements and for nested structures.
Tab characters are not allowed for indentation.

The default data structure is a hash.  
By default, the key of a key-value pair is always converted into a symbol.  

## Another Example

~~~
caption foo
credit  bar
images
  small
    url  http://mywebsite.com/image-small.jpg
    dimensions
      height 500
      width  500
  large
    url  http://mywebsite.com/image-large.jpg
    dimensions
      height 500
      width  500
videos
  small
    preview  http://mywebsite.com/video.m4v
    dimensions
      height 300
      width  400  
~~~

transforms to

~~~
{ caption: "foo",
  credit: "bar",
  images: {
    small: {
      url: "http://mywebsite.com/image-small.jpg",
      dimensions: {
        height: 500,
        width: 500 } },
    large: {
      url: "http://mywebsite.com/image-large.jpg",
      dimensions: {
        height: 500,
        width: 500 } } },
  videos: {
    small: {
      preview: "http://mywebsite.com/video.m4v",
      dimensions: {
        height: 300,
        width: 400 } } } }
~~~

## Variables and String Interpolation

You can define a variable as a placeholder for a basic value.  
In conjunction with variables, there is string interpolation supported.
The values of variables are substituted into string literals.

~~~
$main_path    = /usr/john
$service_dir  = docker-compose-service01
$app01_dir    = application_001
$app02_dir    = application_002
$app03_dir    = application_003
$service_path = $(main_path)/$(service_dir)

config
  app01_path  $(main_path)/$(service_dir)/$(app01_dir)
  app02_path  $(main_path)/$(service_dir)/$(app02_dir)
  app03_path  $(service_path)/$(app03_dir)
~~~
transforms to
~~~
{ config: {
    app01_path: "/usr/john/docker-compose-service01/application_001",
    app02_path: "/usr/john/docker-compose-service01/application_002",
    app03_path: "/usr/john/docker-compose-service01/application_003" } }
~~~

## Schema Definitions

Schema specifiers can be used to predefine the keys of a hash or subhash.
When you specify the values you no longer need to name the key for each value.
This facilitates the input for hashes and prevents typos for keys.  
In combination with the pipe symbol (__\|__), which allows to define multiple values on a single line,
this features a slim and clearly arranged, table-like style for data.

~~~
@schema country(name,capital,area,population,vehicleRegistrationCode,iso3166code,callingCode)
, @schema country                                                                                                              /*
    name            capital            area (km^2)   population      vehicleRegistrationCode   iso3166code   callingCode
  ---------------------------------------------------------------------------------------------------------------------------- */
  : Deutschland   | Berlin           |    357_385  |    82_521_653 | D                       | DE          | 49
  : USA           | Washington, D.C. |  9_833_520  |   325_719_178 | USA                     | US          | 1
  : China         | Beijing          |  9_596_961  | 1_403_500_365 | CHN                     | CN          | 86
  : India         | New Dehli        |  3_287_469  | 1_339_180_000 | IND                     | IN          | 91
  : Austria       | Vienna           |     83_878  |     8_822_267 | A                       | AT          | 43
  : Denmark       | Copenhagen       |     42_921  |     5_748_769 | DK                      | DK          | 45
  : Canada        | Ottawa           |  9_984_670  |    36_503_097 | CDN                     | CA          | 1
  : France        | Paris            |    643_801  |    66_991_000 | F                       | FR          | 33
  : Russia        | Moscow           | 17_075_400  |   144_526_636 | RUS                     | RU          | 7
~~~
transforms to
~~~
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
~~~

## References

References can be used to define an alias for a certain sub structure, that means for a nested array or a nested hash.  
Afterwards in the GDS definition, you can use the reference to refer to this sub structure.

For the definition of a reference you prefix an identifier (unique name) with an __&__ ampersand.  
For the use of a reference you prefix the same identifier with an __*__ asterisk.
~~~
categories , @schema( name )
  &e_bike         : E-Bike
  &mountain_bike  : Mountain Bike
  &city_bike      : City Bike
  &kids_bike      : Kids Bike

bikes , @schema( name, frame_size, wheel_diameter, weight, category )                      /*
  ----------------------------------------------------------------------------------------   
    name               frame size ["]   wheel diameter ["]   weight [kg]   category
  ---------------------------------------------------------------------------------------- */  
  : Speedstar I      | 18             | 27.5               | 23.3        | *city_bike
  : Speedstar I      | 20             | 27.5               | 24.4        | *city_bike
  : Speedstar II     | 22             | 27.5               | 25.5        | *city_bike
  : Little Pony      | 16             | 16                 |  5.98       | *kids_bike
  : Rocket           | 20             | 20                 |  7.13       | *kids_bike
  : Easy Cruiser     | 20             | 28                 | 29.4        | *e_bike
  : Rough Buffalo    | 19             | 26                 | 14.7        | *mountain_bike
~~~
transforms to
~~~
{ categories: [ { name: "E-Bike" }, { name: "Mountain Bike" }, { name: "City Bike" }, { name: "Kids Bike" } ],
  bikes: [ { name: "Speedstar I", frame_size: 18, wheel_diameter: 27.5, weight: 23.3, category: { name: "City Bike" } },
           { name: "Speedstar I", frame_size: 20, wheel_diameter: 27.5, weight: 24.4, category: { name: "City Bike" } },
           { name: "Speedstar II", frame_size: 22, wheel_diameter: 27.5, weight: 25.5, category: { name: "City Bike" } },
           { name: "Little Pony", frame_size: 16, wheel_diameter: 16, weight: 5.98, category: { name: "Kids Bike" } },
           { name: "Rocket", frame_size: 20, wheel_diameter: 20, weight: 7.13, category: { name: "Kids Bike" } },
           { name: "Easy Cruiser", frame_size: 20, wheel_diameter: 28, weight: 29.4, category: { name: "E-Bike" } },
           { name: "Rough Buffalo", frame_size: 19, wheel_diameter: 26, weight: 14.7, category: { name: "Mountain Bike" } } ] }
~~~

### Merging a hash into another - @merge

The __@merge__ directive can be used to merge a hash specified with a reference into another hash.

~~~
$logpath = /var/log/myapp

initial_settings &init
  priority 10
  max_size 2000
  max_age  10

all_log_files ,  
  : @merge *init
    file  $(logpath)/logfile_1.log

  : @merge *init
    file  $(logpath)/logfile_2.log

  : @merge *init
    file     $(logpath)/logfile_3.log
    max_age  8                          # overwrite an existing hash entry
~~~
transforms to
~~~
{ initial_settings: { priority: 10, max_size: 2000, max_age: 10 },
  all_log_files: [ { priority: 10, max_size: 2000, max_age: 10, file: "/var/log/myapp/logfile_1.log" },
                   { priority: 10, max_size: 2000, max_age: 10, file: "/var/log/myapp/logfile_2.log" },
                   { priority: 10, max_size: 2000, max_age: 8, file: "/var/log/myapp/logfile_3.log" } ] }
~~~

### Inserting an array into another - @insert

The __@insert__ directive can be used to insert an array specified with a reference into another array.

~~~
config_files &config_files ,
  Gemfile
  config/application.gdstruct

docu_files &docu_files ,
  README.md
  CHANGELOG.md

app_files &app_files ,
  appmodel.rb
  appview.rb
  appcontroller.rb

complete_file_list ,
  @insert *config_files
  @insert *docu_files
  @insert *app_files
  my_special.rb
~~~
transforms to
~~~
{ config_files: [ "Gemfile", "config/application.gdstruct" ],
  docu_files: [ "README.md", "CHANGELOG.md" ],
  app_files: [ "appmodel.rb", "appview.rb", "appcontroller.rb" ],
  complete_file_list: [ "Gemfile", "config/application.gdstruct", "README.md", "CHANGELOG.md",
                        "appmodel.rb", "appview.rb", "appcontroller.rb", "my_special.rb" ] }
~~~

## Motivation and Features

  * the focus is on the essential data
  * a language for humans, a human-writable format
  * structure and hierarchy is expressed using indentation (whitespace-sensitive) - avoids curly braces and square brackets
  * uses a succinct and minimalist syntax - tries to avoid unnecessary characters
  * in many cases colons, commas and quotes are not necessary
  * less text makes data clearer and more readable
  * for configuration and specification - replacement for XML, JSON, YAML
  * for data/database seeding
  * less text and less potential errors using schema definitions
  * supports block comments, which could be nested
  * allows also the definition of hash and array structures in a kind of restricted classic Ruby like syntax
  * provides an alternative for Ruby hash and array definition without using eval(); can be used as a protection against code injection vulnerabilities, e.g. on web servers

Ruby Gem
========

You can find it on RubyGems.org:  

[rubygems.org/gems/gdstruct](https://rubygems.org/gems/gdstruct)

<div class="topic-separator"></div>
<div id="l-source-code" class="fragment-link"></div>

Source Code
===========

You can find the source code on GitHub:  

[github.com/uliramminger/gdstruct](https://github.com/uliramminger/gdstruct)

Further Information
===================

You will find detailed information here:  [urasepandia.de/gds.html](https://urasepandia.de/gds.html)

Use the GDS Converter, play with it and give the GDS language a try: [urasepandia.de/gdsconverter.html](https://urasepandia.de/gdsconverter.html)  
The GDS Converter translates a GDS definition into various data representation formats and languages like Ruby, JSON, Python, XML and YAML.

There is a collection of practical examples on GitHub:
[github.com/uliramminger/gds-examples](https://github.com/uliramminger/gds-examples)

Maintainer
==========

Uli Ramminger <uli@urasepandia.de>

Copyright
=========

Copyright (c) 2018-2024 Ulrich Ramminger

See MIT-LICENSE for further details.

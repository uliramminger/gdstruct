gdstruct - GDS - General Data Structure
=======================================

A General Data Structure (GDS) is a universal, composable data structure, used to store any kind of data.   
This could be for example the definition of configurations, specifications and data sets.
Typical usage is the definition of configurations, specifications and data sets. 
The GDS language is a special DSL (domain specific language) for defining general data structures. 
It uses a succinct, indentation-sensitive syntax which makes data representation clear and readable. 
The building blocks for general data structures are hashes and arrays.

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
a val a
b val b
EOS

# => h = { a: 'val a', b: 'val b' }
~~~

An Introduction
===============

The GDS language uses two basic symbols (__:__ and __,__) for the creation of hashes and arrays.

A colon (__:__) is used to define a hash.  
A comma (__,__) is used to define an array.  

Use indentation with two spaces for the definition of elements and for nested structures. 
Tab characters are not allowed for indentation.

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
{
  :caption => 'foo',
  :credit => 'bar',
  :images => {
    :small => {
      :url => 'http://mywebsite.com/image-small.jpg',
      :dimensions => {
        :height => 500,
        :width => 500
      }
    },
    :large => {
      :url => 'http://mywebsite.com/image-large.jpg',
      :dimensions => {
        :height => 500,
        :width => 500
      }
    },
  },
  :videos => {
    :small => {
      :preview => 'http://mywebsite.com/video.m4v',
      :dimensions => {
        :height => 300,
        :width => 400
      }
    }
  }
}
~~~

## General Example

~~~
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
      :k441 v441
  v5

# =>  [ 'v1', { k2: 'v2' }, { k31: 'v31', k32: 'v32', k33: 'v33', k34: 'v34', k35: 'v35', k36: 'v36' }, 
        { k41: 'v41', k42: 'v42', k43: [], k44: [1, 2, 3, 4, 5, 6, 7, 8, 9, { k441: 'v441' } ] }, 'v5' ] 
~~~

## Motivation and Features

  * the focus is on the essential data 
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


## Schema specifiers

Schema specifiers can be used to predefine the keys of a hash or subhash. 
When you specify the values you no longer need to name the key for each value.
This facilitates the input for hashes and prevents typos for keys.  
In combination with the pipe symbol (__\|__), which allows to define multiple values on a single line,
this features a slim and clearly arranged, table-like style for data.

~~~
@schema country(name,capital,area,population,vehicleRegistrationCode,iso3166code,callingCode)
, @schema country   /*
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

Further Information
===================

You will find further information here:  [urasepandia.de/gds.html](https://urasepandia.de/gds.html)

Maintainer
==========

Uli Ramminger <uli@urasepandia.de>

Copyright
=========

Copyright (c) 2018 Ulrich Ramminger

See MIT-LICENSE for further details.

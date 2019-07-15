# gdstruct.rb

# You will find further information here:  https://urasepandia.de/gds.html

require_relative 'gdstruct/version'
require_relative 'gdstruct/lng_gds'

class GDstruct

  class << self

    # create a Ruby Hash/Array structure out of a GDS definition string
    #
    # @param gds_definition [String] GDS definition
    # @option config [true/false] :allow_env (false) allow the @env directive to access environment variables, otherwise the @env directive returns nil
    # @option config [Binding] :context (nil) if a binding is set then the @r directive evaluates embedded ruby code, otherwise the @r directive returns nil
    #
    # @return [Hash,Array] hash/array structure
    #
    # @example
    #   require 'gdstruct'
    #
    #   h = GDstruct.c( <<-EOS )
    #   a value 1
    #   b value 2
    #   EOS
    #
    #   # => h = { a: 'value 1', b: 'value 2' }
    def create( gds_definition, config = {} )
      LDLgeneratedLanguage::Gds.parse( gds_definition, config )
    end
    alias :c :create

    # create a Ruby Hash/Array structure out of a GDS definition file
    #
    # @param file_name [String] file name
    # @option config [true/false] :allow_env (false) allow the @env directive to access environment variables, otherwise the @env directive returns nil
    # @option config [Binding] :context (nil) if a binding is set then the @r directive evaluates embedded ruby code, otherwise the @r directive returns nil
    #
    # @return [Hash,Array] hash/array structure
    def create_from_file( file_name, config = {} )
      LDLgeneratedLanguage::Gds.parse( File.read( file_name ), config )
    end
    alias :c_from_file :create_from_file

  end

  # create a Ruby Hash/Array structure out of possibly several separated  GDS definition strings
  #
  # # file: data.gdstruct
  # &persons persons, @schema person        /*
  #     firstname   lastname    yearOfBirth */
  #   : John      | McArthur  | 1987
  #   : Berry     | Miller    | 1976
  #
  # @example
  #   require 'gdstruct'
  #
  #   creator = GDstruct::Creator.new
  #
  #   creator.include( <<-EOS )
  #   @schema person( firstname, lastname, yearOfBirth )
  #   EOS
  #
  #   creator.include_file( 'data.gdstruct' )
  #
  #   creator.include( <<-EOS )
  #   all
  #     mypersons *persons
  #   EOS
  #
  #   res = creator.create
  #
  #   # => res = {:persons=>[{:firstname=>"John", :lastname=>"McArthur", :yearOfBirth=>1987}, {:firstname=>"Berry", :lastname=>"Miller", :yearOfBirth=>1976}],
  #   #           :all=>{:mypersons=>{:persons=>[{:firstname=>"John", :lastname=>"McArthur", :yearOfBirth=>1987}, {:firstname=>"Berry", :lastname=>"Miller", :yearOfBirth=>1976}]}}}
  class Creator

    def initialize
      @gdsDefinition = ""
    end

    def reset
      @gdsDefinition = ""
    end

    def include( gds_definition )
      @gdsDefinition << gds_definition << "\n"
    end

    def include_file( file_name )
      @gdsDefinition << File.read( file_name ) << "\n"
    end

    def create( config = {} )
      LDLgeneratedLanguage::Gds.parse( @gdsDefinition, config )
    end

  end

end

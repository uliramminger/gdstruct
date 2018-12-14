#===============================================================================
# file name : gdstruct.rb
#===============================================================================
=begin - Description
--------------------------------------------------------------------------------

You will find further information here:  https://urasepandia.de/gds.html

--------------------------------------------------------------------------------
=end
#===============================================================================

require_relative 'gdstruct/gds_013'

#===============================================================================

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
  
end

#===============================================================================

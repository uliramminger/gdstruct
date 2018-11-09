#===============================================================================
# file name : gdstruct.rb
#===============================================================================
=begin - Description
--------------------------------------------------------------------------------

You will find further information here:  https://urasepandia.de/gds.html

--------------------------------------------------------------------------------
=end
#===============================================================================

require_relative 'gdstruct/gds_011'

#===============================================================================

class GDstruct
  
  class << self
  
    def create( def_string, config = {} )
      LDLgeneratedLanguage::Gds.parse( def_string, config )
    end
    alias :c :create
    
    def create_from_file( name, config = {} )
      LDLgeneratedLanguage::Gds.parse( File.read( name ), config )
    end
    alias :c_from_file :create_from_file
    
  end
  
end

#===============================================================================

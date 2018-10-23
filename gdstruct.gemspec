require_relative 'lib/gdstruct/version'

Gem::Specification.new do |s|

  s.name        = 'gdstruct'
  s.version     = GDstruct::VERSION
  s.summary     = 'gdstruct - GDS (General Data Structure), a universal, composable data structure, used to store any kind of data'
  s.authors     = [ 'Uli Ramminger' ]
  s.email       = 'uli@urasepandia.de'
  s.homepage    = 'https://urasepandia.de/gds.html'
  s.files       = %w(CHANGELOG.md MIT-LICENSE Rakefile README.md) + Dir["{lib}/**/*"] 
  s.license     = 'MIT'

  s.description = <<-EOS
gdstruct - GDS (General Data Structure), a universal, composable data structure, used to store any kind of data. 
Typical usage is the definition of configurations, specifications and data sets. 
The GDS language is a special DSL (domain specific language) for defining general data structures. 
It uses a succinct, indentation-sensitive syntax which makes data representation clear and readable. 
EOS

  s.add_dependency 'treetop', '~> 1.6', '>= 1.6.9'

  s.add_development_dependency 'rake', '~> 12'
  s.add_development_dependency 'minitest', '~> 5.1'

end

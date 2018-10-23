require 'rake/testtask'

Rake::TestTask.new do |t|
  t.libs = [ 'test' ]
  t.test_files = FileList['test/test*.rb']
  t.verbose = true
end

desc "Gem build"
task :gembuild do
  puts `gem build gdstruct.gemspec`
end

desc "Run tests"
task :default => :test


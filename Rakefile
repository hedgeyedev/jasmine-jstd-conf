require 'rake'
require 'rspec/core/rake_task'
require "bundler/gem_tasks"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Update README.rdoc using lib/views/readme.mustache'
task :readme do
  require 'mustache'
  Mustache.template_path = 'lib/views'

  raw = File.read('lib/views/readme.mustache')
  rendered = Mustache.render(raw, :program_name => 'jasmine-jstd-conf')
  File.open('README.rdoc', 'w') { |f| f.puts(rendered) }
end

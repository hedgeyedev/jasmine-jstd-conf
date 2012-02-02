require 'rake'
require 'rspec/core/rake_task'
require "bundler/gem_tasks"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Update README.rdoc using lib/views/readme.mustache'
task :readme do
  require_relative './lib/jasmine-jstd-conf'

  raw = File.read('lib/views/readme.rdoc.mustache')
  rendered = Mustache.render(raw,
    Jasmine::JSTD::Conf.example.merge(:program_name => 'jasmine-jstd-conf')
  )

  File.open('README.rdoc', 'w') { |f| f.puts(rendered) }
end

desc 'Open a console for interactive development'
task :console do
  system 'irb -I lib -r jasmine-jstd-conf'
end

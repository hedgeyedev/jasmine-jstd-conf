require "jasmine-jstd-conf/version"
require 'rubygems'
require 'bundler'
require 'jasmine'
require 'mustache'

module Jasmine
  module JSTD
    module Conf
      # This looks like YAML, but it's hard to be sure...
      TEMPLATE = <<EOF
server: {{server}}

load:
  {{#paths}}
  - {{.}}
  {{/paths}}
EOF
    
      def self.map(doc)
        paths = doc.js_files
    
        paths = paths.map do |path|
          path.
            gsub(%r{^/}, '').
            gsub('__spec__', 'spec/javascripts')
        end

        paths.unshift('spec/javascripts/support/JasmineAdapter.js')
        paths.unshift(jasmine_js_path)
    
        {
          :server => 'http://localhost:9876',
          :paths => paths,
        }
      end
    
      def self.render
        Mustache.render(TEMPLATE, map(Jasmine::Config.new))
      end
    
      def self.write(path)
        File.open(path, 'w') { |f| f.puts render }
      end
    
      def self.show_usage
        puts <<EOF
Usage: #{$PROGRAM_NAME} path [--help]

  path        Path to write to.
  --help      Show this help text.

Based on jasmine.yml, write a JSTD config file to the supplied path.

Example:

  $ #{$PROGRAM_NAME} jsTestDriver.conf
  $ cat jsTestDriver.conf
  server: http://localhost:9876
  
  load:
    - /path/to/jasmine.js
    - spec/javascripts/support/JasmineAdapter.js
    - spec/javascripts/helpers/jasmine-jquery-1.3.1.js
    - spec/javascripts/FooSpec.js
    - spec/javascripts/BarSpec.js
    - spec/javascripts/BazSpec.js
    - spec/javascripts/QuxSpec.js
  # [...]
EOF
        exit -1
      end

      private

      def self.jasmine_js_path
        "#{locate_gem}/lib/jasmine-core/jasmine.js"
      end

      def self.locate_gem
        spec = Bundler.load.specs.find{|s| s.name == 'jasmine-core' }
        spec.full_gem_path
      end
    end
  end
end

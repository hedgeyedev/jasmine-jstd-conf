# Standard lib
require 'pathname'

# Relative
require "jasmine-jstd-conf/version"

# Gems
require 'rubygems'
require 'bundler'
require 'jasmine'
require 'mustache'

Mustache.template_path = 'lib/views'

module Jasmine
  module JSTD
    module Conf
      def self.example
        {
          :server => 'http://localhost:9876',
          :paths => [ 
            '../relative/path/to/jasmine.js',
            'spec/javascripts/support/JasmineAdapter.js',
            'spec/javascripts/helpers/jasmine-jquery-1.3.1.js',
            'spec/javascripts/FooSpec.js',
            'spec/javascripts/BarSpec.js',
            'spec/javascripts/BazSpec.js',
            'spec/javascripts/QuxSpec.js',
          ]
        }
      end

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
        Mustache.render(raw_mustache('conf'), map(Jasmine::Config.new))
      end
    
      def self.write(path)
        File.open(path, 'w') { |f| f.puts render }
      end
    
      def self.show_usage
        puts Mustache.render(raw_mustache('usage'), example.merge(:program_name => $PROGRAM_NAME))
        exit -1
      end

      private

      def self.jasmine_js_path
        # jsTestDriver can only use relative paths.  Not sure why...
        absolute_path = "#{locate_gem}/lib/jasmine-core/jasmine.js"
        relative_path = Pathname.new(absolute_path).relative_path_from(Pathname.pwd)
        relative_path.to_s
      end

      def self.locate_gem
        spec = Bundler.load.specs.find { |s| s.name == 'jasmine-core' }
        spec.full_gem_path
      end

      def self.raw_mustache(name)
        File.read(File.join(File.dirname(__FILE__), "views/#{name}.mustache"))
      end
    end
  end
end

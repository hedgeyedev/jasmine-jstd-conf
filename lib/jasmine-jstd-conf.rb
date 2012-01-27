require "jasmine-jstd-conf/version"
require 'rubygems'
require 'bundler'
require 'jasmine'
require 'mustache'

module Jasmine
  module JSTD
    module Conf
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
        puts Mustache.render(raw_mustache('usage'), {:program_name => $PROGRAM_NAME})
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

      def self.raw_mustache(name)
        File.read(File.join(File.dirname(__FILE__), "views/#{name}.mustache"))
      end
    end
  end
end

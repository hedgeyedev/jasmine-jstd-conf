require 'spec_helper'

module Jasmine::JSTD
  describe Conf do
    before(:each) do
      config = mock('Jasmine::Config', :js_files => [
        '/__spec__/FooSpec.rb',
        '/__spec__/BarSpec.rb',
      ])
      Jasmine::Config.stub(:new) { config }
    end

    describe 'the config file content' do
      def render
        Jasmine::JSTD::Conf.render
      end

      it 'includes the files specified in the Jasmine config' do
        rendered = render
        
        rendered.should match(%r{^  - spec/javascripts/FooSpec.rb$})
        rendered.should match(%r{^  - spec/javascripts/BarSpec.rb$})
      end

      it 'includes jasmine.js from the jasmine-core gem' do
        rendered = render
        
        md = rendered.match(%r{^  - (/.*?/jasmine.js)$})
        md.should_not be_nil
        jasmine_js_path = md[1]

        File.exists?(jasmine_js_path).should be_true
      end
    end
  end
end

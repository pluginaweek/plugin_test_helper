require 'rails_generator'

module PluginAWeek #:nodoc:
  module PluginTestHelper
    # The base generator for creating parts of the test application
    class Generator < Rails::Generator::NamedBase
      attr_accessor :plugin_name
      
      def initialize(*runtime_args) #:nodoc:
        @plugin_name = runtime_args.first.shift if runtime_args.first.is_a?(Array)
        super(*runtime_args)
      end
      
      private
        def plugin_test_root
          "vendor/plugins/#{plugin_name}/test"
        end
        
        def plugin_app_root
          "#{plugin_test_root}/app_root"
        end
    end
  end
end

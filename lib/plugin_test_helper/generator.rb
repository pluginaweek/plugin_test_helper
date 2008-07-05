require 'rails_generator'

module PluginAWeek #:nodoc:
  module PluginTestHelper
    # The base generator for creating parts of the test application. The first
    # argument of the generator is always the name of the plugin.
    class Generator < Rails::Generator::NamedBase
      attr_accessor :plugin_name
      
      def initialize(*runtime_args) #:nodoc:
        @plugin_name = runtime_args.first.shift if runtime_args.first.is_a?(Array)
        super(*runtime_args)
      end
      
      private
        # The root path of the plugin's test directory
        def plugin_test_root
          "vendor/plugins/#{plugin_name}/test"
        end
        
        # The root path of the plugin's test app
        def plugin_app_root
          "#{plugin_test_root}/app_root"
        end
    end
  end
end

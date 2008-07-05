module PluginAWeek #:nodoc:
  module PluginTestHelper
    # Assists in the initialization process by locating the plugin being tested
    # so that it is tested as if the plugin were loaded in a regular app
    class PluginLocator < Rails::Plugin::Locator
      def plugins
        [Rails::Plugin.new(File.expand_path('.'))]
      end
    end
  end
end

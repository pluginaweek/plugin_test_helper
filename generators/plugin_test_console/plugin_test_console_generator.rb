require 'plugin_test_helper/generator'

# Generates a test console for the plugin's test application.
class PluginTestConsoleGenerator < Rails::Generator::Base
  include PluginTestHelper::Generator
  
  def manifest #:nodoc:
    record do |m|
      # Script directory
      m.directory File.join(plugin_root, 'script')
      
      # Console class
      m.file 'console', File.join(plugin_root, 'script/console')
    end
  end
end

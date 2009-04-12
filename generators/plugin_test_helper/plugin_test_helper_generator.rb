require 'plugin_test_helper/generator'

# Generates the test helper for a plugin
class PluginTestHelperGenerator < Rails::Generator::Base
  include PluginTestHelper::Generator
  
  def manifest #:nodoc:
    record do |m|
      # Test directory
      m.directory File.join(plugin_root, 'test')
      
      # Test helper
      m.file 'test_helper.rb', File.join(plugin_root, 'test/test_helper.rb')
    end
  end
  
  protected
    def banner
      "Usage: #{$0} plugin_test_helper your_plugin"
    end
end

# Generates the test helper for a plugin
class PluginTestHelperGenerator < Rails::Generator::NamedBase
  def manifest #:nodoc:
    record do |m|
      plugin_root = "vendor/plugins/#{name}"
      
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

# Generates the test helper for a plugin
class PluginTestHelperGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      plugin_test_root = "vendor/plugins/#{name}/test"
      m.file 'test_helper.rb', "#{plugin_test_root}/test_helper.rb"
    end
  end
  
  protected
    def banner
      "Usage: #{$0} plugin_test_helper your_plugin"
    end
end

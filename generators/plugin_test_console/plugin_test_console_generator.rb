# Generates the class, helper, and view for a controller in a plugin's test application
class PluginTestConsoleGenerator < Rails::Generator::NamedBase
  def manifest
    record do |m|
      plugin_root = "vendor/plugins/#{name}"
      
      # Script directory.
      m.directory File.join(plugin_root, 'script')
      
      # Console class.
      m.file 'console', File.join(plugin_root, 'script/console')
    end
  end
end

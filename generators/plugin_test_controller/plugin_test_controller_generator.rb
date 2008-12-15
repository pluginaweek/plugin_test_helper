# Generates the class and view for a controller in a plugin's test application
class PluginTestControllerGenerator < PluginTestHelper::Generator
  def manifest #:nodoc:
    record do |m|
      # Check for class naming collisions
      m.class_collisions class_path, "#{class_name}Controller", "#{class_name}Helper"
      
      # Controller and views directories
      m.directory File.join(plugin_app_root, 'app/controllers', class_path)
      m.directory File.join(plugin_app_root, 'app/views', class_path, file_name)
      
      # Controller class
      m.template 'controller.rb', File.join(plugin_app_root, 'app/controllers', class_path, "#{file_name}_controller.rb")
      
      # View template for each action
      actions.each do |action|
        path = File.join(plugin_app_root, 'app/views', class_path, file_name, "#{action}.html.erb")
        m.template 'view.html.erb', path, :assigns => {:action => action, :path => path}
      end
    end
  end
end

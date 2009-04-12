require 'plugin_test_helper/generator'

# Generates the class, fixtures, and migration for a model in a plugin's test application
class PluginTestModelGenerator < Rails::Generator::NamedBase
  include PluginTestHelper::Generator
  
  def manifest #:nodoc:
    record do |m|
      # Check for class naming collisions
      m.class_collisions class_path, class_name
      
      # Model and fixture directories
      m.directory File.join(plugin_app_root, 'app/models', class_path)
      m.directory File.join(plugin_test_root, 'fixtures', class_path)
      
      # Model class and fixtures
      m.template 'model.rb',      File.join(plugin_app_root, 'app/models', class_path, "#{file_name}.rb")
      m.template 'fixtures.yml',  File.join(plugin_test_root, 'fixtures', class_path, "#{table_name}.yml")
      
      # Migration
      m.migration_template 'migration.rb', "#{plugin_app_root}/db/migrate", :assigns => {
        :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}"
      }, :migration_file_name => "create_#{file_path.gsub(/\//, '_').pluralize}"
    end
  end

  protected
    def banner
      "Usage: #{$0} generate your_plugin ModelName [field:type, field:type]"
    end
end

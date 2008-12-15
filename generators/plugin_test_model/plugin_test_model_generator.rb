# Generates the class, fixtures, and migration for a model in a plugin's test application
class PluginTestModelGenerator < PluginTestHelper::Generator
  default_options :skip_migration => false
  
  def manifest #:nodoc:
    record do |m|
      # Check for class naming collisions.
      m.class_collisions class_path, class_name
      
      # Model and fixture directories.
      m.directory File.join(plugin_app_root, 'app/models', class_path)
      m.directory File.join(plugin_test_root, 'fixtures', class_path)
      
      # Model class and fixtures.
      m.template 'model.rb',      File.join(plugin_app_root, 'app/models', class_path, "#{file_name}.rb")
      m.template 'fixtures.yml',  File.join(plugin_test_root, 'fixtures', class_path, "#{table_name}.yml")
      
      unless options[:skip_migration]
        m.migration_template 'migration.rb', "#{plugin_app_root}/db/migrate", :assigns => {
          :migration_name => "Create#{class_name.pluralize.gsub(/::/, '')}"
        }, :migration_file_name => "create_#{file_path.gsub(/\//, '_').pluralize}"
      end
    end
  end

  protected
    def banner
      "Usage: #{$0} generate your_plugin ModelName [field:type, field:type]"
    end
    
    def add_options!(opt)
      opt.separator ''
      opt.separator 'Options:'
      opt.on('--skip-migration',  "Don't generate a migration file for this model") {|v| options[:skip_migration] = v}
    end
end

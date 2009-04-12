require 'plugin_test_helper/generator'

# Generates migrations for a plugin's test application
class PluginTestMigrationGenerator < Rails::Generator::NamedBase
  include PluginTestHelper::Generator
  
  def manifest #:nodoc:
    record do |m|
      m.migration_template 'migration.rb', "#{plugin_app_root}/db/migrate"
    end
  end
end

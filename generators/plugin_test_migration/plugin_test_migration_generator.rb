# Generates migrations for a plugin's test application
class PluginTestMigrationGenerator < PluginAWeek::PluginTestHelper::Generator
  def manifest
    record do |m|
      m.migration_template 'migration.rb', "#{plugin_app_root}/db/migrate"
    end
  end
end

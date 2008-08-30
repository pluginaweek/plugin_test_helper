require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class PluginTestMigrationGeneratorTest < Test::Unit::TestCase
  def setup
    setup_app('empty')
    
    require 'rails_generator'
    require 'rails_generator/scripts/generate'
    Rails::Generator::Base.sources << Rails::Generator::PathSource.new(:plugin_test_migration, "#{Rails.root}/../../generators")
    Rails::Generator::Scripts::Generate.new.run(['plugin_test_migration', 'acts_as_foo', 'create_bars'])
  end
  
  def test_should_create_migration
    migration_path = Dir["#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/db/migrate/*"].first
    assert_not_nil migration_path
    assert_match /^.*_create_bars.rb$/, migration_path
  end
  
  def teardown
    teardown_app
  end
end

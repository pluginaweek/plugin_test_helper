require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class PluginTestModelGeneratorTest < Test::Unit::TestCase
  def setup
    setup_app('empty')
    
    require 'rails_generator'
    require 'rails_generator/scripts/generate'
    Rails::Generator::Base.sources << Rails::Generator::PathSource.new(:plugin_test_model, "#{Rails.root}/../../generators")
    Rails::Generator::Scripts::Generate.new.run(['plugin_test_model', 'acts_as_foo', 'bar'])
  end
  
  def test_should_create_model
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/app/models/bar.rb")
  end
  
  def test_should_create_migration
    migration_path = Dir["#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/db/migrate/*"].first
    assert_not_nil migration_path
    assert_match /^.*_create_bars.rb$/, migration_path
  end
  
  def test_should_create_fixtures
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/fixtures/bars.yml")
  end
  
  def teardown
    teardown_app
  end
end

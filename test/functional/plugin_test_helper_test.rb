require File.expand_path(File.dirname(__FILE__) + '/../test_helper')
require 'fileutils'

class PluginTestHelperTest < Test::Unit::TestCase
  def setup
    @original_load_path = $LOAD_PATH
  end
  
  def test_should_load_with_no_app_root
    load 'plugin_test_helper.rb'
    assert_valid_environment
  end
  
  def test_should_load_with_empty_app_root
    setup_app('empty')
  end
  
  def test_should_load_with_custom_application_controller
    setup_app('with_custom_application_controller')
    
    assert ApplicationController.respond_to?(:custom?)
  end
  
  def test_should_load_with_custom_config
    setup_app('with_custom_config')
    
    assert_not_nil ActsAsFoo
  end
  
  def test_should_load_with_controller
    setup_app('with_controller')
    
    assert_not_nil PeopleController
  end
  
  def test_should_load_with_model
    setup_app('with_model')
    
    assert_not_nil Person
  end
  
  def test_should_load_with_helper
    setup_app('with_helper')
    
    assert_not_nil PeopleHelper
  end
  
  def test_should_load_with_migration
    setup_app('with_migration')
    
    ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate")
    assert Person.table_exists?
  end
  
  def test_should_load_with_fixtures
    setup_app('with_fixtures')
    
    ActiveRecord::Migrator.migrate("#{Rails.root}/db/migrate")
    
    fixtures_path = "#{File.dirname(__FILE__)}/../fixtures"
    Dir.glob("#{fixtures_path}/*.yml").each do |fixture_file|
      Fixtures.create_fixtures(fixtures_path, File.basename(fixture_file, '.*'))
    end
    
    assert Person.count > 0
  end
  
  def test_should_load_with_routes
    setup_app('with_routes')
    
    assert ActionController::Routing::Routes.routes.length == 0
  end
  
  def teardown
    teardown_app
    
    $LOAD_PATH.replace(@original_load_path)
  end
end

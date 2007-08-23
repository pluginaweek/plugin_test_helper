require File.dirname(__FILE__) + '/../test_helper'
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
    initialize_app('empty')
  end
  
  def test_should_load_with_custom_application_controller
    initialize_app('with_custom_application_controller')
    
    assert ApplicationController.respond_to?(:custom?)
  end
  
  def test_should_load_with_custom_config
    initialize_app('with_custom_config')
    
    assert_not_nil PluginAWeek::Acts::Foo
  end
  
  def test_should_load_with_controller
    initialize_app('with_controller')
    
    assert_not_nil PeopleController
  end
  
  def test_should_load_with_model
    initialize_app('with_model')
    
    assert_not_nil Person
  end
  
  def test_should_load_with_helper
    initialize_app('with_helper')
    
    assert_not_nil PeopleHelper
  end
  
  def test_should_load_with_migration
    initialize_app('with_migration')
    
    ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")
    assert Person.table_exists?
  end
  
  def test_should_load_with_fixtures
    initialize_app('with_fixtures')
    
    ActiveRecord::Migrator.migrate("#{RAILS_ROOT}/db/migrate")
    Dir.glob("#{RAILS_ROOT}/test/fixtures/*.yml").each do |fixture_file|
      Fixtures.create_fixtures("#{RAILS_ROOT}/test/fixtures", File.basename(fixture_file, '.*'))
    end
    
    assert Person.count > 0
  end
  
  def test_should_load_with_routes
    initialize_app('with_routes')
    
    assert ActionController::Routing::Routes.routes.length == 0
  end
  
  def teardown
    # Clear dependencies
    ActiveRecord::Base.reset_subclasses
    Dependencies.clear
    ActiveRecord::Base.clear_reloadable_connections!
    
    $LOAD_PATH.replace(@original_load_path)
    FileUtils.rmtree('test/app_root')
  end
  
  private
  def assert_valid_environment
    assert_not_nil ApplicationController
    assert ActiveRecord::Base.connection.active?
  end
  
  def initialize_app(name)
    FileUtils.mkdir('test/app_root')
    FileUtils.cp_r("test/app_roots/#{name}/.", 'test/app_root')
    
    load 'plugin_test_helper.rb'
    assert_valid_environment
  end
end

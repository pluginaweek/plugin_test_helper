require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class PluginTestStructureGeneratorTest < Test::Unit::TestCase
  def setup
    setup_app('empty')
    
    require 'rails_generator'
    require 'rails_generator/scripts/generate'
    Rails::Generator::Base.sources << Rails::Generator::PathSource.new(:plugin_test_structure, "#{Rails.root}/../../generators")
    Rails::Generator::Scripts::Generate.new.run(['plugin_test_structure', 'acts_as_foo'])
  end
  
  def test_should_create_application_controller
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/app/controllers/application.rb")
  end
  
  def test_should_create_in_memory_environment
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/config/environments/in_memory.rb")
  end
  
  def test_should_create_mysql_environment
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/config/environments/mysql.rb")
  end
  
  def test_should_create_postgresql_environment
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/config/environments/postgresql.rb")
  end
  
  def test_should_create_sqlite_environment
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/config/environments/sqlite.rb")
  end
  
  def test_should_create_sqlite3_environment
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/config/environments/sqlite3.rb")
  end
  
  def test_should_create_boot_file
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/config/boot.rb")
  end
  
  def test_should_create_database_configuration
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/config/database.yml")
  end
  
  def test_should_create_environment_configuration
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/config/environment.rb")
  end
  
  def test_should_create_routes
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/config/routes.rb")
  end
  
  def teardown
    teardown_app
  end
end

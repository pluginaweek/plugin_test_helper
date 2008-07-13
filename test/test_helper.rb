require 'test/unit'
require 'fileutils'

$:.unshift("#{File.dirname(__FILE__)}/../lib")

FileUtils.rmtree('test/app_root')
FileUtils.mkdir('test/app_root')

class Test::Unit::TestCase
  private
    def assert_valid_environment
      assert_not_nil ApplicationController
      assert ActiveRecord::Base.connection.active?
    end
    
    def setup_app(name)
      FileUtils.cp_r(Dir.glob("test/app_roots/#{name}/*"), 'test/app_root')
      
      load 'plugin_test_helper.rb'
      assert_valid_environment
    end
    
    def teardown_app
      # Clear dependencies
      self.class.use_transactional_fixtures = false
      ActiveRecord::Base.reset_subclasses
      Dependencies.clear
      ActiveRecord::Base.clear_reloadable_connections!
      
      # Forget that the environment files were loaded so that a new app environment
      # can be set up again
      $".delete('config/environment.rb')
      $".delete('test_help.rb')
    end
end

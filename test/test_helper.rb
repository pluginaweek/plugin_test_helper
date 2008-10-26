require 'test/unit'
require 'fileutils'

$:.unshift("#{File.dirname(__FILE__)}/../lib")

# Ensure the app root is empty
FileUtils.rm_rf('test/app_root')
FileUtils.mkdir('test/app_root')

# Use an in-memory log so that the app root can be removed without having to
# close all loggers in use
require 'logger'
require 'stringio'
Object.const_set('RAILS_DEFAULT_LOGGER', Logger.new(StringIO.new))

Test::Unit::TestCase.class_eval do
  private
    def assert_valid_environment
      assert_not_nil ApplicationController
      assert ActiveRecord::Base.connection.active?
    end
    
    def setup_app(name)
      FileUtils.cp_r(Dir["test/app_roots/#{name}/*"], 'test/app_root')
      
      # Load the environment
      load 'plugin_test_helper.rb'
      assert_valid_environment
    end
    
    def teardown_app
      # Clear dependencies
      self.class.use_transactional_fixtures = false
      ActiveRecord::Base.reset_subclasses
      Dependencies.clear
      
      # Reset open streams
      ActiveRecord::Base.clear_reloadable_connections!
      
      # Forget that the environment files were loaded so that a new app environment
      # can be set up again
      $".delete('config/environment.rb')
      $".delete('test_help.rb')
      
      # Remove the app folder
      FileUtils.rm_r(Dir['test/app_root/*'])
    end
end

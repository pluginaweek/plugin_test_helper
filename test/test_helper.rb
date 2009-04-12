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
  def self.reset_environment
    # Clear dependencies
    ActiveRecord::Base.reset_subclasses
    ActiveSupport::Dependencies.clear
    
    # Clear configurations
    ActionController::Routing.controller_paths.clear
    ActionController::Routing::Routes.configuration_files.clear
    Rails::Rack::Metal.requested_metals.clear if Rails::Rack::Metal.requested_metals
    Rails::Rack::Metal.metal_paths.clear if Rails::Rack::Metal.metal_paths
    
    # Reset open streams
    ActiveRecord::Base.clear_reloadable_connections!
    
    # Forget that the environment files were loaded so that a new app environment
    # can be set up again
    $".delete_if {|path| path =~ /(config\/environment\.rb|test_help\.rb)$/}
  end
  
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
      self.class.reset_environment
      
      # Remove the app folder
      FileUtils.rm_r(Dir['test/app_root/*'])
    end
end

# Load the helper once before tests start so that the Rails library paths
# don't get lost betweeen environment loads
require 'plugin_test_helper'
Test::Unit::TestCase.reset_environment

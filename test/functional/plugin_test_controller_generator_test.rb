require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class PluginTestControllerGeneratorTest < Test::Unit::TestCase
  def setup
    setup_app('empty')
    
    require 'rails_generator'
    require 'rails_generator/scripts/generate'
    Rails::Generator::Base.sources << Rails::Generator::PathSource.new(:plugin_test_controller, "#{Rails.root}/../../generators")
    Rails::Generator::Scripts::Generate.new.run(['plugin_test_controller', 'acts_as_foo', 'site', 'index'])
  end
  
  def test_should_create_controller
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/app/controllers/site_controller.rb")
  end
  
  def test_should_create_view
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/app_root/app/views/site/index.html.erb")
  end
  
  def teardown
    teardown_app
    FileUtils.rm_r(Dir.glob('test/app_root/*'))
  end
end

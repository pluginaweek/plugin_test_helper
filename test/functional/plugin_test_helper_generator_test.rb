require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class PluginTestHelperGeneratorTest < Test::Unit::TestCase
  def setup
    setup_app('empty')
    
    require 'rails_generator'
    require 'rails_generator/scripts/generate'
    Rails::Generator::Base.sources << Rails::Generator::PathSource.new(:plugin_test_helper, "#{Rails.root}/../../generators")
    Rails::Generator::Scripts::Generate.new.run(['plugin_test_helper', 'acts_as_foo'])
  end
  
  def test_should_create_test_helper
    assert File.exists?("#{Rails.root}/vendor/plugins/acts_as_foo/test/test_helper.rb")
  end
  
  def teardown
    teardown_app
    FileUtils.rm_r(Dir.glob('test/app_root/*'))
  end
end

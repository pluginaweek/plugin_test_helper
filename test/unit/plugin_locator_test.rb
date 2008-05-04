require File.expand_path(File.dirname(__FILE__) + '/../test_helper')

class PluginLocatorTest < Test::Unit::TestCase
  def setup
    @original_load_path = $LOAD_PATH
    setup_app('empty')
  end
  
  def test_should_locate_plugin_being_tested
    locator = PluginAWeek::PluginTestHelper::PluginLocator.new(nil)
    assert_equal ['plugin_test_helper'], locator.plugins.map(&:name)
  end
  
  def teardown
    teardown_app
    $LOAD_PATH.replace(@original_load_path)
    FileUtils.rm_r(Dir.glob('test/app_root/*'))    
  end
end

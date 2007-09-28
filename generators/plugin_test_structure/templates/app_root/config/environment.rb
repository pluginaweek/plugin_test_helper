require 'config/boot'

Rails::Initializer.run do |config|
  config.plugin_paths << '..'
  config.plugins = [File.basename(File.expand_path('.'))]
  config.cache_classes = false
  config.frameworks -= [:action_web_service]
  config.whiny_nils = true
end

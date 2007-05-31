require 'config/boot'

Rails::Initializer.run do |config|
  config.log_level = :debug
  config.cache_classes = false
  config.whiny_nils = true
  config.breakpoint_server = true
  config.load_paths << "#{RAILS_ROOT}/../../lib"
end

Dependencies.log_activity = true
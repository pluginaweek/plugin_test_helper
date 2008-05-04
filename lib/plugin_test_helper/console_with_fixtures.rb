(ENV['FIXTURES'] ? ENV['FIXTURES'].split(/,/) : Dir.glob(File.join(RAILS_ROOT, '../fixtures/*.{yml,csv}'))).each do |fixture_file|
  Fixtures.create_fixtures(File.join(RAILS_ROOT, '../fixtures'), File.basename(fixture_file, '.*'))
end

(ENV['FIXTURES'] ? ENV['FIXTURES'].split(/,/) : Dir.glob(File.join(RAILS_ROOT, 'test', 'fixtures', '*.{yml,csv}'))).each do |fixture_file|
  Fixtures.create_fixtures(File.join(RAILS_ROOT, 'test/fixtures'), File.basename(fixture_file, '.*'))
end

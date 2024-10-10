
VCR.configure do |config|
  config.cassette_library_dir = 'spec/vcr_cassettes'
  config.hook_into :faraday
  config.configure_rspec_metadata!
  config.debug_logger = $stderr
end

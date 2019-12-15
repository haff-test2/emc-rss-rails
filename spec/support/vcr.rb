VCR.configure do |cfg|
  cfg.hook_into :faraday
  cfg.cassette_library_dir = 'spec/vcr'
  cfg.default_cassette_options = { preserve_exact_body_bytes: false }
  cfg.configure_rspec_metadata!
end

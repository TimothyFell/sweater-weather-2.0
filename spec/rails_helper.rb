require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
require 'vcr'
require 'webmock/rspec'
require 'securerandom'


VCR.configure do |config|
  config.ignore_localhost = true
  config.cassette_library_dir = 'spec/cassettes'
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<GEOCODING_API_KEY>") { ENV['GEOCODING_API_KEY'] }
  config.filter_sensitive_data("<DARK_SKY_API_KEY>") { ENV['DARK_SKY_API_KEY'] }
  config.filter_sensitive_data("<GIPHY_API_KEY>") { ENV['GIPHY_API_KEY'] }
end

SimpleCov.start "rails" do
  add_filter "app/channels"
  add_filter "app/jobs"
  add_filter "app/mailers"
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec

    with.library :rails
  end
end

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!
end

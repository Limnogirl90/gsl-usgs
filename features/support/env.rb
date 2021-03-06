require 'coveralls'
Coveralls.wear_merged!("rails")

DIR = File.dirname(__FILE__)
require DIR + '/../../config/environment'
unless Rails.env.test?
  puts "Please use RAILS_ENV=test for safety. Run:"
  puts "RAILS_ENV=test cucumber"
  exit 1
end

ActiveRecord::Migration.maintain_test_schema!

require 'cucumber/rails'

ActionController::Base.allow_rescue = false

# Remove/comment out the lines below if your app doesn't have a database.
# For some databases (like MongoDB and CouchDB) you may need to use :truncation instead.
begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

# You may also want to configure DatabaseCleaner to use different strategies for certain features and scenarios.
# See the DatabaseCleaner documentation for details. Example:
#
#   Before('@no-txn,@selenium,@culerity,@celerity,@javascript') do
#     # { :except => [:widgets] } may not do what you expect here
#     # as Cucumber::Rails::Database.javascript_strategy overrides
#     # this setting.
#     DatabaseCleaner.strategy = :truncation
#   end
#
#   Before('~@no-txn', '~@selenium', '~@culerity', '~@celerity', '~@javascript') do
#     DatabaseCleaner.strategy = :transaction
#   end
#

# Possible values are :truncation and :transaction
# The :transaction strategy is faster, but might give you threading problems.
# See https://github.com/cucumber/cucumber-rails/blob/master/features/choose_javascript_database_strategy.feature
Cucumber::Rails::Database.javascript_strategy = :truncation

Before do
  fixtures_to_load =
    %w[
      datasets
    ]

  fixtures_file_spec = "{#{fixtures_to_load.join ','}}.yml"

  ActiveRecord::FixtureSet.reset_cache
  fixtures_folder = File.join(Rails.root, 'spec', 'fixtures')
  fixtures = Dir[File.join(fixtures_folder, fixtures_file_spec)].map { |f| File.basename(f, '.yml') }
  ActiveRecord::FixtureSet.create_fixtures(fixtures_folder, fixtures)
end

Capybara.register_driver :chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

Capybara.register_driver :headless_chrome do |app|
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w(headless disable-gpu) }
  )

  Capybara::Selenium::Driver.new app,
    browser: :chrome,
    desired_capabilities: capabilities
end

Capybara.javascript_driver = :headless_chrome

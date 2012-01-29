require 'rubygems'
require 'spork'
require 'devise'

module ControllerMacros
  def login_admin
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      @admin_user = Factory.create(:admin)
      sign_in @admin_user
    end
  end
  
  def login_user
    before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @logged_in_user = Factory.create(:user)
      sign_in @logged_in_user
    end
  end
end

Spork.prefork do
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'factory_girl'
  
  Rails.env ||= 'test'

  # Requires supporting ruby files with custom matchers and macros, etc,
  # in spec/support/ and its subdirectories.
  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    config.use_transactional_fixtures = true
    config.include ControllerMacros, :type => :controller
    config.include ControllerMacros, :type => :request
    config.include Devise::TestHelpers, :type => :controller
  end

end

Spork.each_run do
  require 'factory_girl_rails'
  Dir.glob(File.join(File.dirname(__FILE__), '../../spec/factories/*.rb')).each {|f| require f }

  Dir[Rails.root.join("lib/**/*.rb")].each {|f| require f}
  #devise is caching the user model
  load File.expand_path(File.dirname(__FILE__) + '/../app/models/user.rb')
end


RSpec.configure do |config|
  config.treat_symbols_as_metadata_keys_with_true_values = true
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
end

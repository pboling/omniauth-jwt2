# Std Lib
require 'securerandom'

# 3rd party gems
begin
  require 'rack/session'
rescue LoadError
  nil # File won't exist in old rack for Ruby 2.2 & 2.3
end
require 'rack/test'
require 'json'
require 'omniauth'
require 'openssl'
begin
  require 'openssl/signature_algorithm'
rescue LoadError
  nil # Gem doesn't exist for ancient Rubies 2.2 & 2.3
end
require 'ed25519'

require 'byebug' if ENV['DEBUG'] == 'true'
# This does not require "simplecov",
#   because that has a side-effect of running `.simplecov`
begin
  require 'kettle-soup-cover'
rescue LoadError
  puts "Not analyzing test coverage"
end

require 'support/hash'
require 'support/next_instance_of'

OmniAuth.config.logger = Logger.new('/dev/null')
require 'omniauth/version'
puts "OMNIAUTH VERSION: #{OmniAuth::VERSION}"
if Gem::Version.new(OmniAuth::VERSION) > Gem::Version.new('2.0')
  OmniAuth.config.silence_get_warning = true
  OmniAuth.config.allowed_request_methods |= [:get, :post]
end
# This file was generated by the `rspec --init` command. Conventionally, all
# specs live under a `spec` directory, which RSpec adds to the `$LOAD_PATH`.
# Require this file using `require "spec_helper"` to ensure that it is only
# loaded once.
#
# See http://rubydoc.info/gems/rspec-core/RSpec/Core/Configuration
RSpec.configure do |config|
  config.run_all_when_everything_filtered = true
  config.filter_run :focus

  include Rack::Test::Methods
  include NextInstanceOf

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = 'random'
end

# Last thing before loading this library, load simplecov:
require 'simplecov' if defined?(Kettle::Soup::Cover) && Kettle::Soup::Cover::DO_COV

require 'omniauth/jwt'

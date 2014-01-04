require 'rubygems'
require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'])

use Rack::CanonicalHost, ENV['CANONICAL_HOST'] if ENV['CANONICAL_HOST']

require './whiskey'
run Whiskey

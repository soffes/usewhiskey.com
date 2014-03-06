require 'rubygems'
require 'bundler'
Bundler.require(:default, ENV['RACK_ENV'])

use Rack::CanonicalHost, ENV['CANONICAL_HOST'] if ENV['CANONICAL_HOST']

map '/assets' do
  sprockets = Sprockets::Environment.new
  sprockets.append_path 'assets/stylesheets'
  sprockets.append_path 'assets/images'
  run sprockets
end

require './whiskey'
run Whiskey

#Use bundler
require 'bundler'
Bundler.require

$LOAD_PATH.unshift 'lib'

require 'rack/cache'
use Rack::Cache

require 'main'
run Blog

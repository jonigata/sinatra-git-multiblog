require 'bundler'
Bundler.require

$LOAD_PATH.unshift 'lib'

use Rack::Cache

require 'main'
run Blog

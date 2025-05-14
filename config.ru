# config.ru
require './app'
require 'rack'

use Rack::Session::Cookie, key: 'rack.session', secret: 'super_secret_key'
run Sinatra::Application

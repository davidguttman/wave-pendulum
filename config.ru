require 'rubygems'
require 'open-uri'
require 'sinatra'

mime_type :coffee, "text/coffeescript"

set :public, File.dirname(__FILE__) + '/public'

get '/' do
  open(File.dirname(__FILE__) + '/public/index.html').read
end

get '/b' do
  open(params[:url]).read
end

run Sinatra::Application
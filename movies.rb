require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'lib/models'
require 'rfeedparser'
require 'rack-flash'

use Rack::Session::Cookie
use Rack::Flash

configure do
  require File.join(File.dirname(__FILE__), 'config', 'movies.rb')
end

get '/update' do
  count = Torrent.update
  torrents = Torrent.all
  flash[:notice] = "#{count} new movies added"
  redirect '/'
end

get '/' do
  @torrents = Torrent.all(:order => [:added_at.desc])
  haml :index
end

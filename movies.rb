require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'lib/models'
require 'rfeedparser'

configure do
  require File.join(File.dirname(__FILE__), 'config', 'movies.rb')
end

get '/update' do
  Torrent.update
  torrents = Torrent.all
  torrents.size.to_s
end

get '/' do
  @torrents = Torrent.all(:order => [:added_at.desc])
  haml :index
end

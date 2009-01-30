require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'lib/models'
require 'rfeedparser'

get '/update' do
  urls = %w(http://www.mininova.org/rss.xml?user=axxo http://www.mininova.org/rss.xml?user=klaxxon http://www.mininova.org/rss.xml?user=fxm)
  urls.each do |url|
    feed = FeedParser.parse(url)
    feed.entries.each do |entry|
      title = entry.title.gsub(/\(\d+S\/\d+L\)/, '').strip
      torrent = Torrent.first(:title => title)
      if torrent.nil?
        new_torrent = Torrent.new :title => title, :link => entry.link, :added_at => entry.updated_time
        new_torrent.save
      end
    end
  end
  torrents = Torrent.all
  torrents.size.to_s
end

get '/' do
  @torrents = Torrent.all(:order => [:added_at.desc])
  haml :index
end

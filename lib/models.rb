class Torrent
  include DataMapper::Resource
  property :id, Integer, :serial => true
  property :title, String, :length => 255
  property :link, String, :length => 255
  property :added_at, DateTime
  property :created_at, DateTime
  property :updated_at, DateTime

  def self.update
    urls = %w(http://www.mininova.org/rss.xml?user=axxo http://www.mininova.org/rss.xml?user=klaxxon http://www.mininova.org/rss.xml?user=fxm)
    count = 0
    urls.each do |url|
      feed = FeedParser.parse(url)
      feed.entries.each do |entry|
        title = entry.title.gsub(/\(\d+S\/\d+L\)/, '').strip
        torrent = Torrent.first(:title => title)
        if torrent.nil?
          new_torrent = Torrent.new :title => title, :link => entry.link, :added_at => entry.updated_time
          saved = new_torrent.save
          count = count + 1 if saved
        end
      end
    end
    return count
  end
end

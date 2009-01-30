DataMapper.setup(:default, "postgres://localhost/movies_development")
class Torrent
  include DataMapper::Resource
  property :id, Integer, :serial => true
  property :title, String, :length => 255
  property :link, String, :length => 255
  property :added_at, DateTime
  property :created_at, DateTime
  property :updated_at, DateTime
end

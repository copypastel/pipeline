class Video
  include DataMapper::Resource
  
  property :id, Serial
  property :url, String
  property :title, String
  property :created_at, DateTime
  property :ip, String

end

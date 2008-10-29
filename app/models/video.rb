class Video
  include DataMapper::Resource
  
  property :id, Serial
  property :url, String
  property :title, String, :default => "Pending..."
  property :created_at, DateTime
  property :updated_at, DateTime
  property :ip, String
  property :count, Integer, :default => 0
  
  def video_id
    url.gsub(/.*youtube.com\/watch\?v=/, '')
  end

  def self.latest
    self.first :order => [:updated_at.desc]
  end

end

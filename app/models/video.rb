class Video
  include DataMapper::Resource
  @@validation_url = 'http://gdata.youtube.com/feeds/api/videos/'
  
  property :id, Serial
  property :url, Text, :lazy => false
  property :title, Text, :lazy => false, :default => "Pending..."
  property :created_at, DateTime
  property :updated_at, DateTime
  property :ip, String
  property :count, Integer, :default => 0
  property :thumbnail, String, :nullable => :false
  
  class << self
    def list
      self.all :order => [:updated_at.desc]
    end
  end
  
  before :valid? do
    validation_url = @@validation_url + self.url.gsub(/.*youtube.com\/watch\?v=/, '').gsub(/&.*/, '')
    result = Net::HTTP.get(Module::URI.parse(validation_url))
    
    self.errors.add(:url, "Check video url.") and throw :halt if result == 'Invalid id'
    
    parser = Hpricot(result)
    thumbnail = (parser/'media:thumbnail')[1]
    title = (parser/'media:title').first
    embedable_tag = (parser/'yt:noembed')
    
    self.errors.add(:url, 'Video is not embeddable.') and throw :halt unless embedable_tag.empty?
    #Makes sure program does not crash if youtube changes XML format
    begin
      self.thumbnail = thumbnail[:url]
      self.title = title.inner_html
    rescue
      self.errors.add(:url, 'Video has improper format.')
      throw :halt
    end
  end
    
  def next
    Video.first :updated_at.gt => self.updated_at, :order => [:updated_at.asc]
  end
  
  def video_id
    url.gsub(/.*youtube.com\/watch\?v=/, '').gsub(/&.*/, '')
  end

  def self.latest
    self.first :order => [:updated_at.desc]
  end

  def to_json
    hash = self.attributes
    hash[:video_id] = self.video_id
    hash.to_json
  end

end

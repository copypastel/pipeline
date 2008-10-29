class Video
  include DataMapper::Resource
  
  @@validation_url = 'http://gdata.youtube.com/feeds/api/videos/'
  
  property :id, Serial
  property :url, Text, :lazy => false, :format => Proc.new {|str|
    unless str.nil?
      url = @@validation_url + str.gsub(/.*youtube.com\/watch\?v=/, '').gsub(/&.*/, '')
      result = Net::HTTP.get(Module::URI.parse(url))
      if result == 'Invalid id'
        false
      else
        true
      end
    else
      false
    end
    }
  property :title, String, :default => "Pending..."
  property :created_at, DateTime
  property :updated_at, DateTime
  property :ip, String
  property :count, Integer, :default => 0
  property :thumbnail, String, :nullable => :false
  
  before :valid? do
    validation_url = @@validation_url + self.url.gsub(/.*youtube.com\/watch\?v=/, '').gsub(/&.*/, '')
    result = Net::HTTP.get(Module::URI.parse(validation_url))
    parser = Hpricot(result)
    thumbnail = (parser/'media:thumbnail')[1]
    title = (parser/'media:title').first
    if thumbnail
      self.thumbnail = thumbnail[:url]
    end
    if title
      self.title = title.inner_html
    end
  end
  
  def video_id
    url.gsub(/.*youtube.com\/watch\?v=/, '')
  end

  def self.latest
    self.first :order => [:updated_at.desc]
  end

end

class Playlist
  include DataMapper::Resource
  
  property :id, Serial

  def next_video
    video = Video.first :updated_at.gt => self.updated_at, :order => [:updated_at.asc]
  end
  
  def current_video
  end

end

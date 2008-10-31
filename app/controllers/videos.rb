class Videos < Application

  # ...and remember, everything returned from an action
  # goes to the client...
  
  provides :html, :json
  
  def index
    @videos = Video.list
    @video = Video.latest
    render
  end
  
  def create(url)
    # If this url has already been submitted, we only need to increase the count
    url.strip!
    if video = Video.first( :url => url)
      video.count += 1
      video.save
    else
      vid = Video.create( :url => url, :ip => request.remote_ip )
      unless vid.valid?
        return vid.errors[:url].first
      end
    end
    "true"
  end
  
  def show(id)
    @videos = Video.list
    @video = Video.get(id)
    render
  end
  
  def playlist
    @videos = Video.list
    partial :playlist
  end
  
  def next(id)
    video = Video.get(id).next
    unless video.nil?
      return video.to_json 
    end
    return {:result => "false"}.to_json
  end
  
end

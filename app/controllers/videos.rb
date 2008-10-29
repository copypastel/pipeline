class Videos < Application

  # ...and remember, everything returned from an action
  # goes to the client...
  
  def index
    @video = Video.latest
    render
  end
  
  def create(url)
    # If this url has already been submitted, we only need to increase the count
    if video = Video.first( :url => url )
      video.count += 1
      video.save
    else
      unless Video.create( :url => url, :ip => request.remote_ip ).valid?
        return "false"
      end
    end
    "true"
  end
  
  def show(id)
    @video = Video.get(id)
    render
  end
  
end

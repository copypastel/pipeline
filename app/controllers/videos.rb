class Videos < Application

  # ...and remember, everything returned from an action
  # goes to the client...
  def index
    render
  end
  
  def create(params)
    # If this url has already been submitted, we only need to increase the count
    if video = Video.find( :url => params[:url] )
      video.count += 1
      video.save
    else
      unless Video.create( :url => params[:url], :ip => request.remote_ip )
        return partial( :not_created )
      end
    end
    partial :created
  end
  
  def show(id)
    @video = Video.get(id)
    render
  end
  
end

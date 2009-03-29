class Videos < Application
  # provides :xml, :yaml, :js

  def index
    @videos = Video.all
    display @videos
  end

  def show(id)
    @video = Video.get(id)
    raise NotFound unless @video
    display @video
  end

  def new
    only_provides :html
    @video = Video.new
    display @video
  end

  def edit(id)
    only_provides :html
    @video = Video.get(id)
    raise NotFound unless @video
    display @video
  end

  def create(video)
    @video = Video.new(video)
    if @video.save
      redirect resource(@video), :message => {:notice => "Video was successfully created"}
    else
      message[:error] = "Video failed to be created"
      render :new
    end
  end

  def update(id, video)
    @video = Video.get(id)
    raise NotFound unless @video
    if @video.update_attributes(video)
       redirect resource(@video)
    else
      display @video, :edit
    end
  end

  def destroy(id)
    @video = Video.get(id)
    raise NotFound unless @video
    if @video.destroy
      redirect resource(:videos)
    else
      raise InternalServerError
    end
  end

end # Videos

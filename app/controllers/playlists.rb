class Playlists < Application
  # provides :xml, :yaml, :js

  def index
    @playlists = Playlist.all
    display @playlists
  end

  def show(id)
    @playlist = Playlist.get(id)
    raise NotFound unless @playlist
    display @playlist
  end

  def new
    only_provides :html
    @playlist = Playlist.new
    display @playlist
  end

  def edit(id)
    only_provides :html
    @playlist = Playlist.get(id)
    raise NotFound unless @playlist
    display @playlist
  end

  def create(playlist)
    @playlist = Playlist.new(playlist)
    if @playlist.save
      redirect resource(@playlist), :message => {:notice => "Playlist was successfully created"}
    else
      message[:error] = "Playlist failed to be created"
      render :new
    end
  end

  def update(id, playlist)
    @playlist = Playlist.get(id)
    raise NotFound unless @playlist
    if @playlist.update_attributes(playlist)
       redirect resource(@playlist)
    else
      display @playlist, :edit
    end
  end

  def destroy(id)
    @playlist = Playlist.get(id)
    raise NotFound unless @playlist
    if @playlist.destroy
      redirect resource(:playlists)
    else
      raise InternalServerError
    end
  end

end # Playlists

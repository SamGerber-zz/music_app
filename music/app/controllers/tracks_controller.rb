class TracksController < ApplicationController

  def index
    @album = Album.find_by(id: params[:album_id])
    @tracks = @album.tracks.order(:name)
    render :index
  end

  def show
    @track = Track.find_by(id: params[:id])
    render :show
  end

  def new
    @track = Track.new(album_id: params[:album_id])
    render :new
  end

  def edit
    @track = Track.find_by(id: params[:id])
    render :edit
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      flash[:notifications] = ["#{@track.name} successfully created!"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def update
    @track = Track.find_by(id: params[:id])
    if @track.update_attributes(track_params)
      flash[:notifications] = ["#{@track.name} successfully edited!"]
      redirect_to track_url(@track)
    else
      flash.now[:errors] = @track.errors.full_messages
      render :edit
    end
  end

  def destroy
    @track = Track.find_by(id: params[:id])
    if @track.destroy.destroyed?
      flash[:notifications] = ["#{@track.name} successfully deleted!"]
      redirect_to album_tracks_url(@track.album)
    else
      flash[:errors] = @track.errors.full_messages
      redirect_to album_tracks_url(@track.album)
    end
  end


  private

  def track_params
    params.require(:track).permit(:id, :name, :bonus, :lyrics, :album_id)
  end


end

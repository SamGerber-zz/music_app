class AlbumsController < ApplicationController

    def index
      @band = Band.find_by(id: params[:band_id])
      @albums = @band.albums.order(:title)
      render :index
    end

    def show
      @album = Album.find_by(id: params[:id])
      render :show
    end

    def new
      @album = Album.new(band_id: params[:id])
      render :new
    end

    def edit
      @album = Album.find_by(id: params[:id])
      render :edit
    end

    def create
      @album = Album.new(album_params)
      if @album.save
        flash[:notifications] = ["#{@album.title} successfully created!"]
        redirect_to album_url(@album)
      else
        flash.now[:errors] = @album.errors.full_messages
        render :new
      end
    end

    def update
      @album = Album.find_by(id: params[:id])
      if @album.update_attributes(album_params)
        flash[:notifications] = ["#{@album.title} successfully edited!"]
        redirect_to album_url(@album)
      else
        flash.now[:errors] = @album.errors.full_messages
        render :edit
      end
    end

    def destroy
      @album = Album.find_by(id: params[:id])
      if @album.destroy.destroyed?
        flash[:notifications] = ["#{@album.title} successfully deleted!"]
        redirect_to band_albums_url(@album.band)
      else
        flash[:errors] = @album.errors.full_messages
        redirect_to band_albums_url(@album.band)
      end
    end


    private

    def album_params
      params.require(:album).permit(:id, :title)
    end

end

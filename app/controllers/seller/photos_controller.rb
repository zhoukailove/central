# -*- encoding : utf-8 -*-
module Seller
  class PhotosController < BaseController
    before_action :set_photo, only: [:show, :edit, :update, :destroy]

    # GET /photos
    def index
      @photos = Photo.all
    end

    # GET /photos/1
    def show
    end

    # GET /photos/new
    def new
      @photo = Photo.new
    end

    # GET /photos/1/edit
    def edit
    end

    # POST /photos
    def create
      @photo = Photo.new(photo_params)

      if @photo.save
        redirect_to @photo, notice: 'Photo was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /photos/1
    def update
      if @photo.update(photo_params)
        redirect_to @photo, notice: 'Photo was successfully updated.'
      else
        render action: 'edit'
      end
    end

    # DELETE /photos/1
    def destroy
      @photo.destroy
      redirect_to photos_url, notice: 'Photo was successfully destroyed.'
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_photo
      @photo = Photo.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def photo_params
      params.require(:photo).permit(:commoity_id, :photo)
    end
  end
end

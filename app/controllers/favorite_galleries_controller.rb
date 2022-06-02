class FavoriteGalleriesController < ApplicationController
  def create
    gallery = Gallery.find(params[:gallery_id])
    current_user.favorite_gallery(gallery)
    flash[:success] = "いいねをしました。"
    redirect_to gallery
  end

  def destroy
    gallery = Gallery.find(params[:gallery_id])
    current_user.unfavorite_gallery(gallery)
    flash[:success] = "いいねを取り消しました。"
    redirect_to gallery
  end
end

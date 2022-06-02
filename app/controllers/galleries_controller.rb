class GalleriesController < ApplicationController
  def new
    @guild = Guild.find(params[:guild_id])
    @gallery = @guild.galleries.build
    unless @guild.members.include?(current_user)
      redirect_back(fallback_location: root_path)
    end
  end

  def show
    @gallery = Gallery.find(params[:id])
    @guild = @gallery.guild
  end

  def create
    @guild = Guild.find(params[:guild_id])
    @gallery = current_user.galleries.build(gallery_params)
    @gallery.guild_id = @guild.id
    if @guild.members.include?(current_user)
      if @gallery.save
        flash[:success] = "写真を投稿しました。"
        redirect_to gallery_guild_path(id: @guild.id)
      else
        flash.now[:danger] = "写真を投稿できませんでした。"
        render :new
      end
    else
      flash[:danger] = "投稿がキャンセルされました。"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end
  
  
  private
  
  def gallery_params
    params.require(:gallery).permit(:photo, :content)
  end
end

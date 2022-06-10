class ToppagesController < ApplicationController
  def index
    if logged_in?
      @join_guilds = current_user.join_guilds.order(id: :desc).page(params[:page]).limit(5)
      @favorite_guilds = Guild.all.page(params[:page]).limit(20)
    end
  end
  
  def home
    @galleries = Gallery.find(FavoriteGallery.group(:gallery_id).order('count(gallery_id) desc').limit(5).pluck(:gallery_id))
    @guilds = Guild.find(FavoriteGuild.group(:guild_id).order('count(guild_id) desc').pluck(:guild_id))
    @blogs = Blog.find(FavoriteBlog.group(:blog_id).order('count(blog_id) desc').limit(10).pluck(:blog_id))
  end
end

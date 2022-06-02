class ToppagesController < ApplicationController
  def index
    if logged_in?
      @join_guilds = current_user.join_guilds.order(id: :desc).page(params[:page]).limit(5)
      @favorite_guilds = Guild.all.page(params[:page]).limit(20)
    end
  end
  
  def home
    @galleries = Gallery.order(id: :desc).limit(5)
    @guilds = Guild.order(id: :desc).page(params[:page]).per(25)
    #ページネーション
    #@guilds = Guild.find(FavoriteGuild.group(:guild_id).order('count(guild_id) desc').limit(25).pluck(:guild_id))
    @blogs = Blog.find(FavoriteBlog.group(:blog_id).order('count(blog_id) desc').limit(10).pluck(:blog_id))
  end
end

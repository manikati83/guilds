class FavoriteBlogsController < ApplicationController
  def create
    blog = Blog.find(params[:blog_id])
    current_user.favorite_blog(blog)
    flash[:success] = "いいねをしました。"
    redirect_to blog
  end

  def destroy
    blog = Blog.find(params[:blog_id])
    current_user.unfavorite_blog(blog)
    flash[:success] = "いいねを取り消しました。"
    redirect_to blog
  end
end

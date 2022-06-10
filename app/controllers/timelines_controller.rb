class TimelinesController < ApplicationController
  before_action :set_q
  
  def index
    @blogs = @q.result.order(id: :desc).page(params[:page]).per(50)
    @blog_count = Blog.all.count
  end
  
  private
  
  def set_q
    @q = Blog.ransack(params[:q])
  end
end

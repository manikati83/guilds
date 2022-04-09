class ToppagesController < ApplicationController
  def index
    if logged_in?
      @join_guilds = current_user.guilds.order(id: :desc).page(params[:page]).limit(5)
      @favorite_guilds = Guild.all.page(params[:page]).limit(20)
    end
  end
end

class FavoriteGuildsController < ApplicationController
  def create
    guild = Guild.find(params[:guild_id])
    current_user.favorite(guild)
    flash[:success] = guild.name + 'をお気に入りに登録しました。'
    redirect_to guild
  end

  def destroy
    guild = Guild.find(params[:guild_id])
    current_user.unfavorite(guild)
    flash[:success] = guild.name + 'のお気に入りを解除しました。'
    redirect_to guild
  end
end

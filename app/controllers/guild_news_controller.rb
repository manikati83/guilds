class GuildNewsController < ApplicationController
  def create
    guild = Guild.find(params[:guild_id])
    if guild.user == current_user
      @news = guild.guild_news.build(news_params)
      if @news.save
        flash[:success] = 'お知らせを作成しました。'
        redirect_to news_guild_path(id: guild.id)
      else
        flash[:danger] = 'お知らせを作成できませんでした。'
        redirect_to news_guild_path(id: guild.id)
      end
    else
      redirect_to news_guild_path(id: guild.id)
    end
  end

  def destroy
  end
  
  private
  
  def news_params
    params.require(:guild_news).permit(:content)
  end
end

class GuildMembersController < ApplicationController
  before_action :require_user_logged_in
  
  def create
    @guild = Guild.find(params[:guild_id])
    @user = User.find(params[:user_id])
    if @guild.members.count >= @guild.limit_member
      flash[:danger] = '加入人数が上限に達しています。'
      redirect_back(fallback_location: approval_members_guild_path(id: @guild.id))
    else
      @guild.add_member(@user)
      if current_user == @user
        flash[:success] = @guild.name + 'に加入しました。'
        redirect_to @guild
      else
        flash[:success] = @user.name + 'さんが加入しました。'
        redirect_to @guild
      end
    end
  end

  def destroy
  end
end

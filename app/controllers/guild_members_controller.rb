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
        @guild.add_notification(@guild.user, '「' + @guild.name +  '」に' + current_user.name + 'さんが加入しました。')
        redirect_to @guild
      else
        flash[:success] = @user.name + 'さんが加入しました。'
        @guild.add_notification(@user, '「' + @guild.name + '」から加入が許可されました。')
        redirect_to @guild
      end
    end
  end

  def destroy
    @guild = Guild.find(params[:guild_id])
    if @guild.user_id != current_user.id
      @guild.del_member(current_user)
      flash[:success] = @guild.name + 'を退会しました。'
      redirect_to @guild
    end
  end
end

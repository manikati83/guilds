class ApprovalsController < ApplicationController
  before_action :require_user_logged_in
  
  def new
    @guild = Guild.find(params[:id])
    @approval = @guild.approvals.build
  end

  def create
    @guild = Guild.find(params[:guild_id])
    if @guild.approval_user?(current_user)
      flash[:success] = 'すでに申請しています。'
      redirect_to @guild
    else
      approval = current_user.approvals.build(approval_params)
      approval.guild_id = @guild.id
      if approval.save
        flash[:success] = '加入申請を送りました。'
        @guild.add_notification(@guild.user, '「' + @guild.name + '」に' + current_user.name + 'さんから加入申請が届きました。')
        redirect_to @guild
      else
        flash.now[:danger] = '加入申請を送れませんでした。'
        render :new
      end
    end
  end 

  def destroy
    @guild = Guild.find(params[:guild_id])
    user = User.find(params[:user_id])
    @guild.approvals.find_by(user_id: user.id).destroy
    redirect_back(fallback_location: root_path)
  end
  
  
  private
  
  def approval_params
    params.require(:approval).permit(:content)
  end
end

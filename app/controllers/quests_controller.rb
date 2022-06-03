class QuestsController < ApplicationController
  
  def index
  
  end
  
  def new
    @guild = Guild.find(params[:id])
    @quest = @guild.quests.build
  end
  
  def show
    @quest = Quest.find(params[:id])
    session[:quest] = @quest.id
    session[:message_status] = 0
    @guild = @quest.guild
    @messages = @quest.quest_messages.where(status: 0)
    @new_message = @quest.quest_messages.build
    @quest_members = @quest.quest_members.order(id: :asc)
    if !@guild.members.include?(current_user) and @quest.user_id != current_user.id
      redirect_back(fallback_location: root_path)
    end
  end
  
  def create
    @guild = Guild.find(params[:guild_id])
    @quest = @guild.quests.build(quest_params)
    @quest.user_id = current_user.id
    if @quest.save and @guild.guild_type
      flash[:success] = @guild.name + "へ依頼しました。"
      redirect_to @guild
    else
      flash.now[:danger] = "依頼を作成できませんでした。"
      render :new
    end
  end
  
  def update
    @quest = Quest.find(params[:id])
    leader = @quest.quest_members.where(leader: true).first
    if leader.user_id == current_user.id
      if @quest.status == 0
        @quest.update(status: 1)
        flash[:success] = '依頼を開始しました。'
        @quest.members.each do |member|
          if member != current_user
            @quest.guild.add_notification(member, '「' +  @quest.title + '」のクエストが開始されました。')
          end
        end
        @quest.guild.add_notification(@quest.user, '「' +  @quest.title + '」のクエストが開始されました。')
        redirect_to @quest
      elsif @quest.status == 1
        @quest.update(status: 2)
        flash[:success] = "依頼を完了しました。"
        @quest.members.each do |member|
          if member != current_user
            @quest.guild.add_notification(member, '「' +  @quest.title + '」のクエストが完了しました。。')
          end
        end
        @quest.guild.add_notification(@quest.user, '「' +  @quest.title + '」のクエストが完了しました。お礼のメッセージを送りましょう。')
        redirect_to @quest
      end
    end
  end
  
  def destroy
    
  end
  
  def member_chat
    @quest = Quest.find(params[:id])
    session[:quest] = @quest.id
    session[:message_status] = 2
    @guild = @quest.guild
    @messages = @quest.quest_messages.where(status: 2)
    @new_message = @quest.quest_messages.build
    @quest_members = @quest.quest_members.order(id: :asc)
    if !@guild.members.include?(current_user) and @quest.user_id != current_user.id
      redirect_back(fallback_location: root_path)
    end
  end
  
  
  
  private
  
  def quest_params
    params.require(:quest).permit(:title, :content, :image)
  end
end

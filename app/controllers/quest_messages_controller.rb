class QuestMessagesController < ApplicationController
  def create
    @quest = Quest.find(session[:quest])
    @message = @quest.quest_messages.build(message_params)
    @message.user_id = current_user.id
    if @quest.status == 2
      @message.status = 1
    else
      @message.status = session[:message_status]
    end
    if @message.save
      if @message.status == 0 or @message.status == 1 #status 0:依頼者⇔受注者 1:お礼　2:クエストメンバー
        flash[:success] = "メッセージを送信しました。"
        @quest.members.each do |member|
          if member != current_user
            @quest.guild.add_notification(member, '「' + @quest.title + '」へ新規メッセージが届いています。')
          end
        end
        if @message.user_id != current_user
          @quest.guild.add_notification(@quest.user, '「' + @quest.title + '」へ新規メッセージが届いています。')
        end
        redirect_to @quest
      else
        flash[:success] = "メッセージを送信しました。"
        @quest.members.each do |member|
          if member != current_user
            @quest.guild.add_notification(member, '「' + @quest.title + '」へ新規メッセージが届いています。')
          end
        end
        redirect_to member_chat_quest_path(id: @quest.id)
      end
    else
      flash[:danger] = "メッセージの送信に失敗しました。"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
  end
  
  private
  
  def message_params
    params.require(:quest_message).permit(:content)
  end
end

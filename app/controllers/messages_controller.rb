class MessagesController < ApplicationController
  def new
    @guild = Guild.find(params[:id])
    @messages = @guild.messages.all
    @new_message = current_user.messages.build
  end
  
  def create
    @guild = Guild.find(params[:guild_id])
    @message = current_user.messages.build(message_params)
    @message.guild_id = @guild.id
    @new_message = current_user.messages.build
    if @guild.members.include?(current_user)
      @message.save
      #ActionCable.server.broadcast 'guild_channel', message: @message.message
      GuildChannel.broadcast_to(@guild, message: @message.message)
    end
  end

  def destroy
  end
  
  
  private
  
  def message_params
    params.require(:message).permit(:message)
  end
end

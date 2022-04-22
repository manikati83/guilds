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
      params[:room] = "Best Room"
      ActionCable.server.broadcast "guild_#{params[:guild_id]}", message: @message.message, guild_id: @guild.id
    end
  end

  def destroy
  end
  
  
  private
  
  def message_params
    params.require(:message).permit(:message)
  end
end

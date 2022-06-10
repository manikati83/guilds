class MessagesController < ApplicationController
  def new
    @guild = Guild.find(params[:id])
    if @guild.members.include?(current_user)
      session[:guild_id] = @guild.id
      @messages = @guild.messages.all
      @new_message = current_user.messages.build
      @members = @guild.members.order(online: :desc)
    else
      redirect_to @guild
    end
  end
  
  def create
    @guild = Guild.find(session[:guild_id])
    @message = current_user.messages.build(message_params)
    @message.guild_id = @guild.id
    @new_message = current_user.messages.build
    address = Digest::MD5::hexdigest(current_user.email.downcase)
    if @guild.members.include?(current_user)
      @message.save
      # ActionCable.server.broadcast "guild_#{params[:guild_id]}", message: @message.message, guild_id: @guild.id
      GuildChannel.broadcast_to(@guild, message: @message.message, guild_id: @guild.id, address: address, name: current_user.name)
    end
  end

  def destroy
  end
  
  
  private
  
  def message_params
    params.require(:message).permit(:message)
  end
end

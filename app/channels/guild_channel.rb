class GuildChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # stream_from "guild_#{params[:guild_id]}"
    stream_from "guild_channel_global"
    current_user.update_attributes(online: true, online_at: DateTime.now)
    @guild = current_user.join_guilds.find_by(id: params[:guild_id])
    #reject if @guild.nil?
    stream_for(@guild)
    GuildChannel.broadcast_to(@guild, guild_id: @guild.id, join_user_id: current_user.id)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user.update_attributes(online: false, online_at: DateTime.now)
  end

  def speak(data)
  end
end

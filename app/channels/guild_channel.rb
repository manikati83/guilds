class GuildChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    # stream_from "guild_#{params[:guild_id]}"
    stream_from "guild_channel_global"
    current_user.update_attributes(online: true, online_at: DateTime.now)
    @guild = current_user.join_guilds.find_by(id: params[:guild_id])
    @guild_member = current_user.guild_members.where(guild_id: @guild.id).first
    @guild_member.update_attributes(connection: true)
    
    #reject if @guild.nil?
    stream_for(@guild)
    GuildChannel.broadcast_to(@guild, guild_id: @guild.id, join_user_id: current_user.id)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user.update_attributes(online: false, online_at: DateTime.now)
    
    if current_user.guild_members.where(connection: true).first
      @guild = current_user.guild_members.where(connection: true).first.guild
      GuildChannel.broadcast_to(@guild, guild_id: @guild.id, out_user_id: current_user.id)
      connections = current_user.guild_members.where(connection: true)
      connections.each do |conn|
        conn.update_attributes(connection: false)
      end
    end
  end

  def speak(data)
  end
end

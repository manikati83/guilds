class GuildChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    #stream_from "guild_channel"
    current_user.update_attributes(online: true, online_at: DateTime.now)
    @guild = Guild.find_by(id: params[:guild_id])
    reject unless @guild.members.include?(current_user)
    stream_for(@guild)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user.update_attributes(online: false, online_at: DateTime.now)
  end

  def speak(data)
  end
end

class GuildChannel < ApplicationCable::Channel
  def subscribed
    # stream_from "some_channel"
    stream_from "guild_#{params[:guild_id]}"
    current_user.update_attributes(online: true, online_at: DateTime.now)
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
    current_user.update_attributes(online: false, online_at: DateTime.now)
  end

  def speak(data)
  end
end

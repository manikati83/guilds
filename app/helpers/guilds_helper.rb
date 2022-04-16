module GuildsHelper
  
  def join_guild(guild)
    guild.members.include?(current_user)
  end
end

class User < ApplicationRecord
  before_save { self.email.downcase! }
  validates :name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :guilds
  
  has_many :guild_members
  has_many :join_guilds, through: :guild_members, source: :guild
  
  has_many :blogs
  
  has_many :approvals, dependent: :destroy
  has_many :approval_guilds, through: :approvals, source: :guild
  
  has_many :messages
  
  has_many :favorite_guilds, dependent: :destroy
  has_many :favorites, through: :favorite_guilds, source: :guild
  
  has_many :galleries
  
  
  def favorite(guild)
    self.favorite_guilds.find_or_create_by(guild_id: guild.id)
  end
  
  def unfavorite(guild)
    favorite_guild = self.favorite_guilds.find_by(guild_id: guild.id)
    favorite_guild.destroy if favorite_guild
  end
  
  def favorite?(guild)
    self.favorites.include?(guild)
  end
  
  def how_long_ago
    if (Time.now - self.online_at) <= 60 * 60
      # 60分以内なら
      ((Time.now - self.online_at) / 60).to_i.to_s + "分前"
    elsif (Time.now - self.online_at) <= 60 * 60 * 24
      # 24時間以内なら
      ((Time.now - self.online_at) / 3600).to_i.to_s + "時間前"
    elsif (Date.today - self.online_at.to_date) <= 30
      # 30日以内なら
      (Date.today - self.online_at.to_date).to_i.to_s + "日前"
    else
      #　それ以降
      self.online_at
    end
  end
end

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
  
  
  def login_at(user)
    result = (Time.zone.now - user.online_at).floor / 60
    return result
  end
end

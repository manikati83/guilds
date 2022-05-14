class Guild < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :content, length: { maximum: 2000 }
  validates :limit_member, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 99}
  mount_uploader :image, ImageUploader
  
  belongs_to :user
  
  has_many :guild_members, dependent: :destroy
  has_many :members, through: :guild_members, source: :user
  
  has_many :guild_hashtag_relations, dependent: :destroy
  has_many :hashtags, through: :guild_hashtag_relations
  
  has_many :guild_blog_tags
  has_many :blogs
  
  has_many :approvals, dependent: :destroy
  has_many :approval_users, through: :approvals, source: :user
  
  has_many :messages
  
  has_many :guild_news
  
  has_many :favorite_guilds, dependent: :destroy
  has_many :favorites, through: :favorite_guilds, source: :user
  
  has_many :galleries
  
  
  after_create do
    guild = Guild.find_by(id: id)
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      guild.hashtags << tag
    end
  end
  
  before_update do
    guild = Guild.find_by(id: id)
    guild.hashtags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      guild.hashtags << tag
    end
  end
  
  def approval_user?(user)
    self.approval_users.include?(user)
  end
  
  def add_member(user)
    if self.members.count < self.limit_member
      self.guild_members.find_or_create_by(user_id: user.id)
      self.approvals.find_by(user_id: user.id).destroy
    end
  end
  
  def del_member(uesr)
    self.guild_members.find_by(user_id: user.id).destroy
  end
  
  def how_long_ago
    if (Time.now - self.created_at) <= 60 * 60
      # 60分以内なら
      ((Time.now - self.created_at) / 60).to_i.to_s + "分前"
    elsif (Time.now - self.created_at) <= 60 * 60 * 24
      # 24時間以内なら
      ((Time.now - self.created_at) / 3600).to_i.to_s + "時間前"
    elsif (Date.today - self.created_at.to_date) <= 30
      # 30日以内なら
      (Date.today - self.created_at.to_date).to_i.to_s + "日前"
    else
      #　それ以降
      self.created_at
    end
  end
  
  def created_format
    self.created_at.strftime('%Y/%m/%d')
  end
end

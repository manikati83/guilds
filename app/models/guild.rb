class Guild < ApplicationRecord
  validates :name, presence: true, length: { maximum: 50 }
  validates :content, length: { maximum: 2000 }
  validates :limit_member, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 99}
  
  belongs_to :user
  
  has_many :guild_members, dependent: :destroy
  has_many :members, through: :guild_members, source: :user
  
  has_many :guild_hashtag_relations, dependent: :destroy
  has_many :hashtags, through: :guild_hashtag_relations
  
  has_many :guild_blog_tags
  has_many :blogs
  
  has_many :approvals, dependent: :destroy
  has_many :approval_users, through: :approvals
  
  has_many :messages
  
  
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
    topic.hashtags.clear
    hashtags = hashbody.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
    hashtags.uniq.map do |hashtag|
      tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
      guild.hashtags << tag
    end
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
end

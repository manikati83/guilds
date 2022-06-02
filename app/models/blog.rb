class Blog < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 5000 }
  
  belongs_to :user
  belongs_to :guild
  belongs_to :guild_blog_tag, optional: true
  belongs_to :guild_blog_tag, dependent: :destroy
  
  has_rich_text :content
  
  has_many :favorite_blogs, dependent: :destroy
  has_many :good_users, through: :favorite_blogs, source: :user
  
  
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
end

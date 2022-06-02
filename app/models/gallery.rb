class Gallery < ApplicationRecord
  validates :content, length: { maximum: 255 }
  validates :photo, presence: true
  
  
  belongs_to :user
  belongs_to :guild
  
  has_many :favorite_galleries, dependent: :destroy
  has_many :good_users, through: :favorite_galleries, source: :user
  
  mount_uploader :photo, PhotoUploader
  
  def created_format
    self.created_at.strftime('%Y年%m月%d日')
  end
end

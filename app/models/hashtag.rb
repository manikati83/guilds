class Hashtag < ApplicationRecord
  validates :hashname, presence: true, length: { maximum: 50 }
  has_many :guild_hashtag_relations, dependent: :destroy
  has_many :guilds, through: :guild_hashtag_relations
end

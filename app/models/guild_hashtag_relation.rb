class GuildHashtagRelation < ApplicationRecord
  belongs_to :guild
  belongs_to :hashtag
  validates :guild_id, presence: true
  validates :hashtag_id, presence: true
end

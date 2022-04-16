class GuildBlogTag < ApplicationRecord
  belongs_to :guild
  has_many :blogs
end

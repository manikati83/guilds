class Blog < ApplicationRecord
  belongs_to :user
  belongs_to :guild
  belongs_to :guild_blog_tag, optional: true
  
  has_rich_text :content
end

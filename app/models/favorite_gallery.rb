class FavoriteGallery < ApplicationRecord
  belongs_to :user
  belongs_to :gallery
end

class Approval < ApplicationRecord
  belongs_to :user
  belongs_to :guild
end

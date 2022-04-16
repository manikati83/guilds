class AddOnlineAtToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :online_at, :datetime
  end
end

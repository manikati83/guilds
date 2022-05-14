class AddConnectionToGuildMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :guild_members, :connection, :boolean, default: :false
  end
end

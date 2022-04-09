class CreateGuildMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :guild_members do |t|
      t.references :user, null: false, foreign_key: true
      t.references :guild, null: false, foreign_key: true

      t.timestamps
      
      t.index [:user_id, :guild_id], unique: true
    end
  end
end

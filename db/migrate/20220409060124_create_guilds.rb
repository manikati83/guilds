class CreateGuilds < ActiveRecord::Migration[6.0]
  def change
    create_table :guilds do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name
      t.text :content
      t.string :image
      t.boolean :guild_type
      t.boolean :join_type
      t.text :hashbody
      t.integer :limit_member

      t.timestamps
    end
  end
end

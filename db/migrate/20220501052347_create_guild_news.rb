class CreateGuildNews < ActiveRecord::Migration[6.0]
  def change
    create_table :guild_news do |t|
      t.references :guild, null: false, foreign_key: true
      t.text :content

      t.timestamps
    end
  end
end

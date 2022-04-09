class CreateGuildHashtagRelations < ActiveRecord::Migration[6.0]
  def change
    create_table :guild_hashtag_relations do |t|
      t.references :guild, null: false, foreign_key: true
      t.references :hashtag, null: false, foreign_key: true

      t.timestamps
    end
  end
end

class CreateQuests < ActiveRecord::Migration[6.0]
  def change
    create_table :quests do |t|
      t.references :user, null: false, foreign_key: true
      t.references :guild, null: false, foreign_key: true
      t.string :title
      t.text :content
      t.string :image
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

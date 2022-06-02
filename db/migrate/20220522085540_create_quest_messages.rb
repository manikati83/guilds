class CreateQuestMessages < ActiveRecord::Migration[6.0]
  def change
    create_table :quest_messages do |t|
      t.references :quest, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.integer :status, default: 0

      t.timestamps
    end
  end
end

class CreateQuestMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :quest_members do |t|
      t.references :quest, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
      
      t.index [:quest_id, :user_id], unique: true
    end
  end
end

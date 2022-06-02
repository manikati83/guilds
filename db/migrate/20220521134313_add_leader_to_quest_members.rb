class AddLeaderToQuestMembers < ActiveRecord::Migration[6.0]
  def change
    add_reference :quest_members, :leader, null: false, foreign_key: { to_table: :users }
  end
end

class AddLeaderToQuestMembers < ActiveRecord::Migration[6.0]
  def change
    add_column :quest_members, :leader, :boolean, default: false
  end
end

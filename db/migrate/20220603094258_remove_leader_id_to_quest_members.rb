class RemoveLeaderIdToQuestMembers < ActiveRecord::Migration[6.0]
  def change
    remove_column :quest_members, :leader_id
  end
end

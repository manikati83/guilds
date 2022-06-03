class ChangeDataLeaderToQuestMembers < ActiveRecord::Migration[6.0]
  def change
    #change_column :quest_members, :leader_id, :boolean, default: false
    change_column :quest_members, :leader_id, 'boolean USING CAST(leader_id AS boolean)'
  end
end

class AddContentToApprovals < ActiveRecord::Migration[6.0]
  def change
    add_column :approvals, :content, :text
  end
end
